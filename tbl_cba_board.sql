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

 Date: 11/07/2026 01:37:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_cba_board
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cba_board`;
CREATE TABLE `tbl_cba_board` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `booking_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订舱id',
  `awb_no` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单号',
  `flight_no` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '航班号',
  `flight_date` datetime DEFAULT NULL COMMENT '航班日期',
  `flight_dep` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '始发站',
  `flight_dest` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第一目的站',
  `board_type` tinyint DEFAULT NULL COMMENT '组板类型',
  `uld` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集装器',
  `uld_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `load_form_code` tinyint DEFAULT NULL COMMENT '轮廓代码',
  `number` int NOT NULL COMMENT '数量',
  `merge_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '合并号',
  `is_bup` tinyint(1) DEFAULT NULL COMMENT '是否bup 0、否 1、是',
  `is_priority` tinyint(1) DEFAULT NULL COMMENT '是否优先 0、否 1、是',
  `is_delete` tinyint(1) NOT NULL COMMENT '是否删除 0:未删除,1:删除',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='CBA组板信息';

-- ----------------------------
-- Records of tbl_cba_board
-- ----------------------------
BEGIN;
INSERT INTO `tbl_cba_board` (`id`, `booking_id`, `awb_no`, `flight_no`, `flight_date`, `flight_dep`, `flight_dest`, `board_type`, `uld`, `uld_no`, `load_form_code`, `number`, `merge_no`, `is_bup`, `is_priority`, `is_delete`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('1494b4cd009c3196ae383021c9752fb8', 'dbb880c8d6f71e478580c9595c2f5580', '197-21222213', 'TC0518', '2026-05-20 00:00:00', 'DAR', 'CAN', NULL, 'PMC-Q4', '01', NULL, 1, '3ec0864f-daa1-4a29-8b2c-fb4340c3e8d9', NULL, NULL, 1, '2026-05-23 00:25:21', 'admin', NULL, NULL);
INSERT INTO `tbl_cba_board` (`id`, `booking_id`, `awb_no`, `flight_no`, `flight_date`, `flight_dep`, `flight_dest`, `board_type`, `uld`, `uld_no`, `load_form_code`, `number`, `merge_no`, `is_bup`, `is_priority`, `is_delete`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('6c13a95aeacdef7cf3e7496290d8b2bc', 'dbb880c8d6f71e478580c9595c2f5580', '197-21222213', 'TC0518', '2026-05-20 00:00:00', 'DAR', 'CAN', NULL, 'PMC-Q5', '01', NULL, 1, 'b1e0a30e-1774-4a09-a617-2245eb369705', NULL, NULL, 0, '2026-05-23 00:38:16', 'admin', NULL, NULL);
INSERT INTO `tbl_cba_board` (`id`, `booking_id`, `awb_no`, `flight_no`, `flight_date`, `flight_dep`, `flight_dest`, `board_type`, `uld`, `uld_no`, `load_form_code`, `number`, `merge_no`, `is_bup`, `is_priority`, `is_delete`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('889a663a5a62323892f95cf4e5d9e66b', 'dbb880c8d6f71e478580c9595c2f5580', '197-21222213', 'TC0518', '2026-05-20 00:00:00', 'DAR', 'CAN', NULL, 'PMC-Q6', '01,02,03,04,05', NULL, 5, 'd5258aaa-7c66-46e2-8981-8f19954d117c', NULL, NULL, 1, '2026-05-23 00:27:37', 'admin', NULL, NULL);
INSERT INTO `tbl_cba_board` (`id`, `booking_id`, `awb_no`, `flight_no`, `flight_date`, `flight_dep`, `flight_dest`, `board_type`, `uld`, `uld_no`, `load_form_code`, `number`, `merge_no`, `is_bup`, `is_priority`, `is_delete`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('b9c0e0d758e7d39845c4b893ce9526a1', 'dbb880c8d6f71e478580c9595c2f5580', '197-21222213', 'TC0518', '2026-05-20 00:00:00', 'DAR', 'CAN', NULL, 'PMC-Q4', '02', NULL, 1, '3ec0864f-daa1-4a29-8b2c-fb4340c3e8d9', NULL, NULL, 1, '2026-05-23 00:25:21', 'admin', NULL, NULL);
INSERT INTO `tbl_cba_board` (`id`, `booking_id`, `awb_no`, `flight_no`, `flight_date`, `flight_dep`, `flight_dest`, `board_type`, `uld`, `uld_no`, `load_form_code`, `number`, `merge_no`, `is_bup`, `is_priority`, `is_delete`, `create_time`, `create_by`, `update_by`, `update_time`) VALUES ('d39326d7ab05347287e31310235efa72', 'dbb880c8d6f71e478580c9595c2f5580', '197-21222213', 'TC0518', '2026-05-20 00:00:00', 'DAR', 'CAN', NULL, 'PMC-Q5', '01', NULL, 1, 'ec8267ec-f692-4523-8525-d17f35399d32', NULL, NULL, 1, '2026-05-23 00:24:01', 'admin', NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
