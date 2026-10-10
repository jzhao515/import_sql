-- 20261009-create-freight-global.sql
--
-- 全局费率表（f_freight_global）建表 + 后端接口 F 型按钮权限。
-- 接口（FreightGlobalController，路径 freight/global）：
--   GET    freight/global/query          freight:global:query   分页查询
--   GET    freight/global/{id}           freight:global:detail  详情（修改回显用）
--   POST   freight/global                freight:global:save    保存
--   PUT    freight/global/{id}           freight:global:update  修改
--   DELETE freight/global/{ids}          freight:global:remove  删除（逻辑删）
--   PUT    freight/global/invalid/{ids}  freight:global:invalid 作废（freight_state=0）
--
-- 执行说明：
--   * CREATE TABLE IF NOT EXISTS 幂等，可重复执行。
--   * 权限按钮挂在“运价管理 → 杂费运价”页面下，国际、国内两处各一套，
--     perms 均为 freight:global:*（接口不区分 scope，国内/国际数据由表内
--     international 列区分）。锚点通过各自 scope 的杂费运价保存按钮
--     （inter:inc:freight:save / dom:inter:inc:freight:save）的 parent_id
--     反查，避免硬编码 menu_id；某锚点不存在时该侧按钮跳过插入，不影响建表。
--   * 判重按 perms + parent_id 组合：已执行过旧版（仅国际六按钮）的环境重跑
--     本脚本会增量补插国内侧六按钮，不会产生重复行。
--   * 页面菜单（C 型）待前端页面落地时另行登记。
--
-- 验证（执行后）：
--   SHOW CREATE TABLE `f_freight_global`;
--   SELECT b.menu_id, b.menu_name, b.parent_id, p.menu_name AS parent_name,
--          p2.menu_name AS parent_dir, b.menu_type, b.perms
--     FROM sys_menu b
--     LEFT JOIN sys_menu p  ON p.menu_id  = b.parent_id
--     LEFT JOIN sys_menu p2 ON p2.menu_id = p.parent_id
--    WHERE b.perms LIKE 'freight:global:%';
--   -- 预期最多 12 行，menu_type 均为 'F'；六组 perms 各出现在
--   -- 国际杂费运价与国内杂费运价页面下。

START TRANSACTION;

-- 1) 建表
CREATE TABLE IF NOT EXISTS `f_freight_global` (
    `id`            varchar(36)   NOT NULL                COMMENT '主键',
    `freight_name`  varchar(100)  NOT NULL                COMMENT '运价名称',
    `carrier`       varchar(10)   NOT NULL                COMMENT '承运人（航司二字码）',
    `international` tinyint       NOT NULL                COMMENT '国内国际 1:国内 2:国际',
    `sp_codes`      varchar(1000) NOT NULL DEFAULT 'ALL'  COMMENT '应用的特货代码集合，逗号分隔，ALL=不限',
    `goods_codes`   varchar(1000) NOT NULL DEFAULT 'ALL'  COMMENT '应用的商品代码集合，逗号分隔，ALL=不限',
    `freight_state` tinyint       NOT NULL DEFAULT 1      COMMENT '运价状态 0:作废 1:启用',
    `apply_scope`   tinyint       NOT NULL                COMMENT '应用范围 1:主运价 2:主运价+杂费',
    `begin_date`    date          NOT NULL                COMMENT '有效期开始',
    `end_date`      date          NOT NULL                COMMENT '有效期结束',
    `rate`          decimal(10,4) NULL     DEFAULT NULL   COMMENT '费率',
    `is_delete`     tinyint(1)    NOT NULL DEFAULT 0      COMMENT '是否删除 0:未删除 1:删除',
    `create_time`   datetime      NULL     DEFAULT NULL   COMMENT '创建时间',
    `create_by`     varchar(100)  NULL     DEFAULT NULL   COMMENT '创建人名称',
    `update_time`   datetime      NULL     DEFAULT NULL   COMMENT '修改时间',
    `update_by`     varchar(100)  NULL     DEFAULT NULL   COMMENT '修改人名称',
    PRIMARY KEY (`id`),
    KEY `idx_freight_name` (`freight_name`),
    KEY `idx_carrier` (`carrier`),
    KEY `idx_international` (`international`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '全局费率表';

-- 1.1) 已按旧版建表（无 rate 列）的环境幂等补列；新建库由上方建表语句直接带上
SET @freight_global_ddl = IF(
    NOT EXISTS(SELECT 1 FROM information_schema.COLUMNS
           WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'f_freight_global'
             AND COLUMN_NAME = 'rate'),
    'ALTER TABLE `f_freight_global` ADD COLUMN `rate` decimal(10,4) NULL DEFAULT NULL COMMENT ''费率'' AFTER `end_date`',
    'SELECT 1'
);
PREPARE freight_global_stmt FROM @freight_global_ddl;
EXECUTE freight_global_stmt;
DEALLOCATE PREPARE freight_global_stmt;

-- 2) 分配菜单ID（与 20260723-add-domestic-rate-settlement-menus.sql 相同的分配方式）
SET @next_menu_id := (SELECT COALESCE(MAX(`menu_id`), 0) FROM `sys_menu`);

-- 3) 反查两侧“杂费运价”页面菜单：取持有对应 scope 杂费运价保存按钮的父级
SET @inter_inc_page := (
    SELECT m1.parent_id
    FROM `sys_menu` m1
    WHERE m1.perms = 'inter:inc:freight:save'
    LIMIT 1
);
SET @dom_inc_page := (
    SELECT m1.parent_id
    FROM `sys_menu` m1
    WHERE m1.perms = 'dom:inter:inc:freight:save'
    LIMIT 1
);

