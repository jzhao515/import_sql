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

 Date: 11/07/2026 01:38:05
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_flight_position
-- ----------------------------
DROP TABLE IF EXISTS `tbl_flight_position`;
CREATE TABLE `tbl_flight_position` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `dep` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '始发站',
  `dest1` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '目的站1',
  `dest2` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '目的站2',
  `flight_line` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航线',
  `plane_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '机型',
  `max_weight` decimal(10,2) NOT NULL COMMENT '最大业载',
  `control_weight` decimal(10,2) NOT NULL COMMENT '控制重量',
  `open_time` int NOT NULL COMMENT '默认开舱时间',
  `close_time` int NOT NULL COMMENT '默认关舱时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `dept_id` bigint DEFAULT NULL COMMENT '创建人部门ID',
  `ancestors` varchar(500) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人部门祖级列表',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='航班舱位控制表';

-- ----------------------------
-- Records of tbl_flight_position
-- ----------------------------
BEGIN;
INSERT INTO `tbl_flight_position` (`id`, `dep`, `dest1`, `dest2`, `flight_line`, `plane_type`, `max_weight`, `control_weight`, `open_time`, `close_time`, `remark`, `create_time`, `create_by`, `dept_id`, `ancestors`, `update_time`, `update_by`) VALUES ('e18560bdc0737eaf12d6ca69f8edadfa', 'DAR', 'HKG', '', 'DAR-HKG', 'B737', 10000.00, 1000.00, 1, 1, '', '2026-05-11 15:47:05', 'represent', NULL, NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
