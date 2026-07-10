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

 Date: 11/07/2026 01:34:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_ticket_assign
-- ----------------------------
DROP TABLE IF EXISTS `t_ticket_assign`;
CREATE TABLE `t_ticket_assign` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `prefix` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '前缀',
  `international` tinyint NOT NULL COMMENT '国内国际, 1: 国内, 2: 国际',
  `ticketType` tinyint NOT NULL COMMENT '票据类型, 1: 货单, 2: 邮单, 3: 变更单, 4: 纸质调拨单, 5: 纸箱提货单,6:公务免单',
  `amount` int NOT NULL COMMENT '数量',
  `assign_user_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分配人, 引 user表主键',
  `assign_user_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分配人名称',
  `start_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '开始号, 8位号段的开始',
  `end_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '结束号',
  `remark` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `receive_unit` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '领用单位, 引用部门表sys_org 主键',
  `unit_type` tinyint NOT NULL COMMENT '单位类型, 1: 总部或者外站,  2: 代理人',
  `parent_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上一次分配id, 引本表的主键，用于追溯上一次分配人',
  `plane_type` tinyint NOT NULL DEFAULT '1' COMMENT '客货类型，1：客机腹仓 ，2：货机',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人名称',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `last_stock_status` tinyint DEFAULT NULL COMMENT '上一次的库存状态, 1: 总部库存(未分配), 2: 代理库存, 3: 外站财务库存',
  `last_used_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上一次的领用单位id',
  `last_used_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上一次的领用单位名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='票证分配表';

-- ----------------------------
-- Records of t_ticket_assign
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
