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

 Date: 11/07/2026 01:35:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_ticket_warning
-- ----------------------------
DROP TABLE IF EXISTS `t_ticket_warning`;
CREATE TABLE `t_ticket_warning` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `carrier` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航司',
  `prefix` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '航司前缀',
  `amount` int NOT NULL COMMENT '预警值',
  `is_delete` tinyint NOT NULL COMMENT '是否删除 0:未删除,1:删除',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人用户名',
  `update_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人用户名',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_airline` (`carrier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='票证预警表';

-- ----------------------------
-- Records of t_ticket_warning
-- ----------------------------
BEGIN;
INSERT INTO `t_ticket_warning` (`id`, `carrier`, `prefix`, `amount`, `is_delete`, `create_time`, `update_time`, `create_by`, `update_by`) VALUES ('000e840e0ce42bbed59e494dcab3d260', 'TC', '197', 100, 0, '2026-05-15 20:20:54', '2026-05-15 20:20:55', 'represent', 'kizimula.p@dashandling.com');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
