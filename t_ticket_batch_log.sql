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

 Date: 11/07/2026 01:35:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_ticket_batch_log
-- ----------------------------
DROP TABLE IF EXISTS `t_ticket_batch_log`;
CREATE TABLE `t_ticket_batch_log` (
  `id` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `start_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '开始号段',
  `end_no` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '结束号段',
  `ticket_type` tinyint(1) NOT NULL COMMENT '票据类型, : 货单, 2: 邮单',
  `international` tinyint(1) NOT NULL COMMENT '国内国际, 1: 国内, 2: 国际',
  `prefix` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前缀',
  `amount` int NOT NULL COMMENT '数量',
  `type` tinyint(1) NOT NULL COMMENT '操作类型, 1: 分配, 2: 入库, 3:核销, 4: 作废, 5: 已使用, 6: 回收, 7: 调配, 8: 配比, 9: 删除',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '操作明细',
  `create_time` datetime NOT NULL COMMENT '操作时间',
  `create_by` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '操作人名称',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='票单批量操作日志表';

-- ----------------------------
-- Records of t_ticket_batch_log
-- ----------------------------
BEGIN;
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('20d9bb3f03495b3c05bf23f9e0a7826e', '00013005', '00013296', 1, 2, '197', 30, 2, 'C_10002000013005-00013296,30张,由admin', '2026-05-11 17:50:00', 'admin', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('3183b82286a10c33946caf54ce2a8acb', '00030004', '00035000', 1, 1, '197', 501, 2, 'C_10002000030004-00035000,501张,由mary.mwaisoloka@airtanzania.co.tz', '2026-05-11 16:32:33', 'mary.mwaisoloka@airtanzania.co.tz', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('4fd7188a9a9d9f78777c7ba7d37d020c', '00005003', '00005106', 1, 1, '197', 11, 2, 'C_10002000005003-00005106,11张,由nizar@ecszanzibar.com', '2026-05-11 16:29:52', 'nizar@ecszanzibar.com', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('63d1917613249a411c97eac90da24831', '00003006', '00004992', 1, 1, '197', 200, 2, 'C_10002000003006-00004992,200张,由rubezosaid2019@gmail.com', '2026-05-11 17:30:34', 'rubezosaid2019@gmail.com', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('7154f3636bc23992540e129b3be21a91', '00008886', '00008971', 1, 1, '197', 10, 2, 'C_10002000008886-00008971,10张,由aishaburhan46@gmail.com', '2026-05-11 16:47:09', 'aishaburhan46@gmail.com', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('76d4e058edba0905c4a85933dbaedcda', '00010010', '00010102', 1, 1, '197', 10, 2, 'C_10002000010010-00010102,10张,由masiku.khitu@airtanzania.co.tz', '2026-05-11 16:31:28', 'masiku.khitu@airtanzania.co.tz', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('7940eb0fe9dc510fc210f5c58f8dfc71', '00001503', '00001794', 1, 2, '197', 30, 2, 'C_10002000001503-00001794,30张,由innocent.swai@airtanzania.co.tz', '2026-05-11 16:41:18', 'innocent.swai@airtanzania.co.tz', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('831b97c4c87c55c32717e4a9d8aad4bd', '00000405', '00000700', 1, 1, '197', 31, 2, 'C_10002000000405-00000700,31张,由sophia.karega@airtanzania.co.tz', '2026-05-11 16:08:23', 'sophia.karega@airtanzania.co.tz', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('867f81766afb67d0a9445fba23aad584', '00011620', '00012003', 1, 1, '197', 39, 2, 'C_10002000011620-00012003,39张,由represent', '2026-05-11 16:51:41', 'represent', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('8f892f1405e2f779db636d0bccff71cd', '00008002', '00008105', 1, 1, '197', 11, 2, 'C_10002000008002-00008105,11张,由aishaburhan46@gmail.com', '2026-05-11 17:04:36', 'aishaburhan46@gmail.com', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('951d2afdf426a4c8a96fe64637475e9b', '00001002', '00001105', 1, 2, '197', 11, 2, 'C_10002000001002-00001105,11张,由represent', '2026-05-11 16:27:05', 'represent', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('9c79f3673b9939cdf4b1ebd1839b7be9', '00002004', '00002096', 1, 1, '197', 10, 2, 'C_10002000002004-00002096,10张,由aishaburhan46@gmail.com', '2026-05-11 16:41:11', 'aishaburhan46@gmail.com', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('be0a6feaf9f28558297a237a97fb6e9e', '00000103', '00000291', 1, 2, '197', 20, 2, 'C_10002000000103-00000291,20张,由represent', '2026-05-11 15:32:42', 'represent', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('c02e688f71d18838a7afb00d2b21f83e', '00000906', '00000954', 1, 1, '197', 6, 2, 'C_10002000000906-00000954,6张,由sophia.karega@airtanzania.co.tz', '2026-05-11 16:23:34', 'sophia.karega@airtanzania.co.tz', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('c08d422a0456653957d01d3fa52143cf', '78900883', '78900975', 1, 2, '197', 10, 2, 'C_10002078900883-78900975,10张,由hellon.magai@airtanzania.co.tz', '2026-05-11 16:36:13', 'hellon.magai@airtanzania.co.tz', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('ca25b0a1ab19f492fde388d143040b4f', '00000803', '00000895', 1, 2, '197', 10, 2, 'C_10002000000803-00000895,10张,由innocent.swai@airtanzania.co.tz', '2026-05-11 16:38:18', 'innocent.swai@airtanzania.co.tz', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('ce01ed29ff9974adfc3643d15621edd5', '00005670', '00005806', 1, 1, '197', 14, 2, 'C_10002000005670-00005806,14张,由joann@igsaviation.com', '2026-05-11 16:51:07', 'joann@igsaviation.com', NULL);
INSERT INTO `t_ticket_batch_log` (`id`, `start_no`, `end_no`, `ticket_type`, `international`, `prefix`, `amount`, `type`, `description`, `create_time`, `create_by`, `remark`) VALUES ('d9f6beefc1b2a48ad4ba4b37130fbc24', '21222213', '21222224', 1, 2, '197', 2, 2, 'C_10002021222213-21222224,2张,由admin', '2026-05-18 18:09:57', 'admin', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
