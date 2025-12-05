/*
 Navicat Premium Data Transfer

 Source Server         : localhost-docker
 Source Server Type    : MySQL
 Source Server Version : 90200 (9.2.0)
 Source Host           : localhost:3306
 Source Schema         : paiad_leadnews_wemedia

 Target Server Type    : MySQL
 Target Server Version : 90200 (9.2.0)
 File Encoding         : 65001

 Date: 06/12/2025 01:00:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for wm_channel
-- ----------------------------
DROP TABLE IF EXISTS `wm_channel`;
CREATE TABLE `wm_channel`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '频道名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '频道描述',
  `is_default` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否默认频道',
  `status` tinyint UNSIGNED NULL DEFAULT NULL,
  `ord` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '默认排序',
  `created_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '频道信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wm_channel
-- ----------------------------
INSERT INTO `wm_channel` VALUES (1, 'Java', '后端框架', 1, 1, 1, '2021-04-18 12:25:30');
INSERT INTO `wm_channel` VALUES (2, 'Mysql', '轻量级数据库', 1, 1, 4, '2021-04-18 10:55:41');
INSERT INTO `wm_channel` VALUES (3, 'Vue', '阿里前端框架', 1, 1, 5, '2021-04-18 10:55:41');
INSERT INTO `wm_channel` VALUES (4, 'Python', '未来的语言', 1, 1, 6, '2021-04-18 10:55:41');
INSERT INTO `wm_channel` VALUES (5, 'Redis', '非关系型数据库', 1, 1, 7, '2021-04-18 10:55:41');
INSERT INTO `wm_channel` VALUES (6, '大数据', '数据是当今世界必不可缺的', 1, 1, 10, '2021-04-18 10:55:41');
INSERT INTO `wm_channel` VALUES (7, '其他', '其他', 1, 1, 12, '2021-04-18 10:55:41');
INSERT INTO `wm_channel` VALUES (8, 'Pumpkin', '南瓜田', 0, 1, 0, '2025-12-04 23:56:47');

-- ----------------------------
-- Table structure for wm_fans_statistics
-- ----------------------------
DROP TABLE IF EXISTS `wm_fans_statistics`;
CREATE TABLE `wm_fans_statistics`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '主账号ID',
  `article` int UNSIGNED NULL DEFAULT NULL COMMENT '子账号ID',
  `read_count` int UNSIGNED NULL DEFAULT NULL,
  `comment` int UNSIGNED NULL DEFAULT NULL,
  `follow` int UNSIGNED NULL DEFAULT NULL,
  `collection` int UNSIGNED NULL DEFAULT NULL,
  `forward` int UNSIGNED NULL DEFAULT NULL,
  `likes` int UNSIGNED NULL DEFAULT NULL,
  `unlikes` int UNSIGNED NULL DEFAULT NULL,
  `unfollow` int UNSIGNED NULL DEFAULT NULL,
  `burst` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_time` date NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_id_time`(`user_id` ASC, `created_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '自媒体粉丝数据统计表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wm_fans_statistics
-- ----------------------------

-- ----------------------------
-- Table structure for wm_material
-- ----------------------------
DROP TABLE IF EXISTS `wm_material`;
CREATE TABLE `wm_material`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '自媒体用户ID',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图片地址',
  `type` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '素材类型\r\n            0 图片\r\n            1 视频',
  `is_collection` tinyint(1) NULL DEFAULT NULL COMMENT '是否收藏',
  `created_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 270 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '自媒体图文素材信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wm_material
-- ----------------------------
INSERT INTO `wm_material` VALUES (74, 1102, 'http://localhost:9000/leadnews/2025/12/03/e0c8224b60a6416cb86e7e331a360f54.png', 0, 1, '2025-12-03 15:56:10');
INSERT INTO `wm_material` VALUES (75, 1102, 'http://localhost:9000/leadnews/2025/12/03/beef515f36774ff39b2d77ddd842a165.jpg', 0, 0, '2025-12-03 16:23:04');
INSERT INTO `wm_material` VALUES (76, 1102, 'http://localhost:9000/leadnews/2025/12/03/f0bfe5b587704bc38582804ef3577f90.png', 0, 1, '2025-12-03 16:31:43');
INSERT INTO `wm_material` VALUES (78, 1102, 'http://localhost:9000/leadnews/2025/12/03/0c5acd0e6e844b698b9df73ecfb3f851.jpg', 0, 1, '2025-12-03 18:00:04');
INSERT INTO `wm_material` VALUES (79, 1102, 'http://localhost:9000/leadnews/2025/12/03/ee6eb2e3ee7944c997aae152a7c50198.png', 0, 0, '2025-12-03 19:03:48');
INSERT INTO `wm_material` VALUES (82, 1102, 'http://localhost:9000/leadnews/2025/12/04/bfbf5d6623e941d981c4c9ea3a27e28a.jpg', 0, 0, '2025-12-04 01:31:48');
INSERT INTO `wm_material` VALUES (85, 1102, 'http://localhost:9000/leadnews/2025/12/04/6f8222b697034d1cb81edd19b88b94f4.png', 0, 0, '2025-12-04 01:37:10');
INSERT INTO `wm_material` VALUES (86, 1102, 'http://localhost:9000/leadnews/2025/12/04/5b60713edc5f451ba9de908b272d3f4b.png', 0, 0, '2025-12-04 01:48:11');
INSERT INTO `wm_material` VALUES (88, 1102, 'http://localhost:9000/leadnews/2025/12/04/a8f65c1726684936bfda729ad1c18372.jpg', 0, 1, '2025-12-04 13:30:38');
INSERT INTO `wm_material` VALUES (89, 1102, 'http://localhost:9000/leadnews/2025/12/04/ea9f7628037e4acb84d1eb4488f15af0.png', 0, 0, '2025-12-04 13:47:42');
INSERT INTO `wm_material` VALUES (90, 1102, 'http://localhost:9000/leadnews/2025/12/04/de1f320525f24385816ff643ae715715.jpg', 0, 0, '2025-12-04 15:56:49');
INSERT INTO `wm_material` VALUES (91, 1102, 'http://localhost:9000/leadnews/2025/12/04/fdf97628e1c548b3a9079fd22a83c3c1.jpg', 0, 0, '2025-12-04 15:56:56');
INSERT INTO `wm_material` VALUES (92, 1102, 'http://localhost:9000/leadnews/2025/12/04/dfeb09bc3e1248f48f1387f65e9bb29f.jpg', 0, 0, '2025-12-04 15:57:02');
INSERT INTO `wm_material` VALUES (93, 1102, 'http://localhost:9000/leadnews/2025/12/04/5f93b880b3d94c01b01cc81d3723823a.jpg', 0, 0, '2025-12-04 15:58:30');
INSERT INTO `wm_material` VALUES (95, 1102, 'http://localhost:9000/leadnews/2025/12/04/8070501b8a4f4a1da6eae1d6b31aa933.jpg', 0, 0, '2025-12-04 15:58:43');
INSERT INTO `wm_material` VALUES (97, 1102, 'http://localhost:9000/leadnews/2025/12/04/31bd269805ca457aa3f75ec04c9f625a.jpg', 0, 0, '2025-12-04 16:02:26');
INSERT INTO `wm_material` VALUES (98, 1102, 'http://localhost:9000/leadnews/2025/12/04/3ae27ca7ffc64cc3b0ffaf1b07bf95cd.jpg', 0, 0, '2025-12-04 16:02:30');
INSERT INTO `wm_material` VALUES (99, 1102, 'http://localhost:9000/leadnews/2025/12/04/7fe8b472224b4a1aa3432989fd2f4cf4.jpg', 0, 0, '2025-12-04 16:02:33');
INSERT INTO `wm_material` VALUES (100, 1102, 'http://localhost:9000/leadnews/2025/12/04/a5fac02a9bdc4bc0b27674e2c7fc78ad.jpg', 0, 0, '2025-12-04 16:02:38');
INSERT INTO `wm_material` VALUES (101, 1102, 'http://localhost:9000/leadnews/2025/12/04/610476893f2247da838e6360573bfc31.jpg', 0, 0, '2025-12-04 16:03:34');
INSERT INTO `wm_material` VALUES (102, 1102, 'http://localhost:9000/leadnews/2025/12/04/a286911df3224e64b67cd939245b182d.jpg', 0, 0, '2025-12-04 16:03:38');
INSERT INTO `wm_material` VALUES (103, 1102, 'http://localhost:9000/leadnews/2025/12/04/156d4e3e852a4f3297ada1c66e9988e2.jpg', 0, 0, '2025-12-04 16:03:42');
INSERT INTO `wm_material` VALUES (104, 1102, 'http://localhost:9000/leadnews/2025/12/04/7d0cb6068a0c4bdc972a4d19ef9599e5.jpg', 0, 0, '2025-12-04 16:03:47');
INSERT INTO `wm_material` VALUES (105, 1102, 'http://localhost:9000/leadnews/2025/12/04/aa50772ffe67463eb7653e22b7a2075d.jpg', 0, 0, '2025-12-04 16:03:52');
INSERT INTO `wm_material` VALUES (106, 1102, 'http://localhost:9000/leadnews/2025/12/04/73be619a51d241158cd3f030d0c50322.jpg', 0, 0, '2025-12-04 16:04:01');
INSERT INTO `wm_material` VALUES (108, 1102, 'http://localhost:9000/leadnews/2025/12/04/1ab8fb012aea48d095d8d1b6dacefa90.jpg', 0, 0, '2025-12-04 16:09:19');
INSERT INTO `wm_material` VALUES (109, 1102, 'http://localhost:9000/leadnews/2025/12/04/3ed2de48fb4a49f1876e3c5677ed9e40.jpg', 0, 0, '2025-12-04 16:09:28');
INSERT INTO `wm_material` VALUES (110, 1102, 'http://localhost:9000/leadnews/2025/12/04/673e683d08ac4404944b67590f5a0910.jpg', 0, 0, '2025-12-04 16:09:36');
INSERT INTO `wm_material` VALUES (111, 1102, 'http://localhost:9000/leadnews/2025/12/04/3d9912d004c446b68819de1c45e7e9f2.jpg', 0, 0, '2025-12-04 17:09:03');
INSERT INTO `wm_material` VALUES (112, 1102, 'http://localhost:9000/leadnews/2025/12/04/881ead055ab94830aeeb594ee9d08f23.jpg', 0, 0, '2025-12-04 17:09:07');
INSERT INTO `wm_material` VALUES (113, 1102, 'http://localhost:9000/leadnews/2025/12/04/0f66a3831f274f7b9d37a6e833ae84e9.jpg', 0, 0, '2025-12-04 17:09:12');
INSERT INTO `wm_material` VALUES (114, 1102, 'http://localhost:9000/leadnews/2025/12/04/ac9d8df5d9564f19bae83a0a8861c028.jpg', 0, 0, '2025-12-04 17:09:16');
INSERT INTO `wm_material` VALUES (115, 1102, 'http://localhost:9000/leadnews/2025/12/04/87dc253dc9b6498b9859d600810044bd.jpg', 0, 0, '2025-12-04 17:09:22');
INSERT INTO `wm_material` VALUES (116, 1102, 'http://localhost:9000/leadnews/2025/12/04/5342cb2902464d37bba95ef27f41fe1d.jpg', 0, 0, '2025-12-04 17:09:40');
INSERT INTO `wm_material` VALUES (117, 1102, 'http://localhost:9000/leadnews/2025/12/04/d4f00f74cf974238b274c3ba5edeae79.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (118, 1102, 'http://localhost:9000/leadnews/2025/12/04/1e9c2d2714634053ac18922543687355.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (119, 1102, 'http://localhost:9000/leadnews/2025/12/04/a33021cc4c9d4e70af9e149c414eb920.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (120, 1102, 'http://localhost:9000/leadnews/2025/12/04/9ada2d35ad1f4fd78cec7f2f74bb89c8.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (121, 1102, 'http://localhost:9000/leadnews/2025/12/04/909084a8395643beade4be828f23ab27.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (122, 1102, 'http://localhost:9000/leadnews/2025/12/04/85b25943ea784b1db3249fcc1ae9326a.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (123, 1102, 'http://localhost:9000/leadnews/2025/12/04/9a371a112e7c498092a076484a6e10ea.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (124, 1102, 'http://localhost:9000/leadnews/2025/12/04/95b04a370a5f4379b9e632b565f2475d.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (125, 1102, 'http://localhost:9000/leadnews/2025/12/04/b02d6963504746bdbd8feac797499167.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (126, 1102, 'http://localhost:9000/leadnews/2025/12/04/2ecc7722fcac40969edee4563736d3fe.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (127, 1102, 'http://localhost:9000/leadnews/2025/12/04/e22afcb5f9d5430ea38539606b5f6feb.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (128, 1102, 'http://localhost:9000/leadnews/2025/12/04/f217b57b4f024a0585b4446d6891250e.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (129, 1102, 'http://localhost:9000/leadnews/2025/12/04/c0ae014b03884d05a2845ca74d227a8f.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (130, 1102, 'http://localhost:9000/leadnews/2025/12/04/f20b597f6efe411184c9b70153d90285.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (131, 1102, 'http://localhost:9000/leadnews/2025/12/04/58321276bcbc484e91c9d737f4ca17cb.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (132, 1102, 'http://localhost:9000/leadnews/2025/12/04/4b3f4f147b8840ab82188adf2111f5dd.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (133, 1102, 'http://localhost:9000/leadnews/2025/12/04/41704363d77d4da8b9cc360e717f799c.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (134, 1102, 'http://localhost:9000/leadnews/2025/12/04/01e90d02400648ffb9bdfa30d423edf1.jpg', 0, 0, '2025-12-04 17:32:49');
INSERT INTO `wm_material` VALUES (135, 1102, 'http://localhost:9000/leadnews/2025/12/04/53813e88b52940219fd53f80b38ffd99.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (136, 1102, 'http://localhost:9000/leadnews/2025/12/04/51382aaaa5834b9abb4c98c051ca9dfa.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (137, 1102, 'http://localhost:9000/leadnews/2025/12/04/ef4563e8a8ca4621b575ceb0458dcdf7.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (138, 1102, 'http://localhost:9000/leadnews/2025/12/04/c6b875c461fb4aefaa4cf7e25a2b5a4b.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (139, 1102, 'http://localhost:9000/leadnews/2025/12/04/c195b644a09c4768a2ddf25000a043b6.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (140, 1102, 'http://localhost:9000/leadnews/2025/12/04/a3e9a44203074fcca28c819043cf47f7.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (141, 1102, 'http://localhost:9000/leadnews/2025/12/04/ebe239e3f3fe45219fd88e306ea2a5d4.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (142, 1102, 'http://localhost:9000/leadnews/2025/12/04/28c12e352be64cd19f6d99fc6f8789b8.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (143, 1102, 'http://localhost:9000/leadnews/2025/12/04/e7cd26daf31149558da711b201d0ea7e.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (144, 1102, 'http://localhost:9000/leadnews/2025/12/04/b0c2162e282940959ee8205d9dc2850f.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (145, 1102, 'http://localhost:9000/leadnews/2025/12/04/72844f2c9a0c434db03fb9fa129b108a.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (146, 1102, 'http://localhost:9000/leadnews/2025/12/04/06f95f6663a34de89e0efd441101ebef.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (147, 1102, 'http://localhost:9000/leadnews/2025/12/04/b1e47133d90b40e19c1a60b38747a6fb.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (148, 1102, 'http://localhost:9000/leadnews/2025/12/04/5139f160a70f404b80185585074742de.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (149, 1102, 'http://localhost:9000/leadnews/2025/12/04/783dc487d8624de6a05d82b246b22b09.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (150, 1102, 'http://localhost:9000/leadnews/2025/12/04/1712a3ec431741688b7518f4f4dd4f82.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (151, 1102, 'http://localhost:9000/leadnews/2025/12/04/3a6a879dfdd44476be2a0732ac7f469e.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (152, 1102, 'http://localhost:9000/leadnews/2025/12/04/39d00228844d46b9a9303bd75e97e8eb.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (153, 1102, 'http://localhost:9000/leadnews/2025/12/04/6be11618e72e4869af764ff7808510e2.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (154, 1102, 'http://localhost:9000/leadnews/2025/12/04/dade0f56fe7a48388f8a37f0a63159e4.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (155, 1102, 'http://localhost:9000/leadnews/2025/12/04/8dd18c8d00cf483cb0c7823b2b145dd6.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (156, 1102, 'http://localhost:9000/leadnews/2025/12/04/3487022c4210470d941c5d1f6eeb9991.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (157, 1102, 'http://localhost:9000/leadnews/2025/12/04/9e1c122c080947cea12dbb487d23100e.jpg', 0, 0, '2025-12-04 17:32:50');
INSERT INTO `wm_material` VALUES (158, 1102, 'http://localhost:9000/leadnews/2025/12/04/eaf8ad91dc894a49a574602aebe08cc3.jpg', 0, 0, '2025-12-04 17:32:51');
INSERT INTO `wm_material` VALUES (159, 1102, 'http://localhost:9000/leadnews/2025/12/04/a254a64003b141d1a1d8c67f9ffdba82.jpg', 0, 0, '2025-12-04 17:32:51');
INSERT INTO `wm_material` VALUES (160, 1102, 'http://localhost:9000/leadnews/2025/12/04/89d05d6f86964ca099371fb0d0244455.jpg', 0, 0, '2025-12-04 17:32:51');
INSERT INTO `wm_material` VALUES (161, 1102, 'http://localhost:9000/leadnews/2025/12/04/e36cee5551c245c799a3690d9d3add44.jpg', 0, 0, '2025-12-04 17:32:51');
INSERT INTO `wm_material` VALUES (162, 1102, 'http://localhost:9000/leadnews/2025/12/04/f7481122926843c9adb3c60b7558659e.jpg', 0, 0, '2025-12-04 17:32:51');
INSERT INTO `wm_material` VALUES (163, 1102, 'http://localhost:9000/leadnews/2025/12/04/288598b1eaf44fe5a69ec0427b5e82f9.jpg', 0, 0, '2025-12-04 17:32:51');
INSERT INTO `wm_material` VALUES (164, 1102, 'http://localhost:9000/leadnews/2025/12/04/d11329ee1b6f499b89b624641fce14ef.jpg', 0, 0, '2025-12-04 17:32:51');
INSERT INTO `wm_material` VALUES (165, 1102, 'http://localhost:9000/leadnews/2025/12/04/2dafdde0f22b4309b0c3f30926b00eb1.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (166, 1102, 'http://localhost:9000/leadnews/2025/12/04/a1b7962c8d8d47d8948a77e68fbf5b87.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (167, 1102, 'http://localhost:9000/leadnews/2025/12/04/496e3623d269499884d1ff938c9ffdaf.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (168, 1102, 'http://localhost:9000/leadnews/2025/12/04/f397e79cdaf9441fb8e9a839ebeebea7.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (169, 1102, 'http://localhost:9000/leadnews/2025/12/04/52e2e552dde044ddb1f1d7c8f4ff4cbb.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (170, 1102, 'http://localhost:9000/leadnews/2025/12/04/63d5c89be81d4c9b93a40f8d5bf64fe5.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (171, 1102, 'http://localhost:9000/leadnews/2025/12/04/af9bc58f8dcd489cac94023cb3185b27.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (172, 1102, 'http://localhost:9000/leadnews/2025/12/04/0f64a00e45144346a26cfbd08ec19364.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (173, 1102, 'http://localhost:9000/leadnews/2025/12/04/0c2e4ee0785240979620c6a29006010f.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (174, 1102, 'http://localhost:9000/leadnews/2025/12/04/7c7fb12d327a4f54bde551aef1ba4d42.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (175, 1102, 'http://localhost:9000/leadnews/2025/12/04/7ce4640a63ad4d3286b62862353060ce.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (176, 1102, 'http://localhost:9000/leadnews/2025/12/04/d65778495c2b46ee8b60600f65e8a064.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (177, 1102, 'http://localhost:9000/leadnews/2025/12/04/4e71bd021b5c4c4f83b8bef04e1319ab.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (178, 1102, 'http://localhost:9000/leadnews/2025/12/04/5126df267d5444ce8b166b651607ae39.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (179, 1102, 'http://localhost:9000/leadnews/2025/12/04/a6f2fe8136e444178964248e519d46e0.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (180, 1102, 'http://localhost:9000/leadnews/2025/12/04/d4e1de3788be4d51ae5ebf28cdef0bb4.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (181, 1102, 'http://localhost:9000/leadnews/2025/12/04/b33227a3aaff4a57ad5fc8a7e4790228.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (182, 1102, 'http://localhost:9000/leadnews/2025/12/04/ea632d8a4e184a93be5526cfb4cd41bd.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (183, 1102, 'http://localhost:9000/leadnews/2025/12/04/3e54b1bce4a049bc82c68007050a0edd.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (184, 1102, 'http://localhost:9000/leadnews/2025/12/04/e1b0dd6c07c543858188fd9831789dc8.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (185, 1102, 'http://localhost:9000/leadnews/2025/12/04/505e5ad97b444f69855bf474f6908b61.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (186, 1102, 'http://localhost:9000/leadnews/2025/12/04/bda7063724c24a3ebd9b076a3ae5a043.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (187, 1102, 'http://localhost:9000/leadnews/2025/12/04/6ed68e6e1918474dbf1efffedc8423d5.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (188, 1102, 'http://localhost:9000/leadnews/2025/12/04/6c30b90068344e43a309b9ac78f66028.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (189, 1102, 'http://localhost:9000/leadnews/2025/12/04/06e835cc4c6a459c88515b9dbb9b5511.jpg', 0, 0, '2025-12-04 17:33:03');
INSERT INTO `wm_material` VALUES (190, 1102, 'http://localhost:9000/leadnews/2025/12/04/c147efe3c067473e9612675ae6fb1f96.jpg', 0, 0, '2025-12-04 17:33:04');
INSERT INTO `wm_material` VALUES (191, 1102, 'http://localhost:9000/leadnews/2025/12/04/3db3eed1b94c4f738814f7f0234b76ba.jpg', 0, 0, '2025-12-04 17:33:04');
INSERT INTO `wm_material` VALUES (192, 1102, 'http://localhost:9000/leadnews/2025/12/04/b0198a3e4c8d42a3aadf2dc0bfda6c8c.jpg', 0, 0, '2025-12-04 17:33:04');
INSERT INTO `wm_material` VALUES (193, 1102, 'http://localhost:9000/leadnews/2025/12/04/73f2173b06e549748dd64c3d6d191561.jpg', 0, 0, '2025-12-04 17:33:04');
INSERT INTO `wm_material` VALUES (194, 1102, 'http://localhost:9000/leadnews/2025/12/04/52dabafff75d4c61bbfdf9cd31436532.jpg', 0, 0, '2025-12-04 17:33:04');
INSERT INTO `wm_material` VALUES (195, 1102, 'http://localhost:9000/leadnews/2025/12/04/0090a386cf374d08a306a905ea3d5a90.jpg', 0, 0, '2025-12-04 17:33:14');
INSERT INTO `wm_material` VALUES (196, 1102, 'http://localhost:9000/leadnews/2025/12/04/db89471923dc4be38102efcc923df244.jpg', 0, 0, '2025-12-04 17:33:14');
INSERT INTO `wm_material` VALUES (197, 1102, 'http://localhost:9000/leadnews/2025/12/04/4e2d900125694256ac52ea9311dfcad7.jpg', 0, 0, '2025-12-04 17:33:14');
INSERT INTO `wm_material` VALUES (198, 1102, 'http://localhost:9000/leadnews/2025/12/04/37b9a8fb10944ed2aa82d5be18d9d07a.jpg', 0, 0, '2025-12-04 17:33:14');
INSERT INTO `wm_material` VALUES (199, 1102, 'http://localhost:9000/leadnews/2025/12/04/2b2fcf0f1239445f8840efb27feeb4f9.jpg', 0, 0, '2025-12-04 17:33:14');
INSERT INTO `wm_material` VALUES (200, 1102, 'http://localhost:9000/leadnews/2025/12/04/dee2abbbac2343cfac45f213279b3ae6.jpg', 0, 0, '2025-12-04 17:33:14');
INSERT INTO `wm_material` VALUES (201, 1102, 'http://localhost:9000/leadnews/2025/12/04/416037f9700542188e2731ba05a48a74.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (202, 1102, 'http://localhost:9000/leadnews/2025/12/04/c2a11a543b764753a8cad96e639f09d9.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (203, 1102, 'http://localhost:9000/leadnews/2025/12/04/bf5e7afd6ec9498dbc3a00f52ac3057d.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (204, 1102, 'http://localhost:9000/leadnews/2025/12/04/92af4a799f934236b2a8eb72ff1d1b2b.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (205, 1102, 'http://localhost:9000/leadnews/2025/12/04/bfb1df3716c349ddae99bbd3171bc948.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (206, 1102, 'http://localhost:9000/leadnews/2025/12/04/eadcb52ca00b447886bb3e9fec4a9a8d.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (207, 1102, 'http://localhost:9000/leadnews/2025/12/04/4a9f791aabbc40c9be6caf41216e46bd.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (208, 1102, 'http://localhost:9000/leadnews/2025/12/04/89757b1812aa470f8d427a2bc218196d.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (209, 1102, 'http://localhost:9000/leadnews/2025/12/04/c0a9d851271544f4988ac6496858550e.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (210, 1102, 'http://localhost:9000/leadnews/2025/12/04/ea105884029245408588bf909c4a38cf.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (211, 1102, 'http://localhost:9000/leadnews/2025/12/04/82c5167a21d9456382300e475173fca4.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (212, 1102, 'http://localhost:9000/leadnews/2025/12/04/251e19b39b9540d191f21537f7dc4c39.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (213, 1102, 'http://localhost:9000/leadnews/2025/12/04/d83f62ce1e114c9bba696bd017579ffb.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (214, 1102, 'http://localhost:9000/leadnews/2025/12/04/3959e1866a6249de97127892f40a2213.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (215, 1102, 'http://localhost:9000/leadnews/2025/12/04/ddea13fdf6f54956a0bc44a6ba20a0b7.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (216, 1102, 'http://localhost:9000/leadnews/2025/12/04/2d42389fbc434e9d81e190d207020bb2.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (217, 1102, 'http://localhost:9000/leadnews/2025/12/04/810d489eae1f40348a57de7675cc5c55.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (218, 1102, 'http://localhost:9000/leadnews/2025/12/04/e5b30c4e00c94d178e15147959d812fa.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (219, 1102, 'http://localhost:9000/leadnews/2025/12/04/12f3656f8bb4490bb25a241bd2759c77.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (220, 1102, 'http://localhost:9000/leadnews/2025/12/04/8949ae357b8c4311abca0a822cd952ce.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (221, 1102, 'http://localhost:9000/leadnews/2025/12/04/6c7a013af9aa4a0b936f632c4c7997d7.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (222, 1102, 'http://localhost:9000/leadnews/2025/12/04/d594a8c901874de7bf2d2581dfa52224.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (223, 1102, 'http://localhost:9000/leadnews/2025/12/04/437174e5ba4f4555a76dd1212b183860.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (224, 1102, 'http://localhost:9000/leadnews/2025/12/04/d70d71f33617466b99c3c33862e75206.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (225, 1102, 'http://localhost:9000/leadnews/2025/12/04/953c0f92e6de4d1f906fdafe8ce04d1b.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (226, 1102, 'http://localhost:9000/leadnews/2025/12/04/5636f796b4774036be638a084d5b3e3b.jpg', 0, 0, '2025-12-04 17:33:15');
INSERT INTO `wm_material` VALUES (227, 1102, 'http://localhost:9000/leadnews/2025/12/04/4a790b6feca9416ba6884ff5e88d719a.jpg', 0, 0, '2025-12-04 17:33:16');
INSERT INTO `wm_material` VALUES (228, 1102, 'http://localhost:9000/leadnews/2025/12/04/d01eead63312436493c6b3aa02c63f4a.jpg', 0, 0, '2025-12-04 17:33:16');
INSERT INTO `wm_material` VALUES (229, 1102, 'http://localhost:9000/leadnews/2025/12/04/7d2c8b605ab84221b1b924d101072a8e.jpg', 0, 0, '2025-12-04 17:33:16');
INSERT INTO `wm_material` VALUES (230, 1102, 'http://localhost:9000/leadnews/2025/12/04/9302fc21b8c94676aa46361b5ae7d11d.jpg', 0, 0, '2025-12-04 17:33:16');
INSERT INTO `wm_material` VALUES (231, 1102, 'http://localhost:9000/leadnews/2025/12/04/a007c7e0feaa4494b912d2466cd4f9d9.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (232, 1102, 'http://localhost:9000/leadnews/2025/12/04/5e59fc21eab14eb59f995473389a7ca4.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (233, 1102, 'http://localhost:9000/leadnews/2025/12/04/5dccf6d7486d4f7ea41476d89b0d2db6.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (234, 1102, 'http://localhost:9000/leadnews/2025/12/04/5d4f3ae6525347328a0764f511e598d2.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (235, 1102, 'http://localhost:9000/leadnews/2025/12/04/c77b3c719df245a585eb5e96abf302dd.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (236, 1102, 'http://localhost:9000/leadnews/2025/12/04/6d0386bdac2e4293af8459aa8b797dc7.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (237, 1102, 'http://localhost:9000/leadnews/2025/12/04/abe98ba7b0344f879cda148adbc81bdc.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (238, 1102, 'http://localhost:9000/leadnews/2025/12/04/20ade4dfb2234486a0a4a7ba9e6c72f3.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (239, 1102, 'http://localhost:9000/leadnews/2025/12/04/d47efca7e2834d4c8e3612bf3cfca6a0.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (240, 1102, 'http://localhost:9000/leadnews/2025/12/04/9a07a5c99aec42acac4fd019c54c42f2.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (241, 1102, 'http://localhost:9000/leadnews/2025/12/04/a8da67727f9242deab046f6ebfcfc341.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (242, 1102, 'http://localhost:9000/leadnews/2025/12/04/80a185f6d06f41bb9051cf2f6b3175e2.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (243, 1102, 'http://localhost:9000/leadnews/2025/12/04/2db7227c2be64f41936f71c1c7ad6a1b.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (244, 1102, 'http://localhost:9000/leadnews/2025/12/04/eaba5ccbad7148458ff0a4a630ca64c9.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (245, 1102, 'http://localhost:9000/leadnews/2025/12/04/fac43fe98d4f44bf8fe2699f89216c59.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (246, 1102, 'http://localhost:9000/leadnews/2025/12/04/3a095cc09ec7466390c76b631df3c9fc.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (247, 1102, 'http://localhost:9000/leadnews/2025/12/04/b26ab72c4cbe4149ac72fd4f7dd92d72.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (248, 1102, 'http://localhost:9000/leadnews/2025/12/04/bd8027245fb54d52adc96a9e420e8670.jpg', 0, 0, '2025-12-04 17:33:28');
INSERT INTO `wm_material` VALUES (249, 1102, 'http://localhost:9000/leadnews/2025/12/04/b51cf73e72ea4f0587d837eddea90f63.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (250, 1102, 'http://localhost:9000/leadnews/2025/12/04/72d857f18a724d9daf2c922abd80cd4e.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (251, 1102, 'http://localhost:9000/leadnews/2025/12/04/4fa09e636f2040d8b94c3df8ce16fc94.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (252, 1102, 'http://localhost:9000/leadnews/2025/12/04/e499dc41eeeb45cab1270d10885527d2.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (253, 1102, 'http://localhost:9000/leadnews/2025/12/04/6d5f3f27ab974f5a9e059ced2b47f0b7.jpg', 0, 1, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (254, 1102, 'http://localhost:9000/leadnews/2025/12/04/b71d974d9c89480c9445eb324136d424.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (255, 1102, 'http://localhost:9000/leadnews/2025/12/04/237ce38c231641e8bf589cb9753437ed.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (256, 1102, 'http://localhost:9000/leadnews/2025/12/04/39c731c26cd440c086634ddbe6f03bbb.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (257, 1102, 'http://localhost:9000/leadnews/2025/12/04/d9762d80ef824042b48ea3082fcbc3fa.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (258, 1102, 'http://localhost:9000/leadnews/2025/12/04/90a32de238624ff391759e97f84a8ee1.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (259, 1102, 'http://localhost:9000/leadnews/2025/12/04/b491008d78454a13b9c8940215f2e316.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (260, 1102, 'http://localhost:9000/leadnews/2025/12/04/c4f3a607f4974b1d818a73a2f3d3486a.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (261, 1102, 'http://localhost:9000/leadnews/2025/12/04/5b40e7a3d0a24d97b442d6395fc59786.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (262, 1102, 'http://localhost:9000/leadnews/2025/12/04/eb82f8e6c15f4e3ba7b6cd2e8732f102.jpg', 0, 1, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (263, 1102, 'http://localhost:9000/leadnews/2025/12/04/3c2bc2f7a6c748d088fff02c9c1226ec.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (264, 1102, 'http://localhost:9000/leadnews/2025/12/04/11dc8b61f55e4deebe53ad7f33ad6c5c.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (265, 1102, 'http://localhost:9000/leadnews/2025/12/04/1ce09480102f4ad9baad43a28cad43f4.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (266, 1102, 'http://localhost:9000/leadnews/2025/12/04/707fd819ab5648e1ae64638c57245b00.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (267, 1102, 'http://localhost:9000/leadnews/2025/12/04/622d3feb673e4ba0bb87fcfc402747c8.jpg', 0, 0, '2025-12-04 17:33:29');
INSERT INTO `wm_material` VALUES (268, 1102, 'http://localhost:9000/leadnews/2025/12/04/8e268f9096de45889e437b0b8a92c80e.jpg', 0, 0, '2025-12-04 17:33:29');

-- ----------------------------
-- Table structure for wm_news
-- ----------------------------
DROP TABLE IF EXISTS `wm_news`;
CREATE TABLE `wm_news`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '自媒体用户ID',
  `title` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图文内容',
  `type` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '文章布局\r\n            0 无图文章\r\n            1 单图文章\r\n            3 多图文章',
  `channel_id` int UNSIGNED NULL DEFAULT NULL COMMENT '图文频道ID',
  `labels` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `submited_time` datetime NULL DEFAULT NULL COMMENT '提交时间',
  `status` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '当前状态\r\n            0 草稿\r\n            1 提交（待审核）\r\n            2 审核失败\r\n            3 人工审核\r\n            4 人工审核通过\r\n            8 审核通过（待发布）\r\n            9 已发布',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '定时发布时间，不定时则为空',
  `reason` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '拒绝理由',
  `article_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '发布库文章ID',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '//图片用逗号分隔',
  `enable` tinyint UNSIGNED NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6268 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '自媒体图文内容信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wm_news
-- ----------------------------
INSERT INTO `wm_news` VALUES (6225, 1102, '“真”项目课程对找工作有什么帮助？', '[{\"type\":\"text\",\"value\":\"找工作，企业重点问的是项目经验，更是HR筛选的“第一门槛”，直接决定了你是否有机会进入面试环节。\\n\\n　　项目经验更是评定“个人能力/技能”真实性的“证据”，反映了求职者某个方面的实际动手能力、对某个领域或某种技能的掌握程度。\"},{\"type\":\"text\",\"value\":\"很多经过培训期望快速上岗的程序员，靠着培训机构“辅导”顺利经过面试官对于“项目经验”的考核上岗后，在面对“有限时间”“复杂业务”“新项目需求”等多项标签加持的工作任务，却往往不知从何下手或开发进度极其缓慢。最终结果就是：熬不过试用期。\\n\\n　　从而也引发了企业对于“培训出身程序员”的“有色眼光”。你甚至也一度怀疑“IT培训班出来的人真的不行吗?”\"}]', 1, 1, '项目课程', '2025-12-04 17:08:21', '2025-12-04 17:08:21', 9, '2025-12-04 17:08:21', '审核成功', 1383828014629179393, 'http://localhost:9000/leadnews/2025/12/04/de1f320525f24385816ff643ae715715.jpg', 1);
INSERT INTO `wm_news` VALUES (6228, 1102, '工作线程数是不是设置的越大越好', '[{\"type\":\"text\",\"value\":\"根据经验来看，jdk api 一般推荐的线程数为CPU核数的2倍。但是有些书籍要求可以设置为CPU核数的8倍，也有的业务设置为CPU核数的32倍。\\n“工作线程数”的设置依据是什么，到底设置为多少能够最大化CPU性能，是本文要讨论的问题。\\n\\n工作线程数是不是设置的越大越好\\n显然不是的。使用java.lang.Thread类或者java.lang.Runnable接口编写代码来定义、实例化和启动新线程。\\n一个Thread类实例只是一个对象，像Java中的任何其他对象一样，具有变量和方法，生死于堆上。\\nJava中，每个线程都有一个调用栈，即使不在程序中创建任何新的线程，线程也在后台运行着。\\n一个Java应用总是从main()方法开始运行，main()方法运行在一个线程内，它被称为主线程。\\n一旦创建一个新的线程，就产生一个新的调用栈。\"}]', 1, 1, '11', '2025-12-04 17:04:06', '2025-12-04 17:04:06', 9, '2025-12-04 17:04:06', '审核成功', 1383827952326987778, 'http://localhost:9000/leadnews/2025/12/04/a5fac02a9bdc4bc0b27674e2c7fc78ad.jpg', 1);
INSERT INTO `wm_news` VALUES (6230, 1102, '为什么项目经理不喜欢重构？', '[{\"type\":\"text\",\"value\":\"经常听到开发人员抱怨 ，“这么烂的代码，我来重构一下！”，“这代码怎么能这么写呢？谁来重构一下？”，“这儿有个坏味道，重构吧！”\\n\\n作为一名项目经理，每次听到“重构”两个字，既想给追求卓越代码的开发人员点个赞，同时又会感觉非常紧张，为什么又要重构？马上就要上线了，怎么还要改？是不是应该阻止开发人员做重构？\\n\\n重构几乎是开发人员最喜欢的一项实践了，可项目经理们却充满了顾虑，那么为什么项目经理不喜欢重构呢？\\n\\n老功能被破坏\\n不止一次遇到这样的场景，某一天一个老功能突然被破坏了，项目经理们感到奇怪，产品这块儿的功能已经很稳定了，也没有在这部分开发什么新功能，为什么突然出问题了呢？\"}]', 1, 1, '', '2025-12-04 17:04:40', '2025-12-04 17:04:40', 9, '2025-12-04 17:04:40', '审核成功', 1383827888816836609, 'http://localhost:9000/leadnews/2025/12/04/8070501b8a4f4a1da6eae1d6b31aa933.jpg', 1);
INSERT INTO `wm_news` VALUES (6231, 1102, 'Kafka文件的存储机制', '[{\"type\":\"text\",\"value\":\"Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130:9000/leadnews/2021/4/20210418/4a498d9cf3614570ac0cb2da3e51c164.jpg\"},{\"type\":\"text\",\"value\":\"请在这里输入正文\"}]', 1, 1, '11', '2021-04-19 00:58:47', '2021-04-19 00:58:47', 9, '2021-04-19 00:20:17', '审核成功', 1383827787629252610, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', 1);
INSERT INTO `wm_news` VALUES (6240, 1102, '为什么天上总是亮晶晶？', '[{\"type\":\"text\",\"value\":\"为什么天上总是亮晶晶？\"}]', 1, 1, '', '2025-12-04 17:19:00', '2025-12-04 17:19:00', 9, '2025-12-04 17:19:00', '审核成功', 1996254403220344833, 'http://localhost:9000/leadnews/2025/12/04/610476893f2247da838e6360573bfc31.jpg', 1);
INSERT INTO `wm_news` VALUES (6242, 1102, 'Sky', '[{\"type\":\"text\",\"value\":\"666666\"}]', 1, 1, '', '2025-12-04 17:18:40', '2025-12-04 17:18:40', 9, '2025-12-04 17:18:40', '审核成功', 1996256255953473538, 'http://localhost:9000/leadnews/2025/12/04/ac9d8df5d9564f19bae83a0a8861c028.jpg', 1);
INSERT INTO `wm_news` VALUES (6243, 1102, 'Hello,World', '[{\"type\":\"text\",\"value\":\"Hello,World\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/5b60713edc5f451ba9de908b272d3f4b.png\"}]', 1, NULL, NULL, '2025-12-04 01:48:55', '2025-12-04 01:48:55', 9, '2025-12-04 01:48:55', '审核成功', 1996275469300928514, 'http://localhost:9000/leadnews/2025/12/04/6f8222b697034d1cb81edd19b88b94f4.png', 1);
INSERT INTO `wm_news` VALUES (6247, 1102, '冰毒', '[{\"type\":\"text\",\"value\":\"123456\"}]', 1, 1, 'usetc,闪电', '2025-12-04 13:28:16', '2025-12-04 13:28:16', 2, '2025-12-04 13:28:16', '当前文章中存在违规内容: [冰毒]', NULL, 'http://localhost:9000/leadnews/2025/12/03/0c5acd0e6e844b698b9df73ecfb3f851.jpg', 1);
INSERT INTO `wm_news` VALUES (6248, 1102, 'Image', '[{\"type\":\"text\",\"value\":\"1234567890\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/03/ee6eb2e3ee7944c997aae152a7c50198.png\"}]', 1, 2, 'sky', '2025-12-04 13:29:30', '2025-12-04 13:29:30', 1, '2025-12-04 13:29:30', NULL, NULL, 'http://localhost:9000/leadnews/2025/12/03/ee6eb2e3ee7944c997aae152a7c50198.png', 1);
INSERT INTO `wm_news` VALUES (6252, 1102, '我不是一个人！', '[{\"type\":\"text\",\"value\":\"我不是一个人！\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/a8f65c1726684936bfda729ad1c18372.jpg\"}]', 1, 1, 'one,person', '2025-12-04 14:47:52', '2025-12-04 14:47:52', 1, '2025-12-04 14:47:52', NULL, NULL, 'http://localhost:9000/leadnews/2025/12/03/e0c8224b60a6416cb86e7e331a360f54.png', 1);
INSERT INTO `wm_news` VALUES (6253, 1102, '电脑', '[{\"type\":\"text\",\"value\":\"电脑\"}]', 1, 2, '31', '2025-12-04 17:01:55', '2025-12-04 17:01:55', 9, '2025-12-04 17:01:55', '审核成功', 1996472721877372929, 'http://localhost:9000/leadnews/2025/12/04/ea9f7628037e4acb84d1eb4488f15af0.png', 1);
INSERT INTO `wm_news` VALUES (6256, 1102, 'Test', '[{\"type\":\"text\",\"value\":\"Test\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/ea9f7628037e4acb84d1eb4488f15af0.png\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/5b60713edc5f451ba9de908b272d3f4b.png\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/03/ee6eb2e3ee7944c997aae152a7c50198.png\"},{\"type\":\"text\",\"value\":\"666\"}]', 1, 1, 'test', '2025-12-04 15:04:07', '2025-12-04 15:04:07', 9, '2025-12-04 15:04:07', '审核成功', 1996475586855440386, 'http://localhost:9000/leadnews/2025/12/03/0c5acd0e6e844b698b9df73ecfb3f851.jpg', 1);
INSERT INTO `wm_news` VALUES (6260, 1102, '草稿', '[{\"type\":\"text\",\"value\":\"123\"}]', 1, 1, '123', '2025-12-06 00:40:21', '2025-12-06 00:40:21', 0, '2025-12-06 00:40:21', '审核成功', 1996493644374347777, 'http://localhost:9000/leadnews/2025/12/04/673e683d08ac4404944b67590f5a0910.jpg', 1);
INSERT INTO `wm_news` VALUES (6261, 1102, 'yellow', '[{\"type\":\"text\",\"value\":\"31231\"}]', 1, 7, '312', '2025-12-04 16:30:45', '2025-12-04 16:30:45', 9, '2025-12-04 16:30:45', '审核成功', 1996493941582729218, 'http://localhost:9000/leadnews/2025/12/04/3ed2de48fb4a49f1876e3c5677ed9e40.jpg', 1);
INSERT INTO `wm_news` VALUES (6262, 1102, '三张图', '[{\"type\":\"text\",\"value\":\"3\"}]', 3, 1, 'star,yellow,cloud', '2025-12-05 13:07:11', '2025-12-05 13:07:11', 9, '2025-12-05 13:07:11', '审核成功', 1996500273299853314, 'http://localhost:9000/leadnews/2025/12/04/31bd269805ca457aa3f75ec04c9f625a.jpg,http://localhost:9000/leadnews/2025/12/04/3ed2de48fb4a49f1876e3c5677ed9e40.jpg,http://localhost:9000/leadnews/2025/12/04/73be619a51d241158cd3f030d0c50322.jpg', 0);
INSERT INTO `wm_news` VALUES (6263, 1102, '草稿', '[{\"type\":\"text\",\"value\":\"草稿\"}]', 1, 1, 'Tree', '2025-12-04 17:54:59', '2025-12-04 17:54:59', 0, '2025-12-04 17:54:59', NULL, NULL, 'http://localhost:9000/leadnews/2025/12/04/622d3feb673e4ba0bb87fcfc402747c8.jpg', 1);
INSERT INTO `wm_news` VALUES (6265, 1102, '延迟队列', '[{\"type\":\"text\",\"value\":\"延迟队列\"}]', 1, 1, '', '2025-12-04 21:44:49', '2025-12-04 21:44:49', 9, '2025-12-04 21:44:49', '审核成功', 1996576426345762818, 'http://localhost:9000/leadnews/2025/12/04/90a32de238624ff391759e97f84a8ee1.jpg', 1);
INSERT INTO `wm_news` VALUES (6267, 1102, 'Test', '[{\"type\":\"text\",\"value\":\"123\"}]', 1, 8, '', '2025-12-05 21:48:14', '2025-12-05 21:48:14', 9, '2025-12-05 21:48:14', '审核成功', 1996940641761890305, 'http://localhost:9000/leadnews/2025/12/04/39c731c26cd440c086634ddbe6f03bbb.jpg', 1);

-- ----------------------------
-- Table structure for wm_news_material
-- ----------------------------
DROP TABLE IF EXISTS `wm_news_material`;
CREATE TABLE `wm_news_material`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `material_id` int UNSIGNED NULL DEFAULT NULL COMMENT '素材ID',
  `news_id` int UNSIGNED NULL DEFAULT NULL COMMENT '图文ID',
  `type` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '引用类型\r\n            0 内容引用\r\n            1 主图引用',
  `ord` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '引用排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 334 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '自媒体图文引用素材信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wm_news_material
-- ----------------------------
INSERT INTO `wm_news_material` VALUES (255, 61, 6232, 0, 0);
INSERT INTO `wm_news_material` VALUES (256, 61, 6232, 1, 0);
INSERT INTO `wm_news_material` VALUES (263, 61, 6231, 0, 0);
INSERT INTO `wm_news_material` VALUES (264, 61, 6231, 1, 0);
INSERT INTO `wm_news_material` VALUES (283, 86, 6243, 0, 0);
INSERT INTO `wm_news_material` VALUES (284, 85, 6243, 1, 0);
INSERT INTO `wm_news_material` VALUES (287, 78, 6247, 1, 0);
INSERT INTO `wm_news_material` VALUES (288, 79, 6248, 0, 0);
INSERT INTO `wm_news_material` VALUES (289, 79, 6248, 1, 0);
INSERT INTO `wm_news_material` VALUES (293, 88, 6252, 0, 0);
INSERT INTO `wm_news_material` VALUES (294, 74, 6252, 1, 0);
INSERT INTO `wm_news_material` VALUES (304, 79, 6256, 0, 0);
INSERT INTO `wm_news_material` VALUES (305, 86, 6256, 0, 1);
INSERT INTO `wm_news_material` VALUES (306, 89, 6256, 0, 2);
INSERT INTO `wm_news_material` VALUES (307, 78, 6256, 1, 0);
INSERT INTO `wm_news_material` VALUES (310, 109, 6261, 1, 0);
INSERT INTO `wm_news_material` VALUES (317, 89, 6253, 1, 0);
INSERT INTO `wm_news_material` VALUES (318, 100, 6228, 1, 0);
INSERT INTO `wm_news_material` VALUES (319, 95, 6230, 1, 0);
INSERT INTO `wm_news_material` VALUES (320, 90, 6225, 1, 0);
INSERT INTO `wm_news_material` VALUES (322, 114, 6242, 1, 0);
INSERT INTO `wm_news_material` VALUES (323, 101, 6240, 1, 0);
INSERT INTO `wm_news_material` VALUES (327, 258, 6265, 1, 0);
INSERT INTO `wm_news_material` VALUES (330, 97, 6262, 1, 0);
INSERT INTO `wm_news_material` VALUES (331, 106, 6262, 1, 1);
INSERT INTO `wm_news_material` VALUES (332, 109, 6262, 1, 2);
INSERT INTO `wm_news_material` VALUES (333, 256, 6267, 1, 0);

-- ----------------------------
-- Table structure for wm_sensitive
-- ----------------------------
DROP TABLE IF EXISTS `wm_sensitive`;
CREATE TABLE `wm_sensitive`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sensitives` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '敏感词',
  `created_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3201 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '敏感词信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wm_sensitive
-- ----------------------------
INSERT INTO `wm_sensitive` VALUES (3104, '冰毒', '2021-05-23 15:38:51');
INSERT INTO `wm_sensitive` VALUES (3105, '法轮功', '2021-05-23 15:38:51');
INSERT INTO `wm_sensitive` VALUES (3106, '私人侦探', '2021-05-23 11:09:22');
INSERT INTO `wm_sensitive` VALUES (3107, '针孔摄象', '2021-05-23 11:09:52');
INSERT INTO `wm_sensitive` VALUES (3108, '信用卡提现', '2021-05-23 11:10:11');
INSERT INTO `wm_sensitive` VALUES (3109, '无抵押贷款', '2021-05-23 11:10:41');
INSERT INTO `wm_sensitive` VALUES (3110, '广告代理', '2021-05-23 11:10:59');
INSERT INTO `wm_sensitive` VALUES (3111, '代开发票', '2021-05-23 11:11:18');
INSERT INTO `wm_sensitive` VALUES (3112, '蚁力神', '2021-05-23 11:11:39');
INSERT INTO `wm_sensitive` VALUES (3113, '售肾', '2021-05-23 11:12:08');
INSERT INTO `wm_sensitive` VALUES (3114, '刻章办', '2021-05-23 11:12:24');
INSERT INTO `wm_sensitive` VALUES (3116, '套牌车', '2021-05-23 11:12:37');
INSERT INTO `wm_sensitive` VALUES (3117, '足球投注', '2021-05-23 11:12:51');
INSERT INTO `wm_sensitive` VALUES (3118, '地下钱庄', '2021-05-23 11:13:07');
INSERT INTO `wm_sensitive` VALUES (3119, '出售答案', '2021-05-23 11:13:24');
INSERT INTO `wm_sensitive` VALUES (3200, '小额贷款', '2021-05-23 11:13:40');

-- ----------------------------
-- Table structure for wm_user
-- ----------------------------
DROP TABLE IF EXISTS `wm_user`;
CREATE TABLE `wm_user`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ap_user_id` int NULL DEFAULT NULL,
  `ap_author_id` int NULL DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录用户名',
  `password` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '登录密码',
  `salt` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '盐',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '昵称',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '头像',
  `location` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '归属地',
  `phone` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '状态\r\n            0 暂时不可用\r\n            1 永久不可用\r\n            9 正常可用',
  `email` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮箱',
  `type` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '账号类型\r\n            0 个人 \r\n            1 企业\r\n            2 子账号',
  `score` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '运营评分',
  `login_time` datetime NULL DEFAULT NULL COMMENT '最后一次登录时间',
  `created_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1120 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '自媒体用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wm_user
-- ----------------------------
INSERT INTO `wm_user` VALUES (1100, NULL, NULL, 'zhangsan', 'ab8c7c1e66a164ab6891b927550ea39a', 'abc', '小张', NULL, NULL, '13588996789', 1, NULL, NULL, NULL, '2020-02-17 23:51:15', '2020-02-17 23:51:18');
INSERT INTO `wm_user` VALUES (1101, NULL, NULL, 'lisi', 'a6ecab0c246bbc87926e0fba442cc014', 'def', '小李', NULL, NULL, '13234567656', 1, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `wm_user` VALUES (1102, NULL, NULL, 'admin', 'a66abb5684c45962d887564f08346e8d', '123456', 'Paiad', 'https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif', NULL, '13234567657', 1, NULL, NULL, NULL, NULL, '2020-03-14 09:35:13');
INSERT INTO `wm_user` VALUES (1118, NULL, NULL, 'lisi1', '123', '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `wm_user` VALUES (1119, NULL, NULL, 'shaseng', '1234', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
