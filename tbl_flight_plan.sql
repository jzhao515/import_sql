/*
 Navicat Premium Dump SQL

 Source Server         : 175.178.115.41
 Source Server Type    : MySQL
 Source Server Version : 90001 (9.0.1)
 Source Host           : 175.178.115.41:3316
 Source Schema         : tanzania_booking_training

 Target Server Type    : MySQL
 Target Server Version : 90001 (9.0.1)
 File Encoding         : 65001

 Date: 11/07/2026 01:37:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_flight_plan
-- ----------------------------
DROP TABLE IF EXISTS `tbl_flight_plan`;
CREATE TABLE `tbl_flight_plan` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `flight_no` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '始发站',
  `dest1` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第一目的站',
  `dest2` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第二目的站',
  `carrier` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '承运人',
  `status` tinyint NOT NULL DEFAULT '1' COMMENT '生成状态  1：未生成 2：生成中 3：暂停生成 4：已生成',
  `plane_num` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '机号',
  `plane_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '机型',
  `begin_date` date DEFAULT NULL COMMENT '开始日期',
  `end_date` date DEFAULT NULL COMMENT '结束日期',
  `schedule` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '班期',
  `dep_time` datetime DEFAULT NULL COMMENT '预计起飞',
  `dest_time` datetime DEFAULT NULL COMMENT '预计到达',
  `plan_dep_time` datetime DEFAULT NULL COMMENT '计划起飞',
  `plan_dest_time` datetime DEFAULT NULL COMMENT '计划到达',
  `act_dep_time` datetime DEFAULT NULL COMMENT '实际起飞',
  `act_dest_time` datetime DEFAULT NULL COMMENT '实际到达',
  `max_weight` decimal(10,2) DEFAULT NULL COMMENT '最大业载',
  `max_volume` decimal(10,2) DEFAULT NULL COMMENT '最大体积',
  `control_weight` decimal(10,2) DEFAULT NULL COMMENT '控制重量',
  `control_volume` decimal(10,2) DEFAULT NULL COMMENT '控制体积',
  `operate_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人名称',
  `last_generate_time` datetime DEFAULT NULL COMMENT '最后生成航班数据时间',
  `dep_time2` datetime DEFAULT NULL COMMENT '预计起飞2',
  `dest_time2` datetime DEFAULT NULL COMMENT '预计到达2',
  `plan_dep_time2` datetime DEFAULT NULL COMMENT '计划起飞2',
  `plan_dest_time2` datetime DEFAULT NULL COMMENT '计划到达2',
  `act_dep_time2` datetime DEFAULT NULL COMMENT '实际起飞2',
  `act_dest_time2` datetime DEFAULT NULL COMMENT '实际到达2',
  `max_weight2` decimal(10,2) DEFAULT NULL COMMENT '最大业载2',
  `max_volume2` decimal(10,2) DEFAULT NULL COMMENT '最大体积2',
  `control_weight2` decimal(10,2) DEFAULT NULL COMMENT '控制重量2',
  `control_volume2` decimal(10,2) DEFAULT NULL COMMENT '控制体积2',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否删除 0:未删除,1:删除',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人名称',
  `dept_id` bigint DEFAULT NULL COMMENT '创建人部门ID',
  `ancestors` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人部门祖级列表',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='航班计划表';

-- ----------------------------
-- Records of tbl_flight_plan
-- ----------------------------
BEGIN;
INSERT INTO `tbl_flight_plan` (`id`, `flight_no`, `dep`, `dest1`, `dest2`, `carrier`, `status`, `plane_num`, `plane_type`, `begin_date`, `end_date`, `schedule`, `dep_time`, `dest_time`, `plan_dep_time`, `plan_dest_time`, `act_dep_time`, `act_dest_time`, `max_weight`, `max_volume`, `control_weight`, `control_volume`, `operate_by`, `last_generate_time`, `dep_time2`, `dest_time2`, `plan_dep_time2`, `plan_dest_time2`, `act_dep_time2`, `act_dest_time2`, `max_weight2`, `max_volume2`, `control_weight2`, `control_volume2`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('18d8008fe38e284dc22ff064be0d9d26', 'TC212', 'LUN', 'DAR', NULL, 'TC', 4, NULL, 'A320', '2026-05-25', '2026-05-31', '2357', NULL, NULL, NULL, NULL, NULL, NULL, 500.00, 3.00, 500.00, 3.00, 'joann@igsaviation.com', '2026-05-12 07:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-05-11 17:10:45', 'joann@igsaviation.com', NULL, NULL, NULL, NULL);
INSERT INTO `tbl_flight_plan` (`id`, `flight_no`, `dep`, `dest1`, `dest2`, `carrier`, `status`, `plane_num`, `plane_type`, `begin_date`, `end_date`, `schedule`, `dep_time`, `dest_time`, `plan_dep_time`, `plan_dest_time`, `act_dep_time`, `act_dest_time`, `max_weight`, `max_volume`, `control_weight`, `control_volume`, `operate_by`, `last_generate_time`, `dep_time2`, `dest_time2`, `plan_dep_time2`, `plan_dest_time2`, `act_dep_time2`, `act_dest_time2`, `max_weight2`, `max_volume2`, `control_weight2`, `control_volume2`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('565c97011cdcde3f8b57d78cf7469aaf', 'TC5402', 'DAR', 'CAN', NULL, 'TC', 4, 'B-1234', 'B787', '2026-05-01', '2026-05-31', '1234567', NULL, NULL, NULL, NULL, NULL, NULL, 9999.00, 59.99, 9990.00, 50.00, 'admin', '2026-05-11 17:51:17', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-05-11 17:51:11', 'admin', 103, '0,100,101', NULL, NULL);
INSERT INTO `tbl_flight_plan` (`id`, `flight_no`, `dep`, `dest1`, `dest2`, `carrier`, `status`, `plane_num`, `plane_type`, `begin_date`, `end_date`, `schedule`, `dep_time`, `dest_time`, `plan_dep_time`, `plan_dest_time`, `act_dep_time`, `act_dest_time`, `max_weight`, `max_volume`, `control_weight`, `control_volume`, `operate_by`, `last_generate_time`, `dep_time2`, `dest_time2`, `plan_dep_time2`, `plan_dest_time2`, `act_dep_time2`, `act_dest_time2`, `max_weight2`, `max_volume2`, `control_weight2`, `control_volume2`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('5be227bb17baf5ccb6758a3cc65f2f6b', 'TC999', 'DAR', 'CAN', NULL, 'TC', 4, NULL, 'A320', '2026-05-25', '2026-05-25', '1234567', NULL, NULL, NULL, NULL, NULL, NULL, 9999.00, 59.99, 9990.00, 50.00, 'admin', '2026-05-25 18:08:27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-05-25 18:08:20', 'admin', 103, '0,100,101', NULL, NULL);
INSERT INTO `tbl_flight_plan` (`id`, `flight_no`, `dep`, `dest1`, `dest2`, `carrier`, `status`, `plane_num`, `plane_type`, `begin_date`, `end_date`, `schedule`, `dep_time`, `dest_time`, `plan_dep_time`, `plan_dest_time`, `act_dep_time`, `act_dest_time`, `max_weight`, `max_volume`, `control_weight`, `control_volume`, `operate_by`, `last_generate_time`, `dep_time2`, `dest_time2`, `plan_dep_time2`, `plan_dest_time2`, `act_dep_time2`, `act_dest_time2`, `max_weight2`, `max_volume2`, `control_weight2`, `control_volume2`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('6514f0f26d32996447e82a1d3a7ef884', 'TC0518', 'DAR', 'CAN', NULL, 'TC', 4, NULL, 'B737', '2026-05-01', '2026-05-31', '1357', NULL, NULL, NULL, NULL, NULL, NULL, 100000.00, 600.00, 2000.00, 30.00, 'admin', '2026-05-18 18:16:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-05-18 18:15:35', 'admin', 103, '0,100,101', NULL, NULL);
INSERT INTO `tbl_flight_plan` (`id`, `flight_no`, `dep`, `dest1`, `dest2`, `carrier`, `status`, `plane_num`, `plane_type`, `begin_date`, `end_date`, `schedule`, `dep_time`, `dest_time`, `plan_dep_time`, `plan_dest_time`, `act_dep_time`, `act_dest_time`, `max_weight`, `max_volume`, `control_weight`, `control_volume`, `operate_by`, `last_generate_time`, `dep_time2`, `dest_time2`, `plan_dep_time2`, `plan_dest_time2`, `act_dep_time2`, `act_dest_time2`, `max_weight2`, `max_volume2`, `control_weight2`, `control_volume2`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('cf4969c6b0ee92f6e9d94bbbf2952a03', '1ASDFWGA', 'DAR', 'CAN', NULL, 'TC', 1, NULL, 'A35K', '2026-05-05', '2026-05-06', '1234567', NULL, NULL, NULL, NULL, NULL, NULL, 111111.00, 666.67, 11.00, 11.00, 'admin', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-05-11 13:25:23', 'admin', 103, '0,100,101', NULL, NULL);
INSERT INTO `tbl_flight_plan` (`id`, `flight_no`, `dep`, `dest1`, `dest2`, `carrier`, `status`, `plane_num`, `plane_type`, `begin_date`, `end_date`, `schedule`, `dep_time`, `dest_time`, `plan_dep_time`, `plan_dest_time`, `act_dep_time`, `act_dest_time`, `max_weight`, `max_volume`, `control_weight`, `control_volume`, `operate_by`, `last_generate_time`, `dep_time2`, `dest_time2`, `plan_dep_time2`, `plan_dest_time2`, `act_dep_time2`, `act_dest_time2`, `max_weight2`, `max_volume2`, `control_weight2`, `control_volume2`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('efc56e77757b055a5593ba2c12319b7d', 'TC0511', 'DAR', 'CAN', NULL, 'TC', 4, NULL, 'B737', '2026-05-11', '2026-06-11', '1357', NULL, NULL, NULL, NULL, NULL, NULL, 100000.00, 600.00, 1000.00, 6.00, 'represent', '2026-05-11 15:42:49', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-05-11 15:42:19', 'represent', NULL, NULL, NULL, NULL);
INSERT INTO `tbl_flight_plan` (`id`, `flight_no`, `dep`, `dest1`, `dest2`, `carrier`, `status`, `plane_num`, `plane_type`, `begin_date`, `end_date`, `schedule`, `dep_time`, `dest_time`, `plan_dep_time`, `plan_dest_time`, `act_dep_time`, `act_dest_time`, `max_weight`, `max_volume`, `control_weight`, `control_volume`, `operate_by`, `last_generate_time`, `dep_time2`, `dest_time2`, `plan_dep_time2`, `plan_dest_time2`, `act_dep_time2`, `act_dest_time2`, `max_weight2`, `max_volume2`, `control_weight2`, `control_volume2`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('f0cd07a0b2b73361d8d5154a2605c3ad', 'TC189', 'DAR', 'MUX', NULL, 'TC', 4, NULL, 'B787', '2026-05-12', '2026-05-31', '135', NULL, NULL, NULL, NULL, NULL, NULL, 40000.00, 240.00, 3000.00, 200.00, 'sophia.karega@airtanzania.co.tz', '2026-05-12 07:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2026-05-11 16:45:32', 'sophia.karega@airtanzania.co.tz', NULL, NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
