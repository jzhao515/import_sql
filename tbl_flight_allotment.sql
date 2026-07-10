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

 Date: 11/07/2026 01:37:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_flight_allotment
-- ----------------------------
DROP TABLE IF EXISTS `tbl_flight_allotment`;
CREATE TABLE `tbl_flight_allotment` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `carrier` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '承运人',
  `agent_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理人编码',
  `flight_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航班号',
  `begin_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '结束日期',
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '始发站',
  `dest1` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第一目的站',
  `dest2` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第二目的站',
  `plane_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '机型',
  `weight` decimal(10,2) NOT NULL COMMENT '配额重量',
  `volume` decimal(10,2) NOT NULL COMMENT '配额体积',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否删除 0:未删除,1:删除',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人名称',
  `dept_id` bigint DEFAULT NULL COMMENT '创建人部门ID',
  `ancestors` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人部门祖级列表',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人名称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `airline_icao` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='航班配额计划表';

-- ----------------------------
-- Records of tbl_flight_allotment
-- ----------------------------
BEGIN;
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2053743303239979009', 'TC', 'IT', 'TC0511', '2026-05-11', '2026-05-15', 'DAR', 'CAN', NULL, 'B737', 200.00, 1.00, 1, '2026-05-11 15:45:35', 'represent', NULL, NULL, 'admin', '2026-06-01 10:07:42', NULL);
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2058773257662099458', 'TC', 'IT', 'TC5402', '2026-05-24', '2026-05-26', 'DAR', 'CAN', NULL, 'A320', 2000.00, 50.00, 1, '2026-05-25 12:52:49', 'admin', 103, '0,100,101,103', 'admin', '2026-05-26 14:59:07', NULL);
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2058857493924540418', 'TC', 'IT', 'TC999', '2026-05-24', '2026-05-26', 'DAR', 'CAN', NULL, 'A320', 2000.00, 10.00, 1, '2026-05-25 18:27:33', 'admin', 103, '0,100,101,103', 'admin', '2026-06-01 10:07:40', NULL);
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2059167828917219329', 'TC', 'IT', 'TC9999', '2026-05-26', '2026-05-26', 'DAR', 'CAN', NULL, 'A320', 1000.00, 10.00, 1, '2026-05-26 15:00:43', 'admin', 103, '0,100,101,103', 'admin', '2026-05-26 15:24:21', NULL);
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2059175502887120897', 'TC', 'IT', 'TC9999', '2026-05-26', '2026-05-26', 'DAR', 'CAN', NULL, 'A320', 1000.00, 10.00, 1, '2026-05-26 15:31:12', 'admin', 103, '0,100,101,103', 'admin', '2026-06-01 10:07:38', NULL);
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2059914091505774594', 'EK', 'IT', 'EK111', '2026-05-28', '2026-05-28', 'DAR', 'CAN', NULL, 'A320', 1000.00, 20.00, 0, '2026-05-28 16:26:05', 'admin', 103, '0,100,101,103', NULL, NULL, NULL);
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2060176029443813378', 'EK', 'IT', 'EK111', '2026-05-29', '2026-05-29', 'DAR', 'CAN', NULL, 'A320', 5000.00, 40.00, 0, '2026-05-29 09:46:56', 'admin', 103, '0,100,101,103', NULL, NULL, NULL);
INSERT INTO `tbl_flight_allotment` (`id`, `carrier`, `agent_code`, `flight_no`, `begin_date`, `end_date`, `dep`, `dest1`, `dest2`, `plane_type`, `weight`, `volume`, `is_delete`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_by`, `update_time`, `airline_icao`) VALUES ('2061268383705722881', 'TC', 'IT', 'TC0511', '2026-06-01', '2026-06-01', 'DAR', 'CAN', NULL, 'B737', 100.00, 1.00, 0, '2026-06-01 10:07:34', 'admin', 103, '0,100,101,103', NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
