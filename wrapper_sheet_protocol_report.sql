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

 Date: 11/07/2026 01:39:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for wrapper_sheet_protocol_report
-- ----------------------------
DROP TABLE IF EXISTS `wrapper_sheet_protocol_report`;
CREATE TABLE `wrapper_sheet_protocol_report` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `report_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '账单id',
  `segment_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '协议-航程id',
  `segment_ids` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '协议-航程id,同一个组下的',
  `flight_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `flight_nature` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航段',
  `flight_line` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航线',
  `merge_flight_number` int DEFAULT NULL COMMENT '合并考核飞机架次',
  `single_basis_weight` decimal(10,2) DEFAULT NULL COMMENT '单班包板签约基重',
  `modify_merge_flight_number` int DEFAULT NULL COMMENT '考核飞机架次（最新修改的）',
  `max_flight_number` int DEFAULT NULL COMMENT '考核飞机架次(最大)',
  `check_price` decimal(10,2) DEFAULT NULL COMMENT '考核运价',
  `merge_signing_total` decimal(10,2) DEFAULT NULL COMMENT '合并考核期签约总量',
  `merge_finish_total` decimal(10,2) DEFAULT NULL COMMENT '合并考核期完成总量',
  `merge_shortfall_total` decimal(10,2) DEFAULT NULL COMMENT '合并考核期差额总量',
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '币种',
  `board_free_cost` decimal(18,2) DEFAULT NULL COMMENT '板内运费小计',
  `off_board_free_cost` decimal(18,2) DEFAULT NULL COMMENT '板外运费小计',
  `merge_supplementary_amount` decimal(18,2) DEFAULT NULL COMMENT '合并考核期补差金额',
  `total_amount` decimal(18,2) DEFAULT NULL COMMENT '应收合计',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_report_id` (`report_id`) USING BTREE,
  KEY `idx_segment_id` (`segment_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='包板协议-账单总表';

-- ----------------------------
-- Records of wrapper_sheet_protocol_report
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
