-- 订舱费用预览专用表（MySQL 5.7+）
-- 执行顺序：1. 本脚本；2. 20260820-migrate-booking-price-preview-history.sql；3. 发布应用。
-- 当前态只保留每个 ticket_id 的最新请求/结果；已提交结果追加到历史表。

CREATE TABLE IF NOT EXISTS `booking_price_preview_current` (
    `ticket_id`           varchar(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT '票证ID，当前态业务主键',
    `prefix`              varchar(10) NOT NULL COMMENT '运单前缀',
    `cargo_no`            varchar(32) NOT NULL COMMENT '运单号',
    `international`       tinyint NOT NULL COMMENT '1国内，2国际',
    `requested_revision`  bigint unsigned NOT NULL DEFAULT 0 COMMENT '最近发起的计算版本',
    `active_revision`     bigint unsigned NULL COMMENT '最近成功发布的计算版本',
    `preview_token`       char(32) CHARACTER SET ascii COLLATE ascii_bin NULL COMMENT '提交时校验令牌',
    `calculation_type`    tinyint NULL COMMENT '1直达，2中转',
    `success`             tinyint(1) NULL COMMENT '是否匹配到有效运价',
    `price_param`         longtext NULL COMMENT '服务端规范化后的计算入参',
    `price_info`          longtext NULL COMMENT '原始计算结果',
    `created_time`        datetime(3) NOT NULL COMMENT '首次创建时间',
    `completed_time`      datetime(3) NULL COMMENT '当前结果完成时间',
    `update_time`         datetime(3) NOT NULL COMMENT '最近更新时间',
    PRIMARY KEY (`ticket_id`),
    UNIQUE KEY `uk_booking_price_preview_current_token` (`preview_token`),
    KEY `idx_booking_price_preview_current_awb` (`prefix`, `cargo_no`, `international`),
    KEY `idx_booking_price_preview_current_update` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  COMMENT='订舱费用预览当前态';

CREATE TABLE IF NOT EXISTS `booking_price_preview_history` (
    `id`                    bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '顺序主键，适配高并发追加写',
    `source_price_param_id` varchar(36) CHARACTER SET ascii COLLATE ascii_bin NULL COMMENT '旧price_param_info来源ID',
    `ticket_id`             varchar(36) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT '票证ID',
    `booking_id`            varchar(36) CHARACTER SET ascii COLLATE ascii_bin NULL COMMENT '订舱聚合首段ID',
    `prefix`                varchar(10) NOT NULL COMMENT '运单前缀',
    `cargo_no`              varchar(32) NOT NULL COMMENT '运单号',
    `international`         tinyint NOT NULL COMMENT '1国内，2国际',
    `revision`              bigint unsigned NOT NULL COMMENT '费用预览版本；旧数据为0',
    `preview_token`         char(32) CHARACTER SET ascii COLLATE ascii_bin NOT NULL COMMENT '幂等令牌',
    `calculation_type`      tinyint NOT NULL COMMENT '1直达，2中转',
    `success`               tinyint(1) NOT NULL COMMENT '是否匹配到有效运价',
    `price_param`           longtext NULL COMMENT '计算入参快照',
    `price_info`            longtext NOT NULL COMMENT '计算结果快照',
    `calculated_time`       datetime(3) NOT NULL COMMENT '计算时间',
    `submitted_time`        datetime(3) NULL COMMENT '订舱提交时间',
    `archive_status`        tinyint NOT NULL DEFAULT 0 COMMENT '0在线，1归档中，2已归档',
    `archive_time`          datetime(3) NULL COMMENT '归档完成时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_booking_price_preview_history_source` (`source_price_param_id`),
    UNIQUE KEY `uk_booking_price_preview_history_token` (`preview_token`),
    KEY `idx_booking_price_preview_history_ticket_time` (`ticket_id`, `calculated_time`),
    KEY `idx_booking_price_preview_history_awb_time` (`prefix`, `cargo_no`, `international`, `calculated_time`),
    KEY `idx_booking_price_preview_history_booking` (`booking_id`),
    KEY `idx_booking_price_preview_history_archive` (`archive_status`, `submitted_time`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci
  COMMENT='订舱已接受费用快照历史';
