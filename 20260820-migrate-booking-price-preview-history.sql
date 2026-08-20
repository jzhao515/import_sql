-- 将 price_param_info 中历史订舱快照（module=1、cargo_type=1）迁移到专用表。
-- 前置条件：已执行 20260820-create-booking-price-preview.sql。
-- 特性：可重复执行；不删除、不修改 price_param_info；无法唯一关联票证或 JSON 无效的数据仅保留在备份表。

-- 1. 原样备份所有历史订舱模块记录。备份表主键沿用旧表 id，INSERT IGNORE 保证可重跑。
CREATE TABLE IF NOT EXISTS `price_param_info_booking_backup_20260820` LIKE `price_param_info`;

INSERT IGNORE INTO `price_param_info_booking_backup_20260820`
SELECT *
FROM `price_param_info`
WHERE `module` = 1;

DROP TEMPORARY TABLE IF EXISTS `tmp_booking_price_preview_valid`;
DROP TEMPORARY TABLE IF EXISTS `tmp_booking_price_preview_candidates`;
DROP TEMPORARY TABLE IF EXISTS `tmp_booking_price_preview_latest`;

-- 2. 只接收能够按“前缀+运单号+国内国际”唯一对应到一张有效票证、且请求/结果均为合法 JSON 的记录。
CREATE TEMPORARY TABLE `tmp_booking_price_preview_valid` (
    `source_price_param_id` varchar(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    `ticket_id`             varchar(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    `booking_id`            varchar(36) CHARACTER SET ascii COLLATE ascii_bin NULL,
    `prefix`                varchar(10) NOT NULL,
    `cargo_no`              varchar(32) NOT NULL,
    `international`         tinyint NOT NULL,
    `preview_token`         char(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
    `calculation_type`      tinyint NOT NULL,
    `success`               tinyint(1) NOT NULL,
    `price_param`           longtext NULL,
    `price_info`            longtext NOT NULL,
    `calculated_time`       datetime(3) NOT NULL,
    PRIMARY KEY (`source_price_param_id`),
    KEY `idx_tmp_booking_price_preview_ticket_time` (`ticket_id`, `calculated_time`, `source_price_param_id`)
) ENGINE=InnoDB;

INSERT INTO `tmp_booking_price_preview_valid` (
    `source_price_param_id`, `ticket_id`, `booking_id`, `prefix`, `cargo_no`, `international`,
    `preview_token`, `calculation_type`, `success`, `price_param`, `price_info`, `calculated_time`
)
SELECT p.`id`,
       t.`ticket_id`,
       b.`booking_id`,
       p.`prefix`,
       p.`cargo_no`,
       p.`international`,
       -- 旧表 ID 本身是唯一 UUID；规范化为稳定令牌，保证脚本重跑时历史态与当前态保持一致。
       LOWER(REPLACE(p.`id`, '-', '')),
       CASE
           WHEN JSON_EXTRACT(p.`price_param`, '$.routePreviewVersion') IS NOT NULL
             OR JSON_EXTRACT(p.`price_info`, '$.totalResult') IS NOT NULL THEN 2
           ELSE 1
       END,
       CASE
           WHEN JSON_UNQUOTE(JSON_EXTRACT(p.`price_info`, '$.success')) = 'true' THEN 1
           WHEN JSON_UNQUOTE(JSON_EXTRACT(p.`price_info`, '$.totalResult.success')) = 'true' THEN 1
           ELSE 0
       END,
       p.`price_param`,
       p.`price_info`,
       COALESCE(p.`create_time`, '1970-01-01 00:00:00.000')
FROM `price_param_info` p
INNER JOIN (
    SELECT MIN(`id`) AS `ticket_id`, `prefix`, `cargo_no`, `international`
    FROM `t_ticket_detail`
    WHERE `is_delete` = 0
    GROUP BY `prefix`, `cargo_no`, `international`
    HAVING COUNT(*) = 1
) t ON t.`prefix` = p.`prefix`
   AND t.`cargo_no` = p.`cargo_no`
   AND t.`international` = p.`international`
LEFT JOIN (
    SELECT `ticket_id`, MIN(`id`) AS `booking_id`
    FROM `tbl_booking`
    WHERE `is_delete` = 0
    GROUP BY `ticket_id`
) b ON b.`ticket_id` = t.`ticket_id`
WHERE p.`module` = 1
  AND p.`cargo_type` = 1
  AND p.`prefix` IS NOT NULL
  AND p.`prefix` <> ''
  AND CHAR_LENGTH(p.`prefix`) <= 10
  AND p.`cargo_no` IS NOT NULL
  AND p.`cargo_no` <> ''
  AND CHAR_LENGTH(p.`cargo_no`) <= 32
  AND CHAR_LENGTH(p.`id`) <= 36
  AND CHAR_LENGTH(REPLACE(p.`id`, '-', '')) = 32
  AND REPLACE(p.`id`, '-', '') REGEXP '^[0-9A-Fa-f]{32}$'
  AND p.`international` IN (1, 2)
  AND p.`price_param` IS NOT NULL
  AND JSON_VALID(p.`price_param`) = 1
  AND p.`price_info` IS NOT NULL
  AND JSON_VALID(p.`price_info`) = 1;

-- 3. 所有有效旧记录进入历史表。source_price_param_id 和 preview_token 双重幂等。
INSERT INTO `booking_price_preview_history` (
    `source_price_param_id`, `ticket_id`, `booking_id`, `prefix`, `cargo_no`, `international`,
    `revision`, `preview_token`, `calculation_type`, `success`, `price_param`, `price_info`,
    `calculated_time`, `submitted_time`
)
SELECT v.`source_price_param_id`,
       v.`ticket_id`,
       v.`booking_id`,
       v.`prefix`,
       v.`cargo_no`,
       v.`international`,
       0,
       v.`preview_token`,
       v.`calculation_type`,
       v.`success`,
       v.`price_param`,
       v.`price_info`,
       v.`calculated_time`,
       CASE WHEN v.`booking_id` IS NULL THEN NULL ELSE v.`calculated_time` END
FROM `tmp_booking_price_preview_valid` v
ON DUPLICATE KEY UPDATE
    `source_price_param_id` = VALUES(`source_price_param_id`);

-- 修正旧版本迁移脚本生成的随机令牌。仅按旧表来源 ID 命中的迁移历史记录会被更新。
UPDATE `booking_price_preview_history` h
INNER JOIN `tmp_booking_price_preview_valid` v
        ON v.`source_price_param_id` = h.`source_price_param_id`
SET h.`preview_token` = v.`preview_token`
WHERE h.`preview_token` <> v.`preview_token`;

-- 4. 每张票只选择“计算时间最新、同一时间下来源ID最大”的一条作为当前态。
-- ON DUPLICATE 采用空操作，避免重跑迁移时覆盖应用上线后产生的新当前态。
-- MySQL 临时表不能在同一查询中重复打开，因此复制一份候选表用于自连接比较。
CREATE TEMPORARY TABLE `tmp_booking_price_preview_candidates` LIKE `tmp_booking_price_preview_valid`;
CREATE TEMPORARY TABLE `tmp_booking_price_preview_latest` LIKE `tmp_booking_price_preview_valid`;

INSERT INTO `tmp_booking_price_preview_candidates`
SELECT *
FROM `tmp_booking_price_preview_valid`;

INSERT INTO `tmp_booking_price_preview_latest` (
    `source_price_param_id`, `ticket_id`, `booking_id`, `prefix`, `cargo_no`, `international`,
    `preview_token`, `calculation_type`, `success`, `price_param`, `price_info`, `calculated_time`
)
SELECT latest.`source_price_param_id`,
       latest.`ticket_id`,
       latest.`booking_id`,
       latest.`prefix`,
       latest.`cargo_no`,
       latest.`international`,
       latest.`preview_token`,
       latest.`calculation_type`,
       latest.`success`,
       latest.`price_param`,
       latest.`price_info`,
       latest.`calculated_time`
FROM `tmp_booking_price_preview_valid` latest
LEFT JOIN `tmp_booking_price_preview_candidates` newer
       ON newer.`ticket_id` = latest.`ticket_id`
      AND (
           newer.`calculated_time` > latest.`calculated_time`
        OR (newer.`calculated_time` = latest.`calculated_time`
            AND newer.`source_price_param_id` > latest.`source_price_param_id`)
      )
WHERE newer.`ticket_id` IS NULL;

INSERT INTO `booking_price_preview_current` (
    `ticket_id`, `prefix`, `cargo_no`, `international`, `requested_revision`, `active_revision`,
    `preview_token`, `calculation_type`, `success`, `price_param`, `price_info`,
    `created_time`, `completed_time`, `update_time`
)
SELECT latest.`ticket_id`,
       latest.`prefix`,
       latest.`cargo_no`,
       latest.`international`,
       1,
       1,
       latest.`preview_token`,
       latest.`calculation_type`,
       latest.`success`,
       latest.`price_param`,
       latest.`price_info`,
       latest.`calculated_time`,
       latest.`calculated_time`,
       latest.`calculated_time`
FROM `tmp_booking_price_preview_latest` latest
ON DUPLICATE KEY UPDATE
    `ticket_id` = VALUES(`ticket_id`);

-- 兼容已执行过旧版本脚本的数据库：只修正仍与迁移快照内容、时间及初始版本完全一致的当前态。
UPDATE `booking_price_preview_current` c
INNER JOIN `tmp_booking_price_preview_latest` v
        ON v.`ticket_id` = c.`ticket_id`
       AND v.`calculated_time` = c.`completed_time`
       AND CAST(c.`price_info` AS BINARY) = CAST(v.`price_info` AS BINARY)
       AND CAST(c.`price_param` AS BINARY) <=> CAST(v.`price_param` AS BINARY)
SET c.`preview_token` = v.`preview_token`
WHERE c.`requested_revision` = 1
  AND c.`active_revision` = 1
  AND c.`preview_token` <> v.`preview_token`;

-- 5. 核对结果。第二项为未迁移行数，需按“票证无法唯一关联/JSON无效/字段不完整”人工抽查。
SELECT COUNT(*) AS `legacy_booking_rows`
FROM `price_param_info`
WHERE `module` = 1 AND `cargo_type` = 1;

SELECT COUNT(*) AS `migrated_valid_rows`
FROM `tmp_booking_price_preview_valid`;

SELECT COUNT(*) AS `legacy_rows_not_migrated`
FROM `price_param_info` p
LEFT JOIN `booking_price_preview_history` h ON h.`source_price_param_id` = p.`id`
WHERE p.`module` = 1
  AND p.`cargo_type` = 1
  AND h.`id` IS NULL;

SELECT COUNT(*) AS `current_ticket_rows`
FROM `booking_price_preview_current`;

DROP TEMPORARY TABLE IF EXISTS `tmp_booking_price_preview_valid`;
DROP TEMPORARY TABLE IF EXISTS `tmp_booking_price_preview_candidates`;
DROP TEMPORARY TABLE IF EXISTS `tmp_booking_price_preview_latest`;
