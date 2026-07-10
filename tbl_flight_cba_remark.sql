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

 Date: 11/07/2026 01:37:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_flight_cba_remark
-- ----------------------------
DROP TABLE IF EXISTS `tbl_flight_cba_remark`;
CREATE TABLE `tbl_flight_cba_remark` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `flight_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `flight_date` datetime DEFAULT NULL COMMENT '航班日期',
  `flight_dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '始发站',
  `flight_dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '目的站',
  `version` int DEFAULT NULL COMMENT '版本号',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CBA航班备注';

-- ----------------------------
-- Records of tbl_flight_cba_remark
-- ----------------------------
BEGIN;
INSERT INTO `tbl_flight_cba_remark` (`id`, `flight_no`, `flight_date`, `flight_dep`, `flight_dest`, `version`, `remark`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('f9f51f0061a86f9d8d29015588d2ee4b', 'TC0518', '2026-05-20 00:00:00', 'DAR', 'CAN', 6, NULL, '2026-05-23 00:24:01', 'admin', 'admin', '2026-05-23 00:38:16');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
