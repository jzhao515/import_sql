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

 Date: 11/07/2026 01:36:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_booking_availability
-- ----------------------------
DROP TABLE IF EXISTS `tbl_booking_availability`;
CREATE TABLE `tbl_booking_availability` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `ticket_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '入库id(票证id)',
  `booking_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订舱id',
  `international` tinyint(1) DEFAULT NULL COMMENT '国内国际, 1: 国内, 2: 国际',
  `flight_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班id',
  `prefix` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '前缀',
  `cargo_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '单号',
  `awb_no` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单号',
  `cargo_dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单始发站',
  `cargo_dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单目的站',
  `flight_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `flight_date` date DEFAULT NULL COMMENT '航班日期',
  `flight_dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班始发站',
  `flight_dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班目的站',
  `priority` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '优先级 MG or SB',
  `volume_weight` decimal(10,2) DEFAULT NULL COMMENT '体积重量',
  `status` tinyint DEFAULT NULL COMMENT '订舱状态 :0,NN/NA申请待批、1,KK审批同意、2,UU审批拒绝、3,LL候补',
  `pc_remark` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '批舱备注',
  `reply_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '审批人',
  `booking_weight` decimal(10,2) DEFAULT NULL COMMENT '批复重量(暂时未使用到)',
  `booking_volume` decimal(10,2) DEFAULT NULL COMMENT '批复体积(暂时未使用到)',
  `allotment_flag` tinyint DEFAULT NULL COMMENT '是否使用配额 0 未使用 1 已使用',
  `goods_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '品名描述',
  `goods_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品类型',
  `goods_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品代码',
  `pc` int NOT NULL COMMENT '订舱件数',
  `weight` decimal(10,2) NOT NULL COMMENT '订舱重量',
  `charge_weight` decimal(10,2) NOT NULL COMMENT '计费重量',
  `volume` decimal(10,2) NOT NULL COMMENT '体积',
  `size` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '尺寸',
  `rate` decimal(10,2) DEFAULT NULL COMMENT '费率(暂时未使用到)',
  `weight_charge` decimal(10,2) DEFAULT NULL COMMENT '航空运费(暂时未使用到)',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `spcode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '特码',
  `packing` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '包装',
  `op_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '订舱人',
  `op_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人Id',
  `segment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物航程',
  `sale_type` tinyint(1) DEFAULT NULL COMMENT '销售类型 0、普通 1、包舱 2、包量 3、短款 4、更改单',
  `is_make_order` tinyint DEFAULT NULL COMMENT '是否制单(0:未制单，1已制单)',
  `reply_time` datetime DEFAULT NULL COMMENT '审批时间',
  `reject_reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '拒绝原因',
  `reject_time` datetime DEFAULT NULL COMMENT '拒舱历史',
  `weight_available` decimal(8,2) DEFAULT NULL COMMENT '配额重量',
  `volume_available` decimal(8,2) DEFAULT NULL COMMENT '配额体积',
  `open_weight` decimal(8,2) DEFAULT NULL COMMENT '开放重量',
  `open_volume` decimal(8,2) DEFAULT NULL COMMENT '开放体积',
  `control_weight` decimal(8,2) DEFAULT NULL COMMENT '控制重量',
  `control_volume` decimal(8,2) DEFAULT NULL COMMENT '控制体积',
  `manual_approval` tinyint DEFAULT NULL COMMENT '手动审批：0自动审批 1,手动审批',
  `airline_org_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司代码',
  `arrangement` tinyint DEFAULT NULL COMMENT '层次',
  `item_first_fdep` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物第一始发站',
  `item_first_fdest` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物第一目的站',
  `item_first_carrier` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物第一承运人',
  `item_second_fdest` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物第二目的站',
  `item_second_carrier` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物第二承运人',
  `item_third_fdest` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物第三目的站',
  `item_third_carrier` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '货物第三承运人',
  `direct_flight_or_transfer` tinyint DEFAULT NULL COMMENT '订舱类型：0，直飞；1：中转',
  `airline_icao1` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码(第一程)',
  `airline_icao2` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码(第二程)',
  `airline_icao3` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航司ICAO码(第三程)',
  `is_delete` tinyint DEFAULT NULL COMMENT '是否删除 0：未删除 1：删除',
  `is_history` tinyint DEFAULT NULL COMMENT '是否历史数据  1:是,0:不是',
  `create_time` datetime DEFAULT NULL COMMENT '订舱时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `agent_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代理人名称',
  `agent_code` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '代理人编码',
  `transcribe_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '转订原因',
  `hs_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'HSCode',
  `ancestors` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '部门祖级',
  `data_sources` smallint DEFAULT '0' COMMENT '数据来源，0：本系统自生成数据，1：圆通国际，2：webcargo',
  `availability_json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '报价json数据',
  `size_data` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '尺寸（不带单位）',
  `op_json_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '订舱json数据',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='订舱报价表';

-- ----------------------------
-- Records of tbl_booking_availability
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
