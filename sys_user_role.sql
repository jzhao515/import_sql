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

 Date: 11/07/2026 01:34:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (1, 1);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (5, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (6, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (8, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (10, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (10, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (12, 2);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (13, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (14, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (15, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (16, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (19, 7);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (23, 9);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (24, 10);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (25, 12);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (26, 12);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (35, 9);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (35, 17);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (36, 13);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (37, 13);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (38, 13);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (40, 14);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (42, 3);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (43, 15);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (44, 17);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (46, 17);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (48, 12);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (51, 15);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (52, 18);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (53, 12);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (54, 15);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (55, 19);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (56, 6);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (60, 19);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (60, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (179, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (180, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (181, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (182, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (183, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (184, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (185, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (186, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (187, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (188, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (189, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (190, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (191, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (192, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (193, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (194, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (195, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (196, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (197, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (198, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (199, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (200, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (201, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (202, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (203, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (204, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (205, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (206, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (207, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (208, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (209, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (210, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (211, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (212, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (213, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (214, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (215, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (216, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (217, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (218, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (219, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (220, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (221, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (222, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (223, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (224, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (225, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (226, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (227, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (228, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (229, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (230, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (231, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (232, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (233, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (234, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (235, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (236, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (237, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (238, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (239, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (240, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (241, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (242, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (243, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (244, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (245, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (246, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (247, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (248, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (249, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (250, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (251, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (252, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (253, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (254, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (255, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (256, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (257, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (258, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (259, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (260, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (261, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (262, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (263, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (264, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (265, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (266, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (267, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (268, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (269, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (270, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (271, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (272, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (273, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (274, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (275, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (276, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (277, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (278, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (279, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (280, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (281, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (282, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (283, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (284, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (285, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (286, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (287, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (288, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (289, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (290, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (291, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (292, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (293, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (294, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (295, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (296, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (297, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (298, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (299, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (300, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (301, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (302, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (303, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (304, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (305, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (306, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (307, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (308, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (309, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (310, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (311, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (312, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (313, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (314, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (315, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (316, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (317, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (318, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (319, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (320, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (321, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (322, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (323, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (324, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (325, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (326, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (327, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (328, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (329, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (330, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (331, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (332, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (333, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (334, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (335, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (336, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (337, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (338, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (339, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (340, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (341, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (342, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (343, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (344, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (345, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (346, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (347, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (348, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (349, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (350, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (351, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (352, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (353, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (354, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (355, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (356, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (357, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (358, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (359, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (360, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (361, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (362, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (363, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (364, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (365, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (366, 21);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (369, 25);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (370, 25);
INSERT INTO `sys_user_role` (`user_id`, `role_id`) VALUES (371, 26);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
