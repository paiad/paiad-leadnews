/*
 Navicat Premium Data Transfer

 Source Server         : localhost-docker
 Source Server Type    : MySQL
 Source Server Version : 90200 (9.2.0)
 Source Host           : localhost:3306
 Source Schema         : paiad_leadnews_schedule

 Target Server Type    : MySQL
 Target Server Version : 90200 (9.2.0)
 File Encoding         : 65001

 Date: 06/12/2025 01:00:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for taskinfo
-- ----------------------------
DROP TABLE IF EXISTS `taskinfo`;
CREATE TABLE `taskinfo`  (
  `task_id` bigint NOT NULL COMMENT '任务id',
  `execute_time` datetime(3) NOT NULL COMMENT '执行时间',
  `parameters` longblob NULL COMMENT '参数',
  `priority` int NOT NULL COMMENT '优先级',
  `task_type` int NOT NULL COMMENT '任务类型',
  PRIMARY KEY (`task_id`) USING BTREE,
  INDEX `index_taskinfo_time`(`task_type` ASC, `priority` ASC, `execute_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of taskinfo
-- ----------------------------

-- ----------------------------
-- Table structure for taskinfo_logs
-- ----------------------------
DROP TABLE IF EXISTS `taskinfo_logs`;
CREATE TABLE `taskinfo_logs`  (
  `task_id` bigint NOT NULL COMMENT '任务id',
  `execute_time` datetime(3) NOT NULL COMMENT '执行时间',
  `parameters` longblob NULL COMMENT '参数',
  `priority` int NOT NULL COMMENT '优先级',
  `task_type` int NOT NULL COMMENT '任务类型',
  `version` int NOT NULL COMMENT '版本号,用乐观锁',
  `status` int NULL DEFAULT 0 COMMENT '状态 0=初始化状态 1=EXECUTED 2=CANCELLED',
  PRIMARY KEY (`task_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of taskinfo_logs
-- ----------------------------
INSERT INTO `taskinfo_logs` VALUES (1996573267973439489, '2025-12-04 21:32:15.457', 0x08F930, 1, 1001, 2, 1);
INSERT INTO `taskinfo_logs` VALUES (1996573726217928706, '2025-12-04 21:36:00.000', 0x08FA30, 1, 1001, 2, 1);
INSERT INTO `taskinfo_logs` VALUES (1996576423889403905, '2025-12-04 21:44:48.643', 0x08F930, 1, 1001, 2, 1);
INSERT INTO `taskinfo_logs` VALUES (1996576607004327938, '2025-12-04 21:47:20.000', 0x08FA30, 1, 1001, 2, 1);
INSERT INTO `taskinfo_logs` VALUES (1996808547565387778, '2025-12-05 13:07:10.893', 0x08F630, 1, 1001, 2, 1);
INSERT INTO `taskinfo_logs` VALUES (1996939673990676481, '2025-12-05 21:48:14.068', 0x08FB30, 1, 1001, 2, 1);

SET FOREIGN_KEY_CHECKS = 1;
