-- 2026-10-29 国际主单 Prepaid 口径修复：存量运单杂费合计回填与 Total 重算（数据迁移）
-- 配套代码：前端 outAwb 回显后重算杂费汇总（otherFeeSummary）+ 后端 AwbServiceImpl.calData 按
--           awbOtherFeeParams 兜底回填 Due Agent / Due Carrier 汇总字段
-- 背景：主单界面回显不触发前端杂费汇总，历史保存运单的 agent/carrier_other_fee_(prepaid|collect)
--       为空，Total Prepaid/Total Collect 因此只含运费不含杂费
-- 口径：owner='A' 杂费行合计进 Total Other Charges Due Agent，owner='C' 进 Due Carrier，
--       按 other_val 落 Prepaid 或 Collect 侧，Total 与后端 calData 公式一致
--       （运费 + 声明价值费 + 安检费 + Due Agent + Due Carrier，不含税）
-- 幂等：仅回填目标列为 NULL 的行，已有值不覆盖，Total 仅在算得值与现值不同时更新，可重复执行
-- 执行前请备份 tbl_awb，执行建议在业务低峰期（ UPDATE 走主键关联，锁范围可控）

-- ============================================================
-- Part 1: 杂费行按运单聚合（owner A/C 分列合计）
-- ============================================================

DROP TEMPORARY TABLE IF EXISTS `tmp_awb_other_fee_agg`;

CREATE TEMPORARY TABLE `tmp_awb_other_fee_agg` AS
SELECT `awb_id`,
       SUM(CASE WHEN `owner` = 'A' THEN `fee` ELSE 0 END) AS `agent_fee`,
       SUM(CASE WHEN `owner` = 'C' THEN `fee` ELSE 0 END) AS `carrier_fee`,
       COUNT(*) AS `fee_rows`
FROM `tbl_awb_other_fee`
WHERE `fee` IS NOT NULL
GROUP BY `awb_id`;

ALTER TABLE `tmp_awb_other_fee_agg` ADD PRIMARY KEY (`awb_id`);

-- 核对：参与回填的运单数量与杂费规模
SELECT COUNT(*) AS agg_awb_count,
       SUM(`fee_rows`) AS total_fee_rows,
       ROUND(SUM(`agent_fee` + `carrier_fee`), 2) AS total_other_fee_amount
FROM `tmp_awb_other_fee_agg`;

-- ============================================================
-- Part 2: 回填缺失的杂费汇总（other_val='PP' 落 Prepaid 侧，'CC' 落 Collect 侧）
-- ============================================================

UPDATE `tbl_awb` a
JOIN `tmp_awb_other_fee_agg` f ON f.`awb_id` = a.`id`
SET a.`agent_other_fee_prepaid`   = COALESCE(a.`agent_other_fee_prepaid`,   ROUND(f.`agent_fee`,   2)),
    a.`carrier_other_fee_prepaid` = COALESCE(a.`carrier_other_fee_prepaid`, ROUND(f.`carrier_fee`, 2))
WHERE a.`is_delete` = 0
  AND a.`other_val` = 'PP'
  AND (a.`agent_other_fee_prepaid` IS NULL OR a.`carrier_other_fee_prepaid` IS NULL);

UPDATE `tbl_awb` a
JOIN `tmp_awb_other_fee_agg` f ON f.`awb_id` = a.`id`
SET a.`agent_other_fee_collect`   = COALESCE(a.`agent_other_fee_collect`,   ROUND(f.`agent_fee`,   2)),
    a.`carrier_other_fee_collect` = COALESCE(a.`carrier_other_fee_collect`, ROUND(f.`carrier_fee`, 2))
WHERE a.`is_delete` = 0
  AND a.`other_val` = 'CC'
  AND (a.`agent_other_fee_collect` IS NULL OR a.`carrier_other_fee_collect` IS NULL);

-- ============================================================
-- Part 3: 重算受影响运单的 Total（与后端 calData 公式一致，仅更新算得值有差异的行）
--   total = 运费 + 声明价值费 + 安检费 + Due Agent 杂费 + Due Carrier 杂费
-- ============================================================

UPDATE `tbl_awb` a
JOIN `tmp_awb_other_fee_agg` f ON f.`awb_id` = a.`id`
SET a.`total_prepaid` = ROUND(COALESCE(a.`flight_fee_prepaid`, 0) + COALESCE(a.`dvc_prepaid`, 0)
                            + COALESCE(a.`sfc_prepaid`, 0) + COALESCE(a.`agent_other_fee_prepaid`, 0)
                            + COALESCE(a.`carrier_other_fee_prepaid`, 0), 2),
    a.`total_amount`  = ROUND(COALESCE(a.`flight_fee_prepaid`, 0) + COALESCE(a.`dvc_prepaid`, 0)
                            + COALESCE(a.`sfc_prepaid`, 0) + COALESCE(a.`agent_other_fee_prepaid`, 0)
                            + COALESCE(a.`carrier_other_fee_prepaid`, 0), 2)
