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

 Date: 11/07/2026 01:37:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_cargo_info_original
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cargo_info_original`;
CREATE TABLE `tbl_cargo_info_original` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务主键（上游数据id）',
  `cal_flag` smallint DEFAULT NULL COMMENT '计算标识\r\n          红色：计算成功不一致(2)\r\n          黄色：无舱单(3)\r\n          黑色：计算失败(4)\r\n          灰色：未计算(0)\r\n          绿色：计算成功一致(1)',
  `prefix` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前缀',
  `cargo_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单号',
  `awb_no` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '运单号',
  `awb_carrier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单承运人',
  `international` tinyint DEFAULT NULL COMMENT '国内国际 1、国内  2、国际',
  `ticket_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '票证id',
  `open_date` date NOT NULL COMMENT '开票日期',
  `airline_org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司代码',
  `cargo_dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单始发站',
  `cargo_dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单目的站',
  `cargo_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单类型:1:货单AWB 2:邮单MAIL 3:其他运单OTH',
  `agent_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理人编码',
  `agent_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理人名称',
  `flight_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航班号',
  `carrier` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '承运人',
  `airline_icao` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码',
  `airline_icao1` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码(第一程)',
  `flight_date` date NOT NULL COMMENT '航班日期',
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '始发站',
  `dep_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '始发站名称',
  `dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '第一目的站',
  `dest_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '目的站名称',
  `dest1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第一目的站',
  `arr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '中转站',
  `flight_nature` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航程',
  `flight_no2` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第二航班号',
  `airline_icao2` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码(第二程)',
  `flight_date2` date DEFAULT NULL COMMENT '第二航班日期',
  `carrier2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第二承运人',
  `dep2` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第二始发站',
  `dest2` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第二到达站',
  `flight_no3` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三航班号',
  `airline_icao3` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码(第三程)',
  `carrier3` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三承运人',
  `flight_date3` date DEFAULT NULL COMMENT '第三航班日期',
  `dep3` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三始发站',
  `dest3` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三到达站',
  `rate_class` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运价种类',
  `rate_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运价名称',
  `rate_type` int DEFAULT NULL COMMENT '费率类型 0为正常费率 1为一票一议 2为自动计算运价',
  `currency` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品名',
  `goods_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结算货物类型',
  `goods_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品代码',
  `pc` int DEFAULT NULL COMMENT '件数',
  `weight` decimal(10,2) DEFAULT NULL COMMENT '重量',
  `charge_weight` decimal(10,2) DEFAULT NULL COMMENT '计费重量',
  `volume` decimal(30,2) DEFAULT NULL COMMENT '体积',
  `spcode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '特码',
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
  `total_amount` decimal(10,2) DEFAULT NULL COMMENT '总金额',
  `remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='运单表原始表';

-- ----------------------------
-- Records of tbl_cargo_info_original
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
