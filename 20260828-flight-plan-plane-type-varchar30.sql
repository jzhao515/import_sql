-- 2026-08-28 航班计划表 tbl_flight_plan.plane_type 列扩容 varchar(10) -> varchar(30)
-- 用途: 动态航班(航班计划) Excel 导入时,机型按 b_plane_model.name 精确等值校验后原样入库,
--       机型全名(如 'Dash 8-Q400' / 'Dash 8-Q300',11 字符)超出 plane_type varchar(10) 长度,
--       导入报 "Data truncation: Data too long for column 'plane_type'" 并整批回滚。
--       本脚本将列长扩至与 b_plane_model.name(varchar(30)) 一致。
-- 说明: 仅扩大长度、不变更类型/默认值/可空性,不影响既有数据,可重复执行(同定义 MODIFY 无副作用)。
--       切勿直接回滚缩回 varchar(10): 若表中已存在超 10 字符的机型名,收缩会在严格模式下失败或截断数据。
-- 用法: mysql -u<user> -p tanzania_booking < 2026-08-28-flight-plan-plane-type-varchar30.sql

ALTER TABLE tbl_flight_plan
    MODIFY COLUMN plane_type varchar(30) NULL;

-- 验证: 期望 COLUMN_TYPE = varchar(30)
SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'tbl_flight_plan'
  AND COLUMN_NAME = 'plane_type';
