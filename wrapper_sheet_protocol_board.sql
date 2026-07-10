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

 Date: 11/07/2026 01:38:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for wrapper_sheet_protocol_board
-- ----------------------------
DROP TABLE IF EXISTS `wrapper_sheet_protocol_board`;
CREATE TABLE `wrapper_sheet_protocol_board` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `report_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '账单id',
  `board_type` smallint DEFAULT NULL COMMENT '1：板内 2：板外',
  `flight_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `flight_date` date DEFAULT NULL COMMENT '航班日期',
  `dep` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '舱单起运站',
  `dest` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '舱单到达站',
  `uld_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '箱板号',
  `load_form_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '轮廓代码',
  `board_actual_weight` decimal(10,2) DEFAULT NULL COMMENT '板内实际重量',
  `basis_weight` decimal(10,2) DEFAULT NULL COMMENT '基量',
  `basis_cost` decimal(10,2) DEFAULT NULL COMMENT '基重运费',
  `basis_price` decimal(10,2) DEFAULT NULL COMMENT '基重运价',
  `overweight_board` decimal(10,2) DEFAULT NULL COMMENT '板内超重',
  `overweight_price` decimal(10,2) DEFAULT NULL COMMENT '超重运价',
  `overweight_cost` decimal(10,2) DEFAULT NULL COMMENT '超重运费',
  `free_weight` decimal(10,2) DEFAULT NULL COMMENT '自由销售重量',
  `free_cost` decimal(10,2) DEFAULT NULL COMMENT '自由销售运费',
  `total_other_fee` decimal(10,2) DEFAULT NULL COMMENT '其他费用',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '合计',
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '币种',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_report_id` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='包板协议-板内板外';

-- ----------------------------
-- Records of wrapper_sheet_protocol_board
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
