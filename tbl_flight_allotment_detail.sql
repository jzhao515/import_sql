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

 Date: 11/07/2026 01:37:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_flight_allotment_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbl_flight_allotment_detail`;
CREATE TABLE `tbl_flight_allotment_detail` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `agent_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理人编码',
  `weight_available` decimal(8,2) NOT NULL COMMENT '剩余可用配额重量',
  `volume_available` decimal(8,2) NOT NULL COMMENT '剩余可用配额体积',
  `carrier` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '承运人',
  `weight` decimal(10,2) NOT NULL COMMENT '配额重量',
  `volume` decimal(10,2) NOT NULL COMMENT '配额体积',
  `flight_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航班号',
  `flight_date` date NOT NULL COMMENT '航班日期',
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '始发站',
  `dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第一目的站',
  `create_time` timestamp NOT NULL DEFAULT '2025-11-04 11:27:02' COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人名称',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人名称',
  `allotment_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '配额计划id',
  `airline_icao` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码',
  `release_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '释放状态1:Yes,0:No',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否删除 0:未删除,1:删除'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='配额详情表';

-- ----------------------------
-- Records of tbl_flight_allotment_detail
-- ----------------------------
BEGIN;
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2053743303277727745', 'IT', 200.00, 1.00, 'TC', 200.00, 1.00, 'TC0511', '2026-05-11', 'DAR', 'CAN', '2026-05-11 15:45:35', 'admin', '2026-06-01 10:07:42', 'represent', '2053743303239979009', NULL, 0, 1);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2053743303281922050', 'IT', 200.00, 1.00, 'TC', 200.00, 1.00, 'TC0511', '2026-05-13', 'DAR', 'CAN', '2026-05-11 15:45:35', NULL, NULL, 'represent', '2053743303239979009', NULL, 0, 0);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2053743303281922051', 'IT', 200.00, 1.00, 'TC', 200.00, 1.00, 'TC0511', '2026-05-15', 'DAR', 'CAN', '2026-05-11 15:45:35', NULL, NULL, 'represent', '2053743303239979009', NULL, 0, 0);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2058773257691459585', 'IT', 2000.00, 50.00, 'TC', 2000.00, 50.00, 'TC5402', '2026-05-24', 'DAR', 'CAN', '2026-05-25 12:52:49', 'admin', '2026-05-26 14:59:07', 'admin', '2058773257662099458', NULL, 0, 1);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2058773257691459586', 'IT', 2000.00, 50.00, 'TC', 2000.00, 50.00, 'TC5402', '2026-05-25', 'DAR', 'CAN', '2026-05-25 12:52:49', NULL, NULL, 'admin', '2058773257662099458', NULL, 0, 0);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2058773257691459587', 'IT', 2000.00, 50.00, 'TC', 2000.00, 50.00, 'TC5402', '2026-05-26', 'DAR', 'CAN', '2026-05-25 12:52:49', 'admin', '2026-05-26 11:36:26', 'admin', '2058773257662099458', NULL, 0, 0);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2058857493941317633', 'IT', 2000.00, 10.00, 'TC', 2000.00, 10.00, 'TC999', '2026-05-25', 'DAR', 'CAN', '2026-05-25 18:27:33', 'admin', '2026-06-01 10:07:40', 'admin', '2058857493924540418', NULL, 0, 1);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2059167828933996545', 'IT', 1000.00, 10.00, 'TC', 1000.00, 10.00, 'TC9999', '2026-05-26', 'DAR', 'CAN', '2026-05-26 15:00:43', 'admin', '2026-05-26 15:24:21', 'admin', '2059167828917219329', NULL, 0, 1);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2059175502903898113', 'IT', 0.00, 0.00, 'TC', 1000.00, 10.00, 'TC9999', '2026-05-26', 'DAR', 'CAN', '2026-05-26 15:31:12', 'admin', '2026-06-01 10:07:38', 'admin', '2059175502887120897', NULL, 0, 1);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2059914091526746114', 'IT', 1000.00, 20.00, 'EK', 1000.00, 20.00, 'EK111', '2026-05-28', 'DAR', 'CAN', '2026-05-28 16:26:05', NULL, NULL, 'admin', '2059914091505774594', NULL, 0, 0);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2060176029460590593', 'IT', 5000.00, 40.00, 'EK', 5000.00, 40.00, 'EK111', '2026-05-29', 'DAR', 'CAN', '2026-05-29 09:46:56', NULL, NULL, 'admin', '2060176029443813378', NULL, 0, 0);
INSERT INTO `tbl_flight_allotment_detail` (`id`, `agent_code`, `weight_available`, `volume_available`, `carrier`, `weight`, `volume`, `flight_no`, `flight_date`, `dep`, `dest`, `create_time`, `update_by`, `update_time`, `create_by`, `allotment_id`, `airline_icao`, `release_status`, `is_delete`) VALUES ('2061268383722500098', 'IT', 100.00, 1.00, 'TC', 100.00, 1.00, 'TC0511', '2026-06-01', 'DAR', 'CAN', '2026-06-01 10:07:34', 'admin', '2026-06-01 10:08:55', 'admin', '2061268383705722881', NULL, 0, 0);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
