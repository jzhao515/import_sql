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

 Date: 11/07/2026 01:36:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_awb_param_config
-- ----------------------------
DROP TABLE IF EXISTS `tbl_awb_param_config`;
CREATE TABLE `tbl_awb_param_config` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `international` smallint NOT NULL COMMENT '国内国际 1、国内  2、国际   -1、ALL ',
  `ticket_type` smallint NOT NULL COMMENT '票证类型 1、运单  2、邮单   -1、ALL ',
  `airport` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '机场 （里面ALL表示所有）',
  `goods_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '商品代码',
  `wdp` smallint NOT NULL COMMENT '重量小数位（校验只能输入 -2，-1，0，1，2）',
  `wac` smallint NOT NULL COMMENT '重量精准度 1、四舍五入  2、向上取整',
  `vr` smallint NOT NULL COMMENT '体积重计算',
  `requireds` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '必填项',
  `config_status` smallint NOT NULL COMMENT '状态 0、未启用  1、启用',
  `is_delete` smallint NOT NULL COMMENT '是否删除 1:删除,0:未删除',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='制单参数配置';

-- ----------------------------
-- Records of tbl_awb_param_config
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
