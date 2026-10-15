-- 2026-10-14 运单审核：主单杂费结构化类别 + 审核 TAX 口径对齐（结构迁移 + 只读核对）
-- 配套代码：AwbOtherFeeEntity/Param/VO 新增 feeType；AwbServiceImpl.saveAwbOtherFees 旧客户端按 feeName 无歧义解析。
-- 执行顺序：先执行本文件结构部分；第二部分核对语句只读，结果用于决定是否需要字典定向调整（见文件末尾说明）。

-- ============================================================
-- Part 1: 幂等结构迁移 —— tbl_awb_other_fee 增加 fee_type
-- ============================================================

DROP PROCEDURE IF EXISTS `migrate_awb_other_fee_add_fee_type`;

DELIMITER $$

CREATE PROCEDURE `migrate_awb_other_fee_add_fee_type`()
BEGIN
    IF DATABASE() IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No database selected';
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'tbl_awb_other_fee'
          AND COLUMN_NAME = 'fee_type'
    ) THEN
        ALTER TABLE `tbl_awb_other_fee`
            ADD COLUMN `fee_type` VARCHAR(32) NULL DEFAULT NULL
                COMMENT '结构化费用类别（DVC/SFC/MCC/MYC/MSC/AWC/TAX/CCA，全局费率为 global rate）' AFTER `fee_name`;
    END IF;
END$$

DELIMITER ;

CALL `migrate_awb_other_fee_add_fee_type`();
DROP PROCEDURE IF EXISTS `migrate_awb_other_fee_add_fee_type`;

-- 释放校验：必须返回 1 行 fee_type 列。
SELECT TABLE_NAME, COLUMN_NAME, COLUMN_TYPE, IS_NULLABLE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'tbl_awb_other_fee'
  AND COLUMN_NAME = 'fee_type';

-- ============================================================
-- Part 1b: 幂等放宽 fee_name 列宽（varchar(100) -> varchar(255)）
--   全局费率政策名（f_freight_global.freight_name 最长 100）与较长的自定义费用名
--   会导致批量保存整批失败（Data too long for column 'fee_name'）
-- ============================================================

DROP PROCEDURE IF EXISTS `migrate_awb_other_fee_widen_fee_name`;

DELIMITER $$

CREATE PROCEDURE `migrate_awb_other_fee_widen_fee_name`()
BEGIN
    IF DATABASE() IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'No database selected';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM information_schema.COLUMNS
        WHERE TABLE_SCHEMA = DATABASE()
          AND TABLE_NAME = 'tbl_awb_other_fee'
          AND COLUMN_NAME = 'fee_name'
          AND CHARACTER_MAXIMUM_LENGTH < 255
    ) THEN
        ALTER TABLE `tbl_awb_other_fee`
            MODIFY COLUMN `fee_name` varchar(255) NOT NULL COMMENT '费用名称';
    END IF;
END$$

DELIMITER ;

CALL `migrate_awb_other_fee_widen_fee_name`();
DROP PROCEDURE IF EXISTS `migrate_awb_other_fee_widen_fee_name`;

-- 释放校验：必须返回 varchar(255)。
SELECT COLUMN_NAME, COLUMN_TYPE
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'tbl_awb_other_fee'
  AND COLUMN_NAME = 'fee_name';

-- ============================================================
-- Part 2: 只读核对 —— fee_type 字典、TAX / global tax 编码与引用
-- 实施前必须先跑完本部分并留档结果；不做任何全库字符串替换。
-- ============================================================

-- 2.1 fee_type 字典当前值（CommonVar.FEE_TYPE = 'fee_type'，杂费维护页类别来源；
--     英文标签 dict_label_en 参与名称解析，需一并核对）
SELECT dict_code, dict_label, dict_label_en, dict_value, dict_sort, status, remark
FROM sys_dict_data
WHERE dict_type = 'fee_type'
ORDER BY dict_sort, dict_code;

-- 2.2 检查是否存在编码/标签含 tax / global 的字典行（大小写不敏感）
SELECT dict_type, dict_code, dict_label, dict_value, status
FROM sys_dict_data
WHERE LOWER(dict_type) LIKE '%fee%'
   OR LOWER(dict_value) LIKE '%tax%'
   OR LOWER(dict_label) LIKE '%tax%'
   OR LOWER(dict_value) LIKE '%global%'
   OR LOWER(dict_label) LIKE '%global%'
ORDER BY dict_type, dict_sort;

-- 2.3 主单杂费明细按名称分布：评估旧数据里可无歧义解析的类别量
--     （DVC/SFC/MCC/MYC/MSC/AWC/TAX/CCA 精确匹配才会被代码解析为 fee_type）
SELECT fee_name, COUNT(*) AS cnt
FROM tbl_awb_other_fee
GROUP BY fee_name
ORDER BY cnt DESC;

-- 2.4 全局费率政策的名称与引用（f_freight_global，判断政策名与普通费用代码是否撞名）
--     状态列为 freight_state（0作废/1启用），另有软删 is_delete（0未删/1删除）
SELECT id, freight_name, rate, apply_scope, begin_date, end_date, freight_state, is_delete
FROM f_freight_global
ORDER BY create_time DESC;

-- 2.5 计算明细快照中 detail_type=15(TAX) / 18(全局费率) 的使用量
--     detail_type=15 显示标签应为“税/TAX”；detail_type=18 仍表示全局费率，不得改成 TAX。
SELECT detail_type, COUNT(*) AS cnt
FROM cal_detail_snapshot
WHERE detail_type IN (15, 18)
GROUP BY detail_type;

-- ============================================================
-- Part 3: 字典定向调整模板（仅在核对结果支持时执行）
-- ============================================================
-- 情形 A：fee_type 字典存在编码为 TAX 的行、但标签显示为其他文案（如“税金”/“税费”），
--         且产品要求显示 TAX：只改标签，不改编码。
-- UPDATE sys_dict_data
-- SET dict_label = 'TAX'
-- WHERE dict_type = 'fee_type' AND dict_value = 'TAX';
--
-- 情形 B：若 2.2 发现存在编码字面量为 'global tax' 的字典行（仓库源码未检索到该字面值，
--         须以核对结果为准）：先执行 2.4/2.5 列出政策与明细引用，再单独评估定向编码迁移，
--         本文件不预先提供 UPDATE。
--
-- 注意：任何 sys_dict_data 直改后，必须调用 /system/dict/type/refreshCache 刷新 Redis 字典缓存，
--       否则 CalServiceImpl 等按字典取标签的逻辑仍读旧值。