-- 4) F 型按钮：全局费率分页（国际 + 国内）
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 1, '全局费率分页', 'Global Freight Query', @inter_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:query', '#', 'admin', NOW(), '', NULL, '全局费率分页按钮'
FROM DUAL
WHERE @inter_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:query' AND `parent_id` = @inter_inc_page
);
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 7, '全局费率分页', 'Global Freight Query', @dom_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:query', '#', 'admin', NOW(), '', NULL, '全局费率分页按钮（国内运价）'
FROM DUAL
WHERE @dom_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:query' AND `parent_id` = @dom_inc_page
);

-- 5) F 型按钮：全局费率详情（国际 + 国内）
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 2, '全局费率详情', 'Global Freight Detail', @inter_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:detail', '#', 'admin', NOW(), '', NULL, '全局费率详情按钮'
FROM DUAL
WHERE @inter_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:detail' AND `parent_id` = @inter_inc_page
);
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 8, '全局费率详情', 'Global Freight Detail', @dom_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:detail', '#', 'admin', NOW(), '', NULL, '全局费率详情按钮（国内运价）'
FROM DUAL
WHERE @dom_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:detail' AND `parent_id` = @dom_inc_page
);

-- 6) F 型按钮：全局费率保存（国际 + 国内）
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 3, '全局费率保存', 'Global Freight Save', @inter_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:save', '#', 'admin', NOW(), '', NULL, '全局费率保存按钮'
FROM DUAL
WHERE @inter_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:save' AND `parent_id` = @inter_inc_page
);
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 9, '全局费率保存', 'Global Freight Save', @dom_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:save', '#', 'admin', NOW(), '', NULL, '全局费率保存按钮（国内运价）'
FROM DUAL
WHERE @dom_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:save' AND `parent_id` = @dom_inc_page
);

-- 7) F 型按钮：全局费率修改（国际 + 国内）
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 4, '全局费率修改', 'Global Freight Update', @inter_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:update', '#', 'admin', NOW(), '', NULL, '全局费率修改按钮'
FROM DUAL
WHERE @inter_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:update' AND `parent_id` = @inter_inc_page
);
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 10, '全局费率修改', 'Global Freight Update', @dom_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:update', '#', 'admin', NOW(), '', NULL, '全局费率修改按钮（国内运价）'
FROM DUAL
WHERE @dom_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:update' AND `parent_id` = @dom_inc_page
);

-- 8) F 型按钮：全局费率删除（国际 + 国内）
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 5, '全局费率删除', 'Global Freight Remove', @inter_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:remove', '#', 'admin', NOW(), '', NULL, '全局费率删除按钮'
FROM DUAL
WHERE @inter_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:remove' AND `parent_id` = @inter_inc_page
);
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 11, '全局费率删除', 'Global Freight Remove', @dom_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:remove', '#', 'admin', NOW(), '', NULL, '全局费率删除按钮（国内运价）'
FROM DUAL
WHERE @dom_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:remove' AND `parent_id` = @dom_inc_page
);

-- 9) F 型按钮：全局费率作废（国际 + 国内）
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 6, '全局费率作废', 'Global Freight Invalid', @inter_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:invalid', '#', 'admin', NOW(), '', NULL, '全局费率作废按钮'
FROM DUAL
WHERE @inter_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:invalid' AND `parent_id` = @inter_inc_page
);
INSERT INTO `sys_menu` (`menu_id`, `menu_name`, `menu_name_en`, `parent_id`, `order_num`, `path`,
                        `component`, `query`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`,
                        `perms`, `icon`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @next_menu_id + 12, '全局费率作废', 'Global Freight Invalid', @dom_inc_page, 99, '',
       NULL, NULL, 1, 0, 'F', '0', '0',
       'freight:global:invalid', '#', 'admin', NOW(), '', NULL, '全局费率作废按钮（国内运价）'
FROM DUAL
WHERE @dom_inc_page IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM `sys_menu` WHERE `perms` = 'freight:global:invalid' AND `parent_id` = @dom_inc_page
);

-- 10) detail_type 字典补“全局费率运价”（detailType=18）：
--     订舱/运单审核明细列表经 /system/dict/data/type/detail_type 渲染类型标签，
--     不补则全局费率行显示裸值 18。按 dict_type+dict_value 判重，幂等。
--     ★ 字典接口走 Redis 缓存（sys_dict:detail_type），SQL 直插不会立即生效：
--     执行本节后必须在 系统管理→字典管理→刷新缓存（DELETE /system/dict/type/refreshCache）
--     或删除 Redis 键 sys_dict:detail_type，接口才会返回 18。
--     验证（刷新后）：
--       GET /system/dict/data/type/detail_type 应包含 dictValue=18；或
--       SELECT dict_code, dict_sort, dict_label, dict_label_en, dict_value
--         FROM sys_dict_data WHERE dict_type = 'detail_type' AND dict_value = '18';
SET @detail_type_sort := (
    SELECT COALESCE(MAX(`dict_sort`), 0) + 1 FROM `sys_dict_data` WHERE `dict_type` = 'detail_type'
);
INSERT INTO `sys_dict_data` (`dict_sort`, `dict_label`, `dict_label_en`, `dict_value`, `dict_type`,
                             `css_class`, `list_class`, `is_default`, `status`,
                             `create_by`, `create_time`, `update_by`, `update_time`, `remark`)
SELECT @detail_type_sort, '全局费率运价', 'global rate', '18', 'detail_type',
       NULL, 'default', 'N', '0',
       'admin', NOW(), '', NULL, '全局费率费用明细类型（f_freight_global 计费）'
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM `sys_dict_data` WHERE `dict_type` = 'detail_type' AND `dict_value` = '18'
);

COMMIT;
