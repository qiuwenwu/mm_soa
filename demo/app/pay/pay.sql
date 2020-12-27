/*
 Navicat Premium Data Transfer

 Source Server         : 本地数据库
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : mm

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 12/11/2020 08:16:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for pay_account
-- ----------------------------
DROP TABLE IF EXISTS `pay_account`;
CREATE TABLE `pay_account`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[1,8388607]',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：[0,10](1正常|2异常|3冻结|4注销)',
  `bank` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网银账户：[0,32]',
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网银名称：[0,255]含支行',
  `bank_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '微信认证：[0,1](0未认证|1已认证)',
  `wechat` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款微信账户：[0,32]',
  `wechat_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '微信认证：[0,1](0未认证|1已认证)',
  `alipay` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款支付宝账户：[0,32]',
  `alipay_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '微信认证：[0,1](0未认证|1已认证)',
  `btc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '比特币地址：[0,255]',
  `btc_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '比特币地址认证：[0,1](0未认证|1已认证)',
  `eth` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '以太币地址：[0,255]',
  `eth_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '以太币地址认证：[0,1](0未认证|1已认证)',
  `eos` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '柚子币地址：[0,255]',
  `eos_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '柚子币地址认证：[0,1](0未认证|1已认证)',
  `mm` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '美眉币地址：[0,255]',
  `mm_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '美眉币地址认证：[0,1](0未认证|1已认证)',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付账户：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_account
-- ----------------------------
INSERT INTO `pay_account` VALUES (0, 0, NULL, NULL, 0, 'qiuwenwu91', 1, NULL, 0, NULL, 0, NULL, 0, NULL, 0, NULL, 0);

-- ----------------------------
-- Table structure for pay_account_amount
-- ----------------------------
DROP TABLE IF EXISTS `pay_account_amount`;
CREATE TABLE `pay_account_amount`  (
  `seller_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户ID：[1,8388607]用于对应商户',
  `usd` decimal(16, 2) NOT NULL DEFAULT 0.00 COMMENT '美元余额：',
  `cny` decimal(16, 2) NOT NULL DEFAULT 0.00 COMMENT '人民币余额：',
  `mm` decimal(16, 4) NOT NULL DEFAULT 0.0000 COMMENT '美眉币余额：',
  `btc` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '比特币余额：',
  `eth` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '以太币余额：',
  `eos` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '柚子币余额：',
  PRIMARY KEY (`seller_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账户余额：' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of pay_account_amount
-- ----------------------------
INSERT INTO `pay_account_amount` VALUES (0, 5.00, 7.00, 9.0000, 10.00000000, 19.00000000, 5.00000000);

-- ----------------------------
-- Table structure for pay_account_discount
-- ----------------------------
DROP TABLE IF EXISTS `pay_account_discount`;
CREATE TABLE `pay_account_discount`  (
  `discount_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '提现申请ID：[1,2147483647]',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '提现状态：[0,10](1申请中|2转帐中|3已完成|4已拒绝)',
  `to_user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收款人：[1,8388607]如果是商户收款，可选填(user_account.nickname.user_id)',
  `seller_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户ID：[1,8388607]商户收款的ID(pay_seller)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '审批人：[1,8388607]转账申请处理负责人，即由谁放款的(user_account.nickname)',
  `amount` decimal(17, 8) NOT NULL DEFAULT 0.00000000 COMMENT '提现金额：',
  `fee` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '手续费：',
  `time_create` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间：',
  `pay_time` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '转账支付时间：',
  `time_end` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '资金到账时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后编辑时间：用于判断提现申请是否异常',
  `platform` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用平台：[0,12]pc电脑版网站、moblie移动版网站、wechat微信公众号、app手机应用',
  `way` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款方式：[0,12]third第三方支付、bank网银、digiccy数字货币',
  `institution` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转账机构：[0,16]第三方填支付宝、微信，银行填银行名称例如建设银行，数字货币填数字货币名称，例如比特币',
  `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发起提现时的IP：[0,32]',
  `from_user` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款账户：[0,128]',
  `to_user` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款账户：[0,128]',
  `cause` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拒绝原因：[0,255]告知商户为什么拒绝本次提现',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商户备注：[0,255]提现完成后的商户备注信息，便于商户查询',
  PRIMARY KEY (`discount_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '账户提现：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pay_config
-- ----------------------------
DROP TABLE IF EXISTS `pay_config`;
CREATE TABLE `pay_config`  (
  `config_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID：[1,2147483647]',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '变量名：[0,16]',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'string' COMMENT '数据类型：[0,16]string文本型、number数字型、boolean布尔型',
  `title` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变量标题：[0,16]可以用中文名',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变量描述：[0,255]描述该变量的作用',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变量值：[0,255]',
  `model` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '数据模型：json格式，用于单选、多选模式',
  PRIMARY KEY (`config_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付配置：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for pay_seller
-- ----------------------------
DROP TABLE IF EXISTS `pay_seller`;
CREATE TABLE `pay_seller`  (
  `seller_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商户ID：[1,8388607]',
  `institution_state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '认证状态：[0,10](1未认证|2认证中|3已认证|4认证失败)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户持有人：[1,8388607](user_account.nickname)',
  `province_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '省份ID：[1,2147483647]用户所在地的省份(sys_address_province)',
  `city_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所在城市ID：[1,2147483647](sys_address_city)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商户名称：[0,16]',
  `institution` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册企业名：[0,64]',
  `institution_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组织机构码：[0,64]',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址：[0,255]商户办公地的详细地址',
  `business` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '经营范围：[0,255]',
  `institution_img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '营业执照图片：',
  PRIMARY KEY (`seller_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商户信息：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pay_seller
-- ----------------------------
INSERT INTO `pay_seller` VALUES (1, 1, 1, 650000, 652700, '香雪', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for pay_trade
-- ----------------------------
DROP TABLE IF EXISTS `pay_trade`;
CREATE TABLE `pay_trade`  (
  `trade_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '交易序号：[1,2147483647]',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '付款状态：[0,10](1待付款|2待确认|3已完成|4已取消)',
  `from_user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '付款人：[1,8388607](user_account.nickname.user_id)',
  `to_user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收款人：[1,8388607]如果是商户收款，可选填(user_account.nickname.user_id)',
  `seller_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商户ID：[1,8388607]商户收款的ID(pay_seller)',
  `total` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '付款总计金额：',
  `amount` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '实际付款金额：',
  `fee` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '手续费：',
  `pay_time` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '转账支付时间：',
  `platform` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用平台：[0,12]pc电脑版网站、moblie移动版网站、wechat微信公众号、app手机应用',
  `way` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款方式：[0,12]third第三方支付、bank网银、digiccy数字货币',
  `app` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款应用：[0,16]cms内容管理系统、mall商城、bbs论坛，可自定义',
  `institution` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转账机构：[0,16]第三方填支付宝、微信，银行填银行名称例如建设银行，数字货币填数字货币名称，例如比特币',
  `title` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款标题：[0,16]',
  `transaction_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '交易ID：[0,32]类似合同编号，可用来查询该笔交易明细',
  `ip` varchar(67) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转账时的用户IP：[0,67]',
  `from_user` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款账户：[0,128]',
  `to_user` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '收款账户：[0,128]',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款描述：[0,255]告知用户付款的原因',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '付款人备注：[0,255]付款完成后的用户备注信息，便于用户查询',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '付款内容：根据应用定格式，一般为json格式',
  `create_time` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '订单创建时间：',
  `end_time` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '付款到账时间：',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '最后编辑时间：用于判断订单是否异常',
  PRIMARY KEY (`trade_id`, `transaction_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '交易信息：' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
