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

 Date: 11/07/2026 01:36:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_booking_cba
-- ----------------------------
DROP TABLE IF EXISTS `tbl_booking_cba`;
CREATE TABLE `tbl_booking_cba` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `booking_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订舱id',
  `flight_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航班号',
  `flight_date` datetime NOT NULL COMMENT '航班日期',
  `flight_dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '始发站',
  `flight_dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第一目的站',
  `prefix` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前缀',
  `cargo_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单号',
  `awb_no` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '运单号(前缀-单号)',
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单始发站',
  `dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单目的站',
  `requires` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组装要求',
  `is_history` tinyint NOT NULL COMMENT '是否历史数据  1:是,0:不是',
  `op_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人名称（操作代理）',
  `op_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人Id',
  `is_delete` tinyint NOT NULL COMMENT '是否删除 0:未删除,1:删除',
  `awb_remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单备注',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人名',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人名',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='航班CBA表（主板要求）';

-- ----------------------------
-- Records of tbl_booking_cba
-- ----------------------------
BEGIN;
INSERT INTO `tbl_booking_cba` (`id`, `booking_id`, `flight_no`, `flight_date`, `flight_dep`, `flight_dest`, `prefix`, `cargo_no`, `awb_no`, `dep`, `dest`, `requires`, `is_history`, `op_name`, `op_id`, `is_delete`, `awb_remark`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('9528e52918b54fcea6cfdf46f88169f1', 'dbb880c8d6f71e478580c9595c2f5580', 'TC0518', '2026-05-20 00:00:00', 'DAR', 'CAN', '197', '21222213', '197-21222213', NULL, NULL, NULL, 0, '111', NULL, 0, '1', '2026-05-23 00:24:01', 'admin', 'admin', '2026-05-23 00:38:16');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
