/*
 Navicat Premium Data Transfer

 Source Server         : localhost-docker
 Source Server Type    : MySQL
 Source Server Version : 90200 (9.2.0)
 Source Host           : localhost:3306
 Source Schema         : paiad_leadnews_article

 Target Server Type    : MySQL
 Target Server Version : 90200 (9.2.0)
 File Encoding         : 65001

 Date: 06/12/2025 01:00:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ap_article
-- ----------------------------
DROP TABLE IF EXISTS `ap_article`;
CREATE TABLE `ap_article`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '标题',
  `author_id` int UNSIGNED NULL DEFAULT NULL COMMENT '文章作者的ID',
  `author_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '作者昵称',
  `channel_id` int UNSIGNED NULL DEFAULT NULL COMMENT '文章所属频道ID',
  `channel_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '频道名称',
  `layout` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '文章布局\r\n            0 无图文章\r\n            1 单图文章\r\n            2 多图文章',
  `flag` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '文章标记\r\n            0 普通文章\r\n            1 热点文章\r\n            2 置顶文章\r\n            3 精品文章\r\n            4 大V 文章',
  `images` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章图片\r\n            多张逗号分隔',
  `labels` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '文章标签最多3个 逗号分隔',
  `likes` int UNSIGNED NULL DEFAULT NULL COMMENT '点赞数量',
  `collection` int UNSIGNED NULL DEFAULT NULL COMMENT '收藏数量',
  `comment` int UNSIGNED NULL DEFAULT NULL COMMENT '评论数量',
  `views` int UNSIGNED NULL DEFAULT NULL COMMENT '阅读数量',
  `province_id` int UNSIGNED NULL DEFAULT NULL COMMENT '省市',
  `city_id` int UNSIGNED NULL DEFAULT NULL COMMENT '市区',
  `county_id` int UNSIGNED NULL DEFAULT NULL COMMENT '区县',
  `created_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `publish_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  `sync_status` tinyint(1) NULL DEFAULT 0 COMMENT '同步状态',
  `origin` tinyint UNSIGNED NULL DEFAULT 0 COMMENT '来源',
  `static_url` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1996940641761890306 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章信息表，存储已发布的文章' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ap_article
-- ----------------------------
INSERT INTO `ap_article` VALUES (1302862387124125698, '什么是Java语言', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 14:52:54', '2020-09-07 14:56:18', 0, 0, '');
INSERT INTO `ap_article` VALUES (1302864436297482242, 'Java语言跨平台原理', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 15:01:02', '2020-09-07 15:01:02', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302864730402078722, '我是一个测试标题', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 15:02:12', '2020-09-07 15:02:12', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302865008438296577, '过山车故障20名游客倒挂空中', 4, 'admin', 1, 'java', 3, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 15:03:19', '2020-09-07 15:03:19', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302865306489733122, '武汉高校开学典礼万人歌唱祖国', 4, 'admin', 1, 'java', 3, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 15:04:30', '2020-09-07 15:04:30', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302865474094120961, '天降铁球砸死女婴整栋楼被判赔', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 15:05:10', '2020-09-07 15:05:10', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302977178887004162, '央视曝光境外医疗豪华旅游套路', 4, 'admin', 1, 'java', 0, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 22:29:02', '2020-09-07 22:29:02', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302977458215067649, '10多名陌生人合力托举悬窗女童', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 22:30:09', '2020-09-07 22:30:09', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302977558807060482, '杨澜回应一秒变脸', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 22:30:33', '2020-09-07 22:30:33', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302977754114826241, '黄龄工作室发视频回应', 4, 'admin', 4, 'Python', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 22:31:19', '2020-09-07 22:31:19', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302977754114826242, '黄龄工作室发视频回应', 4, 'admin', 4, 'Python', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 22:31:19', '2020-09-07 22:31:19', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1302977754114826243, '黄龄工作室发视频回应', 4, 'admin', 4, 'Python', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-07 22:31:19', '2020-09-07 22:31:19', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1303156149041758210, '全国抗击新冠肺炎疫情表彰大会', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-09-08 10:20:12', '2020-09-08 10:20:12', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1383827787629252610, 'Kafka文件的存储机制', 4, 'admin', 1, 'java', 1, NULL, 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/uestc-e3.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-04-19 01:00:29', '2021-04-19 00:20:17', 0, 0, 'http://localhost:9000/leadnews/2025/12/02/1383827787629252610.html');
INSERT INTO `ap_article` VALUES (1383827888816836609, '为什么项目经理不喜欢重构？', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/8070501b8a4f4a1da6eae1d6b31aa933.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 17:04:40', '2025-12-04 17:04:40', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1383827888816836609.html');
INSERT INTO `ap_article` VALUES (1383827952326987778, '工作线程数是不是设置的越大越好', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/a5fac02a9bdc4bc0b27674e2c7fc78ad.jpg', '11', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 17:04:06', '2025-12-04 17:04:06', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1383827952326987778.html');
INSERT INTO `ap_article` VALUES (1383828014629179393, '“真”项目课程对找工作有什么帮助？', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/de1f320525f24385816ff643ae715715.jpg', '项目课程', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 17:08:21', '2025-12-04 17:08:21', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1383828014629179393.html');
INSERT INTO `ap_article` VALUES (1996230181710336001, '黑马头条项目背景', NULL, NULL, NULL, NULL, 1, NULL, 'http://192.168.200.130:9000/leadnews/2021/04/26/5ddbdb5c68094ce393b08a47860da275.jpg', '黑马头条', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2028-03-14 19:35:49', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1996254403220344833, '为什么天上总是亮晶晶？', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/610476893f2247da838e6360573bfc31.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 17:19:00', '2025-12-04 17:19:00', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996254403220344833.html');
INSERT INTO `ap_article` VALUES (1996255938335608834, '1234567890', 1102, 'admin', 2, 'Mysql', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 00:31:18', NULL, 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1996256255953473538, 'Sky', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/ac9d8df5d9564f19bae83a0a8861c028.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 17:18:40', '2025-12-04 17:18:40', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996256255953473538.html');
INSERT INTO `ap_article` VALUES (1996275469300928514, 'Hello,World', 1102, 'admin', NULL, NULL, 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/6f8222b697034d1cb81edd19b88b94f4.png', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 01:48:55', '2025-12-04 01:48:55', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1996451786877177857, 'Image', 1102, 'admin', 2, 'Mysql', 1, NULL, 'http://localhost:9000/leadnews/2025/12/03/ee6eb2e3ee7944c997aae152a7c50198.png', 'sky', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 13:29:30', '2025-12-04 13:29:30', 0, 0, NULL);
INSERT INTO `ap_article` VALUES (1996472721877372929, '电脑', 1102, 'admin', 2, 'Mysql', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/ea9f7628037e4acb84d1eb4488f15af0.png', '31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 17:01:55', '2025-12-04 17:01:55', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996472721877372929.html');
INSERT INTO `ap_article` VALUES (1996475586855440386, 'Test', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/03/0c5acd0e6e844b698b9df73ecfb3f851.jpg', 'test', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 15:04:07', '2025-12-04 15:04:07', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996475586855440386.html');
INSERT INTO `ap_article` VALUES (1996488779220783105, '123123', 1102, 'admin', 1, 'Java', 1, NULL, NULL, '3132', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 15:56:29', '2025-12-04 15:56:29', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996488779220783105.html');
INSERT INTO `ap_article` VALUES (1996493644374347777, '草稿', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/673e683d08ac4404944b67590f5a0910.jpg', '123', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 16:15:53', '2025-12-04 16:15:52', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996493644374347777.html');
INSERT INTO `ap_article` VALUES (1996493941582729218, 'yellow', 1102, 'admin', 7, '其他', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/3ed2de48fb4a49f1876e3c5677ed9e40.jpg', '312', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 16:30:45', '2025-12-04 16:30:45', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996493941582729218.html');
INSERT INTO `ap_article` VALUES (1996500273299853314, '三张图', 1102, 'admin', 1, 'Java', 3, NULL, 'http://localhost:9000/leadnews/2025/12/04/31bd269805ca457aa3f75ec04c9f625a.jpg,http://localhost:9000/leadnews/2025/12/04/3ed2de48fb4a49f1876e3c5677ed9e40.jpg,http://localhost:9000/leadnews/2025/12/04/73be619a51d241158cd3f030d0c50322.jpg', 'star,yellow,cloud', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-05 13:12:04', '2025-12-05 13:07:11', 0, 0, 'http://localhost:9000/leadnews/2025/12/05/1996500273299853314.html');
INSERT INTO `ap_article` VALUES (1996576319424565249, '延迟队列', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/90a32de238624ff391759e97f84a8ee1.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 21:44:23', '2025-12-04 21:32:15', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996576319424565249.html');
INSERT INTO `ap_article` VALUES (1996576319424565250, 'Test-queue', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/39c731c26cd440c086634ddbe6f03bbb.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 21:44:23', '2025-12-04 21:36:00', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996576319424565250.html');
INSERT INTO `ap_article` VALUES (1996576426345762818, '延迟队列', 1102, 'admin', 1, 'Java', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/90a32de238624ff391759e97f84a8ee1.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-04 21:44:49', '2025-12-04 21:44:49', 0, 0, 'http://localhost:9000/leadnews/2025/12/04/1996576426345762818.html');
INSERT INTO `ap_article` VALUES (1996940641761890305, 'Test', 1102, 'admin', 8, 'Pumpkin', 1, NULL, 'http://localhost:9000/leadnews/2025/12/04/39c731c26cd440c086634ddbe6f03bbb.jpg', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-12-05 21:52:05', '2025-12-05 21:48:14', 0, 0, 'http://localhost:9000/leadnews/2025/12/05/1996940641761890305.html');

-- ----------------------------
-- Table structure for ap_article_config
-- ----------------------------
DROP TABLE IF EXISTS `ap_article_config`;
CREATE TABLE `ap_article_config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `article_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '文章ID',
  `is_comment` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否可评论',
  `is_forward` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否转发',
  `is_down` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否下架',
  `is_delete` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_article_id`(`article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1996940641933856770 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'APP已发布文章配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ap_article_config
-- ----------------------------
INSERT INTO `ap_article_config` VALUES (1302862387933626369, 1302862387124125698, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302864437425750018, 1302864436297482242, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302864731203190785, 1302864730402078722, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302865009533009922, 1302865008438296577, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302865307408285697, 1302865306489733122, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302865475297886209, 1302865474094120961, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302977180199821313, 1302977178887004162, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302977459322363905, 1302977458215067649, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302977559788527618, 1302977558807060482, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302977754882383873, 1302977754114826241, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302977754882383874, 1302977754114826242, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1302977754882383875, 1302977754114826243, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1303156149909979137, 1303156149041758210, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1383827787704750082, 1383827787629252610, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1383827888829419522, 1383827888816836609, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1383827952326987779, 1383827952326987778, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1383828014645956609, 1383828014629179393, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996230181882302465, 1996230181710336001, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996254403430060033, 1996254403220344833, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996255938335608835, 1996255938335608834, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996256255953473539, 1996256255953473538, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996275469363843073, 1996275469300928514, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996451787103670273, 1996451786877177857, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996472721931898882, 1996472721877372929, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996475586888994817, 1996475586855440386, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996488779451469826, 1996488779220783105, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996493644433068034, 1996493644374347777, 1, 1, 1, 0);
INSERT INTO `ap_article_config` VALUES (1996493941645643778, 1996493941582729218, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996500273366962177, 1996500273299853314, 1, 1, 1, 0);
INSERT INTO `ap_article_config` VALUES (1996576319638474753, 1996576319424565250, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996576319638474754, 1996576319424565249, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996576426408677377, 1996576426345762818, 1, 1, 0, 0);
INSERT INTO `ap_article_config` VALUES (1996940641933856769, 1996940641761890305, 1, 1, 0, 0);

-- ----------------------------
-- Table structure for ap_article_content
-- ----------------------------
DROP TABLE IF EXISTS `ap_article_content`;
CREATE TABLE `ap_article_content`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `article_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '文章ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '文章内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_article_id`(`article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1996940641933856771 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'APP已发布文章内容表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ap_article_content
-- ----------------------------
INSERT INTO `ap_article_content` VALUES (1302862388957036545, 1302862387124125698, '[{\"type\":\"text\",\"value\":\"Java语言是美国Sun公司（Stanford University Network），在1995年推出的高级的编程语言。所谓编程语言，是计算机的语言，人们可以使用编程语言对计算机下达命令，让计算机完成人们需要的功能。\\n\\n2009年，Sun公司被甲骨文公司收购，所以我们现在访问oracle官网即可：https://www.oracle.com\\nJava语言共同创始人之一：詹姆斯·高斯林 （James Gosling），被称为“Java之父”\\n\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl9V2CqAZe18AAOoOOsvWPc041.png\"},{\"type\":\"text\",\"value\":\"Java语言发展历史\\n\\n- 1995年Sun公司推出Java语言\\n- 1996年发布Java 1.0版本\\n- 1997年发布Java 1.1版本\\n- 1998年发布Java 1.2版本\\n- 2000年发布Java 1.3版本\\n- 2002年发布Java 1.4版本\\n- 2004年发布Java 5.0版本\\n- 2006年发布Java 6.0版本\\n- 2009年Oracle甲骨文公司收购Sun公司\\n- 2011年发布Java 7.0版本\\n- 2014年发布Java 8.0版本\\n- 2017年9月发布Java 9.0版本\\n- 2018年3月发布Java 10.0版本\\n- 2018年9月发布Java 11.0版本\\n\"},{\"type\":\"text\",\"value\":\"Java 语言的三个版本\\n\\n- JavaSE：标准版，用于桌面应用的开发，是其他两个版本的基础。\\n  - 学习JavaSE的目的, 是为了就业班要学习的JavaEE打基础.\\n\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl9V2F6AdQxAAAGyaOdp4gk784.png\"},{\"type\":\"text\",\"value\":\"- JavaEE：企业版，用于Web方向的网站开发\\n  - 网站：网页 + 后台服务器\\n\\nJava语言主要应用在互联网程序的开发领域。常见的互联网程序比如天猫、京东、物流系统、网银系统等，以及服务器后台处理大数据的存储、查询、数据挖掘等也有很多应用。\\n\"}]');
INSERT INTO `ap_article_content` VALUES (1302864438885367810, 1302864436297482242, '[{\"type\":\"text\",\"value\":\"Java虚拟机——JVM\\n\\n- JVM（Java Virtual Machine ）：Java虚拟机，简称JVM，是运行所有Java程序的假想计算机，是Java程序的运行环境，是Java 最具吸引力的特性之一。我们编写的Java代码，都运行在JVM 之上。\\n- 跨平台：任何软件的运行，都必须要运行在操作系统之上，而我们用Java编写的软件可以运行在任何的操作系统上，这个特性称为Java语言的跨平台特性。该特性是由JVM实现的，我们编写的程序运行在JVM上，而JVM运行在操作系统上。\\n\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl9V2n6AArZsAAGMmaPdt7w502.png\"},{\"type\":\"text\",\"value\":\"如图所示，Java的虚拟机本身不具备跨平台功能的，每个操作系统下都有不同版本的虚拟机。\\n\\n问题1: Java 是如何实现跨平台的呢？\\n\\n- 答：因为在不同操作系统中都安装了对应版本的 JVM 虚拟机\\n- 注意: Java程序想要运行, 必须依赖于JVM虚拟机.\\n\\n问题2: JVM 本身是否允许跨平台呢？\\n\\n- 答：不允许，允许跨平台的是 Java 程序，而不是虚拟机。\\n\"}]');
INSERT INTO `ap_article_content` VALUES (1302864732679585794, 1302864730402078722, '[{\"type\":\"text\",\"value\":\"这些都是测试这些都是测试这些都是测试这些都是测试这些都是测试这些都是测试\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892wqAANwOAAJW8oQUlAc087.jpg\"},{\"type\":\"text\",\"value\":\"这些都是测试这些都是测试这些都是测试这些都是测试\"}]');
INSERT INTO `ap_article_content` VALUES (1302865011026182145, 1302865008438296577, '[{\"type\":\"text\",\"value\":\"过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892uyAR12rAADi7UxPXeM267.jpg\"},{\"type\":\"text\",\"value\":\"过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中过山车故障20名游客倒挂空中\"},{\"type\":\"text\",\"value\":\"请在这里输入正文\"}]');
INSERT INTO `ap_article_content` VALUES (1302865308704325633, 1302865306489733122, '[{\"type\":\"text\",\"value\":\"武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892vuAXr_MAASCMYD0yzc919.jpg\"},{\"type\":\"text\",\"value\":\"武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国武汉高校开学典礼万人歌唱祖国v\"}]');
INSERT INTO `ap_article_content` VALUES (1302865476799447041, 1302865474094120961, '[{\"type\":\"text\",\"value\":\"天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892tyAFc60AAMUNUuOKPA619.jpg\"},{\"type\":\"text\",\"value\":\"天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔天降铁球砸死女婴整栋楼被判赔vv\"},{\"type\":\"text\",\"value\":\"请在这里输入正文\"}]');
INSERT INTO `ap_article_content` VALUES (1302977181835599873, 1302977178887004162, '[{\"type\":\"text\",\"value\":\"央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路央视曝光境外医疗豪华旅游套路\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892wqAANwOAAJW8oQUlAc087.jpg\"}]');
INSERT INTO `ap_article_content` VALUES (1302977460907810818, 1302977458215067649, '[{\"type\":\"text\",\"value\":\"510多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892vOASiunAAGzs3UZ1Cg252.jpg\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892uyAR12rAADi7UxPXeM267.jpg\"},{\"type\":\"text\",\"value\":\"10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童v\"},{\"type\":\"text\",\"value\":\"请10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童10多名陌生人合力托举悬窗女童v\"}]');
INSERT INTO `ap_article_content` VALUES (1302977561034235906, 1302977558807060482, '[{\"type\":\"text\",\"value\":\"杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892wKAZLhtAASZUi49De0836.jpg\"},{\"type\":\"text\",\"value\":\"杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸杨澜回应一秒变脸\"},{\"type\":\"text\",\"value\":\"请在这里输入正文\"}]');
INSERT INTO `ap_article_content` VALUES (1302977755742216193, 1302977754114826241, '[{\"type\":\"text\",\"value\":\"3黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl892vuAXr_MAASCMYD0yzc919.jpg\"},{\"type\":\"text\",\"value\":\"请在这里输入正文黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应黄龄工作室发视频回应\"}]');
INSERT INTO `ap_article_content` VALUES (1303156151151493121, 1303156149041758210, '[{\"type\":\"image\",\"value\":\"http://192.168.200.130/group1/M00/00/00/wKjIgl9W6iOAD2doAAFY4E1K7-g384.png\"},{\"type\":\"text\",\"value\":\"全国抗击新冠肺炎疫情表彰大会开始15家“文化会客厅”展现产业发展的集群效应全球疫情简报:印度新冠确诊病例超420万 升至全球第二中方提出《全球数据安全倡议》\"}]');
INSERT INTO `ap_article_content` VALUES (1383827787742498817, 1383827787629252610, '[{\"type\":\"text\",\"value\":\"Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制Kafka文件的存储机制\"},{\"type\":\"image\",\"value\":\"http://192.168.200.130:9000/leadnews/2021/4/20210418/4a498d9cf3614570ac0cb2da3e51c164.jpg\"},{\"type\":\"text\",\"value\":\"请在这里输入正文\"}]');
INSERT INTO `ap_article_content` VALUES (1383827888833613826, 1383827888816836609, '[{\"type\":\"text\",\"value\":\"经常听到开发人员抱怨 ，“这么烂的代码，我来重构一下！”，“这代码怎么能这么写呢？谁来重构一下？”，“这儿有个坏味道，重构吧！”\\n\\n作为一名项目经理，每次听到“重构”两个字，既想给追求卓越代码的开发人员点个赞，同时又会感觉非常紧张，为什么又要重构？马上就要上线了，怎么还要改？是不是应该阻止开发人员做重构？\\n\\n重构几乎是开发人员最喜欢的一项实践了，可项目经理们却充满了顾虑，那么为什么项目经理不喜欢重构呢？\\n\\n老功能被破坏\\n不止一次遇到这样的场景，某一天一个老功能突然被破坏了，项目经理们感到奇怪，产品这块儿的功能已经很稳定了，也没有在这部分开发什么新功能，为什么突然出问题了呢？\"}]');
INSERT INTO `ap_article_content` VALUES (1383827952335376385, 1383827952326987778, '[{\"type\":\"text\",\"value\":\"根据经验来看，jdk api 一般推荐的线程数为CPU核数的2倍。但是有些书籍要求可以设置为CPU核数的8倍，也有的业务设置为CPU核数的32倍。\\n“工作线程数”的设置依据是什么，到底设置为多少能够最大化CPU性能，是本文要讨论的问题。\\n\\n工作线程数是不是设置的越大越好\\n显然不是的。使用java.lang.Thread类或者java.lang.Runnable接口编写代码来定义、实例化和启动新线程。\\n一个Thread类实例只是一个对象，像Java中的任何其他对象一样，具有变量和方法，生死于堆上。\\nJava中，每个线程都有一个调用栈，即使不在程序中创建任何新的线程，线程也在后台运行着。\\n一个Java应用总是从main()方法开始运行，main()方法运行在一个线程内，它被称为主线程。\\n一旦创建一个新的线程，就产生一个新的调用栈。\"}]');
INSERT INTO `ap_article_content` VALUES (1383828014650150914, 1383828014629179393, '[{\"type\":\"text\",\"value\":\"找工作，企业重点问的是项目经验，更是HR筛选的“第一门槛”，直接决定了你是否有机会进入面试环节。\\n\\n　　项目经验更是评定“个人能力/技能”真实性的“证据”，反映了求职者某个方面的实际动手能力、对某个领域或某种技能的掌握程度。\"},{\"type\":\"text\",\"value\":\"很多经过培训期望快速上岗的程序员，靠着培训机构“辅导”顺利经过面试官对于“项目经验”的考核上岗后，在面对“有限时间”“复杂业务”“新项目需求”等多项标签加持的工作任务，却往往不知从何下手或开发进度极其缓慢。最终结果就是：熬不过试用期。\\n\\n　　从而也引发了企业对于“培训出身程序员”的“有色眼光”。你甚至也一度怀疑“IT培训班出来的人真的不行吗?”\"}]');
INSERT INTO `ap_article_content` VALUES (1996230182335287297, 1996230181710336001, '22222222222222222黑马头条项目背景,黑马头条项目背景,黑马头条项目背景,黑马头条项目背景，黑马头条项目背景');
INSERT INTO `ap_article_content` VALUES (1996254403492974594, 1996254403220344833, '[{\"type\":\"text\",\"value\":\"为什么天上总是亮晶晶？\"}]');
INSERT INTO `ap_article_content` VALUES (1996256255953473540, 1996256255953473538, '[{\"type\":\"text\",\"value\":\"666666\"}]');
INSERT INTO `ap_article_content` VALUES (1996275469426757634, 1996275469300928514, '[{\"type\":\"text\",\"value\":\"Hello,World\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/5b60713edc5f451ba9de908b272d3f4b.png\"}]');
INSERT INTO `ap_article_content` VALUES (1996451787166584833, 1996451786877177857, '[{\"type\":\"text\",\"value\":\"1234567890\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/03/ee6eb2e3ee7944c997aae152a7c50198.png\"}]');
INSERT INTO `ap_article_content` VALUES (1996472722057728002, 1996472721877372929, '[{\"type\":\"text\",\"value\":\"电脑\"}]');
INSERT INTO `ap_article_content` VALUES (1996475586888994818, 1996475586855440386, '[{\"type\":\"text\",\"value\":\"Test\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/ea9f7628037e4acb84d1eb4488f15af0.png\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/5b60713edc5f451ba9de908b272d3f4b.png\"},{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/03/ee6eb2e3ee7944c997aae152a7c50198.png\"},{\"type\":\"text\",\"value\":\"666\"}]');
INSERT INTO `ap_article_content` VALUES (1996488779514384385, 1996488779220783105, '[{\"type\":\"text\",\"value\":\"312312\"}]');
INSERT INTO `ap_article_content` VALUES (1996493644433068035, 1996493644374347777, '[{\"type\":\"text\",\"value\":\"123\"}]');
INSERT INTO `ap_article_content` VALUES (1996493941645643779, 1996493941582729218, '[{\"type\":\"text\",\"value\":\"31231\"}]');
INSERT INTO `ap_article_content` VALUES (1996500273366962178, 1996500273299853314, '[{\"type\":\"text\",\"value\":\"3\"}]');
INSERT INTO `ap_article_content` VALUES (1996576319638474755, 1996576319424565250, '[{\"type\":\"image\",\"value\":\"http://localhost:9000/leadnews/2025/12/04/39c731c26cd440c086634ddbe6f03bbb.jpg\"}]');
INSERT INTO `ap_article_content` VALUES (1996576319638474756, 1996576319424565249, '[{\"type\":\"text\",\"value\":\"延迟队列\"}]');
INSERT INTO `ap_article_content` VALUES (1996576426408677378, 1996576426345762818, '[{\"type\":\"text\",\"value\":\"延迟队列\"}]');
INSERT INTO `ap_article_content` VALUES (1996940641933856770, 1996940641761890305, '[{\"type\":\"text\",\"value\":\"123\"}]');

-- ----------------------------
-- Table structure for ap_author
-- ----------------------------
DROP TABLE IF EXISTS `ap_author`;
CREATE TABLE `ap_author`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '作者名称',
  `type` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '0 爬取数据\r\n            1 签约合作商\r\n            2 平台自媒体人\r\n            ',
  `user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '社交账号ID',
  `created_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `wm_user_id` int UNSIGNED NULL DEFAULT NULL COMMENT '自媒体账号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_type_name`(`type` ASC, `name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = 'APP文章作者信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ap_author
-- ----------------------------
INSERT INTO `ap_author` VALUES (1, 'zhangsan', 2, 1, '2020-03-19 23:43:54', NULL);
INSERT INTO `ap_author` VALUES (2, 'lisi', 2, 2, '2020-03-19 23:47:44', NULL);
INSERT INTO `ap_author` VALUES (3, 'wangwu', 2, 3, '2020-03-19 23:50:09', NULL);
INSERT INTO `ap_author` VALUES (4, 'admin', 2, 4, '2020-03-30 16:36:41', NULL);

-- ----------------------------
-- Table structure for ap_collection
-- ----------------------------
DROP TABLE IF EXISTS `ap_collection`;
CREATE TABLE `ap_collection`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `entry_id` int UNSIGNED NULL DEFAULT NULL COMMENT '实体ID',
  `article_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '文章ID',
  `type` tinyint UNSIGNED NULL DEFAULT NULL COMMENT '点赞内容类型\r\n            0文章\r\n            1动态',
  `collection_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `published_time` datetime NULL DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_type`(`entry_id` ASC, `article_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'APP收藏信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of ap_collection
-- ----------------------------
INSERT INTO `ap_collection` VALUES (1, 1, 1303156149041758210, 0, '2020-04-07 23:46:47', '2020-04-07 23:46:50');

SET FOREIGN_KEY_CHECKS = 1;
