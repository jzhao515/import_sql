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

 Date: 11/07/2026 01:38:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tbl_volume
-- ----------------------------
DROP TABLE IF EXISTS `tbl_volume`;
CREATE TABLE `tbl_volume` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `awb_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '运单id',
  `hawb_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分单id',
  `ticket_id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '票证id',
  `length` decimal(10,2) DEFAULT NULL COMMENT '长',
  `wide` decimal(10,2) DEFAULT NULL COMMENT '宽',
  `height` decimal(10,2) DEFAULT NULL COMMENT '高',
  `pieces` int DEFAULT NULL COMMENT '件数',
  `volume` decimal(10,2) DEFAULT NULL COMMENT '体积',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='体积表';

-- ----------------------------
-- Records of tbl_volume
-- ----------------------------
BEGIN;
INSERT INTO `tbl_volume` (`id`, `awb_id`, `hawb_id`, `ticket_id`, `length`, `wide`, `height`, `pieces`, `volume`) VALUES ('04c1ada05df4a82f113c43317b0fd0ce', '80f23dd5444139bd7a1b41c16a6ebce9', NULL, NULL, 100.00, 100.00, 100.00, 11, 11000000.00);
INSERT INTO `tbl_volume` (`id`, `awb_id`, `hawb_id`, `ticket_id`, `length`, `wide`, `height`, `pieces`, `volume`) VALUES ('1db4994c4f5dddb2d215d17d4efd6153', '28df709a4273715593edbb154b2bc5ec', NULL, NULL, 111.00, 111.00, 111.00, 11, 15043941.00);
INSERT INTO `tbl_volume` (`id`, `awb_id`, `hawb_id`, `ticket_id`, `length`, `wide`, `height`, `pieces`, `volume`) VALUES ('4b48079d6a5073a488824da932c6ec74', NULL, NULL, '071d4c5975e90080684a36bde2dae8dd', 100.00, 100.00, 100.00, 11, 11000000.00);
INSERT INTO `tbl_volume` (`id`, `awb_id`, `hawb_id`, `ticket_id`, `length`, `wide`, `height`, `pieces`, `volume`) VALUES ('4c5a4d200919f668e23e775261d4bd99', NULL, NULL, '28c336aa96888375d7e47eb2efa1445e', 1.00, 1.00, 1.00, 11, 11.00);
INSERT INTO `tbl_volume` (`id`, `awb_id`, `hawb_id`, `ticket_id`, `length`, `wide`, `height`, `pieces`, `volume`) VALUES ('7a58a2a2054c878a7ff55eeabf8f26f5', '25ab56df09255b42277610f8a9cd7345', NULL, NULL, 111.00, 111.00, 111.00, 11, 15043941.00);
INSERT INTO `tbl_volume` (`id`, `awb_id`, `hawb_id`, `ticket_id`, `length`, `wide`, `height`, `pieces`, `volume`) VALUES ('c3da780f32087499c539b2f10577551d', '4392f3a5933c7356376e5518709609ee', NULL, NULL, 100.00, 100.00, 100.00, 11, 11000000.00);
INSERT INTO `tbl_volume` (`id`, `awb_id`, `hawb_id`, `ticket_id`, `length`, `wide`, `height`, `pieces`, `volume`) VALUES ('e74f12bed0c0106bd1fe58d3efa14db2', NULL, NULL, '7bb9cf032895922cc13cf3d450933895', 111.00, 111.00, 111.00, 11, 15043941.00);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
