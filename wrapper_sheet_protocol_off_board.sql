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

 Date: 11/07/2026 01:39:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for wrapper_sheet_protocol_off_board
-- ----------------------------
DROP TABLE IF EXISTS `wrapper_sheet_protocol_off_board`;
CREATE TABLE `wrapper_sheet_protocol_off_board` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键ID',
  `report_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '账单id',
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '业务主键（上游原始数据tbl_awb表id）',
  `prefix` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '前缀',
  `cargo_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '单号',
  `awb_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单号',
  `international` smallint DEFAULT NULL COMMENT '国内国际 1、国内  2、国际',
  `open_date` datetime DEFAULT NULL COMMENT '开票日期',
  `cargo_type` smallint DEFAULT NULL COMMENT '运单类型 1、运单，2、邮单，3、其他，4、更改单，5、作废单',
  `agent_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代理人编码',
  `agent_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代理人名称',
  `flight_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `carrier` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '承运人',
  `flight_date` datetime DEFAULT NULL COMMENT '航班日期',
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '始发站',
  `dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '目的站',
  `arr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '中转站',
  `flight_nature` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航程',
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '币种',
  `goods_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品名',
  `goods_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结算货物类型',
  `goods_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品代码',
  `pc` int DEFAULT NULL COMMENT '件数',
  `weight` decimal(10,2) DEFAULT NULL COMMENT '重量',
  `charge_weight` decimal(10,2) DEFAULT NULL COMMENT '计费重量',
  `settle_weight` decimal(10,2) DEFAULT NULL COMMENT '结算重量',
  `volume` decimal(10,2) DEFAULT NULL COMMENT '体积',
  `rate` decimal(10,2) DEFAULT NULL COMMENT '费率',
  `flight_fee` decimal(10,2) DEFAULT NULL COMMENT '航空运费',
  `fuel_fee` decimal(10,2) DEFAULT NULL COMMENT '燃油附加费',
  `awc` decimal(10,2) DEFAULT NULL COMMENT '制单费',
  `dvc` decimal(10,2) DEFAULT NULL COMMENT '声明价值附加费',
  `sfc` decimal(10,2) DEFAULT NULL COMMENT '地面运费',
  `msc` decimal(10,2) DEFAULT NULL COMMENT '战险费',
  `cca_fee` decimal(10,2) DEFAULT NULL COMMENT 'cca费用',
  `tax` decimal(10,2) DEFAULT NULL COMMENT '税费',
  `other_fee` decimal(10,2) DEFAULT NULL COMMENT '其他费用',
  `total_other_fee` decimal(10,2) DEFAULT NULL COMMENT '杂费合计',
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '小计',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_report_id` (`report_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='包板协议-自由销售计算-板外';

-- ----------------------------
-- Records of wrapper_sheet_protocol_off_board
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
