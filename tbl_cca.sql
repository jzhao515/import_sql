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

 Date: 11/07/2026 01:37:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_cca
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cca`;
CREATE TABLE `tbl_cca` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务主键（关联表ID）',
  `report_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '账单id',
  `type` tinyint NOT NULL COMMENT '类型：0-承运人 1-代理人',
  `international` tinyint NOT NULL COMMENT '国内国际 1-国内 2-国际',
  `bill_status` smallint NOT NULL COMMENT '是否开账：0：未开账、1：已开账',
  `prefix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前缀',
  `cargo_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '单号',
  `awb_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '运单号',
  `agent_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理人代码',
  `agent_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代理人名称',
  `cca_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '更改单号',
  `open_date` datetime NOT NULL COMMENT '开票日期',
  `flight_no` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `flight_date` datetime NOT NULL COMMENT '航班日期',
  `dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '始发站',
  `dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '目的站',
  `arr` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '中转站',
  `refund` decimal(12,2) DEFAULT NULL COMMENT '补(退)款金额',
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '币种',
  `remark` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `cca_no` (`cca_no`) USING BTREE,
  KEY `idx_awb_no` (`awb_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='更改单';

-- ----------------------------
-- Records of tbl_cca
-- ----------------------------
BEGIN;
INSERT INTO `tbl_cca` (`id`, `uuid`, `report_id`, `type`, `international`, `bill_status`, `prefix`, `cargo_no`, `awb_no`, `agent_code`, `agent_name`, `cca_no`, `open_date`, `flight_no`, `flight_date`, `dep`, `dest`, `arr`, `refund`, `currency`, `remark`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('277e046c633d695d2cca547a9c64bd9a', '8e0230678ad64f1d036da16fe824b6d7', NULL, 0, 2, 0, '197', '00013156', '197-00013156', 'IT', 'iTran', '197-0001315601', '2026-05-15 15:41:17', 'TC0511', '2026-05-15 00:00:00', 'DAR', 'CAN', NULL, 110.00, 'TZS', '', '2026-05-15 15:41:17', 'represent', NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
