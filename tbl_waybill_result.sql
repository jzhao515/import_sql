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

 Date: 11/07/2026 01:38:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_waybill_result
-- ----------------------------
DROP TABLE IF EXISTS `tbl_waybill_result`;
CREATE TABLE `tbl_waybill_result` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件名',
  `upload_file_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上传文件后返回的id',
  `upload_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上传请求的参数',
  `upload_result` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '上传返回的结果集',
  `chat_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '识别请求的参数',
  `chat_result` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '识别上传返回的结果集',
  `file_base64` longblob COMMENT '文件base64',
  `ys_file_base64` longblob COMMENT '压缩的文件base64',
  `chat_modify_result` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '界面修正后的数据，可以直接转成awbVO',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '文件后缀',
  `status` smallint DEFAULT NULL COMMENT '运单解析状态：0：解析中；1：已完成；2：已修正；3：识别失败',
  `is_delete` smallint DEFAULT NULL COMMENT '是否删除 0：未删除；1:已删除',
  `chat_time` datetime DEFAULT NULL COMMENT '识别完成时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '更新人',
  `storage_key` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'MinIO 存储键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of tbl_waybill_result
-- ----------------------------
BEGIN;
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
