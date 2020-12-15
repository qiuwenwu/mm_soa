/*
 Navicat Premium Data Transfer

 Source Server         : 本地服务器
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : mm

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 15/12/2020 18:32:45
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_ad
-- ----------------------------
DROP TABLE IF EXISTS `sys_ad`;
CREATE TABLE `sys_ad`  (
  `ad_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '广告ID：[1,32767]',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,10000]数值越小，越优先显示',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放城市ID：[0,8388607](sys_address_city)',
  `area_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放地区：[0,8388607](sys_address_area)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '广告主ID：[1,8388607]表示是谁打的广告(user_account.nickname)',
  `times_user` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访客数：[0,2147483647]',
  `times_max` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '次数上限：[0,2147483647]表示点击或展现达多少次后不再打该广告',
  `times_show` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '展现量：[0,2147483647]',
  `times_click` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击量：[0,2147483647]',
  `fee` double(5, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用：每次点击或展现、增加访客所需的费用',
  `fee_max` double(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用上限：表示打广告消费到多少钱后不再打广告',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '广告名称：[0,16]',
  `type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '广告类型：[0,16]text文字、img图片、video视频、flash交互动画',
  `location` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '投放位置：[0,16]',
  `fee_way` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '付费方式：[0,16]click点击付费、show展现付费、user访客付费',
  `app` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展现应用：[0,16]将在指定的应用下才展现广告',
  `trade` varchar(24) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属行业：[0,24]可以根据不同的行业定制不同的投放',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '广告标题：[0,32]',
  `device` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '呈现设备：[0,125]在什么设备上展示，web_pc、web_pad、web_phone、app_pad、app_phone，多个设备用逗号隔开',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '广告描述：[0,255]',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '广告图：[0,255]',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转链接：[0,255]',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,255]在出现于关键词相关的情况下才打广告，多个关键词用空格分隔',
  PRIMARY KEY (`ad_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '广告信息：' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_ad
-- ----------------------------
INSERT INTO `sys_ad` VALUES (1, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告1', 'banner', '', '', '', '', 'banner_1', '', '', '/home/pc/img/banner/banner_3.jpg', '/', '');
INSERT INTO `sys_ad` VALUES (2, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告2', 'banner', '', '', '', '', 'banner_2', '', '', '/home/pc/img/banner/banner_2.jpg', '/', '');
INSERT INTO `sys_ad` VALUES (3, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告3', 'banner', '', '', '', '', 'banner_3', '', '', '/home/pc/img/banner/banner_1.jpg', '/', '');

-- ----------------------------
-- Table structure for sys_address_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_address_area`;
CREATE TABLE `sys_address_area`  (
  `area_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '地区ID：[1,8388607]',
  `show` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可见：[0,2](0仅表单可见|1表单和搜索可见|2均可见)',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[1,8388607](sys_address_city)',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '地区名称：[0,16]',
  PRIMARY KEY (`area_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地区：' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_address_area
-- ----------------------------

-- ----------------------------
-- Table structure for sys_address_city
-- ----------------------------
DROP TABLE IF EXISTS `sys_address_city`;
CREATE TABLE `sys_address_city`  (
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '城市ID：[1,8388607]',
  `show` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '显示位置：[0,2](0仅表单可见|1表单和搜索可见|2均可见)',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `province_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属省份ID：[1,8388607](sys_address_province)',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市名称：[0,16]',
  PRIMARY KEY (`city_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '城市：' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_address_city
-- ----------------------------
INSERT INTO `sys_address_city` VALUES (2, 0, 100, 0, '测试');

-- ----------------------------
-- Table structure for sys_address_province
-- ----------------------------
DROP TABLE IF EXISTS `sys_address_province`;
CREATE TABLE `sys_address_province`  (
  `province_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '省份ID：[1,8388607]',
  `show` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可见：[0,2](0仅表单可见|1表单和搜索可见|2均可见)',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省份名称：[0,16]',
  PRIMARY KEY (`province_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '省份：' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_address_province
-- ----------------------------
INSERT INTO `sys_address_province` VALUES (1, 0, 100, '广东省');

-- ----------------------------
-- Table structure for sys_app
-- ----------------------------
DROP TABLE IF EXISTS `sys_app`;
CREATE TABLE `sys_app`  (
  `app_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '应用序号：[1,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可用：[0,1]在未审核状态下， 该应用授权为不可用(0否|1是)',
  `encrypt` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '加解密方式：[0,10](1明文模式|2兼容模式|3安全模式)',
  `times_allow` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '每日允许请求次数：[0,32767]用于限制应用每日可授权次数',
  `times_today` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '今日请求次数：[0,32767]用于记录今日请求授权次数，判断授权次数是否超限',
  `max_age` smallint(5) UNSIGNED NOT NULL DEFAULT 1825 COMMENT '有效期时长：[0,32767]授权应用可以使用的时长，超时需重新申请。单位：天',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '持有者ID：[1,8388607]该客户端所有人的ID(user_account.nickname)',
  `times_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '请求总次数：[0,2147483647]用于记录授权总次数',
  `time_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上次使用时间：用于记录上次授权时间，防止频繁操作',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用名称：[0,16]用于用户登陆时显示授权应用',
  `appid` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用ID：[0,16]用于应用授权访问时的账号',
  `token` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息访问令牌：[0,32]用于访问应用时验证身份',
  `encoding_aes_key` varchar(43) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息加密钥匙：[16,43]用于给应用发送消息时的加密钥匙',
  `appsecret` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用密钥：[0,64]用于应用授权访问时的密码',
  `icon` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '应用图标：用于用户登录时显示',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '消息访问地址：[0,255]当接收到用户所发消息后回访该地址',
  `bind_ip` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '访问绑定IP：网站授权时确认重定向网址为已授权IP',
  `scope` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '允许使用的接口：多个接口用”，“分隔',
  `scope_not` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '不允许使用的接口：“多个接口用”，“分隔',
  `users` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '授权的用户：',
  PRIMARY KEY (`app_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用信息：' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_app
-- ----------------------------

-- ----------------------------
-- Table structure for sys_app_refresh
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_refresh`;
CREATE TABLE `sys_app_refresh`  (
  `refresh_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '刷新Token的ID：[1,2147483647]',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[1,8388607]表示当前Token绑定的用户uid(user_account.nickname)',
  `time_create` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间：用来判断刷新令牌有效期',
  `time_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间：用来判断是否频繁刷新访问牌',
  `appid` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用ID：[0,16]',
  `refresh_token` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '刷新令牌：[0,32]用来刷新访问牌，保留30天',
  PRIMARY KEY (`refresh_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用刷新：' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_app_refresh
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID：[1,2147483647]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量名：[0,16]',
  `type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'string' COMMENT '数据类型：[0,16]string文本型、number数字型、boolean布尔型',
  `title` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量标题：[0,16]可以用中文名',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量值：[0,255]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量描述：[0,255]描述该变量的作用',
  `model` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据模型：json格式，用于单选、多选模式',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置：' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'theme_style', 'string', '主题风格', 'default', '用于配置系统默认主题风格', '');
INSERT INTO `sys_config` VALUES (2, 'theme_color', 'string', '主题色', 'blue', '用于配置系统默认主题色调', '[{\n   \"name\":\"红\",\n   \"value\": \"red\"\n},{\n   \"name\":\"黄\",\n   \"value\": \"yellow\"\n},{\n   \"name\":\"绿\",\n   \"value\": \"green\"\n},{\n   \"name\":\"蓝\",\n   \"value\": \"blue\"\n},{\n   \"name\":\"紫\",\n   \"value\": \"purple\"\n}\n]');
INSERT INTO `sys_config` VALUES (3, 'sys_lang', 'string', '系统语言', 'zh_cn', '用于配置系统默认语言', '[{\n   \"name\":\"英文\",\n   \"value\": \"en\"\n},{\n   \"name\":\"简体中文\",\n   \"value\": \"zh_cn\"\n},{\n   \"name\":\"繁体中文\",\n   \"value\": \"zh_tw\"\n},{\n   \"name\":\"英文\",\n   \"value\": \"en\"\n},{\n   \"name\":\"日文\",\n   \"value\": \"ja\"\n},{\n   \"name\":\"韩文\",\n   \"value\": \"ko\"\n}\n]');

-- ----------------------------
-- Table structure for sys_lang
-- ----------------------------
DROP TABLE IF EXISTS `sys_lang`;
CREATE TABLE `sys_lang`  (
  `lang_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '语言ID',
  `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文',
  `zh_cn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简体中文',
  `zh_tw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '繁体中文',
  `ko` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '韩文',
  `ja` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日文',
  PRIMARY KEY (`lang_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 47 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统语言：用于开发站点多国语' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_lang
-- ----------------------------
INSERT INTO `sys_lang` VALUES (1, 'web_name', 'mm', '超级美眉', '', '', '');
INSERT INTO `sys_lang` VALUES (2, 'btn_sign_in', 'SignIn', '登录', '', '', '');
INSERT INTO `sys_lang` VALUES (3, 'btn_sign_up', 'SignUp', '注册', '', '', '');
INSERT INTO `sys_lang` VALUES (4, 'nav_home', 'Home', '首页', '', '', '');
INSERT INTO `sys_lang` VALUES (5, 'nav_about', 'About', '关于我们', '', '', '');
INSERT INTO `sys_lang` VALUES (6, 'nav_product', 'Product', '产品展示', '', '', '');
INSERT INTO `sys_lang` VALUES (7, 'nav_document', 'Document', '开发文档', '', '', '');
INSERT INTO `sys_lang` VALUES (8, 'nav_forum', 'Forum', '论坛', '', '', '');
INSERT INTO `sys_lang` VALUES (9, 'nav_service', 'Service', '技术服务', '', '', '');
INSERT INTO `sys_lang` VALUES (10, 'nav_contact', 'Contact', '联系方式', '', '', '');
INSERT INTO `sys_lang` VALUES (11, 'btn_read_more', 'Read More', '查看更多', '', '', '');
INSERT INTO `sys_lang` VALUES (12, 'btn_more', 'More', '更多', '', '', '');
INSERT INTO `sys_lang` VALUES (13, 'banner_1', 'Software development actually has a lot of considerations', '软件开发其实有很多注意事项', '', '', '');
INSERT INTO `sys_lang` VALUES (14, 'banner_2', 'Professional development team and solutions make you worry free', '专业的开发团队和解决方案让您无忧无虑', '', '', '');
INSERT INTO `sys_lang` VALUES (15, 'banner_3', 'Explore the world of super applications with us', '和我们一起探索超级应用的世界', '', '', '');
INSERT INTO `sys_lang` VALUES (16, 'title_online_solutions', 'Online solutions', '在线解决方案', '', '', '');
INSERT INTO `sys_lang` VALUES (17, 'desc_online_solutions', 'Cloud excel is used to provide solutions, which is convenient for cooperation and can be viewed and changed at any time', '采用云excel提供解决方案，协作方便，随时可看可改', '', '', '');
INSERT INTO `sys_lang` VALUES (18, 'title_team', 'Senior engineer team', '高级工程师团队', '', '', '');
INSERT INTO `sys_lang` VALUES (19, 'desc_team', 'Collaborative development of technical teams from Huawei, Tencent and other enterprises', '从华为、腾讯等企业出来的技术团队协作开发', '', '', '');
INSERT INTO `sys_lang` VALUES (20, 'title_framework', 'Secondary development document', '二次开发文档', '', '', '');
INSERT INTO `sys_lang` VALUES (21, 'desc_framework', 'Have mature program architecture and perfect development documents', '拥有成熟的程序架构和完善的开发文档', '', '', '');
INSERT INTO `sys_lang` VALUES (22, 'title_welcome', 'Welcome to our website', '欢迎来到我们网站', '', '', '');
INSERT INTO `sys_lang` VALUES (23, 'content_welcome_1', 'Maybe you\'ve met a lot of development companies to come to us, but when you see us, you will find that we are your best choice', '也许你看到过许多的开发公司才找到我们，但是当你看到我们之后就会发现，我们就是你最好的选择。', '', '', '');
INSERT INTO `sys_lang` VALUES (24, 'content_welcome_2', 'Reasonable price is only a feature. What\'s more, our development framework superior to the market after use makes it easier for you to upgrade your application and innovate with the market at any time', '合理的价格只是一个特点。更重要的是，我们的开发框架在使用后优于市场，使您更容易升级应用程序，并随时与市场一起创新', '', '', '');
INSERT INTO `sys_lang` VALUES (25, 'title_apply', 'Apply for preferential price', '申请优惠价', '', '', '');
INSERT INTO `sys_lang` VALUES (26, 'input_desc_search', 'Search service or document...', '搜索服务或文档...', '', '', '');
INSERT INTO `sys_lang` VALUES (27, 'desc_apply', 'Officially start activities in 2021', '2021年正式启动活动', '', '', '');
INSERT INTO `sys_lang` VALUES (28, 'content_apply', 'If you are our regular customers or introduced by customers, we will give you more favorable prices and give you valuable marketing services', '如果你是我们的老客户，或者是客户介绍过来的，我们将给你更加优惠的价格和赠送你超值的营销服务', '', '', '');
INSERT INTO `sys_lang` VALUES (29, 'title_form_need', 'Demand consultation', '需求咨询', '', '', '');
INSERT INTO `sys_lang` VALUES (30, 'desc_form_need', 'Free needs analysis for you', '免费为您分析需求', '', '', '');
INSERT INTO `sys_lang` VALUES (31, 'btn_submit', 'Submit', '提交', '', '', '');
INSERT INTO `sys_lang` VALUES (32, 'input_desc_name', 'Please enter your name', '请输入您的姓名', '', '', '');
INSERT INTO `sys_lang` VALUES (33, 'input_desc_phone', 'Please enter your phone', '请输入您的手机号码', '', '', '');
INSERT INTO `sys_lang` VALUES (34, 'dev_web', 'Complete DIY<br />Official website', '完成定制<br />企业官网', '', '', '');
INSERT INTO `sys_lang` VALUES (35, 'dev_blockchain', 'Complete a<br />blockchain app', '完成一款<br />区块链应用', '', '', '');
INSERT INTO `sys_lang` VALUES (36, 'dev_mall', 'Complete the whole<br />e-commerce platform', '完成整套<br />电商平台', '', '', '');
INSERT INTO `sys_lang` VALUES (37, 'dev_app', 'Complete large-scale<br />commercial app', '完成大型<br />商业应用', '', '', '');
INSERT INTO `sys_lang` VALUES (38, 'dev_sns', 'SNS', '社交软件', '', '', '');
INSERT INTO `sys_lang` VALUES (39, 'dev_platform', 'Electronic platform', '电商平台', '', '', '');
INSERT INTO `sys_lang` VALUES (40, 'dev_code', 'Code up', '源码升级', '', '', '');
INSERT INTO `sys_lang` VALUES (41, 'dev_science', 'Science', '科学实验', '', '', '');
INSERT INTO `sys_lang` VALUES (42, 'dev_finance', 'Finance', '金融理财', '', '', '');
INSERT INTO `sys_lang` VALUES (43, 'dev_block_chain', 'Block chain', '区块链应用', '', '', '');
INSERT INTO `sys_lang` VALUES (44, 'dev_manage_system', 'Manage system', '管理系统', '', '', '');
INSERT INTO `sys_lang` VALUES (45, 'dev_web_ui', 'Web UI', '网页设计', '', '', '');
INSERT INTO `sys_lang` VALUES (46, 'title_profile', 'Company Profile', ' 企业简介', '', '', '');

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message`  (
  `message_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息ID：用于记录和识别消息',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言标题',
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '留言内容',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_message
-- ----------------------------
INSERT INTO `sys_message` VALUES (1, NULL, '你好');
INSERT INTO `sys_message` VALUES (2, NULL, '你好');
INSERT INTO `sys_message` VALUES (3, NULL, '111');
INSERT INTO `sys_message` VALUES (4, NULL, '你好');
INSERT INTO `sys_message` VALUES (5, NULL, '你好');
INSERT INTO `sys_message` VALUES (6, NULL, '111');
INSERT INTO `sys_message` VALUES (7, NULL, '你好');
INSERT INTO `sys_message` VALUES (8, NULL, '111');
INSERT INTO `sys_message` VALUES (9, NULL, '111');
INSERT INTO `sys_message` VALUES (10, NULL, '111');
INSERT INTO `sys_message` VALUES (11, NULL, '111');
INSERT INTO `sys_message` VALUES (12, NULL, '111');
INSERT INTO `sys_message` VALUES (13, '', 'fdsfgsdf');
INSERT INTO `sys_message` VALUES (14, '', 'ngfnfgngfn');
INSERT INTO `sys_message` VALUES (15, '', 'ngfnfgngfn');
INSERT INTO `sys_message` VALUES (16, '', '321132');
INSERT INTO `sys_message` VALUES (17, '', '123123132');
INSERT INTO `sys_message` VALUES (18, '', '12132312132');
INSERT INTO `sys_message` VALUES (19, '', 'DERER');
INSERT INTO `sys_message` VALUES (20, '', 'DERER');
INSERT INTO `sys_message` VALUES (21, '', 'DERER');
INSERT INTO `sys_message` VALUES (22, '', 'DERER');
INSERT INTO `sys_message` VALUES (23, '', 'DEEE');
INSERT INTO `sys_message` VALUES (24, '', '12132312312312312321321312312321');
INSERT INTO `sys_message` VALUES (25, '', '213123132132');
INSERT INTO `sys_message` VALUES (26, '', '123123123');
INSERT INTO `sys_message` VALUES (27, '', '132123');

-- ----------------------------
-- Table structure for sys_nav
-- ----------------------------
DROP TABLE IF EXISTS `sys_nav`;
CREATE TABLE `sys_nav`  (
  `nav_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '导航ID：[0,32767]',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名称：[0,32]用于多国语识别',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '中文标题：[0,32]用于中文提示',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转链接：[0,255]跳转的链接地址',
  `style` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '风格样式：[0,255]自定义css样式',
  `class` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式类型：[0,32]绑定的css class',
  `target` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转方式：[0,32]_blank表示新窗口跳转',
  `position` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '展现位置：[0,125]top顶部、bottom底部、side侧边，main主要，quick快捷，menu菜单，多个位置用逗号隔开',
  `device` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '呈现设备：[0,125]在什么设备上展示，web_pc、web_pad、web_phone、app_pad、app_phone，多个设备用逗号隔开',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[0,10000]在频道列表操作时，当上级导航展开时，才显示该导航(sys_nav.name.nav_id)',
  PRIMARY KEY (`nav_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '导航：用于管理员自定义应用的导航' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_nav
-- ----------------------------
INSERT INTO `sys_nav` VALUES (1, 'home', '首页', '/', '', '', '', 'top', '', 0);
INSERT INTO `sys_nav` VALUES (2, 'about', '关于我们', '/about', '', '', '', 'top', '', 0);
INSERT INTO `sys_nav` VALUES (3, 'product', '产品展示', '/product', '', '', '', 'top', '', 0);
INSERT INTO `sys_nav` VALUES (4, 'service', '技术服务', '/service', '', '', '', 'top', '', 0);
INSERT INTO `sys_nav` VALUES (5, 'contact', '联系方式', '/contact', '', '', '', 'top', '', 0);

-- ----------------------------
-- Table structure for user_account
-- ----------------------------
DROP TABLE IF EXISTS `user_account`;
CREATE TABLE `user_account`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID：[1,8388607]用户获取其他与用户相关的数据',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '账户状态：[0,10](1可用|2异常|3已冻结|4已注销)',
  `vip` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员级别：[0,10]用于确定用户访问权限',
  `gm` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员级别：[0,10]用于确定用户管理权限',
  `mc` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商家级别：[0,10]用于确定商家用户的管理权限',
  `group_id` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所在用户组：[1,32767]决定用户身份和权限(user_group)',
  `admin_id` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所在管理组：[1,32767]决定用户身份和权限(user_admin)',
  `referee_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '推荐人ID：[1,8388607]用于推荐注册时积分奖级(user_account.nickname.user_id)',
  `login_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '上次登录时间：',
  `salt` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '短验证：[0,6]',
  `invite_code` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邀请注册码：[0,8]随着用户注册而生成',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码：[0,11]用户的手机号码，用于找回密码时或登录时',
  `phone_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '手机认证：[0,1](0未认证|1审核中|2已认证)',
  `username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名：[0,16]用户登录时所用的账户名称',
  `nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '昵称：[0,16]',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码：[0,32]用户登录所需的密码，由6-16位数字或英文组成',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮箱：[0,64]用户的邮箱，用于找回密码时或登录时',
  `email_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '邮箱认证：[0,1](0未认证|1审核中|2已认证)',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上次登录时的IP地址：[0,128]',
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个性签名：[0,255]',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址：[0,255]',
  `friends` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '好友：多个好友ID用“,”分隔',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间：',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户账户：用于保存用户登录信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_account
-- ----------------------------
INSERT INTO `user_account` VALUES (1, 1, 14, 5, 5, 1, 1, 0, '2020-12-15 15:31:30', 'mm2020', '', NULL, 0, 'admin', '管理员', '0cf6066acc83160a6c65282835399c40', '', 0, '192.168.0.134', NULL, NULL, NULL, '2020-11-11 11:10:28');
INSERT INTO `user_account` VALUES (2, 1, 0, 0, 0, 0, 0, 0, '2020-11-11 11:11:14', '', '', '', 0, 'qiuwenwu', '文武', '', '', 0, '', '', '', '', '2020-11-11 11:10:45');

-- ----------------------------
-- Table structure for user_admin
-- ----------------------------
DROP TABLE IF EXISTS `user_admin`;
CREATE TABLE `user_admin`  (
  `admin_id` smallint(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理组ID：[1,1000]',
  `father_id` smallint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[1,32767](user_admin.name.admin_id)',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称：[0,16]',
  `department` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门：[0,12]用于区分管理组织结构',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该用户组的特点或权限范围',
  `icon` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '图标：用于标识用户组',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理组：用于判断用户后台管理鉴权' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_admin
-- ----------------------------

-- ----------------------------
-- Table structure for user_count
-- ----------------------------
DROP TABLE IF EXISTS `user_count`;
CREATE TABLE `user_count`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[1,8388607]',
  `level` smallint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '等级：[0,1000]',
  `iq` smallint(3) UNSIGNED NOT NULL DEFAULT 100 COMMENT 'IQ智商：[80,200]用于激励用户评论和发帖',
  `credit` int(10) UNSIGNED NOT NULL DEFAULT 100 COMMENT '信用度：[0,2147483647]用于评估用户信誉',
  `credit_points` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '积分：[0,2147483647]用于代金消费或兑换商品',
  `exp` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '经验值：[0,2147483647]',
  `extcredits1` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分1：[0,2147483647]',
  `extcredits2` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分2：[0,2147483647]',
  `extcredits3` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分3：[0,2147483647]',
  `extcredits4` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分4：[0,2147483647]',
  `extcredits5` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分5：[0,2147483647]',
  `extcredits6` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分6：[0,2147483647]',
  `extcredits7` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分7：[0,2147483647]',
  `extcredits8` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '拓展积分8：[0,2147483647]',
  `money` double(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '钱：用于现金业务',
  `coin` decimal(16, 8) NOT NULL DEFAULT 0.00000000 COMMENT '货币：用于游戏或数字货币业务',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户统计：用于统计用户等级、经验、积分等' ROW_FORMAT = FIXED;

-- ----------------------------
-- Records of user_count
-- ----------------------------

-- ----------------------------
-- Table structure for user_group
-- ----------------------------
DROP TABLE IF EXISTS `user_group`;
CREATE TABLE `user_group`  (
  `group_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户组ID：[1,8388607]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `level` smallint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '等级划分：[0,1000]用于识别级别分组',
  `next_group_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '下级用户组ID：[1,8388607]决定用户升级后所属用户组(user_group.name.group_id)',
  `exp` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '升级所需经验：[0,2147483647]用于确定用户的升级',
  `discount` double(3, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '折扣：用于确定用户的消费折扣',
  `bonus` double(3, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '奖励比例：用于确定用户的积分奖励',
  `app` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '应用：[0,12]用于区分用户组使用范围，cms内容管理系统、bbs社区、mall商城',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称：[0,16]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该用户组的特点或权限范围',
  `icon` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '图标：用于标识用户组',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户组：用于用户前端身份和鉴权' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_group
-- ----------------------------

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[1,8388607]',
  `sex` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别：[0,2](0未设置|1男|2女)',
  `idcard_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '身份实名认证：[0,10](1未认证|2认证中|3认证通过)',
  `age` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '年龄：[0,150]',
  `province_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '省份ID：[1,2147483647]用户所在地的省份(sys_address_province)',
  `city_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所在城市ID：[1,2147483647](sys_address_city)',
  `birthday` date NOT NULL DEFAULT '1970-01-01' COMMENT '生日：',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名：[2,16]',
  `job` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职业：[0,16]',
  `school` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业学校：[0,16]',
  `major` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所学专业：[0,16]',
  `idcard` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号：[0,64]',
  `company_address` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司地址：[0,125]用户当前就职的公司地址',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '详细地址：[0,255]用户居住地的详细地址',
  `job_scope` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工作范围：[0,255]',
  `company_business` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司经营范围：[0,255]',
  `idcard_img` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '身份证图片：保存json格式',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息：用于保存用户个人信息，如年龄、住址等' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message`  (
  `message_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息ID：用于记录和识别消息',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '留言内容',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言者手机',
  `email` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言者邮箱',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言者姓名',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户留言' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_message
-- ----------------------------
INSERT INTO `user_message` VALUES (1, NULL, '你好', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (2, NULL, '你好', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (3, NULL, '111', '18823759846', NULL, NULL);
INSERT INTO `user_message` VALUES (4, NULL, '你好', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (5, NULL, '你好', '15817188815', NULL, NULL);
INSERT INTO `user_message` VALUES (6, NULL, '111', '18823759846', NULL, NULL);
INSERT INTO `user_message` VALUES (7, NULL, '你好', '15817188815', NULL, NULL);
INSERT INTO `user_message` VALUES (8, NULL, '111', '18823759846', NULL, NULL);
INSERT INTO `user_message` VALUES (9, NULL, '111', '18823759846', NULL, NULL);
INSERT INTO `user_message` VALUES (10, NULL, '111', '18823759846', NULL, NULL);
INSERT INTO `user_message` VALUES (11, NULL, '111', '18823759846', NULL, NULL);
INSERT INTO `user_message` VALUES (12, NULL, '111', '18823759846', NULL, NULL);
INSERT INTO `user_message` VALUES (13, '', 'fdsfgsdf', '18823759846', '', '');
INSERT INTO `user_message` VALUES (14, '', 'ngfnfgngfn', '18823759846', '', '');
INSERT INTO `user_message` VALUES (15, '', 'ngfnfgngfn', '18823759846', '', '');
INSERT INTO `user_message` VALUES (16, '', '321132', '12312313245', '', '');
INSERT INTO `user_message` VALUES (17, '', '123123132', '18079307448', '', '');
INSERT INTO `user_message` VALUES (18, '', '12132312132', '18079307448', '', '');
INSERT INTO `user_message` VALUES (19, '', 'DERER', '15817188815', '', '');
INSERT INTO `user_message` VALUES (20, '', 'DERER', '15817188815', '', '');
INSERT INTO `user_message` VALUES (21, '', 'DERER', '15817188815', '', '');
INSERT INTO `user_message` VALUES (22, '', 'DERER', '15817188815', '', '');
INSERT INTO `user_message` VALUES (23, '', 'DEEE', '12312133331', '', '');
INSERT INTO `user_message` VALUES (24, '', '12132312312312312321321312312321', '18079307448', '', '');
INSERT INTO `user_message` VALUES (25, '', '213123132132', '18079307448', '', '');
INSERT INTO `user_message` VALUES (26, '', '123123123', '18079307448', '', '');
INSERT INTO `user_message` VALUES (27, '', '132123', '12312312312', '', '');
INSERT INTO `user_message` VALUES (28, NULL, '123312312', '18079307448', NULL, NULL);
INSERT INTO `user_message` VALUES (29, NULL, '12213213213', '18079307448', NULL, NULL);
INSERT INTO `user_message` VALUES (30, NULL, '123231213', '18079307448', NULL, NULL);
INSERT INTO `user_message` VALUES (31, NULL, '4444', NULL, '22121@qq.com', NULL);

-- ----------------------------
-- Table structure for user_sns
-- ----------------------------
DROP TABLE IF EXISTS `user_sns`;
CREATE TABLE `user_sns`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[1,8388607]',
  `qq` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'QQ号：[5,12]',
  `qq_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'QQ认证：[0,1](0未认证|1已认证)',
  `wechat` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信号：[5,16]',
  `wechat_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '微信认证：[0,1](0未认证|1已认证)',
  `mm` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'MM号：[5,16]',
  `mm_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'MM认证：[0,1](0未认证|1已认证)',
  `baidu` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '百度账号：[5,14]',
  `baidu_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '百度认证：[0,1](0未认证|1已认证)',
  `taobao` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '淘宝账号：[5,10]',
  `taobao_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '淘宝认证：[0,1](0未认证|1已认证)',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '社交账户：用于保存用的社交平台账户，方便同步登录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_sns
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