WHERE a.`is_delete` = 0
  AND a.`wt_val` = 'PP'
  AND (a.`total_prepaid` IS NULL OR a.`total_amount` IS NULL
       OR a.`total_prepaid` <> ROUND(COALESCE(a.`flight_fee_prepaid`, 0) + COALESCE(a.`dvc_prepaid`, 0)
                                   + COALESCE(a.`sfc_prepaid`, 0) + COALESCE(a.`agent_other_fee_prepaid`, 0)
                                   + COALESCE(a.`carrier_other_fee_prepaid`, 0), 2)
       OR a.`total_amount` <> ROUND(COALESCE(a.`flight_fee_prepaid`, 0) + COALESCE(a.`dvc_prepaid`, 0)
                                  + COALESCE(a.`sfc_prepaid`, 0) + COALESCE(a.`agent_other_fee_prepaid`, 0)
                                  + COALESCE(a.`carrier_other_fee_prepaid`, 0), 2));

UPDATE `tbl_awb` a
JOIN `tmp_awb_other_fee_agg` f ON f.`awb_id` = a.`id`
SET a.`total_collect` = ROUND(COALESCE(a.`flight_fee_collect`, 0) + COALESCE(a.`dvc_collect`, 0)
                            + COALESCE(a.`sfc_collect`, 0) + COALESCE(a.`agent_other_fee_collect`, 0)
                            + COALESCE(a.`carrier_other_fee_collect`, 0), 2),
    a.`total_amount`  = ROUND(COALESCE(a.`flight_fee_collect`, 0) + COALESCE(a.`dvc_collect`, 0)
                            + COALESCE(a.`sfc_collect`, 0) + COALESCE(a.`agent_other_fee_collect`, 0)
                            + COALESCE(a.`carrier_other_fee_collect`, 0), 2)
WHERE a.`is_delete` = 0
  AND a.`wt_val` = 'CC'
  AND (a.`total_collect` IS NULL OR a.`total_amount` IS NULL
       OR a.`total_collect` <> ROUND(COALESCE(a.`flight_fee_collect`, 0) + COALESCE(a.`dvc_collect`, 0)
                                   + COALESCE(a.`sfc_collect`, 0) + COALESCE(a.`agent_other_fee_collect`, 0)
                                   + COALESCE(a.`carrier_other_fee_collect`, 0), 2)
       OR a.`total_amount` <> ROUND(COALESCE(a.`flight_fee_collect`, 0) + COALESCE(a.`dvc_collect`, 0)
                                  + COALESCE(a.`sfc_collect`, 0) + COALESCE(a.`agent_other_fee_collect`, 0)
                                  + COALESCE(a.`carrier_other_fee_collect`, 0), 2));

-- ============================================================
-- Part 4: 释放后核对
-- ============================================================

-- 核对一：仍缺杂费汇总的运单（预期仅剩 other_val 未选 PP/CC 的行，应人工确认）
SELECT a.`id`, a.`awb_no`, a.`other_val`,
       f.`agent_fee`, f.`carrier_fee`
FROM `tbl_awb` a
JOIN `tmp_awb_other_fee_agg` f ON f.`awb_id` = a.`id`
WHERE a.`is_delete` = 0
  AND (a.`agent_other_fee_prepaid` IS NULL AND a.`carrier_other_fee_prepaid` IS NULL
       AND a.`agent_other_fee_collect` IS NULL AND a.`carrier_other_fee_collect` IS NULL);

-- 核对二：Total 与分项之和仍不一致的运单（预期 0 行）
SELECT a.`id`, a.`awb_no`, a.`wt_val`, a.`total_prepaid`, a.`total_collect`, a.`total_amount`
FROM `tbl_awb` a
JOIN `tmp_awb_other_fee_agg` f ON f.`awb_id` = a.`id`
WHERE a.`is_delete` = 0
  AND ((a.`wt_val` = 'PP' AND a.`total_prepaid` <> ROUND(COALESCE(a.`flight_fee_prepaid`, 0)
        + COALESCE(a.`dvc_prepaid`, 0) + COALESCE(a.`sfc_prepaid`, 0)
        + COALESCE(a.`agent_other_fee_prepaid`, 0) + COALESCE(a.`carrier_other_fee_prepaid`, 0), 2))
    OR (a.`wt_val` = 'CC' AND a.`total_collect` <> ROUND(COALESCE(a.`flight_fee_collect`, 0)
        + COALESCE(a.`dvc_collect`, 0) + COALESCE(a.`sfc_collect`, 0)
        + COALESCE(a.`agent_other_fee_collect`, 0) + COALESCE(a.`carrier_other_fee_collect`, 0), 2)));

-- 核对三：抽样查看回填结果（前 20 行）
SELECT a.`awb_no`, a.`wt_val`, a.`other_val`,
       a.`flight_fee_prepaid`, a.`agent_other_fee_prepaid`, a.`carrier_other_fee_prepaid`,
       a.`total_prepaid`, a.`total_amount`
FROM `tbl_awb` a
JOIN `tmp_awb_other_fee_agg` f ON f.`awb_id` = a.`id`
WHERE a.`is_delete` = 0 AND a.`other_val` = 'PP'
ORDER BY a.`update_time` DESC
LIMIT 20;

DROP TEMPORARY TABLE IF EXISTS `tmp_awb_other_fee_agg`;
