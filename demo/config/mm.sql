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

 Date: 21/03/2021 02:45:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for bbs_config
-- ----------------------------
DROP TABLE IF EXISTS `bbs_config`;
CREATE TABLE `bbs_config`  (
  `config_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID：[0,2147483647]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量名：[0,16]',
  `type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'string' COMMENT '数据类型：[0,16]string文本型、number数字型、boolean布尔型',
  `title` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量标题：[0,16]可以用中文名',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量值：[0,255]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量描述：[0,255]描述该变量的作用',
  `model` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据模型：json格式，用于单选、多选模式',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '社区配置：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bbs_config
-- ----------------------------

-- ----------------------------
-- Table structure for bbs_thread
-- ----------------------------
DROP TABLE IF EXISTS `bbs_thread`;
CREATE TABLE `bbs_thread`  (
  `thread_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主题id：[0,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后前台才会显示该主题(0否|1是)',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：[1,5](1正常|2推荐|3认证|4违规|5官方)',
  `type_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '主题分类ID：[0,1000]用来搜索指定类型的主题(bbs_thread_type)',
  `channel_id` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '频道ID：[0,10000]该主题所属频道，仅该频道列表可以看到该主题(bbs_thread_channel)',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序：[0,10000]决定主题显示的顺序',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[0,8388607]对于一些地方主题，可以通过该ID筛看(sys_address_city)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]编辑这篇主题到本站的用户ID(user_account.nickname)',
  `hot` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '热度：[0,1000000000]访问这篇主题的人次',
  `praise` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞次数：[0,1000000000]',
  `collect_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '采集规则ID：[0,1000000000]如果主题是通过采集的方式获得，那么具有采集ID',
  `time_create` datetime(0) NOT NULL DEFAULT '1997-01-01 00:00:00' COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题：[0,125]用于主题和html的<title>标签中',
  `keywords` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,125]用于搜索引擎收录',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]用于主题提纲和搜索引擎收录',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源地址：[0,255]用于跳转到发布该主题的网站',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签：[0,255]用于标注主题所属相关内容，多个标签用空格隔开',
  `img` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '封面图：用于显示于主题列表页，多个封面图用换行分隔',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '正文：主题的主体内容',
  `collecter` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '收藏者：多个收藏者用”,“分隔',
  PRIMARY KEY (`thread_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '社区主题：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bbs_thread
-- ----------------------------

-- ----------------------------
-- Table structure for bbs_thread_channel
-- ----------------------------
DROP TABLE IF EXISTS `bbs_thread_channel`;
CREATE TABLE `bbs_thread_channel`  (
  `channel_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '频道ID：[0,10000]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后才可以看到该频道(0否|1是)',
  `hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏：[0,1]隐藏非管理员该频道无法查看.(0否|1是)',
  `can_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可评论：[0,1]不可评论则用户只能看，无法点评。(0否|1是)',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]决定频道显示的先后顺序',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[0,10000]在频道列表操作时，当上级频道展开时，才显示该频道(bbs_thread_channel.name.channel_id)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市：[0,8388607]一些地方频道，可以通过该条判断是否可查看(sys_address_city)',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '频道名称：[2,16]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '频道标题：[0,125]',
  `template` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '风格模板：[0,64]频道和主题都使用的样式。question问答、info资讯、news新闻、article文章、activity活动',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该频道的作用',
  `icon` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '频道图标：',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '外链地址：[0,255]如果该频道是跳转到其他网站的情况下，就在该URL上设置',
  PRIMARY KEY (`channel_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '主题板块：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bbs_thread_channel
-- ----------------------------

-- ----------------------------
-- Table structure for bbs_thread_comment
-- ----------------------------
DROP TABLE IF EXISTS `bbs_thread_comment`;
CREATE TABLE `bbs_thread_comment`  (
  `comment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论id：[0,2147483647]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用则显示该评论(0否|1是)',
  `score` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评分：[0,5]最低1分、最多5分',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示排序：[0,1000]决定显示的顺序',
  `thread_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 1 COMMENT '所属主题id：[0,8388607](bbs_thread.title)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]编辑评论的用户ID(user_account.nickname)',
  `tag` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签：[0,64]评论人给的标签，多个标签用空格隔开',
  `reply` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '评论回复：对评论人的评论做出的回复。通过form-url格式保存，多个人的回复用换行分隔',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '正文：评论内容',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '主题评论：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bbs_thread_comment
-- ----------------------------

-- ----------------------------
-- Table structure for bbs_thread_type
-- ----------------------------
DROP TABLE IF EXISTS `bbs_thread_type`;
CREATE TABLE `bbs_thread_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主题分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID：[0,32767](bbs_thread_type.name.type_id)',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称：[0,16]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类描述：[0,255]',
  `icon` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '分类图标：',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '主题分类：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bbs_thread_type
-- ----------------------------

-- ----------------------------
-- Table structure for cms_ad
-- ----------------------------
DROP TABLE IF EXISTS `cms_ad`;
CREATE TABLE `cms_ad`  (
  `ad_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '广告ID：[0,32767]',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,10000]数值越小，越优先显示',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放城市ID：[0,8388607](sys_address_city)',
  `area_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放地区：[0,8388607](sys_address_area)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '广告主ID：[0,8388607]表示是谁打的广告(user_account.nickname)',
  `times_user` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访客数：[0,2147483647]',
  `times_max` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '次数上限：[0,2147483647]表示点击或展现达多少次后不再打该广告',
  `times_show` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '展现量：[0,2147483647]',
  `times_click` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击量：[0,2147483647]',
  `fee` double(5, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用：每次点击或展现、增加访客所需的费用',
  `fee_max` double(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用上限：表示打广告消费到多少钱后不再打广告',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '广告名称：[0,16]',
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
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'CMS广告：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_ad
-- ----------------------------
INSERT INTO `cms_ad` VALUES (1, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告1', 'banner', '', '', '', '', 'banner_1', '', '', '/cms/home_pc/template/default/img/banner/banner_3.jpg', '/', '');
INSERT INTO `cms_ad` VALUES (2, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告2', 'banner', '', '', '', '', 'banner_2', '', '', '/cms/home_pc/template/default/img/banner/banner_2.jpg', '/', '');
INSERT INTO `cms_ad` VALUES (3, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告3', 'banner', '', '', '', '', 'banner_3', '', '', '/cms/home_pc/template/default/img/banner/banner_1.jpg', '/', '');

-- ----------------------------
-- Table structure for cms_article
-- ----------------------------
DROP TABLE IF EXISTS `cms_article`;
CREATE TABLE `cms_article`  (
  `article_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章id：[0,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后前台才会显示该文章(0否|1是)',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：[1,5](1正常|2推荐|3认证|4违规|5官方)',
  `type_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章分类ID：[0,1000]用来搜索指定类型的文章(cms_article_type)',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序：[0,10000]决定文章显示的顺序',
  `channel_id` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '频道ID：[0,10000]该文章所属频道，仅该频道列表可以看到该文章(cms_article_channel)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]编辑这篇文章到本站的用户ID(user_account.nickname)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[0,8388607]对于一些地方文章，可以通过该ID筛看(sys_address_city)',
  `hot` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '热度：[0,1000000000]访问这篇文章的人次',
  `praise` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞次数：[0,1000000000]',
  `collect_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '采集规则ID：[0,1000000000]如果文章是通过采集的方式获得，那么具有采集ID',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `lang` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'zh_cn' COMMENT '语言：[0,16]默认zh_cn(zh_cn|en|zh_tw|ko|ja)',
  `author` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者：[0,16]写出该文章的人',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题：[0,125]用于文章和html的title标签中',
  `keywords` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,125]用于搜索引擎收录',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]用于文章提纲和搜索引擎收录',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源：[0,255]文章的出处',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源地址：[0,255]用于跳转到发布该文章的网站',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签：[0,255]用于标注文章所属相关内容，多个标签用空格隔开',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面图：[0,255]用于显示于文章列表页，多个封面图用换行分隔',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正文：文章的主体内容',
  `collecter` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '收藏者：多个收藏者用”,“分隔',
  PRIMARY KEY (`article_id`, `title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章：用于内容管理系统的文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_article
-- ----------------------------
INSERT INTO `cms_article` VALUES (6, 1, 1, 0, 100, 12, 0, 0, 0, 0, 0, '2020-12-17 13:57:14', '2020-12-17 14:19:42', 'zh_cn', '', '2017年超级美眉程序框架诞生', '', '', '', '', '', '', '', '');
INSERT INTO `cms_article` VALUES (7, 1, 1, 0, 100, 12, 0, 0, 0, 0, 0, '2020-12-17 00:00:00', '2020-12-17 14:19:43', 'zh_cn', '', '2018年基于超级美眉开发手机选号应用', '', '', '', '', '', '', '', '');
INSERT INTO `cms_article` VALUES (8, 1, 1, 0, 100, 11, 0, 0, 0, 0, 0, '2020-12-17 00:00:00', '2020-12-17 14:49:12', 'zh_cn', '', '选号平台', '', '一个在线交易手机号码的网站，在这里你能够根据各种条件搜索到自己喜欢的号码来进行购买。', '', '', '', '', '', '');
INSERT INTO `cms_article` VALUES (9, 1, 1, 0, 100, 11, 0, 0, 0, 0, 0, '2020-12-17 00:00:00', '2020-12-17 14:50:44', 'zh_cn', '', '企业官网', '', '一个具有中英文切换和风格切换的企业网站，并且带有SEO优化功能，适合企业建站宣传自己。', '', '', '', '', '', '');
INSERT INTO `cms_article` VALUES (10, 1, 1, 0, 100, 11, 0, 0, 0, 0, 0, '2020-12-17 00:00:00', '2020-12-21 17:27:04', 'zh_cn', '', '同城信息网', '类同 百姓网 58同城 信息分类网 服务 求职 招聘 租房 买房', '一个类似于58同城的信息分类网站，可以比58同城更精细的分类信息和更精准的找到自己想要的信息', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for cms_article_channel
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_channel`;
CREATE TABLE `cms_article_channel`  (
  `channel_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '频道ID：[0,10000]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后才可以看到该频道。(0否|1是)',
  `hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏：[0,1]隐藏非管理员该频道无法查看。(0否|1是)',
  `can_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可评论：[0,1]不可评论则用户只能看，无法点评。(0否|1是)',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]决定频道显示的先后顺序',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[0,10000]在频道列表操作时，当上级频道展开时，才显示该频道(cms_article_channel.name.channel_id)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市：[0,8388607]一些地方频道，可以通过该条判断是否可查看。(sys_address_city)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '频道名称：[2,16]',
  `template` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风格模板：[0,64]频道和文章都使用的样式',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该频道的作用',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '频道图标：',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外链地址：[0,255]如果该频道是跳转到其他网站的情况下，就在该URL上设置',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '频道标题：[0,125]',
  PRIMARY KEY (`channel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章频道：用于汇总浏览文章，在不同频道下展示不同文章。' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_article_channel
-- ----------------------------
INSERT INTO `cms_article_channel` VALUES (2, 1, 1, 0, 100, 0, 0, 'info', '', '企业信息', '', '', '企业信息');
INSERT INTO `cms_article_channel` VALUES (3, 1, 0, 0, 100, 0, 0, 'help', '', '操作帮助', '', '', '操作帮助');
INSERT INTO `cms_article_channel` VALUES (4, 1, 0, 0, 100, 0, 0, 'product', '', '产品展示', '', '', '产品展示');
INSERT INTO `cms_article_channel` VALUES (5, 1, 0, 0, 100, 4, 0, 'ui', '', 'UI类产品展示', '', '', 'UI');
INSERT INTO `cms_article_channel` VALUES (6, 1, 0, 0, 100, 4, 0, 'front_end', '', '前端产品展示', '', '', '前端');
INSERT INTO `cms_article_channel` VALUES (7, 1, 0, 0, 100, 4, 0, 'after_end', '', '后端产品展示', '', '', '后端');
INSERT INTO `cms_article_channel` VALUES (8, 1, 0, 0, 100, 0, 0, 'doc', '', '开发文档', '', '', '开发文档');
INSERT INTO `cms_article_channel` VALUES (9, 1, 0, 0, 100, 8, 0, 'doc_front_end', '', '前端开发文档', '', '', '前端开发文档');
INSERT INTO `cms_article_channel` VALUES (10, 1, 0, 0, 100, 8, 0, 'doc_after_end', '', '后端开发文档', '', '', '后端开发文档');
INSERT INTO `cms_article_channel` VALUES (11, 1, 0, 0, 100, 4, 0, 'package', '', '完整应用展示', '', '', '完整应用');
INSERT INTO `cms_article_channel` VALUES (12, 1, 0, 0, 100, 2, 0, 'event', '', '历史事件', '', '', '历史事件');

-- ----------------------------
-- Table structure for cms_article_comment
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_comment`;
CREATE TABLE `cms_article_comment`  (
  `comment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论id：[0,2147483647]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用则显示该评论(0否|1是)',
  `score` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评分：[0,5]最低1分、最多5分',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示排序：[0,1000]决定显示的顺序',
  `article_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 1 COMMENT '所属文章id：[0,8388607](cms_article.title)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]编辑评论的用户ID(user_account.nickname)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '留言者姓名：[2,16]用于实名回复',
  `tag` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签：[0,64]评论人给的标签，多个标签用空格隔开',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正文：评论内容',
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评论回复：对评论人的评论做出的回复。通过form-url格式保存，多个人的回复用换行分隔',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章评论：用于记录读者对某文章的评论' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_article_comment
-- ----------------------------

-- ----------------------------
-- Table structure for cms_article_section
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_section`;
CREATE TABLE `cms_article_section`  (
  `section_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '章节模块ID：[0,2147483647]',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序：[0,10000]决定文章显示的顺序',
  `article_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '对应文章ID：[0,2147483647](cms_article.title)',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '章节标题：[0,255]',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '章节标签：[0,255]',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '章节内容：',
  `img` varchar(0) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '章节图片：',
  PRIMARY KEY (`section_id`, `title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章章节：文章的正文是单独一块保存的，一个个章节保存' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_article_section
-- ----------------------------

-- ----------------------------
-- Table structure for cms_article_type
-- ----------------------------
DROP TABLE IF EXISTS `cms_article_type`;
CREATE TABLE `cms_article_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文章分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID：[0,32767](cms_article_type.name.type_id)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称：[0,16]',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类描述：[0,255]',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '分类图标：',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类标题：[0,125]',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章分类：将文章归类，可选看不同类型的文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_article_type
-- ----------------------------

-- ----------------------------
-- Table structure for cms_lang
-- ----------------------------
DROP TABLE IF EXISTS `cms_lang`;
CREATE TABLE `cms_lang`  (
  `lang_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '语言ID',
  `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文',
  `zh_cn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简体中文',
  `zh_tw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '繁体中文',
  `ko` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '韩文',
  `ja` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日文',
  PRIMARY KEY (`lang_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'CMS语言包：用于开发站点多国语' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_lang
-- ----------------------------
INSERT INTO `cms_lang` VALUES (1, 'web_name', 'MM', '超级美眉', '', '', '');
INSERT INTO `cms_lang` VALUES (2, 'btn_sign_in', 'SignIn', '登录', '', '', '');
INSERT INTO `cms_lang` VALUES (3, 'btn_sign_up', 'SignUp', '注册', '', '', '');
INSERT INTO `cms_lang` VALUES (4, 'nav_home', 'Home', '首页', '', '', '');
INSERT INTO `cms_lang` VALUES (5, 'nav_about', 'About', '关于我们', '', '', '');
INSERT INTO `cms_lang` VALUES (6, 'nav_product', 'Product', '产品展示', '', '', '');
INSERT INTO `cms_lang` VALUES (7, 'nav_document', 'Document', '开发文档', '', '', '');
INSERT INTO `cms_lang` VALUES (8, 'nav_forum', 'Forum', '论坛', '', '', '');
INSERT INTO `cms_lang` VALUES (9, 'nav_service', 'Service', '技术服务', '', '', '');
INSERT INTO `cms_lang` VALUES (10, 'nav_contact', 'Contact', '联系方式', '', '', '');
INSERT INTO `cms_lang` VALUES (11, 'btn_read_more', 'Read More', '查看更多', '', '', '');
INSERT INTO `cms_lang` VALUES (12, 'btn_more', 'More', '更多', '', '', '');
INSERT INTO `cms_lang` VALUES (13, 'banner_1', 'Software development actually has a lot of considerations', '软件开发其实有很多注意事项', '', '', '');
INSERT INTO `cms_lang` VALUES (14, 'banner_2', 'Professional development team and solutions make you worry free', '专业的开发团队和解决方案让您无忧无虑', '', '', '');
INSERT INTO `cms_lang` VALUES (15, 'banner_3', 'Explore the world of super applications with us', '和我们一起探索超级应用的世界', '', '', '');
INSERT INTO `cms_lang` VALUES (16, 'title_online_solutions', 'Online solutions', '在线解决方案', '', '', '');
INSERT INTO `cms_lang` VALUES (17, 'desc_online_solutions', 'Cloud excel is used to provide solutions, which is convenient for cooperation and can be viewed and changed at any time', '采用云excel提供解决方案，协作方便，随时可看可改', '', '', '');
INSERT INTO `cms_lang` VALUES (18, 'title_team', 'Senior engineer team', '高级工程师团队', '', '', '');
INSERT INTO `cms_lang` VALUES (19, 'desc_team', 'Collaborative development of technical teams from Huawei, Tencent and other enterprises', '从华为、腾讯等企业出来的技术团队协作开发', '', '', '');
INSERT INTO `cms_lang` VALUES (20, 'title_document', 'Secondary development document', '二次开发文档', '', '', '');
INSERT INTO `cms_lang` VALUES (21, 'desc_document', 'Have mature program architecture and perfect development documents', '拥有成熟的程序架构和完善的开发文档', '', '', '');
INSERT INTO `cms_lang` VALUES (22, 'title_welcome', 'Welcome to our website', '欢迎来到我们网站', '', '', '');
INSERT INTO `cms_lang` VALUES (23, 'content_welcome_1', 'Maybe you\'ve met a lot of development companies to come to us, but when you see us, you will find that we are your best choice', '也许你看到过许多的开发公司才找到我们，但是当你看到我们之后就会发现，我们就是你最好的选择。', '', '', '');
INSERT INTO `cms_lang` VALUES (24, 'content_welcome_2', 'Reasonable price is only a feature. What\'s more, our development framework superior to the market after use makes it easier for you to upgrade your application and innovate with the market at any time', '合理的价格只是一个特点。更重要的是，我们的开发框架在使用后优于市场，使您更容易升级应用程序，并随时与市场一起创新', '', '', '');
INSERT INTO `cms_lang` VALUES (25, 'title_apply', 'Apply for preferential price', '申请优惠价', '', '', '');
INSERT INTO `cms_lang` VALUES (26, 'input_desc_search', 'Search service or document...', '搜索服务或文档...', '', '', '');
INSERT INTO `cms_lang` VALUES (27, 'desc_apply', 'Officially start activities in 2021', '2021年正式启动活动', '', '', '');
INSERT INTO `cms_lang` VALUES (28, 'content_apply', 'If you are our regular customers or introduced by customers, we will give you more favorable prices and give you valuable marketing services', '如果你是我们的老客户，或者是客户介绍过来的，我们将给你更加优惠的价格和赠送你超值的营销服务', '', '', '');
INSERT INTO `cms_lang` VALUES (29, 'title_form_need', 'Demand consultation', '需求咨询', '', '', '');
INSERT INTO `cms_lang` VALUES (30, 'desc_form_need', 'Free needs analysis for you', '免费为您分析需求', '', '', '');
INSERT INTO `cms_lang` VALUES (31, 'btn_submit', 'Submit', '提交', '', '', '');
INSERT INTO `cms_lang` VALUES (32, 'input_desc_name', 'Please enter your name', '请输入您的姓名', '', '', '');
INSERT INTO `cms_lang` VALUES (33, 'input_desc_phone', 'Please enter your phone', '请输入您的手机号码', '', '', '');
INSERT INTO `cms_lang` VALUES (34, 'dev_web', 'Complete DIY<br />Official website', '完成定制<br />企业官网', '', '', '');
INSERT INTO `cms_lang` VALUES (35, 'dev_blockchain', 'Complete a<br />blockchain app', '完成一款<br />区块链应用', '', '', '');
INSERT INTO `cms_lang` VALUES (36, 'dev_mall', 'Complete the whole<br />e-commerce platform', '完成整套<br />电商平台', '', '', '');
INSERT INTO `cms_lang` VALUES (37, 'dev_app', 'Complete large-scale<br />commercial app', '完成大型<br />商业应用', '', '', '');
INSERT INTO `cms_lang` VALUES (38, 'dev_sns', 'SNS', '社交软件', '', '', '');
INSERT INTO `cms_lang` VALUES (39, 'dev_platform', 'Electronic platform', '电商平台', '', '', '');
INSERT INTO `cms_lang` VALUES (40, 'dev_code', 'Code up', '源码升级', '', '', '');
INSERT INTO `cms_lang` VALUES (41, 'dev_science', 'Science', '科学实验', '', '', '');
INSERT INTO `cms_lang` VALUES (42, 'dev_finance', 'Finance', '金融理财', '', '', '');
INSERT INTO `cms_lang` VALUES (43, 'dev_block_chain', 'Block chain', '区块链应用', '', '', '');
INSERT INTO `cms_lang` VALUES (44, 'dev_manage_system', 'Manage system', '管理系统', '', '', '');
INSERT INTO `cms_lang` VALUES (45, 'dev_web_ui', 'Web UI', '网页设计', '', '', '');
INSERT INTO `cms_lang` VALUES (46, 'title_profile', 'Company Profile', '企业简介', '', '', '');
INSERT INTO `cms_lang` VALUES (47, 'content_profile_1', '', '深圳图灵魔方信息科技有限公司专注于科技信息咨询和移动应用开发领域，主要开发电商、社交、区块链相关应用。“图灵魔方”在应用设计和开发领域是为数不多的拥有自主研发框架和高级技术，能够在业内中更快速开发出优质应用。', '', '', '');
INSERT INTO `cms_lang` VALUES (48, 'content_profile_2', '', '原来我们只是为其他开发公司所服务，现在我们直接为需求方服务，不仅价格实惠，还更能实现理想的应用效果。', '', '', '');
INSERT INTO `cms_lang` VALUES (49, 'title_framework', 'MM', '超级美眉', '', '', '');
INSERT INTO `cms_lang` VALUES (50, 'desc_framework', 'Framework', '应用框架', '', '', '');
INSERT INTO `cms_lang` VALUES (51, 'content_framework', '', '这是用JavaScript编程语言开发的商业级应用框架，适用于大型商城、中小型游戏、社交软件开发，框架简化了对函数和数据的调用，让开发应用变得更加轻松、灵活。全新的架构体让多人协作开发和升级维护更加容易，是未来理想的选择。', '', '', '');
INSERT INTO `cms_lang` VALUES (52, 'title_latest_product', 'Latest Product', '最近产品', '', '', '');
INSERT INTO `cms_lang` VALUES (53, 'title_latest_event', 'Latest event', '最近事件', '', '', '');
INSERT INTO `cms_lang` VALUES (54, 'btn_view_all', 'View all', '查看全部', '', '', '');
INSERT INTO `cms_lang` VALUES (55, 'title_about_us', 'About Our Institution', '关于我们机构', '', '', '');
INSERT INTO `cms_lang` VALUES (56, 'desc_about_us', 'About Our Institution', '关于我们机构的介绍', '', '', '');

-- ----------------------------
-- Table structure for cms_nav
-- ----------------------------
DROP TABLE IF EXISTS `cms_nav`;
CREATE TABLE `cms_nav`  (
  `nav_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '导航ID：[0,32767]',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名称：[0,32]用于多国语识别',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '中文标题：[0,32]用于中文提示',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转链接：[0,255]跳转的链接地址',
  `style` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '风格样式：[0,255]自定义css样式',
  `class` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式类型：[0,32]绑定的css class',
  `target` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转方式：[0,32]_blank表示新窗口跳转',
  `position` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'top' COMMENT '展现位置：[0,125]top顶部、bottom底部、side侧边，main主要，quick快捷，menu菜单，多个位置用逗号隔开',
  `device` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '呈现设备：[0,125]在什么设备上展示，web_pc、web_pad、web_phone、app_pad、app_phone，多个设备用逗号隔开',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[0,10000]在频道列表操作时，当上级导航展开时，才显示该导航(sys_nav.name.nav_id)',
  PRIMARY KEY (`nav_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = 'CMS导航：用于管理员自定义应用的导航' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cms_nav
-- ----------------------------
INSERT INTO `cms_nav` VALUES (1, 'home', '首页', '/', '', '', '', 'top', '', 0);
INSERT INTO `cms_nav` VALUES (2, 'about', '关于我们', '/about', '', '', '', 'top', '', 0);
INSERT INTO `cms_nav` VALUES (3, 'product', '产品展示', '/product', '', '', '', 'top', '', 0);
INSERT INTO `cms_nav` VALUES (4, 'service', '技术服务', '/service', '', '', '', 'top', '', 0);
INSERT INTO `cms_nav` VALUES (5, 'contact', '联系方式', '/contact', '', '', '', 'top', '', 0);

-- ----------------------------
-- Table structure for dev_app
-- ----------------------------
DROP TABLE IF EXISTS `dev_app`;
CREATE TABLE `dev_app`  (
  `app_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '应用ID：[0,2147483647]',
  `type_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '应用分类ID：[0,2147483647](dev_app_type.name.type_id)',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用名：[0,32]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,255]',
  PRIMARY KEY (`app_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用：用于引导创建应用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_app
-- ----------------------------

-- ----------------------------
-- Table structure for dev_app_type
-- ----------------------------
DROP TABLE IF EXISTS `dev_app_type`;
CREATE TABLE `dev_app_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '应用分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID：[0,32767](dev_app_type.name.type_id)',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类名称：[0,32]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类描述：[0,255]',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,255]',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用分类：将应用归类，方便选择构建不同的应用' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_app_type
-- ----------------------------

-- ----------------------------
-- Table structure for dev_component
-- ----------------------------
DROP TABLE IF EXISTS `dev_component`;
CREATE TABLE `dev_component`  (
  `page_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '适用页面ID：[0,2147483647](dev_page.name.page_id)',
  `num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用次数：[0,2147483647]',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组件名称：[0,32]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]',
  PRIMARY KEY (`page_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组件：用于组装成新页面' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_component
-- ----------------------------

-- ----------------------------
-- Table structure for dev_component_type
-- ----------------------------
DROP TABLE IF EXISTS `dev_component_type`;
CREATE TABLE `dev_component_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '页面分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID：[0,32767](dev_component_type.name.type_id)',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分类名称：[0,32]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类描述：[0,255]',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,255]',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '组件分类：将组件归类，方便引用不同的组件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_component_type
-- ----------------------------

-- ----------------------------
-- Table structure for dev_dict
-- ----------------------------
DROP TABLE IF EXISTS `dev_dict`;
CREATE TABLE `dev_dict`  (
  `dict_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '字典ID',
  `zh` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '中文',
  `en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文',
  `times` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '使用次数',
  PRIMARY KEY (`dict_id`, `zh`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 73 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '开发字典：用于检索英文' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_dict
-- ----------------------------
INSERT INTO `dev_dict` VALUES (1, '成绩', 'achievement', 1);
INSERT INTO `dev_dict` VALUES (2, '成绩ID', 'grade_id', 1);
INSERT INTO `dev_dict` VALUES (3, '学生ID', 'student_id', 1);
INSERT INTO `dev_dict` VALUES (4, '手机号码', 'phone_number', 1);
INSERT INTO `dev_dict` VALUES (5, '联系电话', 'contact_number', 1);
INSERT INTO `dev_dict` VALUES (6, '成交量', 'turnover', 1);
INSERT INTO `dev_dict` VALUES (7, '商品信息', 'product_information', 1);
INSERT INTO `dev_dict` VALUES (8, '学生信息', 'student_information', 1);
INSERT INTO `dev_dict` VALUES (9, '学号', 'student_number', 1);
INSERT INTO `dev_dict` VALUES (10, '学生姓名', 'student_name', 1);
INSERT INTO `dev_dict` VALUES (11, '性别', 'gender', 1);
INSERT INTO `dev_dict` VALUES (12, '用户ID', 'user_id', 1);
INSERT INTO `dev_dict` VALUES (13, '身份证', 'id', 1);
INSERT INTO `dev_dict` VALUES (14, '手机号', 'phone_number', 1);
INSERT INTO `dev_dict` VALUES (15, '学分', 'credit', 1);
INSERT INTO `dev_dict` VALUES (16, '照片', 'photo', 1);
INSERT INTO `dev_dict` VALUES (17, '班级', 'class', 1);
INSERT INTO `dev_dict` VALUES (18, '班级信息', 'class_information', 1);
INSERT INTO `dev_dict` VALUES (19, '班号', 'class_number', 1);
INSERT INTO `dev_dict` VALUES (20, '描述', 'describe', 1);
INSERT INTO `dev_dict` VALUES (21, '班ID', 'class_id', 1);
INSERT INTO `dev_dict` VALUES (22, '班级编号', 'class_number', 1);
INSERT INTO `dev_dict` VALUES (23, '排序', 'sort', 1);
INSERT INTO `dev_dict` VALUES (24, '12312', 'twelve_thousand_three_hundred_and_twelve', 1);
INSERT INTO `dev_dict` VALUES (25, '测试', 'test', 1);
INSERT INTO `dev_dict` VALUES (26, '语文成绩', 'grade_scores_of_chinese', 1);
INSERT INTO `dev_dict` VALUES (27, '英语成绩', 'english_achievement', 1);
INSERT INTO `dev_dict` VALUES (28, '备注', 'remarks', 1);
INSERT INTO `dev_dict` VALUES (29, '打分老师', 'grading_teacher', 1);
INSERT INTO `dev_dict` VALUES (30, '打分账号', 'scoring_account_number', 1);
INSERT INTO `dev_dict` VALUES (31, '老师信息', 'teacher_information', 1);
INSERT INTO `dev_dict` VALUES (32, '老师名称', 'teacher_name', 1);
INSERT INTO `dev_dict` VALUES (33, '老师工号', 'teacher_job_number', 1);
INSERT INTO `dev_dict` VALUES (34, '老师照片', 'teacher_photos', 1);
INSERT INTO `dev_dict` VALUES (35, '商品', 'commodity', 1);
INSERT INTO `dev_dict` VALUES (36, '产品信息', 'product_information', 1);
INSERT INTO `dev_dict` VALUES (37, '商品名称', 'trade_name', 1);
INSERT INTO `dev_dict` VALUES (38, '商品价格', 'commodity_price', 1);
INSERT INTO `dev_dict` VALUES (39, '商品封面', 'product_cover', 1);
INSERT INTO `dev_dict` VALUES (40, '账号', 'account_number', 1);
INSERT INTO `dev_dict` VALUES (41, '商家', 'business', 1);
INSERT INTO `dev_dict` VALUES (42, '商家名称', 'business_name', 1);
INSERT INTO `dev_dict` VALUES (43, '商家编号', 'merchant_number', 1);
INSERT INTO `dev_dict` VALUES (44, '商家电话', 'business_phone', 1);
INSERT INTO `dev_dict` VALUES (45, '库存', 'stock', 1);
INSERT INTO `dev_dict` VALUES (46, '用户', 'user', 1);
INSERT INTO `dev_dict` VALUES (47, '买家', 'buyers', 1);
INSERT INTO `dev_dict` VALUES (48, '用户名称', 'user_name', 1);
INSERT INTO `dev_dict` VALUES (49, '年龄', 'age', 1);
INSERT INTO `dev_dict` VALUES (50, '订单', 'order', 1);
INSERT INTO `dev_dict` VALUES (51, '购买数量', 'purchase_quantity', 1);
INSERT INTO `dev_dict` VALUES (52, '药品', 'drugs', 1);
INSERT INTO `dev_dict` VALUES (53, '学生', 'student', 1);
INSERT INTO `dev_dict` VALUES (54, '国籍', 'nationality', 1);
INSERT INTO `dev_dict` VALUES (55, '设备管理', 'device_management', 1);
INSERT INTO `dev_dict` VALUES (56, '宠物信息', 'pet_information', 1);
INSERT INTO `dev_dict` VALUES (57, '宠物编号', 'pet_number', 1);
INSERT INTO `dev_dict` VALUES (58, '宠物类型', 'pet_type', 1);
INSERT INTO `dev_dict` VALUES (59, '宠物图片', 'pet_pictures', 1);
INSERT INTO `dev_dict` VALUES (60, '宠物标题', 'pet_title', 1);
INSERT INTO `dev_dict` VALUES (61, '宠物价格', 'pet_price', 1);
INSERT INTO `dev_dict` VALUES (62, '宠物详情', 'pet_details', 1);
INSERT INTO `dev_dict` VALUES (63, '药理知识', 'pharmacological_knowledge', 1);
INSERT INTO `dev_dict` VALUES (64, '密码', 'password', 1);
INSERT INTO `dev_dict` VALUES (65, 'gouami', 'gouami', 1);
INSERT INTO `dev_dict` VALUES (66, '数学成绩', 'mathematics_achievement', 1);
INSERT INTO `dev_dict` VALUES (67, '用户信息', 'user_information', 1);
INSERT INTO `dev_dict` VALUES (68, '处方', 'prescription', 1);
INSERT INTO `dev_dict` VALUES (69, '处方编号', 'prescription_number', 1);
INSERT INTO `dev_dict` VALUES (70, '处方名称', 'prescription_name', 1);
INSERT INTO `dev_dict` VALUES (71, '处方价格', 'prescription_price', 1);
INSERT INTO `dev_dict` VALUES (72, '处方数量', 'number_of_prescriptions', 1);

-- ----------------------------
-- Table structure for dev_page
-- ----------------------------
DROP TABLE IF EXISTS `dev_page`;
CREATE TABLE `dev_page`  (
  `page_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '页面ID：[0,2147483647]',
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '页面分组ID：[0,2147483647](dev_page_group.name.group_id)',
  `num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用次数：[0,2147483647]',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '页面名称：[0,32]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]',
  PRIMARY KEY (`page_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '页面：用于构建MVC或MVVM页面' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_page
-- ----------------------------

-- ----------------------------
-- Table structure for dev_page_group
-- ----------------------------
DROP TABLE IF EXISTS `dev_page_group`;
CREATE TABLE `dev_page_group`  (
  `group_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '页面分组ID：[0,30000]',
  `display` int(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` int(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分组ID：[0,32767](dev_page_group.name.group_id)',
  `app_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '适用的应用ID：[0,2147483647](dev_app.name.app_id)',
  `num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用次数：[0,2147483647]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组名称：[0,16]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组描述：[0,255]',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '页面分组：将文章归类，可选看不同类型的文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_page_group
-- ----------------------------

-- ----------------------------
-- Table structure for dev_table
-- ----------------------------
DROP TABLE IF EXISTS `dev_table`;
CREATE TABLE `dev_table`  (
  `table_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '数据表ID：[0,2147483647]',
  `app_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '适用的应用ID：[0,2147483647](dev_app.name.app_id)',
  `group_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '数据表分组ID：[0,2147483647](dev_table_group.name.group_id)',
  `num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用次数：[0,2147483647]',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '表名：[0,32]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,255]',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据表：用于构建应用时自动创建表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_table
-- ----------------------------

-- ----------------------------
-- Table structure for dev_table_field
-- ----------------------------
DROP TABLE IF EXISTS `dev_table_field`;
CREATE TABLE `dev_table_field`  (
  `field_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '字段ID：[0,2147483647]',
  `key` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否主键：[0,1]',
  `fill_zero` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否补零：[0,1]',
  `not_null` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否非空：[0,1]',
  `symbol` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否含符号：[0,1]',
  `decimal` smallint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '小数点位：[0,99]',
  `table_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '适用的表ID：[0,2147483647](dev_table.name.table_id)',
  `num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用次数：[0,2147483647]',
  `min_length` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最小长度：[0,2147483647]',
  `max_length` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大长度：[0,2147483647]',
  `min` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最小值：[0,2147483647]',
  `max` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大值：[0,2147483647]',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '字段名：[0,32]',
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '数据类型：[0,32]',
  `auto` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '自动：[0,125]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,255]',
  `default` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '默认值：[0,255]',
  `map` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关联图：[0,255]',
  PRIMARY KEY (`field_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '开发表字段：用于构建数据表时自动创建字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_table_field
-- ----------------------------

-- ----------------------------
-- Table structure for dev_table_group
-- ----------------------------
DROP TABLE IF EXISTS `dev_table_group`;
CREATE TABLE `dev_table_group`  (
  `group_id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '数据表分组ID：[0,30000]',
  `display` int(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` int(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分组ID：[0,32767](dev_table_group.name.group_id)',
  `app_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '适用的应用ID：[0,2147483647](dev_app.name.app_id)',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组名称：[0,16]',
  `title` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组标题：[0,125]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分组描述：[0,255]',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据表分组：将数据表分组，方便创造新表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_table_group
-- ----------------------------

-- ----------------------------
-- Table structure for dev_template
-- ----------------------------
DROP TABLE IF EXISTS `dev_template`;
CREATE TABLE `dev_template`  (
  `template_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '模板ID：[0,2147483647]',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '模板图片：[0,255]',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件路径：[0,255]',
  `colors` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支持颜色：[0,255]',
  `tag` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签：[0,255]用于标注模板相关标签，多个标签用空格隔开',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称：[0,64]',
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题：[0,64]',
  PRIMARY KEY (`template_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dev_template
-- ----------------------------

-- ----------------------------
-- Table structure for mall_ad
-- ----------------------------
DROP TABLE IF EXISTS `mall_ad`;
CREATE TABLE `mall_ad`  (
  `ad_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '广告ID：[0,32767]',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,10000]数值越小，越优先显示',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放城市ID：[0,8388607](sys_address_city)',
  `area_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放地区：[0,8388607](sys_address_area)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '广告主ID：[0,8388607]表示是谁打的广告(user_account.nickname)',
  `times_user` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访客数：[0,2147483647]',
  `times_max` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '次数上限：[0,2147483647]表示点击或展现达多少次后不再打该广告',
  `times_show` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '展现量：[0,2147483647]',
  `times_click` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击量：[0,2147483647]',
  `fee` double(5, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用：每次点击或展现、增加访客所需的费用',
  `fee_max` double(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用上限：表示打广告消费到多少钱后不再打广告',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '广告名称：[0,16]',
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
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城广告：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_ad
-- ----------------------------

-- ----------------------------
-- Table structure for mall_config
-- ----------------------------
DROP TABLE IF EXISTS `mall_config`;
CREATE TABLE `mall_config`  (
  `config_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID：[1,2147483647]',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '变量名：[0,16]',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'string' COMMENT '数据类型：[0,16]string文本型、number数字型、boolean布尔型',
  `title` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变量标题：[0,16]可以用中文名',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变量描述：[0,255]描述该变量的作用',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '变量值：[0,255]',
  `model` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '数据模型：json格式，用于单选、多选模式',
  PRIMARY KEY (`config_id`, `name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商城配置：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_config
-- ----------------------------

-- ----------------------------
-- Table structure for mall_lang
-- ----------------------------
DROP TABLE IF EXISTS `mall_lang`;
CREATE TABLE `mall_lang`  (
  `lang_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '语言ID：[0,2147483647]',
  `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '主键：[0,32]',
  `en` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '英文：[0,255]',
  `zh_cn` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简体中文：[0,255]',
  `zh_tw` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '繁体中文：[0,255]',
  `ko` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '韩文：[0,255]',
  `ja` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日文：[0,255]',
  PRIMARY KEY (`lang_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城语言：用于开发站点多国语' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_lang
-- ----------------------------

-- ----------------------------
-- Table structure for mall_nav
-- ----------------------------
DROP TABLE IF EXISTS `mall_nav`;
CREATE TABLE `mall_nav`  (
  `nav_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '导航ID：[0,32767]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后才可以看到该导航。(0否|1是)',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '英文名称：[0,32]用于多国语识别',
  `title` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '中文标题：[0,32]用于中文提示',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转链接：[0,255]跳转的链接地址',
  `style` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '风格样式：[0,255]自定义css样式',
  `class` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '样式类型：[0,32]绑定的css class',
  `target` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转方式：[0,32]_blank表示新窗口跳转',
  `position` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'top' COMMENT '展现位置：[0,125]top顶部、bottom底部、side侧边，main主要，quick快捷，menu菜单，多个位置用逗号隔开',
  `device` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '呈现设备：[0,125]在什么设备上展示，web_pc、web_pad、web_phone、app_pad、app_phone，多个设备用逗号隔开',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[0,10000]在频道列表操作时，当上级导航展开时，才显示该导航(mall_nav.name.nav_id)',
  PRIMARY KEY (`nav_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '商城导航：用于管理员自定义应用的导航' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_nav
-- ----------------------------

-- ----------------------------
-- Table structure for mall_product
-- ----------------------------
DROP TABLE IF EXISTS `mall_product`;
CREATE TABLE `mall_product`  (
  `product_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '产品id：[0,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后前台才会显示该产品(0否|1是)',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：[0,5](1出售中|2预售中|3已下架|4已删除|5已违规)',
  `type_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品分类ID：[0,1000]用来搜索指定类型的产品(mall_product_type.name)',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序：[0,10000]决定产品显示的顺序',
  `channel_id` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '频道ID：[0,10000]该产品所属频道，该频道列表可以看到该产品(mall_product_channel.name)',
  `shop_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺ID：[0,8388607]该商品所属的店铺(mall_shop.name)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[0,8388607]对于一些地方产品，可以通过该ID筛看(sys_address_city)',
  `hot` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '热度：[0,1000000000]访问这篇产品的人次',
  `praise` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞次数：[0,1000000000]',
  `price` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '卖价：[1]',
  `price_old` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '原价：[1]',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题：[0,125]用于产品和html的<title>标签中',
  `keywords` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,125]用于搜索引擎收录',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]用于产品提纲和搜索引擎收录',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签：[0,255]用于标注产品所属相关内容，多个标签用空格隔开',
  `img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面图：用于显示于产品列表页，多个封面图用换行分隔',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正文：产品的主体内容',
  `collecter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '收藏者：多个收藏者用”,“分隔',
  `brand` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '品牌：[0,18]商品的品牌',
  `group_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分组ID：[0,8388607]该商品在店铺的分组(mall_product_group.name)',
  `sales` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量：[0,1000000000]',
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品信息：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_product
-- ----------------------------
INSERT INTO `mall_product` VALUES (1, 1, 2, 2, 100, 1, 1, 130200, 1, 3, 2.50, 8.56, '1997-01-01 00:00:00', '2020-06-23 21:03:02', '商品1', 'cvbjkl', 'cvbnklm', NULL, '', NULL, NULL, NULL, 0, 0);

-- ----------------------------
-- Table structure for mall_product_augmented
-- ----------------------------
DROP TABLE IF EXISTS `mall_product_augmented`;
CREATE TABLE `mall_product_augmented`  (
  `augmented_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '附加产品ID：[0,2147483647]',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品名称：[0,255]',
  `group` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '产品分组：[0,32]',
  `price` decimal(10, 2) NOT NULL COMMENT '附加价格：',
  `shop_id` mediumint(9) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺ID：[0,8388607]',
  PRIMARY KEY (`augmented_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附加商品：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_product_augmented
-- ----------------------------

-- ----------------------------
-- Table structure for mall_product_channel
-- ----------------------------
DROP TABLE IF EXISTS `mall_product_channel`;
CREATE TABLE `mall_product_channel`  (
  `channel_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '频道ID：[0,10000]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后才可以看到该频道。(0否|1是)',
  `hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏：[0,1]隐藏非管理员该频道无法查看。(0否|1是)',
  `can_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可评论：[0,1]不可评论则用户只能看，无法点评。(0否|1是)',
  `display` mediumint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]决定频道显示的先后顺序',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[0,10000]在频道列表操作时，当上级频道展开时，才显示该频道(mall_product_channel.name.channel_id)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市：[0,8388607]一些地方频道，可以通过该条判断是否可查看(sys_address_city)',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'product' COMMENT '频道类型：[0,16]question问答、info资讯、news新闻、product产品、activity活动',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '频道名称：[2,16]',
  `template` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风格模板：[0,64]频道和产品都使用的样式',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '频道图标：',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外链地址：[0,255]如果该频道是跳转到其他网站的情况下，就在该URL上设置',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该频道的作用',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '频道标题：[0,125]',
  PRIMARY KEY (`channel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品专区：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_product_channel
-- ----------------------------
INSERT INTO `mall_product_channel` VALUES (1, 1, 0, 0, 100, 0, 222400, 'info', '美食', '', '', '', '', NULL);
INSERT INTO `mall_product_channel` VALUES (2, 0, 0, 0, 100, 1, 0, 'info', '简餐便当', '', '', '', '', NULL);
INSERT INTO `mall_product_channel` VALUES (3, 0, 0, 0, 100, 0, 0, 'info', '汉堡披萨', '', '', '', '', NULL);
INSERT INTO `mall_product_channel` VALUES (4, 0, 0, 0, 100, 1, 0, 'info', '炸鸡炸串', '', '', '', '', NULL);
INSERT INTO `mall_product_channel` VALUES (5, 0, 0, 0, 100, 1, 0, 'info', '奶茶果汁', '', '', '', '', NULL);

-- ----------------------------
-- Table structure for mall_product_comment
-- ----------------------------
DROP TABLE IF EXISTS `mall_product_comment`;
CREATE TABLE `mall_product_comment`  (
  `comment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论id：[0,2147483647]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用则显示该评论(0否|1是)',
  `score` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评分：[0,5]最低1分、最多5分',
  `display` smallint(3) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示排序：[0,1000]决定显示的顺序',
  `product_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 1 COMMENT '所属产品id：[0,8388607](mall_product.title)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]编辑评论的用户ID(user_account.nickname)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '留言者姓名：[2,16]用于实名回复',
  `tag` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签：[0,64]评论人给的标签，多个标签用空格隔开',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正文：评论内容',
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评论回复：对评论人的评论做出的回复。通过form-url格式保存，多个人的回复用换行分隔',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品评论：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_product_comment
-- ----------------------------
INSERT INTO `mall_product_comment` VALUES (1, 1, 0, 100, 1, 1, NULL, '可爱', '这是我见过最可爱的雪糕', NULL);
INSERT INTO `mall_product_comment` VALUES (2, 0, 0, 100, 1, 3, NULL, NULL, '', NULL);

-- ----------------------------
-- Table structure for mall_product_group
-- ----------------------------
DROP TABLE IF EXISTS `mall_product_group`;
CREATE TABLE `mall_product_group`  (
  `group_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '产品分组ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分组名称：[0,16]',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '分组图标：',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分组描述：[0,255]',
  `shop_id` mediumint(9) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺ID：[0,8388607]对应每个商家店铺(mall_shop.name)',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分组标题：[0,125]',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品分组：用于店铺自定义产品分组' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_product_group
-- ----------------------------
INSERT INTO `mall_product_group` VALUES (34, 100, '爱尚酸菜小鱼', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (35, 100, '小酥肉系列', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (36, 100, '无骨烤鱼饭', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (37, 100, '鱼伴侣（配菜）', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (38, 100, '爱尚必点冒菜', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (39, 100, '新品香锅', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (40, 100, '爱尚特色香锅', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (41, 100, '爱尚有凉菜', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (42, 100, '爱尚酒水饮料', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (43, 100, '米饭单点', '', '', 1, NULL);
INSERT INTO `mall_product_group` VALUES (44, 100, '测试菜', '', '', 1, NULL);

-- ----------------------------
-- Table structure for mall_product_property
-- ----------------------------
DROP TABLE IF EXISTS `mall_product_property`;
CREATE TABLE `mall_product_property`  (
  `property_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '产品分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称：[0,16]',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '分类图标：',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类描述：[0,255]',
  PRIMARY KEY (`property_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品属性：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_product_property
-- ----------------------------
INSERT INTO `mall_product_property` VALUES (1, 100, '食品 ', 'data:image/jpeg;base64,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6idiWeMKAFUnJI6V2lABRRRQAVnzaxbW2swaZcLJFJcput5XA8uVhnMYOfvgDdggZHIzhsaFc34otrnXQPD1vbOkcyrLcX7oQtsobgxHvNlcrj7mAx/hDAGpDrFtc6zPpluskslsm64lQDy4mOMRk5++Qd2ADgcnGVzoVzfhe2udCB8PXFs7xwq0tvfohK3KluTKe02Wy2fv5LD+IL0lAGb4i/5FnVv+vOb/ANANaVZviL/kWdW/685v/QDWlVv4F6v9CF8b9F+oUUUVBZSSwdLlrgXcqs5UyIiqEYgAdwSBx61dqPzo/wC9+lHnR/3v0oAoz/8AIzWP/Xnc/wDocFaVY93N/wAVHYlG/wCXS4zx/tw1d86T+9+lXPaPp+rIhvL1/REP9gaN/wBAmw/8Bk/wqe20ywspDJa2NtBIRtLRRKpI9MgdOKTzpP736UedJ/e/SoLLdFVPOk/vfpR50n979KALdFVPOk/vfpR50n979KALdFVPOk/vfpR50n979KALdFVPOk/vfpR50n979KALdFVPOk/vfpR50n979KALdFVPOk/vfpR50n979KALdFVPOk/vfpR50n979KALdFVPOk/vfpR50n979KAJ4LeG1hENvDHDGCSEjUKAScngepJP41JVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgCeW3hn8vzoY5PLcSJvUHaw6MM9D71JVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP736UedJ/e/SgC3RVTzpP7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6vf2mlraQ2iX01pNPdxyI5VXiKoUXBGMuSMnPA6GqmqxarqF9pVxN4d1XzLPH2gQvatHOMo+0Fp1IAdFOSvQEY5pNNh1Sy1bVr2Hw5qoe9B+zid7RUt87mILLOxIZ2J4Xj0OKAOx0+9j1LTbW+hBEdzEsqg9QGAI/nWd4q1aTRfD897DcW0EiFQrXITacnGPnliXP1cfj0q7o9h/ZWi2On+Z5n2aBIi+MbioAz+NRa/pCa9oN7pck0kK3MTR+ZGzKVJHB+Ugkeozg9DxQB5nZfErV/7CsbmbVtD8wxM9xJNHH/D5Ix+7uSN37x26BjtwI62bzxVeL45/s+01GV2adBDZtLapDIhgD/MCDcDLfxKCB+BFXJPh6V1tb+x1O6tthiAkkvLqaQopBdATMAA20D5g49quan4U1W8uLu5t9fe3klu0uIYordBGmFVPn3B2chQfulASe3UAFbS/Fmr/ANib9SsbYXhtbeWB47guJWmcom8eWu35sZAzxVv/AITOw0/UtVsNZ1bSrSezMYiEsywmXMSsTtZs43EgY+nPWo5PD2ovaXWIraB4EtUsY4bgyb1t5C67mZF2ls7SBnHqaIJ9Stb/AFiceGNZkF/IrDa9mAm2MJxm4yc7c9B1oAueHtfu9SGnfbUgB1DTUvYjCpGDhfMU5Jzy6kH0OD0yejrlPDWl3sT6W11a3FrFpmnfY41uDHvlYldz4jdwBiNcfMfvH0rq6ACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDP17/AJF3U/8Ar0l/9ANaFZ+vf8i7qf8A16S/+gGtCrfwL1f6EL436L9QoooqCyK2toLO2jtrWCOCCJQscUSBVQDoABwBTLKwstOhaGxtILWJnLlIIwilj1OAOp9af9ni9JP+/wDJ/wDF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P/iaKgslooooAz3/AORq03/r2uP5xVYs/wDVS/8AXxN/6Maq7/8AI1ab/wBe1x/OKrFn/qpf+vib/wBGNVz2j6fqyIby9f0RYoooqCxyffFTf5/z/n/60KffFTf5/wA/5/8ArAEqfcFOpqfcFOoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACsvUfDWg6xcC41PRNNvp1XYJLm0SVgvplgTjk/nWpRQBT03SdN0e3a30vT7SxhZt7R2sKxKWwBkhQBnAHPtVyiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAMTxR/wAgO/8A+vKf/wBBq5VPxR/yA7//AK8p/wD0GrlW/gXq/wBCF8b9F+oUUUVBZU/tGL/nhe/+AU3/AMTR/aMX/PC9/wDAKb/4mtqigDm47hLjxVp21J1221xnzYHj7x9NwGfwq7Z/6qX/AK+Jv/RjUXn/ACNWlf8AXtc/zios/wDVS/8AXxN/6MarntH0/VkQ3l6/oixRRRUFjk++Km/z/n/P/wBaFPvipv8AP+f8/wD1gCVPuCnU1PuCnUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBieKP8AkB3/AP15T/8AoNL/AGjF/wA8L3/wCm/+JpPFH/IDv/8Aryn/APQa26t/AvV/oQvjfov1MX+0Yv8Anhe/+AU3/wATRW1RUFhRRRQBkXn/ACNWlf8AXtc/zios/wDVS/8AXxN/6Mai8/5GrSv+va5/nFRZ/wCql/6+Jv8A0Y1XPaPp+rIhvL1/RFiiiioLHJ98VN/n/P8An/60KffFTf5/z/n/AOsASp9wU6mp9wU6gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAMTxR/wAgO/8A+vKf/wBBrbrE8Uf8gO//AOvKf/0GturfwL1f6EL436L9QoooqCwooooAyLz/AJGrSv8Ar2uf5xUWf+ql/wCvib/0Y1F5/wAjVpX/AF7XP84qLP8A1Uv/AF8Tf+jGq57R9P1ZEN5ev6IsUUUVBY5Pvipv8/5/z/8AWhT74qb/AD/n/P8A9YAlT7gp1NT7gp1ABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAYnij/AJAd/wD9eU//AKDW3WJ4o/5Ad/8A9eU//oNbdW/gXq/0IXxv0X6hRRRUFhRWN4r03+1vDl1ZeVdTByhMdq0QkcBgcDzf3bA4wVfgjINcivh+9ax0c6n4TtbzT7YXCto1rFBGkbMwMcpiaTyi20ODhzgvkdTgQG9Fqv2/x6bPydn9nrNDv358zdHbyZxjj7+O/StKz/1Uv/XxN/6Maue0rSJtP+Ilzdy2q26XiMYQjgrsSG2XAA6AMGHQZx6YrobP/VS/9fE3/oxq0n8MfQiO8vX9EWKKKKzLHJ98VN/n/P8An/60KffFTf5/z/n/AOsASp9wU6mp9wU6gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAMTxR/wAgO/8A+vKf/wBBrbrE8Uf8gO//AOvKf/0GturfwL1f6EL436L9QoooqCzKsPDOgaVdm607Q9Ms7kgqZre0jjfB6jKgHFatFFAGRef8jVpX/Xtc/wA4qLP/AFUv/XxN/wCjGovP+Rq0r/r2uf5xUWf+ql/6+Jv/AEY1XPaPp+rIhvL1/RFiiiioLHJ98VN/n/P+f/rQp98VN/n/AD/n/wCsASp9wU6mp9wU6gAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKAMTxR/yA7/8A68p//Qa26xPFH/IDv/8Aryn/APQa26t/AvV/oQvjfov1CiiioLCiiigDIvP+Rq0r/r2uf5xUWf8Aqpf+vib/ANGNRef8jVpX/Xtc/wA4qLP/AFUv/XxN/wCjGq57R9P1ZEN5ev6IsUUUVBY5Pvipv8/5/wA//WhT74qb/P8An/P/ANYAlT7gp1NT7gp1ABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAYnij/kB3/wD15T/+g1t1ieKP+QHf/wDXlP8A+g1t1b+Ber/QhfG/RfqFFFFQWFFFFAGRef8AI1aV/wBe1z/OKiz/ANVL/wBfE3/oxqLz/katK/69rn+cVFn/AKqX/r4m/wDRjVc9o+n6siG8vX9EWKKKKgscn3xU3+f8/wCf/rQp98VN/n/P+f8A6wBKn3BTqan3BTqACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAxPFH/ACA7/wD68p//AEGtusTxR/yA7/8A68p//Qa26t/AvV/oQvjfov1CiiioLOMuvHVxDr0mnQaFdXUdtLHBdSwRXD7ZGCk7CsJRlUOMlnQ8Hjpnotd1KbSNHmvbexmvpUKhYIlYk5YDJCqzYGcnarHAOAahbwzpJ1Jb9beSOYbMrFcSJE5QYUvGrBHIAGCykjA9BUKxazqnmWms6ZYW9m4z5tlqszShgeMYijK/UNkUdPMOt+hT0/VRq+s6PcF7JpDa3W77Fcm4iHzxjAcquT8pyMDByK0rP/VS/wDXxN/6MaqkOm2mk6/pNrZxskYgu2JeRpHZi0RLMzEsxJPUkmrdn/qpf+vib/0Y1XPaP9dWRDeXr+iLFFFFQWOT74qb/P8An/P/ANaFPvipv8/5/wA//WAJU+4KdTU+4KdQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAGJ4o/5Ad//wBeU/8A6DW3WJ4o/wCQHf8A/XlP/wCg1t1b+Ber/QhfG/RfqFFFFQWFFFFAGRef8jVpX/Xtc/zios/9VL/18Tf+jGovP+Rq0r/r2uf5xUWf+ql/6+Jv/RjVc9o+n6siG8vX9EWKKKKgscn3xU3+f8/5/wDrQp98VN/n/P8An/6wBKn3BTqan3BTqACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAxPFH/IDv/8Aryn/APQa26xPFH/IDv8A/ryn/wDQa26t/AvV/oQvjfov1CiiioLCiiigDIvP+Rq0r/r2uf5xUWf+ql/6+Jv/AEY1F5/yNWlf9e1z/OKiz/1Uv/XxN/6MarntH0/VkQ3l6/oixRRRUFjk++Km/wA/5/z/APWhT74qb/P+f8//AFgCVPuCnU1PuCnUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQBieKP+QHf/wDXlP8A+g1t1ieKP+QHf/8AXlP/AOg1t1b+Ber/AEIXxv0X6hRRRUFhRRRQBkXn/I1aV/17XP8AOKiz/wBVL/18Tf8AoxqLz/katK/69rn+cVFn/qpf+vib/wBGNVz2j6fqyIby9f0RYoooqCxyffFTf5/z/n/60KffFTf5/wA/5/8ArAEqfcFOpqfcFOoAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigAooooAKKKKACiiigDE8Uf8gO//AOvKf/0GtusTxR/yA7//AK8p/wD0GturfwL1f6EL436L9QoooqCwooooAyLz/katK/69rn+cVFn/AKqX/r4m/wDRjUXn/I1aV/17XP8AOKiz/wBVL/18Tf8Aoxque0fT9WRDeXr+iLFFFFQWOT74qb/P+f8AP/1oU++Km/z/AJ/z/wDWAJU+4KdTU+4KdQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFABRRRQAUUUUAFFFFAGJ4o/5Ad/8A9eU//oNbdYnij/kB3/8A15T/APoNbdW/gXq/0IXxv0X6hRRRUFhRRRQBkXn/ACNWlf8AXtc/ziqzJMVlZdz8HoATVa8/5GrSv+va5/nFU7f8fUn0H8zVz2j6fqyIby9f0QfaD/ek/wC+Wo+0H+9J/wB8tXNa94yt9Cu5YmtfPigRfOlF3BCI5HyUQmZ0HIUng5HHBzVCz+IcN9oWo6hBpu6SwtfPlSPULadN2PuboZHbnBwSgzg8Z4qFrqW9DtPtB/vSf98tR9oP96T/AL5avPx4+1mBg114fURNMiBljv49iswXkyWirkE5yWUV6DQAn2g/3pP++Wp8f2iVN6EbSSBlyDwcelNqxaf8e4/3m/8AQjQAzy7r1T/v4f8ACjy7r1T/AL+H/CuVuvFmow6hqxtdMu7lLWZIFhktbhEUAcvuSF3csW4CKyhUBJXdznWvijxVqHhTU2OlTWuoW9sXjkWC581n3cAJJaqp4z93eeny80r6XC2tju/LuvVP+/h/wo8u69U/7+H/AArx6HxN42k1K4gju9XkMTQ7YzZueGPO7Ompxj1Mf1PWvTrvVdTt/F2nacYLRdOuklxIHZpWZVB6YAQA+7Zz/Djliuafl3Xqn/fw/wCFRyPNCyiQn5gSNrE9Me3vV6qt1/rov91v6UDIftB/vSf98tR9oP8Aek/75auF8S/EldBvryzt9Jnu5bXbvLpNGpGyRzhhEw4EfB6HJOQFJrT0/wATanei7mOkW8ltbSIpa0vHldlbBLBGiXOAc4zk4OM8ZAeh0/2g/wB6T/vlqPtB/vSf98tXKP4l13+zb3U4dE05rG1ecZfU3WVliZlJ2iAgE7TgbvxrqwcgH1oAPtB/vSf98tR9p/2pOP8AZNLTE+9J/vf0FADvtB/vSf8AfLUfaD/ek/75asyHXLa41yTS4PnkhRzMTkGNl8v5cEc5EgOelV7PxLFPpQvriwv4V8qKXEdtJPvDgEbPLUlsHIPAIxkgAgk6XA2/tB/vSf8AfLUfaD/ek/75auWt/H2lXGo3lotrqx+zbMldJu2bLAnBURZXt165rqVYOisM4IyMgg/kelAB9oP96T/vlqcJWZQQ7YIyOaSmRf6lP90UAS73/vN+dG9/7zfnTaKAHb3/ALzfnRvf+83502igB29/7zfnRvf+83502igB29/7zfnRvf8AvN+dNooAdvf+8350b3/vN+dNooAdvf8AvN+dG9/7zfnTaKAHb3/vN+dG9/7zfnTaKAHb3/vN+dG9/wC83502igB29/7zfnRvf+83502igB29/wC8350b3/vN+dNooAdvf+8350b3/vN+dNooAdvf+8350b3/ALzfnTaKAHb3/vN+dG9/7zfnTaKAHb3/ALzfnRvf+83502igB29/7zfnRvf+83502igB29/7zfnRvf8AvN+dNooAdvf+8350b3/vN+dNooAdvf8AvN+dG9/7zfnTaKAHb3/vN+dG9/7zfnTaKAHb3/vN+dG9/wC83502igB29/7zfnRvf+83502igB29/wC8350b3/vN+dNooAdvf+8350b3/vN+dNooAdvf+8350b3/ALzfnTaKAHb3/vN+dG9/7zfnTaKAHb3/ALzfnRvf+83502igB29/7zfnRvf+83502igB29/7zfnRvf8AvN+dNooAdvf+8350b3/vN+dNooAdvf8AvN+dG9/7zfnTaKAHb3/vN+dG9/7zfnTaKAHb3/vN+dG9/wC83502igB29/7zfnRvf+83502igB29/wC8350b3/vN+dNooAdvf+8350b3/vN+dNooAdvf+8350b3/ALzfnTaKAHb3/vN+dG9/7zfnTaKAHb3/ALzfnRvf+83502igB29/7zfnRvf+83502igB29/7zfnRvf8AvN+dNooAdvf+8350b3/vN+dNooAdvf8AvN+dG9/7zfnTaKAHb3/vN+dG9/7zfnTaKAHb3/vN+dG9/wC83502igB29/7zfnRvf+83502igB29/wC8350b3/vN+dNooAdvf+8350b3/vN+dNooAdvf+8350b3/ALzfnTaKAHb3/vN+dG9/7zfnTaKAHb3/ALzfnRvf+83502igB29/7zfnRvf+83502igB29/7zfnRvf8AvN+dNooAdvf+8350b3/vN+dNooAdvf8AvN+dG9/7zfnTaKAHb3/vN+dG9/7zfnTaKAHb3/vN+dG9/wC83502igB29/7zfnRvf+83502igB29/wC8350b3/vN+dNooAdvf+8350b3/vN+dNooAdvf+8350b3/ALzfnTaKAHb3/vN+dG9/7zfnTaKAHb3/ALzfnRvf+83502ig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KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/woAZRT/In/ALsf/fZ/wo8if+7H/wB9n/CgBlFP8if+7H/32f8ACjyJ/wC7H/32f8KAGUU/yJ/7sf8A32f8KPIn/ux/99n/AAoAZRT/ACJ/7sf/AH2f8KPIn/ux/wDfZ/wo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', NULL);

-- ----------------------------
-- Table structure for mall_product_type
-- ----------------------------
DROP TABLE IF EXISTS `mall_product_type`;
CREATE TABLE `mall_product_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '产品分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID：[0,32767](mall_product_type.name.type_id)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称：[0,16]',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '分类图标：',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类描述：[0,255]',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类标题：[0,125]',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 34 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '商品分类：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_product_type
-- ----------------------------
INSERT INTO `mall_product_type` VALUES (1, 100, 0, '餐饭', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (2, 100, 1, '蔬菜', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (3, 100, 1, '瓜果', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (4, 100, 1, '肉禽', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (5, 100, 1, '海鲜', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (6, 100, 1, '炖汤', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (7, 100, 1, '主食', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (8, 100, 1, '凉拌', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (9, 100, 1, '五谷', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (10, 100, 1, '酒水', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (11, 100, 1, '糖水', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (12, 100, 1, '甜品', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (13, 100, 1, '点心', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (14, 100, 1, '小吃', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (15, 100, 0, '饮品', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (16, 100, 15, '奶茶', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (17, 100, 15, '果汁', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (18, 100, 15, '咖啡', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (19, 100, 15, '鸡尾酒', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (20, 100, 15, '啤酒', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (21, 100, 15, '白酒', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (22, 100, 15, '红酒', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (23, 100, 15, '洋酒', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (24, 100, 15, '大补酒', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (25, 100, 15, '冰沙', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (26, 100, 0, '特色菜', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (27, 100, 26, '铁板', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (28, 100, 26, '干锅', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (29, 100, 26, '小炒', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (30, 100, 26, '盖浇饭', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (31, 100, 26, '煲仔饭', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (32, 100, 26, '蒸饭', '', '', NULL);
INSERT INTO `mall_product_type` VALUES (33, 100, 26, '水煮', '', '', NULL);

-- ----------------------------
-- Table structure for mall_shop
-- ----------------------------
DROP TABLE IF EXISTS `mall_shop`;
CREATE TABLE `mall_shop`  (
  `shop_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '店铺id：[0,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后前台才会显示该店铺(0否|1是)',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：[0,5](1营业中|2已歇业|3已关店|4已删除|5已违规)',
  `type_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺分类ID：[0,1000]用来搜索指定类型的店铺(mall_shop_type.name)',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序：[0,1000]决定店铺显示的顺序',
  `channel_id` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '频道ID：[0,10000]该店铺所属频道，该频道列表可以看到该店铺(mall_shop_channel.name)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[0,8388607]对于一些地方店铺，可以通过该ID筛看(sys_address_city.name)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '店铺所属人ID：[0,8388607]即该店铺是属于哪个用户的(user_account.nickname)',
  `hot` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '热度：[0,1000000000]访问这篇店铺的人次',
  `praise` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞次数：[0,1000000000]',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `name` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题：[0,125]用于店铺和html的<title>标签中',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]用于店铺提纲和搜索引擎收录',
  `keywords` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词：[0,64]用于搜索引擎收录',
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面图：[0,255]用于显示于店铺列表页，多个封面图用换行分隔',
  `tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签：[0,255]用于标注店铺所属相关内容，多个标签用空格隔开',
  `collecter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '收藏者：多个收藏者用”,“分隔',
  PRIMARY KEY (`shop_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺信息：用于存储店铺相关的信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_shop
-- ----------------------------
INSERT INTO `mall_shop` VALUES (1, 1, 1, 2, 100, 0, 542500, 6, 5, 10, '1997-01-01 00:00:00', '2020-12-21 14:26:03', '粤海街道爱尚酸菜鱼小店', '主营酸菜鱼、烤鱼、酥肉、冒血旺', '', 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAJlBTIDASIAAhEB', '', '');

-- ----------------------------
-- Table structure for mall_shop_channel
-- ----------------------------
DROP TABLE IF EXISTS `mall_shop_channel`;
CREATE TABLE `mall_shop_channel`  (
  `channel_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '频道ID：[0,10000]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后才可以看到该频道(0否|1是)',
  `hide` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否隐藏：[0,1]隐藏非管理员该频道无法查看. 0为不隐藏，1为隐藏(0否|1是)',
  `can_comment` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否可评论：[0,1]不可评论则用户只能看，无法点评。0为不可评论，1为可评论(0否|1是)',
  `display` mediumint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]决定频道显示的先后顺序',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级ID：[0,10000]在频道列表操作时，当上级频道展开时，才显示该频道(mall_shop_channel.name.channel_id)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市：[0,8388607]一些地方频道，可以通过该条判断是否可查看(sys_address_city.name)',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'shop' COMMENT '频道类型：[0,16]question问答、info资讯、news新闻、shop店铺、activity活动',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '频道名称：[2,16]',
  `template` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '风格模板：[0,64]频道和店铺都使用的样式',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '频道图标：',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '外链地址：[0,255]如果该频道是跳转到其他网站的情况下，就在该URL上设置',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该频道的作用',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '频道标题：[0,125]',
  PRIMARY KEY (`channel_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺专区：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_shop_channel
-- ----------------------------
INSERT INTO `mall_shop_channel` VALUES (1, 1, 0, 1, 100, 0, 620300, 'info', '美食区', '', '', '', '', NULL);
INSERT INTO `mall_shop_channel` VALUES (2, 1, 0, 1, 100, 0, 0, 'info', '零食区', '', '', '', '', NULL);

-- ----------------------------
-- Table structure for mall_shop_comment
-- ----------------------------
DROP TABLE IF EXISTS `mall_shop_comment`;
CREATE TABLE `mall_shop_comment`  (
  `comment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论id：[0,2147483647]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用则显示该评论(0否|是)',
  `score` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评分：[0,5]最低1分、最多5分',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示排序：[0,1000]决定显示的顺序',
  `shop_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 1 COMMENT '所属店铺id：[0,8388607](mall_shop.name)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]编辑评论的用户ID(user_account.nickname)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '留言者姓名：[2,16]用于实名回复',
  `tag` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签：[0,64]评论人给的标签，多个标签用空格隔开',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正文：评论内容',
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '评论回复：对评论人的评论做出的回复。通过form-url格式保存，多个人的回复用换行分隔',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺评论：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_shop_comment
-- ----------------------------
INSERT INTO `mall_shop_comment` VALUES (1, 1, 0, 100, 1, 6, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for mall_shop_type
-- ----------------------------
DROP TABLE IF EXISTS `mall_shop_type`;
CREATE TABLE `mall_shop_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '店铺分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID：[0,32767](mall_shop_type.name.type_id)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称：[0,16]',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '分类图标：',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类描述：[0,255]',
  `title` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类标题：[0,125]',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '店铺分类：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mall_shop_type
-- ----------------------------
INSERT INTO `mall_shop_type` VALUES (1, 100, 0, '餐饮', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (2, 100, 1, '中餐', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (3, 100, 1, '西餐', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (4, 100, 1, '饮品', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (5, 100, 1, '面点', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (6, 100, 1, '汤粉', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (7, 100, 1, '烧烤', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (8, 100, 1, '油炸', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (9, 100, 1, '火锅', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (10, 100, 1, '小吃', '', '', NULL);
INSERT INTO `mall_shop_type` VALUES (11, 100, 0, '食品', '', '', NULL);

-- ----------------------------
-- Table structure for service_achievement
-- ----------------------------
DROP TABLE IF EXISTS `service_achievement`;
CREATE TABLE `service_achievement`  (
  `achievement_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '业绩ID:',
  `score` mediumint(1) NOT NULL DEFAULT 0 COMMENT '评分:',
  `income` double(11, 2) NOT NULL DEFAULT 0.00 COMMENT '收入:',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '用户ID',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  PRIMARY KEY (`achievement_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '业绩:' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of service_achievement
-- ----------------------------

-- ----------------------------
-- Table structure for service_balance
-- ----------------------------
DROP TABLE IF EXISTS `service_balance`;
CREATE TABLE `service_balance`  (
  `account_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '结算ID:',
  `remain_cash` double(11, 2) NOT NULL DEFAULT 0.00 COMMENT '账户余额:',
  `settlement` double(11, 2) NOT NULL DEFAULT 0.00 COMMENT '结款金额:',
  `state` mediumint(1) NOT NULL DEFAULT 0 COMMENT '状态:',
  `user_id` int(11) NOT NULL DEFAULT 0 COMMENT '结款人:',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  PRIMARY KEY (`account_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '结算:' ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of service_balance
-- ----------------------------

-- ----------------------------
-- Table structure for service_info
-- ----------------------------
DROP TABLE IF EXISTS `service_info`;
CREATE TABLE `service_info`  (
  `info_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '服务信息ID：[0,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否启用：[0,1]启用后前台才会显示该产品(0否|1是)',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：[0,5](1空闲中|2工作中|3休假中|4已退出|5已违规)',
  `type_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '服务分类ID：[0,1000]用来搜索指定类型的服务(service_type.name)',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '排序：[0,10000]决定成员显示的顺序',
  `way` smallint(1) NOT NULL COMMENT '收费方式：(1次|2时|3日|4周|5月|6季|7年)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[0,8388607]提供服务的城市，可以通过该ID筛看(sys_address_city)',
  `area_id` mediumint(8) NOT NULL COMMENT '所属市区ID：[0,8388607]对于一些地方服务，可以通过该ID筛看(sys_address_area)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]提供这些服务的用户ID(user_account.nickname)',
  `hot` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '热度：[0,1000000000]访问这服务的人次',
  `praise` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞次数：[0,1000000000]',
  `sales` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '销量：[0,1000000000]',
  `position_x` decimal(10, 0) NOT NULL COMMENT '坐标位置X',
  `position_y` decimal(10, 0) NOT NULL COMMENT '坐标位置Y',
  `price` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '服务定价：[1,1000000]',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `service_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务者电话',
  `servicer_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务者姓名',
  `items` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务项：[0,255]用于说明提供的服务项，多个标签用空格隔开',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '具体地址',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '正文：服务的内容，用于介绍具体提供哪些服务',
  `img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '封面图：显示于服务列表页，默认为头像，多个封面图用换行分隔',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务信息：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service_info
-- ----------------------------
INSERT INTO `service_info` VALUES (1, 1, 2, 2, 100, 0, 130200, 0, 0, 1, 3, 0, 0, 0, 8.56, '1997-01-01 00:00:00', '2020-06-23 00:00:00', NULL, NULL, NULL, '', NULL, '');

-- ----------------------------
-- Table structure for service_member
-- ----------------------------
DROP TABLE IF EXISTS `service_member`;
CREATE TABLE `service_member`  (
  `member_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '成员ID：[0,8388607]',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]提供这些服务的用户ID(user_account.nickname)',
  `way` smallint(1) NOT NULL COMMENT '收费方式：(1次|2时|3日|4周|5月|6季|7年)',
  `type_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '默认分类ID：[0,1000]用来搜索指定类型的服务(service_type.name)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[0,8388607]提供服务的城市，可以通过该ID筛看(sys_address_city)',
  `area_id` mediumint(8) NOT NULL COMMENT '所属市区ID：[0,8388607]对于一些地方服务，可以通过该ID筛看(sys_address_area)',
  `position_x` decimal(10, 0) NOT NULL COMMENT '坐标位置X',
  `position_y` decimal(10, 0) NOT NULL COMMENT '坐标位置Y',
  `price` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '默认定价：[1,1000000]',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `service_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务者电话',
  `servicer_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务者姓名',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '具体地址',
  PRIMARY KEY (`member_id`, `user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务成员：用于填写默认信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service_member
-- ----------------------------
INSERT INTO `service_member` VALUES (1, 0, 0, 2, 130200, 0, 0, 0, 8.56, '1997-01-01 00:00:00', '2020-06-23 21:03:02', NULL, NULL, '');

-- ----------------------------
-- Table structure for service_order
-- ----------------------------
DROP TABLE IF EXISTS `service_order`;
CREATE TABLE `service_order`  (
  `order_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单id：[0,8388607]',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态：[0,6](1待接单|2待上门|3待开工|4已取消|5工作中|6已完成)',
  `way` smallint(1) NOT NULL COMMENT '收费方式：(1次|2时|3日|4周|5月|6季|7年)',
  `type_id` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '服务分类ID：[0,1000]用来搜索指定类型的服务(service_type.name)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '下单用户ID：[0,8388607]提供这些服务的用户ID(user_account.nickname.user_id)',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[0,8388607]提供服务的城市，可以通过该ID筛看(sys_address_city)',
  `area_id` mediumint(8) NOT NULL COMMENT '所属市区ID：[0,8388607]对于一些地方服务，可以通过该ID筛看(sys_address_area)',
  `position_x` decimal(10, 0) NOT NULL COMMENT '坐标位置X',
  `position_y` decimal(10, 0) NOT NULL COMMENT '坐标位置Y',
  `price` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '价格：[1,1000000]',
  `price_ago` double(8, 2) NOT NULL DEFAULT 0.00 COMMENT '原价：[1,1000000]',
  `time_validity` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '有效期至：如果属于日、周、月、季、年，那么就会有个有效期',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '具体地址',
  `user_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联系电话',
  `service_phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务者电话',
  `servicer_name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务者姓名',
  PRIMARY KEY (`order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '订单信息：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service_order
-- ----------------------------
INSERT INTO `service_order` VALUES (1, 2, 0, 2, 0, 130200, 0, 0, 0, 8.56, 0.00, '1970-01-01 00:00:00', '1997-01-01 00:00:00', '2020-06-23 21:03:02', '', '', NULL, NULL);

-- ----------------------------
-- Table structure for service_type
-- ----------------------------
DROP TABLE IF EXISTS `service_type`;
CREATE TABLE `service_type`  (
  `type_id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '服务分类ID：[0,30000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `father_id` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类ID：[0,32767](service_type.name.type_id)',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类名称：[0,16]',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '分类图标：',
  `time_create` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '服务分类：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of service_type
-- ----------------------------

-- ----------------------------
-- Table structure for stock_analyse
-- ----------------------------
DROP TABLE IF EXISTS `stock_analyse`;
CREATE TABLE `stock_analyse`  (
  `analyse_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分析ID：[1,2147483647]用来查询和修改结果',
  `weight` smallint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '权重得分：[-99,99]',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `datetime` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '当日时间：指股票当天',
  `policy_buy` smallint(2) NOT NULL DEFAULT 0 COMMENT '决策买入：分值越高，别是越应该买入',
  `policy_hold` smallint(2) NOT NULL DEFAULT 0 COMMENT '决策留守：分值越高，别是越应该留守',
  `policy_sell` smallint(2) NOT NULL DEFAULT 0 COMMENT '决策卖出：分值越高，别是越应该卖出',
  `presage_today` smallint(2) NOT NULL DEFAULT 0 COMMENT '预示今日：[-99,99]今日涨跌评分，负分看跌，正分看涨',
  `presage_recently` smallint(2) NOT NULL DEFAULT 0 COMMENT '预示近日：[-99,99]近3日涨跌评分，负分看跌，正分看涨',
  `presage_next` smallint(2) NOT NULL DEFAULT 0 COMMENT '预示后市：[-99,99]之后涨跌走势评分，负分看跌，正分看涨',
  `code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '股票代码：[0,16]',
  `tip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分析提示：[0,255]技术分析名称',
  `action` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '执行方式：[0,16]买、卖、留',
  `predict` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预言：[0,255]告知近日和将来走势',
  PRIMARY KEY (`analyse_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '股票分析：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_analyse
-- ----------------------------

-- ----------------------------
-- Table structure for stock_formula
-- ----------------------------
DROP TABLE IF EXISTS `stock_formula`;
CREATE TABLE `stock_formula`  (
  `formula_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '公式ID：[1,2147483647]',
  `weight` smallint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '权重：[0,99]权重决定买卖和看涨看跌',
  `policy` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方针：[0,4]只想操作方式',
  `tense` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分析时态：[0,8]同时过去还是今时、今日数据分析。now今时、today今日、past昔日',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公式名称：[0,16]技术分析名称',
  `filter` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '过滤：[0,16]当出现该技术分析时结果时，其他某个分析结果将无效，所以将其过滤调',
  `presage` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '预示：[0,255]今日、近日、之后走势的看涨、看跌',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公式简介：[0,255]介绍该公式是什么技术分析的',
  `express` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '股票公式：用于分析走势，返回逻辑值',
  PRIMARY KEY (`formula_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '股票公式：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_formula
-- ----------------------------

-- ----------------------------
-- Table structure for stock_info
-- ----------------------------
DROP TABLE IF EXISTS `stock_info`;
CREATE TABLE `stock_info`  (
  `stock_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '股票ID：[1,2147483647]',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '股票名称：[0,16]',
  `code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '股票代码：[0,12]',
  `company` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '公司名称：[0,32]',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '股票简介：[0,255]',
  `bonus` double(4, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '分红频率：1年1次为1.0；2年一次为0.5；3年一次为0.33；不分红为0',
  `issue_price` double(6, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '：',
  `pe` double(6, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '市盈率：',
  `pb` double(6, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '市净率：',
  `profit` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '公司利润：如果为0或负数，表示公司不盈利',
  `num` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '发行量：[0,2147483647]单位(万股)',
  `time_to_market` date NOT NULL DEFAULT '1970-01-01' COMMENT '上市时间：',
  PRIMARY KEY (`stock_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '股票信息：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_info
-- ----------------------------

-- ----------------------------
-- Table structure for stock_market
-- ----------------------------
DROP TABLE IF EXISTS `stock_market`;
CREATE TABLE `stock_market`  (
  `market_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '行情ID：[1,2147483647]',
  `code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '股票代码：[0,16]',
  `HIGH` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '最高价：',
  `LOW` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '最低价：',
  `OPEN` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '开盘价：',
  `CLOSE` double(8, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '收盘价：',
  `VOL` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '成交量：[0,2147483647]',
  `CHG` double(5, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '涨跌幅：',
  `TOTAL` double(12, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '总成交额：',
  `DATETIME` date NOT NULL DEFAULT '1970-01-01' COMMENT '交易日期：',
  PRIMARY KEY (`market_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '股票行情：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of stock_market
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ad
-- ----------------------------
DROP TABLE IF EXISTS `sys_ad`;
CREATE TABLE `sys_ad`  (
  `ad_id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '广告ID：[0,32767]',
  `display` smallint(5) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,10000]数值越小，越优先显示',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放城市ID：[0,8388607](sys_address_city)',
  `area_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '投放地区：[0,8388607](sys_address_area)',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '广告主ID：[0,8388607]表示是谁打的广告(user_account.nickname)',
  `times_user` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访客数：[0,2147483647]',
  `times_max` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '次数上限：[0,2147483647]表示点击或展现达多少次后不再打该广告',
  `times_show` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '展现量：[0,2147483647]',
  `times_click` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击量：[0,2147483647]',
  `fee` double(5, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用：每次点击或展现、增加访客所需的费用',
  `fee_max` double(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '费用上限：表示打广告消费到多少钱后不再打广告',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '广告名称：[0,16]',
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
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '广告信息：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_ad
-- ----------------------------
INSERT INTO `sys_ad` VALUES (1, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告1', 'banner', '', '', '', '', 'banner_1', '', '', '/cms/home_pc/template/default/img/banner/banner_3.jpg', '/', '');
INSERT INTO `sys_ad` VALUES (2, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告2', 'banner', '', '', '', '', 'banner_2', '', '', '/cms/home_pc/template/default/img/banner/banner_2.jpg', '/', '');
INSERT INTO `sys_ad` VALUES (3, 100, 0, 0, 0, 0, 0, 0, 0, 0.00, 0.00, '广告3', 'banner', '', '', '', '', 'banner_3', '', '', '/cms/home_pc/template/default/img/banner/banner_1.jpg', '/', '');

-- ----------------------------
-- Table structure for sys_address_area
-- ----------------------------
DROP TABLE IF EXISTS `sys_address_area`;
CREATE TABLE `sys_address_area`  (
  `area_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '地区ID：[1,8388607]',
  `show` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可见：[0,2]0为仅表单可见，1为仅表单和搜索时可见 ，2为均可见',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `city_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属城市ID：[1,8388607]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '地区名称：[0,16]',
  PRIMARY KEY (`area_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 659005 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '地区：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_address_area
-- ----------------------------
INSERT INTO `sys_address_area` VALUES (110101, 0, 100, 110100, '东城区');
INSERT INTO `sys_address_area` VALUES (110102, 0, 100, 110100, '西城区');
INSERT INTO `sys_address_area` VALUES (110103, 0, 100, 110100, '崇文区');
INSERT INTO `sys_address_area` VALUES (110104, 0, 100, 110100, '宣武区');
INSERT INTO `sys_address_area` VALUES (110105, 0, 100, 110100, '朝阳区');
INSERT INTO `sys_address_area` VALUES (110106, 0, 100, 110100, '丰台区');
INSERT INTO `sys_address_area` VALUES (110107, 0, 100, 110100, '石景山区');
INSERT INTO `sys_address_area` VALUES (110108, 0, 100, 110100, '海淀区');
INSERT INTO `sys_address_area` VALUES (110109, 0, 100, 110100, '门头沟区');
INSERT INTO `sys_address_area` VALUES (110111, 0, 100, 110100, '房山区');
INSERT INTO `sys_address_area` VALUES (110112, 0, 100, 110100, '通州区');
INSERT INTO `sys_address_area` VALUES (110113, 0, 100, 110100, '顺义区');
INSERT INTO `sys_address_area` VALUES (110114, 0, 100, 110100, '昌平区');
INSERT INTO `sys_address_area` VALUES (110115, 0, 100, 110100, '大兴区');
INSERT INTO `sys_address_area` VALUES (110116, 0, 100, 110100, '怀柔区');
INSERT INTO `sys_address_area` VALUES (110117, 0, 100, 110100, '平谷区');
INSERT INTO `sys_address_area` VALUES (110228, 0, 100, 110200, '密云县');
INSERT INTO `sys_address_area` VALUES (110229, 0, 100, 110200, '延庆县');
INSERT INTO `sys_address_area` VALUES (120101, 0, 100, 120100, '和平区');
INSERT INTO `sys_address_area` VALUES (120102, 0, 100, 120100, '河东区');
INSERT INTO `sys_address_area` VALUES (120103, 0, 100, 120100, '河西区');
INSERT INTO `sys_address_area` VALUES (120104, 0, 100, 120100, '南开区');
INSERT INTO `sys_address_area` VALUES (120105, 0, 100, 120100, '河北区');
INSERT INTO `sys_address_area` VALUES (120106, 0, 100, 120100, '红桥区');
INSERT INTO `sys_address_area` VALUES (120107, 0, 100, 120100, '塘沽区');
INSERT INTO `sys_address_area` VALUES (120108, 0, 100, 120100, '汉沽区');
INSERT INTO `sys_address_area` VALUES (120109, 0, 100, 120100, '大港区');
INSERT INTO `sys_address_area` VALUES (120110, 0, 100, 120100, '东丽区');
INSERT INTO `sys_address_area` VALUES (120111, 0, 100, 120100, '西青区');
INSERT INTO `sys_address_area` VALUES (120112, 0, 100, 120100, '津南区');
INSERT INTO `sys_address_area` VALUES (120113, 0, 100, 120100, '北辰区');
INSERT INTO `sys_address_area` VALUES (120114, 0, 100, 120100, '武清区');
INSERT INTO `sys_address_area` VALUES (120115, 0, 100, 120100, '宝坻区');
INSERT INTO `sys_address_area` VALUES (120221, 0, 100, 120200, '宁河县');
INSERT INTO `sys_address_area` VALUES (120223, 0, 100, 120200, '静海县');
INSERT INTO `sys_address_area` VALUES (120225, 0, 100, 120200, '蓟　县');
INSERT INTO `sys_address_area` VALUES (130101, 0, 100, 130100, '市辖区');
INSERT INTO `sys_address_area` VALUES (130102, 0, 100, 130100, '长安区');
INSERT INTO `sys_address_area` VALUES (130103, 0, 100, 130100, '桥东区');
INSERT INTO `sys_address_area` VALUES (130104, 0, 100, 130100, '桥西区');
INSERT INTO `sys_address_area` VALUES (130105, 0, 100, 130100, '新华区');
INSERT INTO `sys_address_area` VALUES (130107, 0, 100, 130100, '井陉矿区');
INSERT INTO `sys_address_area` VALUES (130108, 0, 100, 130100, '裕华区');
INSERT INTO `sys_address_area` VALUES (130121, 0, 100, 130100, '井陉县');
INSERT INTO `sys_address_area` VALUES (130123, 0, 100, 130100, '正定县');
INSERT INTO `sys_address_area` VALUES (130124, 0, 100, 130100, '栾城县');
INSERT INTO `sys_address_area` VALUES (130125, 0, 100, 130100, '行唐县');
INSERT INTO `sys_address_area` VALUES (130126, 0, 100, 130100, '灵寿县');
INSERT INTO `sys_address_area` VALUES (130127, 0, 100, 130100, '高邑县');
INSERT INTO `sys_address_area` VALUES (130128, 0, 100, 130100, '深泽县');
INSERT INTO `sys_address_area` VALUES (130129, 0, 100, 130100, '赞皇县');
INSERT INTO `sys_address_area` VALUES (130130, 0, 100, 130100, '无极县');
INSERT INTO `sys_address_area` VALUES (130131, 0, 100, 130100, '平山县');
INSERT INTO `sys_address_area` VALUES (130132, 0, 100, 130100, '元氏县');
INSERT INTO `sys_address_area` VALUES (130133, 0, 100, 130100, '赵　县');
INSERT INTO `sys_address_area` VALUES (130181, 0, 100, 130100, '辛集市');
INSERT INTO `sys_address_area` VALUES (130182, 0, 100, 130100, '藁城市');
INSERT INTO `sys_address_area` VALUES (130183, 0, 100, 130100, '晋州市');
INSERT INTO `sys_address_area` VALUES (130184, 0, 100, 130100, '新乐市');
INSERT INTO `sys_address_area` VALUES (130185, 0, 100, 130100, '鹿泉市');
INSERT INTO `sys_address_area` VALUES (130201, 0, 100, 130200, '市辖区');
INSERT INTO `sys_address_area` VALUES (130202, 0, 100, 130200, '路南区');
INSERT INTO `sys_address_area` VALUES (130203, 0, 100, 130200, '路北区');
INSERT INTO `sys_address_area` VALUES (130204, 0, 100, 130200, '古冶区');
INSERT INTO `sys_address_area` VALUES (130205, 0, 100, 130200, '开平区');
INSERT INTO `sys_address_area` VALUES (130207, 0, 100, 130200, '丰南区');
INSERT INTO `sys_address_area` VALUES (130208, 0, 100, 130200, '丰润区');
INSERT INTO `sys_address_area` VALUES (130223, 0, 100, 130200, '滦　县');
INSERT INTO `sys_address_area` VALUES (130224, 0, 100, 130200, '滦南县');
INSERT INTO `sys_address_area` VALUES (130225, 0, 100, 130200, '乐亭县');
INSERT INTO `sys_address_area` VALUES (130227, 0, 100, 130200, '迁西县');
INSERT INTO `sys_address_area` VALUES (130229, 0, 100, 130200, '玉田县');
INSERT INTO `sys_address_area` VALUES (130230, 0, 100, 130200, '唐海县');
INSERT INTO `sys_address_area` VALUES (130281, 0, 100, 130200, '遵化市');
INSERT INTO `sys_address_area` VALUES (130283, 0, 100, 130200, '迁安市');
INSERT INTO `sys_address_area` VALUES (130301, 0, 100, 130300, '市辖区');
INSERT INTO `sys_address_area` VALUES (130302, 0, 100, 130300, '海港区');
INSERT INTO `sys_address_area` VALUES (130303, 0, 100, 130300, '山海关区');
INSERT INTO `sys_address_area` VALUES (130304, 0, 100, 130300, '北戴河区');
INSERT INTO `sys_address_area` VALUES (130321, 0, 100, 130300, '青龙满族自治县');
INSERT INTO `sys_address_area` VALUES (130322, 0, 100, 130300, '昌黎县');
INSERT INTO `sys_address_area` VALUES (130323, 0, 100, 130300, '抚宁县');
INSERT INTO `sys_address_area` VALUES (130324, 0, 100, 130300, '卢龙县');
INSERT INTO `sys_address_area` VALUES (130401, 0, 100, 130400, '市辖区');
INSERT INTO `sys_address_area` VALUES (130402, 0, 100, 130400, '邯山区');
INSERT INTO `sys_address_area` VALUES (130403, 0, 100, 130400, '丛台区');
INSERT INTO `sys_address_area` VALUES (130404, 0, 100, 130400, '复兴区');
INSERT INTO `sys_address_area` VALUES (130406, 0, 100, 130400, '峰峰矿区');
INSERT INTO `sys_address_area` VALUES (130421, 0, 100, 130400, '邯郸县');
INSERT INTO `sys_address_area` VALUES (130423, 0, 100, 130400, '临漳县');
INSERT INTO `sys_address_area` VALUES (130424, 0, 100, 130400, '成安县');
INSERT INTO `sys_address_area` VALUES (130425, 0, 100, 130400, '大名县');
INSERT INTO `sys_address_area` VALUES (130426, 0, 100, 130400, '涉　县');
INSERT INTO `sys_address_area` VALUES (130427, 0, 100, 130400, '磁　县');
INSERT INTO `sys_address_area` VALUES (130428, 0, 100, 130400, '肥乡县');
INSERT INTO `sys_address_area` VALUES (130429, 0, 100, 130400, '永年县');
INSERT INTO `sys_address_area` VALUES (130430, 0, 100, 130400, '邱　县');
INSERT INTO `sys_address_area` VALUES (130431, 0, 100, 130400, '鸡泽县');
INSERT INTO `sys_address_area` VALUES (130432, 0, 100, 130400, '广平县');
INSERT INTO `sys_address_area` VALUES (130433, 0, 100, 130400, '馆陶县');
INSERT INTO `sys_address_area` VALUES (130434, 0, 100, 130400, '魏　县');
INSERT INTO `sys_address_area` VALUES (130435, 0, 100, 130400, '曲周县');
INSERT INTO `sys_address_area` VALUES (130481, 0, 100, 130400, '武安市');
INSERT INTO `sys_address_area` VALUES (130501, 0, 100, 130500, '市辖区');
INSERT INTO `sys_address_area` VALUES (130502, 0, 100, 130500, '桥东区');
INSERT INTO `sys_address_area` VALUES (130503, 0, 100, 130500, '桥西区');
INSERT INTO `sys_address_area` VALUES (130521, 0, 100, 130500, '邢台县');
INSERT INTO `sys_address_area` VALUES (130522, 0, 100, 130500, '临城县');
INSERT INTO `sys_address_area` VALUES (130523, 0, 100, 130500, '内丘县');
INSERT INTO `sys_address_area` VALUES (130524, 0, 100, 130500, '柏乡县');
INSERT INTO `sys_address_area` VALUES (130525, 0, 100, 130500, '隆尧县');
INSERT INTO `sys_address_area` VALUES (130526, 0, 100, 130500, '任　县');
INSERT INTO `sys_address_area` VALUES (130527, 0, 100, 130500, '南和县');
INSERT INTO `sys_address_area` VALUES (130528, 0, 100, 130500, '宁晋县');
INSERT INTO `sys_address_area` VALUES (130529, 0, 100, 130500, '巨鹿县');
INSERT INTO `sys_address_area` VALUES (130530, 0, 100, 130500, '新河县');
INSERT INTO `sys_address_area` VALUES (130531, 0, 100, 130500, '广宗县');
INSERT INTO `sys_address_area` VALUES (130532, 0, 100, 130500, '平乡县');
INSERT INTO `sys_address_area` VALUES (130533, 0, 100, 130500, '威　县');
INSERT INTO `sys_address_area` VALUES (130534, 0, 100, 130500, '清河县');
INSERT INTO `sys_address_area` VALUES (130535, 0, 100, 130500, '临西县');
INSERT INTO `sys_address_area` VALUES (130581, 0, 100, 130500, '南宫市');
INSERT INTO `sys_address_area` VALUES (130582, 0, 100, 130500, '沙河市');
INSERT INTO `sys_address_area` VALUES (130601, 0, 100, 130600, '市辖区');
INSERT INTO `sys_address_area` VALUES (130602, 0, 100, 130600, '新市区');
INSERT INTO `sys_address_area` VALUES (130603, 0, 100, 130600, '北市区');
INSERT INTO `sys_address_area` VALUES (130604, 0, 100, 130600, '南市区');
INSERT INTO `sys_address_area` VALUES (130621, 0, 100, 130600, '满城县');
INSERT INTO `sys_address_area` VALUES (130622, 0, 100, 130600, '清苑县');
INSERT INTO `sys_address_area` VALUES (130623, 0, 100, 130600, '涞水县');
INSERT INTO `sys_address_area` VALUES (130624, 0, 100, 130600, '阜平县');
INSERT INTO `sys_address_area` VALUES (130625, 0, 100, 130600, '徐水县');
INSERT INTO `sys_address_area` VALUES (130626, 0, 100, 130600, '定兴县');
INSERT INTO `sys_address_area` VALUES (130627, 0, 100, 130600, '唐　县');
INSERT INTO `sys_address_area` VALUES (130628, 0, 100, 130600, '高阳县');
INSERT INTO `sys_address_area` VALUES (130629, 0, 100, 130600, '容城县');
INSERT INTO `sys_address_area` VALUES (130630, 0, 100, 130600, '涞源县');
INSERT INTO `sys_address_area` VALUES (130631, 0, 100, 130600, '望都县');
INSERT INTO `sys_address_area` VALUES (130632, 0, 100, 130600, '安新县');
INSERT INTO `sys_address_area` VALUES (130633, 0, 100, 130600, '易　县');
INSERT INTO `sys_address_area` VALUES (130634, 0, 100, 130600, '曲阳县');
INSERT INTO `sys_address_area` VALUES (130635, 0, 100, 130600, '蠡　县');
INSERT INTO `sys_address_area` VALUES (130636, 0, 100, 130600, '顺平县');
INSERT INTO `sys_address_area` VALUES (130637, 0, 100, 130600, '博野县');
INSERT INTO `sys_address_area` VALUES (130638, 0, 100, 130600, '雄　县');
INSERT INTO `sys_address_area` VALUES (130681, 0, 100, 130600, '涿州市');
INSERT INTO `sys_address_area` VALUES (130682, 0, 100, 130600, '定州市');
INSERT INTO `sys_address_area` VALUES (130683, 0, 100, 130600, '安国市');
INSERT INTO `sys_address_area` VALUES (130684, 0, 100, 130600, '高碑店市');
INSERT INTO `sys_address_area` VALUES (130701, 0, 100, 130700, '市辖区');
INSERT INTO `sys_address_area` VALUES (130702, 0, 100, 130700, '桥东区');
INSERT INTO `sys_address_area` VALUES (130703, 0, 100, 130700, '桥西区');
INSERT INTO `sys_address_area` VALUES (130705, 0, 100, 130700, '宣化区');
INSERT INTO `sys_address_area` VALUES (130706, 0, 100, 130700, '下花园区');
INSERT INTO `sys_address_area` VALUES (130721, 0, 100, 130700, '宣化县');
INSERT INTO `sys_address_area` VALUES (130722, 0, 100, 130700, '张北县');
INSERT INTO `sys_address_area` VALUES (130723, 0, 100, 130700, '康保县');
INSERT INTO `sys_address_area` VALUES (130724, 0, 100, 130700, '沽源县');
INSERT INTO `sys_address_area` VALUES (130725, 0, 100, 130700, '尚义县');
INSERT INTO `sys_address_area` VALUES (130726, 0, 100, 130700, '蔚　县');
INSERT INTO `sys_address_area` VALUES (130727, 0, 100, 130700, '阳原县');
INSERT INTO `sys_address_area` VALUES (130728, 0, 100, 130700, '怀安县');
INSERT INTO `sys_address_area` VALUES (130729, 0, 100, 130700, '万全县');
INSERT INTO `sys_address_area` VALUES (130730, 0, 100, 130700, '怀来县');
INSERT INTO `sys_address_area` VALUES (130731, 0, 100, 130700, '涿鹿县');
INSERT INTO `sys_address_area` VALUES (130732, 0, 100, 130700, '赤城县');
INSERT INTO `sys_address_area` VALUES (130733, 0, 100, 130700, '崇礼县');
INSERT INTO `sys_address_area` VALUES (130801, 0, 100, 130800, '市辖区');
INSERT INTO `sys_address_area` VALUES (130802, 0, 100, 130800, '双桥区');
INSERT INTO `sys_address_area` VALUES (130803, 0, 100, 130800, '双滦区');
INSERT INTO `sys_address_area` VALUES (130804, 0, 100, 130800, '鹰手营子矿区');
INSERT INTO `sys_address_area` VALUES (130821, 0, 100, 130800, '承德县');
INSERT INTO `sys_address_area` VALUES (130822, 0, 100, 130800, '兴隆县');
INSERT INTO `sys_address_area` VALUES (130823, 0, 100, 130800, '平泉县');
INSERT INTO `sys_address_area` VALUES (130824, 0, 100, 130800, '滦平县');
INSERT INTO `sys_address_area` VALUES (130825, 0, 100, 130800, '隆化县');
INSERT INTO `sys_address_area` VALUES (130826, 0, 100, 130800, '丰宁满族自治县');
INSERT INTO `sys_address_area` VALUES (130827, 0, 100, 130800, '宽城满族自治县');
INSERT INTO `sys_address_area` VALUES (130828, 0, 100, 130800, '围场满族蒙古族自治县');
INSERT INTO `sys_address_area` VALUES (130901, 0, 100, 130900, '市辖区');
INSERT INTO `sys_address_area` VALUES (130902, 0, 100, 130900, '新华区');
INSERT INTO `sys_address_area` VALUES (130903, 0, 100, 130900, '运河区');
INSERT INTO `sys_address_area` VALUES (130921, 0, 100, 130900, '沧　县');
INSERT INTO `sys_address_area` VALUES (130922, 0, 100, 130900, '青　县');
INSERT INTO `sys_address_area` VALUES (130923, 0, 100, 130900, '东光县');
INSERT INTO `sys_address_area` VALUES (130924, 0, 100, 130900, '海兴县');
INSERT INTO `sys_address_area` VALUES (130925, 0, 100, 130900, '盐山县');
INSERT INTO `sys_address_area` VALUES (130926, 0, 100, 130900, '肃宁县');
INSERT INTO `sys_address_area` VALUES (130927, 0, 100, 130900, '南皮县');
INSERT INTO `sys_address_area` VALUES (130928, 0, 100, 130900, '吴桥县');
INSERT INTO `sys_address_area` VALUES (130929, 0, 100, 130900, '献　县');
INSERT INTO `sys_address_area` VALUES (130930, 0, 100, 130900, '孟村回族自治县');
INSERT INTO `sys_address_area` VALUES (130981, 0, 100, 130900, '泊头市');
INSERT INTO `sys_address_area` VALUES (130982, 0, 100, 130900, '任丘市');
INSERT INTO `sys_address_area` VALUES (130983, 0, 100, 130900, '黄骅市');
INSERT INTO `sys_address_area` VALUES (130984, 0, 100, 130900, '河间市');
INSERT INTO `sys_address_area` VALUES (131001, 0, 100, 131000, '市辖区');
INSERT INTO `sys_address_area` VALUES (131002, 0, 100, 131000, '安次区');
INSERT INTO `sys_address_area` VALUES (131003, 0, 100, 131000, '广阳区');
INSERT INTO `sys_address_area` VALUES (131022, 0, 100, 131000, '固安县');
INSERT INTO `sys_address_area` VALUES (131023, 0, 100, 131000, '永清县');
INSERT INTO `sys_address_area` VALUES (131024, 0, 100, 131000, '香河县');
INSERT INTO `sys_address_area` VALUES (131025, 0, 100, 131000, '大城县');
INSERT INTO `sys_address_area` VALUES (131026, 0, 100, 131000, '文安县');
INSERT INTO `sys_address_area` VALUES (131028, 0, 100, 131000, '大厂回族自治县');
INSERT INTO `sys_address_area` VALUES (131081, 0, 100, 131000, '霸州市');
INSERT INTO `sys_address_area` VALUES (131082, 0, 100, 131000, '三河市');
INSERT INTO `sys_address_area` VALUES (131101, 0, 100, 131100, '市辖区');
INSERT INTO `sys_address_area` VALUES (131102, 0, 100, 131100, '桃城区');
INSERT INTO `sys_address_area` VALUES (131121, 0, 100, 131100, '枣强县');
INSERT INTO `sys_address_area` VALUES (131122, 0, 100, 131100, '武邑县');
INSERT INTO `sys_address_area` VALUES (131123, 0, 100, 131100, '武强县');
INSERT INTO `sys_address_area` VALUES (131124, 0, 100, 131100, '饶阳县');
INSERT INTO `sys_address_area` VALUES (131125, 0, 100, 131100, '安平县');
INSERT INTO `sys_address_area` VALUES (131126, 0, 100, 131100, '故城县');
INSERT INTO `sys_address_area` VALUES (131127, 0, 100, 131100, '景　县');
INSERT INTO `sys_address_area` VALUES (131128, 0, 100, 131100, '阜城县');
INSERT INTO `sys_address_area` VALUES (131181, 0, 100, 131100, '冀州市');
INSERT INTO `sys_address_area` VALUES (131182, 0, 100, 131100, '深州市');
INSERT INTO `sys_address_area` VALUES (140101, 0, 100, 140100, '市辖区');
INSERT INTO `sys_address_area` VALUES (140105, 0, 100, 140100, '小店区');
INSERT INTO `sys_address_area` VALUES (140106, 0, 100, 140100, '迎泽区');
INSERT INTO `sys_address_area` VALUES (140107, 0, 100, 140100, '杏花岭区');
INSERT INTO `sys_address_area` VALUES (140108, 0, 100, 140100, '尖草坪区');
INSERT INTO `sys_address_area` VALUES (140109, 0, 100, 140100, '万柏林区');
INSERT INTO `sys_address_area` VALUES (140110, 0, 100, 140100, '晋源区');
INSERT INTO `sys_address_area` VALUES (140121, 0, 100, 140100, '清徐县');
INSERT INTO `sys_address_area` VALUES (140122, 0, 100, 140100, '阳曲县');
INSERT INTO `sys_address_area` VALUES (140123, 0, 100, 140100, '娄烦县');
INSERT INTO `sys_address_area` VALUES (140181, 0, 100, 140100, '古交市');
INSERT INTO `sys_address_area` VALUES (140201, 0, 100, 140200, '市辖区');
INSERT INTO `sys_address_area` VALUES (140202, 0, 100, 140200, '城　区');
INSERT INTO `sys_address_area` VALUES (140203, 0, 100, 140200, '矿　区');
INSERT INTO `sys_address_area` VALUES (140211, 0, 100, 140200, '南郊区');
INSERT INTO `sys_address_area` VALUES (140212, 0, 100, 140200, '新荣区');
INSERT INTO `sys_address_area` VALUES (140221, 0, 100, 140200, '阳高县');
INSERT INTO `sys_address_area` VALUES (140222, 0, 100, 140200, '天镇县');
INSERT INTO `sys_address_area` VALUES (140223, 0, 100, 140200, '广灵县');
INSERT INTO `sys_address_area` VALUES (140224, 0, 100, 140200, '灵丘县');
INSERT INTO `sys_address_area` VALUES (140225, 0, 100, 140200, '浑源县');
INSERT INTO `sys_address_area` VALUES (140226, 0, 100, 140200, '左云县');
INSERT INTO `sys_address_area` VALUES (140227, 0, 100, 140200, '大同县');
INSERT INTO `sys_address_area` VALUES (140301, 0, 100, 140300, '市辖区');
INSERT INTO `sys_address_area` VALUES (140302, 0, 100, 140300, '城　区');
INSERT INTO `sys_address_area` VALUES (140303, 0, 100, 140300, '矿　区');
INSERT INTO `sys_address_area` VALUES (140311, 0, 100, 140300, '郊　区');
INSERT INTO `sys_address_area` VALUES (140321, 0, 100, 140300, '平定县');
INSERT INTO `sys_address_area` VALUES (140322, 0, 100, 140300, '盂　县');
INSERT INTO `sys_address_area` VALUES (140401, 0, 100, 140400, '市辖区');
INSERT INTO `sys_address_area` VALUES (140402, 0, 100, 140400, '城　区');
INSERT INTO `sys_address_area` VALUES (140411, 0, 100, 140400, '郊　区');
INSERT INTO `sys_address_area` VALUES (140421, 0, 100, 140400, '长治县');
INSERT INTO `sys_address_area` VALUES (140423, 0, 100, 140400, '襄垣县');
INSERT INTO `sys_address_area` VALUES (140424, 0, 100, 140400, '屯留县');
INSERT INTO `sys_address_area` VALUES (140425, 0, 100, 140400, '平顺县');
INSERT INTO `sys_address_area` VALUES (140426, 0, 100, 140400, '黎城县');
INSERT INTO `sys_address_area` VALUES (140427, 0, 100, 140400, '壶关县');
INSERT INTO `sys_address_area` VALUES (140428, 0, 100, 140400, '长子县');
INSERT INTO `sys_address_area` VALUES (140429, 0, 100, 140400, '武乡县');
INSERT INTO `sys_address_area` VALUES (140430, 0, 100, 140400, '沁　县');
INSERT INTO `sys_address_area` VALUES (140431, 0, 100, 140400, '沁源县');
INSERT INTO `sys_address_area` VALUES (140481, 0, 100, 140400, '潞城市');
INSERT INTO `sys_address_area` VALUES (140501, 0, 100, 140500, '市辖区');
INSERT INTO `sys_address_area` VALUES (140502, 0, 100, 140500, '城　区');
INSERT INTO `sys_address_area` VALUES (140521, 0, 100, 140500, '沁水县');
INSERT INTO `sys_address_area` VALUES (140522, 0, 100, 140500, '阳城县');
INSERT INTO `sys_address_area` VALUES (140524, 0, 100, 140500, '陵川县');
INSERT INTO `sys_address_area` VALUES (140525, 0, 100, 140500, '泽州县');
INSERT INTO `sys_address_area` VALUES (140581, 0, 100, 140500, '高平市');
INSERT INTO `sys_address_area` VALUES (140601, 0, 100, 140600, '市辖区');
INSERT INTO `sys_address_area` VALUES (140602, 0, 100, 140600, '朔城区');
INSERT INTO `sys_address_area` VALUES (140603, 0, 100, 140600, '平鲁区');
INSERT INTO `sys_address_area` VALUES (140621, 0, 100, 140600, '山阴县');
INSERT INTO `sys_address_area` VALUES (140622, 0, 100, 140600, '应　县');
INSERT INTO `sys_address_area` VALUES (140623, 0, 100, 140600, '右玉县');
INSERT INTO `sys_address_area` VALUES (140624, 0, 100, 140600, '怀仁县');
INSERT INTO `sys_address_area` VALUES (140701, 0, 100, 140700, '市辖区');
INSERT INTO `sys_address_area` VALUES (140702, 0, 100, 140700, '榆次区');
INSERT INTO `sys_address_area` VALUES (140721, 0, 100, 140700, '榆社县');
INSERT INTO `sys_address_area` VALUES (140722, 0, 100, 140700, '左权县');
INSERT INTO `sys_address_area` VALUES (140723, 0, 100, 140700, '和顺县');
INSERT INTO `sys_address_area` VALUES (140724, 0, 100, 140700, '昔阳县');
INSERT INTO `sys_address_area` VALUES (140725, 0, 100, 140700, '寿阳县');
INSERT INTO `sys_address_area` VALUES (140726, 0, 100, 140700, '太谷县');
INSERT INTO `sys_address_area` VALUES (140727, 0, 100, 140700, '祁　县');
INSERT INTO `sys_address_area` VALUES (140728, 0, 100, 140700, '平遥县');
INSERT INTO `sys_address_area` VALUES (140729, 0, 100, 140700, '灵石县');
INSERT INTO `sys_address_area` VALUES (140781, 0, 100, 140700, '介休市');
INSERT INTO `sys_address_area` VALUES (140801, 0, 100, 140800, '市辖区');
INSERT INTO `sys_address_area` VALUES (140802, 0, 100, 140800, '盐湖区');
INSERT INTO `sys_address_area` VALUES (140821, 0, 100, 140800, '临猗县');
INSERT INTO `sys_address_area` VALUES (140822, 0, 100, 140800, '万荣县');
INSERT INTO `sys_address_area` VALUES (140823, 0, 100, 140800, '闻喜县');
INSERT INTO `sys_address_area` VALUES (140824, 0, 100, 140800, '稷山县');
INSERT INTO `sys_address_area` VALUES (140825, 0, 100, 140800, '新绛县');
INSERT INTO `sys_address_area` VALUES (140826, 0, 100, 140800, '绛　县');
INSERT INTO `sys_address_area` VALUES (140827, 0, 100, 140800, '垣曲县');
INSERT INTO `sys_address_area` VALUES (140828, 0, 100, 140800, '夏　县');
INSERT INTO `sys_address_area` VALUES (140829, 0, 100, 140800, '平陆县');
INSERT INTO `sys_address_area` VALUES (140830, 0, 100, 140800, '芮城县');
INSERT INTO `sys_address_area` VALUES (140881, 0, 100, 140800, '永济市');
INSERT INTO `sys_address_area` VALUES (140882, 0, 100, 140800, '河津市');
INSERT INTO `sys_address_area` VALUES (140901, 0, 100, 140900, '市辖区');
INSERT INTO `sys_address_area` VALUES (140902, 0, 100, 140900, '忻府区');
INSERT INTO `sys_address_area` VALUES (140921, 0, 100, 140900, '定襄县');
INSERT INTO `sys_address_area` VALUES (140922, 0, 100, 140900, '五台县');
INSERT INTO `sys_address_area` VALUES (140923, 0, 100, 140900, '代　县');
INSERT INTO `sys_address_area` VALUES (140924, 0, 100, 140900, '繁峙县');
INSERT INTO `sys_address_area` VALUES (140925, 0, 100, 140900, '宁武县');
INSERT INTO `sys_address_area` VALUES (140926, 0, 100, 140900, '静乐县');
INSERT INTO `sys_address_area` VALUES (140927, 0, 100, 140900, '神池县');
INSERT INTO `sys_address_area` VALUES (140928, 0, 100, 140900, '五寨县');
INSERT INTO `sys_address_area` VALUES (140929, 0, 100, 140900, '岢岚县');
INSERT INTO `sys_address_area` VALUES (140930, 0, 100, 140900, '河曲县');
INSERT INTO `sys_address_area` VALUES (140931, 0, 100, 140900, '保德县');
INSERT INTO `sys_address_area` VALUES (140932, 0, 100, 140900, '偏关县');
INSERT INTO `sys_address_area` VALUES (140981, 0, 100, 140900, '原平市');
INSERT INTO `sys_address_area` VALUES (141001, 0, 100, 141000, '市辖区');
INSERT INTO `sys_address_area` VALUES (141002, 0, 100, 141000, '尧都区');
INSERT INTO `sys_address_area` VALUES (141021, 0, 100, 141000, '曲沃县');
INSERT INTO `sys_address_area` VALUES (141022, 0, 100, 141000, '翼城县');
INSERT INTO `sys_address_area` VALUES (141023, 0, 100, 141000, '襄汾县');
INSERT INTO `sys_address_area` VALUES (141024, 0, 100, 141000, '洪洞县');
INSERT INTO `sys_address_area` VALUES (141025, 0, 100, 141000, '古　县');
INSERT INTO `sys_address_area` VALUES (141026, 0, 100, 141000, '安泽县');
INSERT INTO `sys_address_area` VALUES (141027, 0, 100, 141000, '浮山县');
INSERT INTO `sys_address_area` VALUES (141028, 0, 100, 141000, '吉　县');
INSERT INTO `sys_address_area` VALUES (141029, 0, 100, 141000, '乡宁县');
INSERT INTO `sys_address_area` VALUES (141030, 0, 100, 141000, '大宁县');
INSERT INTO `sys_address_area` VALUES (141031, 0, 100, 141000, '隰　县');
INSERT INTO `sys_address_area` VALUES (141032, 0, 100, 141000, '永和县');
INSERT INTO `sys_address_area` VALUES (141033, 0, 100, 141000, '蒲　县');
INSERT INTO `sys_address_area` VALUES (141034, 0, 100, 141000, '汾西县');
INSERT INTO `sys_address_area` VALUES (141081, 0, 100, 141000, '侯马市');
INSERT INTO `sys_address_area` VALUES (141082, 0, 100, 141000, '霍州市');
INSERT INTO `sys_address_area` VALUES (141101, 0, 100, 141100, '市辖区');
INSERT INTO `sys_address_area` VALUES (141102, 0, 100, 141100, '离石区');
INSERT INTO `sys_address_area` VALUES (141121, 0, 100, 141100, '文水县');
INSERT INTO `sys_address_area` VALUES (141122, 0, 100, 141100, '交城县');
INSERT INTO `sys_address_area` VALUES (141123, 0, 100, 141100, '兴　县');
INSERT INTO `sys_address_area` VALUES (141124, 0, 100, 141100, '临　县');
INSERT INTO `sys_address_area` VALUES (141125, 0, 100, 141100, '柳林县');
INSERT INTO `sys_address_area` VALUES (141126, 0, 100, 141100, '石楼县');
INSERT INTO `sys_address_area` VALUES (141127, 0, 100, 141100, '岚　县');
INSERT INTO `sys_address_area` VALUES (141128, 0, 100, 141100, '方山县');
INSERT INTO `sys_address_area` VALUES (141129, 0, 100, 141100, '中阳县');
INSERT INTO `sys_address_area` VALUES (141130, 0, 100, 141100, '交口县');
INSERT INTO `sys_address_area` VALUES (141181, 0, 100, 141100, '孝义市');
INSERT INTO `sys_address_area` VALUES (141182, 0, 100, 141100, '汾阳市');
INSERT INTO `sys_address_area` VALUES (150101, 0, 100, 150100, '市辖区');
INSERT INTO `sys_address_area` VALUES (150102, 0, 100, 150100, '新城区');
INSERT INTO `sys_address_area` VALUES (150103, 0, 100, 150100, '回民区');
INSERT INTO `sys_address_area` VALUES (150104, 0, 100, 150100, '玉泉区');
INSERT INTO `sys_address_area` VALUES (150105, 0, 100, 150100, '赛罕区');
INSERT INTO `sys_address_area` VALUES (150121, 0, 100, 150100, '土默特左旗');
INSERT INTO `sys_address_area` VALUES (150122, 0, 100, 150100, '托克托县');
INSERT INTO `sys_address_area` VALUES (150123, 0, 100, 150100, '和林格尔县');
INSERT INTO `sys_address_area` VALUES (150124, 0, 100, 150100, '清水河县');
INSERT INTO `sys_address_area` VALUES (150125, 0, 100, 150100, '武川县');
INSERT INTO `sys_address_area` VALUES (150201, 0, 100, 150200, '市辖区');
INSERT INTO `sys_address_area` VALUES (150202, 0, 100, 150200, '东河区');
INSERT INTO `sys_address_area` VALUES (150203, 0, 100, 150200, '昆都仑区');
INSERT INTO `sys_address_area` VALUES (150204, 0, 100, 150200, '青山区');
INSERT INTO `sys_address_area` VALUES (150205, 0, 100, 150200, '石拐区');
INSERT INTO `sys_address_area` VALUES (150206, 0, 100, 150200, '白云矿区');
INSERT INTO `sys_address_area` VALUES (150207, 0, 100, 150200, '九原区');
INSERT INTO `sys_address_area` VALUES (150221, 0, 100, 150200, '土默特右旗');
INSERT INTO `sys_address_area` VALUES (150222, 0, 100, 150200, '固阳县');
INSERT INTO `sys_address_area` VALUES (150223, 0, 100, 150200, '达尔罕茂明安联合旗');
INSERT INTO `sys_address_area` VALUES (150301, 0, 100, 150300, '市辖区');
INSERT INTO `sys_address_area` VALUES (150302, 0, 100, 150300, '海勃湾区');
INSERT INTO `sys_address_area` VALUES (150303, 0, 100, 150300, '海南区');
INSERT INTO `sys_address_area` VALUES (150304, 0, 100, 150300, '乌达区');
INSERT INTO `sys_address_area` VALUES (150401, 0, 100, 150400, '市辖区');
INSERT INTO `sys_address_area` VALUES (150402, 0, 100, 150400, '红山区');
INSERT INTO `sys_address_area` VALUES (150403, 0, 100, 150400, '元宝山区');
INSERT INTO `sys_address_area` VALUES (150404, 0, 100, 150400, '松山区');
INSERT INTO `sys_address_area` VALUES (150421, 0, 100, 150400, '阿鲁科尔沁旗');
INSERT INTO `sys_address_area` VALUES (150422, 0, 100, 150400, '巴林左旗');
INSERT INTO `sys_address_area` VALUES (150423, 0, 100, 150400, '巴林右旗');
INSERT INTO `sys_address_area` VALUES (150424, 0, 100, 150400, '林西县');
INSERT INTO `sys_address_area` VALUES (150425, 0, 100, 150400, '克什克腾旗');
INSERT INTO `sys_address_area` VALUES (150426, 0, 100, 150400, '翁牛特旗');
INSERT INTO `sys_address_area` VALUES (150428, 0, 100, 150400, '喀喇沁旗');
INSERT INTO `sys_address_area` VALUES (150429, 0, 100, 150400, '宁城县');
INSERT INTO `sys_address_area` VALUES (150430, 0, 100, 150400, '敖汉旗');
INSERT INTO `sys_address_area` VALUES (150501, 0, 100, 150500, '市辖区');
INSERT INTO `sys_address_area` VALUES (150502, 0, 100, 150500, '科尔沁区');
INSERT INTO `sys_address_area` VALUES (150521, 0, 100, 150500, '科尔沁左翼中旗');
INSERT INTO `sys_address_area` VALUES (150522, 0, 100, 150500, '科尔沁左翼后旗');
INSERT INTO `sys_address_area` VALUES (150523, 0, 100, 150500, '开鲁县');
INSERT INTO `sys_address_area` VALUES (150524, 0, 100, 150500, '库伦旗');
INSERT INTO `sys_address_area` VALUES (150525, 0, 100, 150500, '奈曼旗');
INSERT INTO `sys_address_area` VALUES (150526, 0, 100, 150500, '扎鲁特旗');
INSERT INTO `sys_address_area` VALUES (150581, 0, 100, 150500, '霍林郭勒市');
INSERT INTO `sys_address_area` VALUES (150602, 0, 100, 150600, '东胜区');
INSERT INTO `sys_address_area` VALUES (150621, 0, 100, 150600, '达拉特旗');
INSERT INTO `sys_address_area` VALUES (150622, 0, 100, 150600, '准格尔旗');
INSERT INTO `sys_address_area` VALUES (150623, 0, 100, 150600, '鄂托克前旗');
INSERT INTO `sys_address_area` VALUES (150624, 0, 100, 150600, '鄂托克旗');
INSERT INTO `sys_address_area` VALUES (150625, 0, 100, 150600, '杭锦旗');
INSERT INTO `sys_address_area` VALUES (150626, 0, 100, 150600, '乌审旗');
INSERT INTO `sys_address_area` VALUES (150627, 0, 100, 150600, '伊金霍洛旗');
INSERT INTO `sys_address_area` VALUES (150701, 0, 100, 150700, '市辖区');
INSERT INTO `sys_address_area` VALUES (150702, 0, 100, 150700, '海拉尔区');
INSERT INTO `sys_address_area` VALUES (150721, 0, 100, 150700, '阿荣旗');
INSERT INTO `sys_address_area` VALUES (150722, 0, 100, 150700, '莫力达瓦达斡尔族自治旗');
INSERT INTO `sys_address_area` VALUES (150723, 0, 100, 150700, '鄂伦春自治旗');
INSERT INTO `sys_address_area` VALUES (150724, 0, 100, 150700, '鄂温克族自治旗');
INSERT INTO `sys_address_area` VALUES (150725, 0, 100, 150700, '陈巴尔虎旗');
INSERT INTO `sys_address_area` VALUES (150726, 0, 100, 150700, '新巴尔虎左旗');
INSERT INTO `sys_address_area` VALUES (150727, 0, 100, 150700, '新巴尔虎右旗');
INSERT INTO `sys_address_area` VALUES (150781, 0, 100, 150700, '满洲里市');
INSERT INTO `sys_address_area` VALUES (150782, 0, 100, 150700, '牙克石市');
INSERT INTO `sys_address_area` VALUES (150783, 0, 100, 150700, '扎兰屯市');
INSERT INTO `sys_address_area` VALUES (150784, 0, 100, 150700, '额尔古纳市');
INSERT INTO `sys_address_area` VALUES (150785, 0, 100, 150700, '根河市');
INSERT INTO `sys_address_area` VALUES (150801, 0, 100, 150800, '市辖区');
INSERT INTO `sys_address_area` VALUES (150802, 0, 100, 150800, '临河区');
INSERT INTO `sys_address_area` VALUES (150821, 0, 100, 150800, '五原县');
INSERT INTO `sys_address_area` VALUES (150822, 0, 100, 150800, '磴口县');
INSERT INTO `sys_address_area` VALUES (150823, 0, 100, 150800, '乌拉特前旗');
INSERT INTO `sys_address_area` VALUES (150824, 0, 100, 150800, '乌拉特中旗');
INSERT INTO `sys_address_area` VALUES (150825, 0, 100, 150800, '乌拉特后旗');
INSERT INTO `sys_address_area` VALUES (150826, 0, 100, 150800, '杭锦后旗');
INSERT INTO `sys_address_area` VALUES (150901, 0, 100, 150900, '市辖区');
INSERT INTO `sys_address_area` VALUES (150902, 0, 100, 150900, '集宁区');
INSERT INTO `sys_address_area` VALUES (150921, 0, 100, 150900, '卓资县');
INSERT INTO `sys_address_area` VALUES (150922, 0, 100, 150900, '化德县');
INSERT INTO `sys_address_area` VALUES (150923, 0, 100, 150900, '商都县');
INSERT INTO `sys_address_area` VALUES (150924, 0, 100, 150900, '兴和县');
INSERT INTO `sys_address_area` VALUES (150925, 0, 100, 150900, '凉城县');
INSERT INTO `sys_address_area` VALUES (150926, 0, 100, 150900, '察哈尔右翼前旗');
INSERT INTO `sys_address_area` VALUES (150927, 0, 100, 150900, '察哈尔右翼中旗');
INSERT INTO `sys_address_area` VALUES (150928, 0, 100, 150900, '察哈尔右翼后旗');
INSERT INTO `sys_address_area` VALUES (150929, 0, 100, 150900, '四子王旗');
INSERT INTO `sys_address_area` VALUES (150981, 0, 100, 150900, '丰镇市');
INSERT INTO `sys_address_area` VALUES (152201, 0, 100, 152200, '乌兰浩特市');
INSERT INTO `sys_address_area` VALUES (152202, 0, 100, 152200, '阿尔山市');
INSERT INTO `sys_address_area` VALUES (152221, 0, 100, 152200, '科尔沁右翼前旗');
INSERT INTO `sys_address_area` VALUES (152222, 0, 100, 152200, '科尔沁右翼中旗');
INSERT INTO `sys_address_area` VALUES (152223, 0, 100, 152200, '扎赉特旗');
INSERT INTO `sys_address_area` VALUES (152224, 0, 100, 152200, '突泉县');
INSERT INTO `sys_address_area` VALUES (152501, 0, 100, 152500, '二连浩特市');
INSERT INTO `sys_address_area` VALUES (152502, 0, 100, 152500, '锡林浩特市');
INSERT INTO `sys_address_area` VALUES (152522, 0, 100, 152500, '阿巴嘎旗');
INSERT INTO `sys_address_area` VALUES (152523, 0, 100, 152500, '苏尼特左旗');
INSERT INTO `sys_address_area` VALUES (152524, 0, 100, 152500, '苏尼特右旗');
INSERT INTO `sys_address_area` VALUES (152525, 0, 100, 152500, '东乌珠穆沁旗');
INSERT INTO `sys_address_area` VALUES (152526, 0, 100, 152500, '西乌珠穆沁旗');
INSERT INTO `sys_address_area` VALUES (152527, 0, 100, 152500, '太仆寺旗');
INSERT INTO `sys_address_area` VALUES (152528, 0, 100, 152500, '镶黄旗');
INSERT INTO `sys_address_area` VALUES (152529, 0, 100, 152500, '正镶白旗');
INSERT INTO `sys_address_area` VALUES (152530, 0, 100, 152500, '正蓝旗');
INSERT INTO `sys_address_area` VALUES (152531, 0, 100, 152500, '多伦县');
INSERT INTO `sys_address_area` VALUES (152921, 0, 100, 152900, '阿拉善左旗');
INSERT INTO `sys_address_area` VALUES (152922, 0, 100, 152900, '阿拉善右旗');
INSERT INTO `sys_address_area` VALUES (152923, 0, 100, 152900, '额济纳旗');
INSERT INTO `sys_address_area` VALUES (210101, 0, 100, 210100, '市辖区');
INSERT INTO `sys_address_area` VALUES (210102, 0, 100, 210100, '和平区');
INSERT INTO `sys_address_area` VALUES (210103, 0, 100, 210100, '沈河区');
INSERT INTO `sys_address_area` VALUES (210104, 0, 100, 210100, '大东区');
INSERT INTO `sys_address_area` VALUES (210105, 0, 100, 210100, '皇姑区');
INSERT INTO `sys_address_area` VALUES (210106, 0, 100, 210100, '铁西区');
INSERT INTO `sys_address_area` VALUES (210111, 0, 100, 210100, '苏家屯区');
INSERT INTO `sys_address_area` VALUES (210112, 0, 100, 210100, '东陵区');
INSERT INTO `sys_address_area` VALUES (210113, 0, 100, 210100, '新城子区');
INSERT INTO `sys_address_area` VALUES (210114, 0, 100, 210100, '于洪区');
INSERT INTO `sys_address_area` VALUES (210122, 0, 100, 210100, '辽中县');
INSERT INTO `sys_address_area` VALUES (210123, 0, 100, 210100, '康平县');
INSERT INTO `sys_address_area` VALUES (210124, 0, 100, 210100, '法库县');
INSERT INTO `sys_address_area` VALUES (210181, 0, 100, 210100, '新民市');
INSERT INTO `sys_address_area` VALUES (210201, 0, 100, 210200, '市辖区');
INSERT INTO `sys_address_area` VALUES (210202, 0, 100, 210200, '中山区');
INSERT INTO `sys_address_area` VALUES (210203, 0, 100, 210200, '西岗区');
INSERT INTO `sys_address_area` VALUES (210204, 0, 100, 210200, '沙河口区');
INSERT INTO `sys_address_area` VALUES (210211, 0, 100, 210200, '甘井子区');
INSERT INTO `sys_address_area` VALUES (210212, 0, 100, 210200, '旅顺口区');
INSERT INTO `sys_address_area` VALUES (210213, 0, 100, 210200, '金州区');
INSERT INTO `sys_address_area` VALUES (210224, 0, 100, 210200, '长海县');
INSERT INTO `sys_address_area` VALUES (210281, 0, 100, 210200, '瓦房店市');
INSERT INTO `sys_address_area` VALUES (210282, 0, 100, 210200, '普兰店市');
INSERT INTO `sys_address_area` VALUES (210283, 0, 100, 210200, '庄河市');
INSERT INTO `sys_address_area` VALUES (210301, 0, 100, 210300, '市辖区');
INSERT INTO `sys_address_area` VALUES (210302, 0, 100, 210300, '铁东区');
INSERT INTO `sys_address_area` VALUES (210303, 0, 100, 210300, '铁西区');
INSERT INTO `sys_address_area` VALUES (210304, 0, 100, 210300, '立山区');
INSERT INTO `sys_address_area` VALUES (210311, 0, 100, 210300, '千山区');
INSERT INTO `sys_address_area` VALUES (210321, 0, 100, 210300, '台安县');
INSERT INTO `sys_address_area` VALUES (210323, 0, 100, 210300, '岫岩满族自治县');
INSERT INTO `sys_address_area` VALUES (210381, 0, 100, 210300, '海城市');
INSERT INTO `sys_address_area` VALUES (210401, 0, 100, 210400, '市辖区');
INSERT INTO `sys_address_area` VALUES (210402, 0, 100, 210400, '新抚区');
INSERT INTO `sys_address_area` VALUES (210403, 0, 100, 210400, '东洲区');
INSERT INTO `sys_address_area` VALUES (210404, 0, 100, 210400, '望花区');
INSERT INTO `sys_address_area` VALUES (210411, 0, 100, 210400, '顺城区');
INSERT INTO `sys_address_area` VALUES (210421, 0, 100, 210400, '抚顺县');
INSERT INTO `sys_address_area` VALUES (210422, 0, 100, 210400, '新宾满族自治县');
INSERT INTO `sys_address_area` VALUES (210423, 0, 100, 210400, '清原满族自治县');
INSERT INTO `sys_address_area` VALUES (210501, 0, 100, 210500, '市辖区');
INSERT INTO `sys_address_area` VALUES (210502, 0, 100, 210500, '平山区');
INSERT INTO `sys_address_area` VALUES (210503, 0, 100, 210500, '溪湖区');
INSERT INTO `sys_address_area` VALUES (210504, 0, 100, 210500, '明山区');
INSERT INTO `sys_address_area` VALUES (210505, 0, 100, 210500, '南芬区');
INSERT INTO `sys_address_area` VALUES (210521, 0, 100, 210500, '本溪满族自治县');
INSERT INTO `sys_address_area` VALUES (210522, 0, 100, 210500, '桓仁满族自治县');
INSERT INTO `sys_address_area` VALUES (210601, 0, 100, 210600, '市辖区');
INSERT INTO `sys_address_area` VALUES (210602, 0, 100, 210600, '元宝区');
INSERT INTO `sys_address_area` VALUES (210603, 0, 100, 210600, '振兴区');
INSERT INTO `sys_address_area` VALUES (210604, 0, 100, 210600, '振安区');
INSERT INTO `sys_address_area` VALUES (210624, 0, 100, 210600, '宽甸满族自治县');
INSERT INTO `sys_address_area` VALUES (210681, 0, 100, 210600, '东港市');
INSERT INTO `sys_address_area` VALUES (210682, 0, 100, 210600, '凤城市');
INSERT INTO `sys_address_area` VALUES (210701, 0, 100, 210700, '市辖区');
INSERT INTO `sys_address_area` VALUES (210702, 0, 100, 210700, '古塔区');
INSERT INTO `sys_address_area` VALUES (210703, 0, 100, 210700, '凌河区');
INSERT INTO `sys_address_area` VALUES (210711, 0, 100, 210700, '太和区');
INSERT INTO `sys_address_area` VALUES (210726, 0, 100, 210700, '黑山县');
INSERT INTO `sys_address_area` VALUES (210727, 0, 100, 210700, '义　县');
INSERT INTO `sys_address_area` VALUES (210781, 0, 100, 210700, '凌海市');
INSERT INTO `sys_address_area` VALUES (210782, 0, 100, 210700, '北宁市');
INSERT INTO `sys_address_area` VALUES (210801, 0, 100, 210800, '市辖区');
INSERT INTO `sys_address_area` VALUES (210802, 0, 100, 210800, '站前区');
INSERT INTO `sys_address_area` VALUES (210803, 0, 100, 210800, '西市区');
INSERT INTO `sys_address_area` VALUES (210804, 0, 100, 210800, '鲅鱼圈区');
INSERT INTO `sys_address_area` VALUES (210811, 0, 100, 210800, '老边区');
INSERT INTO `sys_address_area` VALUES (210881, 0, 100, 210800, '盖州市');
INSERT INTO `sys_address_area` VALUES (210882, 0, 100, 210800, '大石桥市');
INSERT INTO `sys_address_area` VALUES (210901, 0, 100, 210900, '市辖区');
INSERT INTO `sys_address_area` VALUES (210902, 0, 100, 210900, '海州区');
INSERT INTO `sys_address_area` VALUES (210903, 0, 100, 210900, '新邱区');
INSERT INTO `sys_address_area` VALUES (210904, 0, 100, 210900, '太平区');
INSERT INTO `sys_address_area` VALUES (210905, 0, 100, 210900, '清河门区');
INSERT INTO `sys_address_area` VALUES (210911, 0, 100, 210900, '细河区');
INSERT INTO `sys_address_area` VALUES (210921, 0, 100, 210900, '阜新蒙古族自治县');
INSERT INTO `sys_address_area` VALUES (210922, 0, 100, 210900, '彰武县');
INSERT INTO `sys_address_area` VALUES (211001, 0, 100, 211000, '市辖区');
INSERT INTO `sys_address_area` VALUES (211002, 0, 100, 211000, '白塔区');
INSERT INTO `sys_address_area` VALUES (211003, 0, 100, 211000, '文圣区');
INSERT INTO `sys_address_area` VALUES (211004, 0, 100, 211000, '宏伟区');
INSERT INTO `sys_address_area` VALUES (211005, 0, 100, 211000, '弓长岭区');
INSERT INTO `sys_address_area` VALUES (211011, 0, 100, 211000, '太子河区');
INSERT INTO `sys_address_area` VALUES (211021, 0, 100, 211000, '辽阳县');
INSERT INTO `sys_address_area` VALUES (211081, 0, 100, 211000, '灯塔市');
INSERT INTO `sys_address_area` VALUES (211101, 0, 100, 211100, '市辖区');
INSERT INTO `sys_address_area` VALUES (211102, 0, 100, 211100, '双台子区');
INSERT INTO `sys_address_area` VALUES (211103, 0, 100, 211100, '兴隆台区');
INSERT INTO `sys_address_area` VALUES (211121, 0, 100, 211100, '大洼县');
INSERT INTO `sys_address_area` VALUES (211122, 0, 100, 211100, '盘山县');
INSERT INTO `sys_address_area` VALUES (211201, 0, 100, 211200, '市辖区');
INSERT INTO `sys_address_area` VALUES (211202, 0, 100, 211200, '银州区');
INSERT INTO `sys_address_area` VALUES (211204, 0, 100, 211200, '清河区');
INSERT INTO `sys_address_area` VALUES (211221, 0, 100, 211200, '铁岭县');
INSERT INTO `sys_address_area` VALUES (211223, 0, 100, 211200, '西丰县');
INSERT INTO `sys_address_area` VALUES (211224, 0, 100, 211200, '昌图县');
INSERT INTO `sys_address_area` VALUES (211281, 0, 100, 211200, '调兵山市');
INSERT INTO `sys_address_area` VALUES (211282, 0, 100, 211200, '开原市');
INSERT INTO `sys_address_area` VALUES (211301, 0, 100, 211300, '市辖区');
INSERT INTO `sys_address_area` VALUES (211302, 0, 100, 211300, '双塔区');
INSERT INTO `sys_address_area` VALUES (211303, 0, 100, 211300, '龙城区');
INSERT INTO `sys_address_area` VALUES (211321, 0, 100, 211300, '朝阳县');
INSERT INTO `sys_address_area` VALUES (211322, 0, 100, 211300, '建平县');
INSERT INTO `sys_address_area` VALUES (211324, 0, 100, 211300, '喀喇沁左翼蒙古族自治县');
INSERT INTO `sys_address_area` VALUES (211381, 0, 100, 211300, '北票市');
INSERT INTO `sys_address_area` VALUES (211382, 0, 100, 211300, '凌源市');
INSERT INTO `sys_address_area` VALUES (211401, 0, 100, 211400, '市辖区');
INSERT INTO `sys_address_area` VALUES (211402, 0, 100, 211400, '连山区');
INSERT INTO `sys_address_area` VALUES (211403, 0, 100, 211400, '龙港区');
INSERT INTO `sys_address_area` VALUES (211404, 0, 100, 211400, '南票区');
INSERT INTO `sys_address_area` VALUES (211421, 0, 100, 211400, '绥中县');
INSERT INTO `sys_address_area` VALUES (211422, 0, 100, 211400, '建昌县');
INSERT INTO `sys_address_area` VALUES (211481, 0, 100, 211400, '兴城市');
INSERT INTO `sys_address_area` VALUES (220101, 0, 100, 220100, '市辖区');
INSERT INTO `sys_address_area` VALUES (220102, 0, 100, 220100, '南关区');
INSERT INTO `sys_address_area` VALUES (220103, 0, 100, 220100, '宽城区');
INSERT INTO `sys_address_area` VALUES (220104, 0, 100, 220100, '朝阳区');
INSERT INTO `sys_address_area` VALUES (220105, 0, 100, 220100, '二道区');
INSERT INTO `sys_address_area` VALUES (220106, 0, 100, 220100, '绿园区');
INSERT INTO `sys_address_area` VALUES (220112, 0, 100, 220100, '双阳区');
INSERT INTO `sys_address_area` VALUES (220122, 0, 100, 220100, '农安县');
INSERT INTO `sys_address_area` VALUES (220181, 0, 100, 220100, '九台市');
INSERT INTO `sys_address_area` VALUES (220182, 0, 100, 220100, '榆树市');
INSERT INTO `sys_address_area` VALUES (220183, 0, 100, 220100, '德惠市');
INSERT INTO `sys_address_area` VALUES (220201, 0, 100, 220200, '市辖区');
INSERT INTO `sys_address_area` VALUES (220202, 0, 100, 220200, '昌邑区');
INSERT INTO `sys_address_area` VALUES (220203, 0, 100, 220200, '龙潭区');
INSERT INTO `sys_address_area` VALUES (220204, 0, 100, 220200, '船营区');
INSERT INTO `sys_address_area` VALUES (220211, 0, 100, 220200, '丰满区');
INSERT INTO `sys_address_area` VALUES (220221, 0, 100, 220200, '永吉县');
INSERT INTO `sys_address_area` VALUES (220281, 0, 100, 220200, '蛟河市');
INSERT INTO `sys_address_area` VALUES (220282, 0, 100, 220200, '桦甸市');
INSERT INTO `sys_address_area` VALUES (220283, 0, 100, 220200, '舒兰市');
INSERT INTO `sys_address_area` VALUES (220284, 0, 100, 220200, '磐石市');
INSERT INTO `sys_address_area` VALUES (220301, 0, 100, 220300, '市辖区');
INSERT INTO `sys_address_area` VALUES (220302, 0, 100, 220300, '铁西区');
INSERT INTO `sys_address_area` VALUES (220303, 0, 100, 220300, '铁东区');
INSERT INTO `sys_address_area` VALUES (220322, 0, 100, 220300, '梨树县');
INSERT INTO `sys_address_area` VALUES (220323, 0, 100, 220300, '伊通满族自治县');
INSERT INTO `sys_address_area` VALUES (220381, 0, 100, 220300, '公主岭市');
INSERT INTO `sys_address_area` VALUES (220382, 0, 100, 220300, '双辽市');
INSERT INTO `sys_address_area` VALUES (220401, 0, 100, 220400, '市辖区');
INSERT INTO `sys_address_area` VALUES (220402, 0, 100, 220400, '龙山区');
INSERT INTO `sys_address_area` VALUES (220403, 0, 100, 220400, '西安区');
INSERT INTO `sys_address_area` VALUES (220421, 0, 100, 220400, '东丰县');
INSERT INTO `sys_address_area` VALUES (220422, 0, 100, 220400, '东辽县');
INSERT INTO `sys_address_area` VALUES (220501, 0, 100, 220500, '市辖区');
INSERT INTO `sys_address_area` VALUES (220502, 0, 100, 220500, '东昌区');
INSERT INTO `sys_address_area` VALUES (220503, 0, 100, 220500, '二道江区');
INSERT INTO `sys_address_area` VALUES (220521, 0, 100, 220500, '通化县');
INSERT INTO `sys_address_area` VALUES (220523, 0, 100, 220500, '辉南县');
INSERT INTO `sys_address_area` VALUES (220524, 0, 100, 220500, '柳河县');
INSERT INTO `sys_address_area` VALUES (220581, 0, 100, 220500, '梅河口市');
INSERT INTO `sys_address_area` VALUES (220582, 0, 100, 220500, '集安市');
INSERT INTO `sys_address_area` VALUES (220601, 0, 100, 220600, '市辖区');
INSERT INTO `sys_address_area` VALUES (220602, 0, 100, 220600, '八道江区');
INSERT INTO `sys_address_area` VALUES (220621, 0, 100, 220600, '抚松县');
INSERT INTO `sys_address_area` VALUES (220622, 0, 100, 220600, '靖宇县');
INSERT INTO `sys_address_area` VALUES (220623, 0, 100, 220600, '长白朝鲜族自治县');
INSERT INTO `sys_address_area` VALUES (220625, 0, 100, 220600, '江源县');
INSERT INTO `sys_address_area` VALUES (220681, 0, 100, 220600, '临江市');
INSERT INTO `sys_address_area` VALUES (220701, 0, 100, 220700, '市辖区');
INSERT INTO `sys_address_area` VALUES (220702, 0, 100, 220700, '宁江区');
INSERT INTO `sys_address_area` VALUES (220721, 0, 100, 220700, '前郭尔罗斯蒙古族自治县');
INSERT INTO `sys_address_area` VALUES (220722, 0, 100, 220700, '长岭县');
INSERT INTO `sys_address_area` VALUES (220723, 0, 100, 220700, '乾安县');
INSERT INTO `sys_address_area` VALUES (220724, 0, 100, 220700, '扶余县');
INSERT INTO `sys_address_area` VALUES (220801, 0, 100, 220800, '市辖区');
INSERT INTO `sys_address_area` VALUES (220802, 0, 100, 220800, '洮北区');
INSERT INTO `sys_address_area` VALUES (220821, 0, 100, 220800, '镇赉县');
INSERT INTO `sys_address_area` VALUES (220822, 0, 100, 220800, '通榆县');
INSERT INTO `sys_address_area` VALUES (220881, 0, 100, 220800, '洮南市');
INSERT INTO `sys_address_area` VALUES (220882, 0, 100, 220800, '大安市');
INSERT INTO `sys_address_area` VALUES (222401, 0, 100, 222400, '延吉市');
INSERT INTO `sys_address_area` VALUES (222402, 0, 100, 222400, '图们市');
INSERT INTO `sys_address_area` VALUES (222403, 0, 100, 222400, '敦化市');
INSERT INTO `sys_address_area` VALUES (222404, 0, 100, 222400, '珲春市');
INSERT INTO `sys_address_area` VALUES (222405, 0, 100, 222400, '龙井市');
INSERT INTO `sys_address_area` VALUES (222406, 0, 100, 222400, '和龙市');
INSERT INTO `sys_address_area` VALUES (222424, 0, 100, 222400, '汪清县');
INSERT INTO `sys_address_area` VALUES (222426, 0, 100, 222400, '安图县');
INSERT INTO `sys_address_area` VALUES (230101, 0, 100, 230100, '市辖区');
INSERT INTO `sys_address_area` VALUES (230102, 0, 100, 230100, '道里区');
INSERT INTO `sys_address_area` VALUES (230103, 0, 100, 230100, '南岗区');
INSERT INTO `sys_address_area` VALUES (230104, 0, 100, 230100, '道外区');
INSERT INTO `sys_address_area` VALUES (230106, 0, 100, 230100, '香坊区');
INSERT INTO `sys_address_area` VALUES (230107, 0, 100, 230100, '动力区');
INSERT INTO `sys_address_area` VALUES (230108, 0, 100, 230100, '平房区');
INSERT INTO `sys_address_area` VALUES (230109, 0, 100, 230100, '松北区');
INSERT INTO `sys_address_area` VALUES (230111, 0, 100, 230100, '呼兰区');
INSERT INTO `sys_address_area` VALUES (230123, 0, 100, 230100, '依兰县');
INSERT INTO `sys_address_area` VALUES (230124, 0, 100, 230100, '方正县');
INSERT INTO `sys_address_area` VALUES (230125, 0, 100, 230100, '宾　县');
INSERT INTO `sys_address_area` VALUES (230126, 0, 100, 230100, '巴彦县');
INSERT INTO `sys_address_area` VALUES (230127, 0, 100, 230100, '木兰县');
INSERT INTO `sys_address_area` VALUES (230128, 0, 100, 230100, '通河县');
INSERT INTO `sys_address_area` VALUES (230129, 0, 100, 230100, '延寿县');
INSERT INTO `sys_address_area` VALUES (230181, 0, 100, 230100, '阿城市');
INSERT INTO `sys_address_area` VALUES (230182, 0, 100, 230100, '双城市');
INSERT INTO `sys_address_area` VALUES (230183, 0, 100, 230100, '尚志市');
INSERT INTO `sys_address_area` VALUES (230184, 0, 100, 230100, '五常市');
INSERT INTO `sys_address_area` VALUES (230201, 0, 100, 230200, '市辖区');
INSERT INTO `sys_address_area` VALUES (230202, 0, 100, 230200, '龙沙区');
INSERT INTO `sys_address_area` VALUES (230203, 0, 100, 230200, '建华区');
INSERT INTO `sys_address_area` VALUES (230204, 0, 100, 230200, '铁锋区');
INSERT INTO `sys_address_area` VALUES (230205, 0, 100, 230200, '昂昂溪区');
INSERT INTO `sys_address_area` VALUES (230206, 0, 100, 230200, '富拉尔基区');
INSERT INTO `sys_address_area` VALUES (230207, 0, 100, 230200, '碾子山区');
INSERT INTO `sys_address_area` VALUES (230208, 0, 100, 230200, '梅里斯达斡尔族区');
INSERT INTO `sys_address_area` VALUES (230221, 0, 100, 230200, '龙江县');
INSERT INTO `sys_address_area` VALUES (230223, 0, 100, 230200, '依安县');
INSERT INTO `sys_address_area` VALUES (230224, 0, 100, 230200, '泰来县');
INSERT INTO `sys_address_area` VALUES (230225, 0, 100, 230200, '甘南县');
INSERT INTO `sys_address_area` VALUES (230227, 0, 100, 230200, '富裕县');
INSERT INTO `sys_address_area` VALUES (230229, 0, 100, 230200, '克山县');
INSERT INTO `sys_address_area` VALUES (230230, 0, 100, 230200, '克东县');
INSERT INTO `sys_address_area` VALUES (230231, 0, 100, 230200, '拜泉县');
INSERT INTO `sys_address_area` VALUES (230281, 0, 100, 230200, '讷河市');
INSERT INTO `sys_address_area` VALUES (230301, 0, 100, 230300, '市辖区');
INSERT INTO `sys_address_area` VALUES (230302, 0, 100, 230300, '鸡冠区');
INSERT INTO `sys_address_area` VALUES (230303, 0, 100, 230300, '恒山区');
INSERT INTO `sys_address_area` VALUES (230304, 0, 100, 230300, '滴道区');
INSERT INTO `sys_address_area` VALUES (230305, 0, 100, 230300, '梨树区');
INSERT INTO `sys_address_area` VALUES (230306, 0, 100, 230300, '城子河区');
INSERT INTO `sys_address_area` VALUES (230307, 0, 100, 230300, '麻山区');
INSERT INTO `sys_address_area` VALUES (230321, 0, 100, 230300, '鸡东县');
INSERT INTO `sys_address_area` VALUES (230381, 0, 100, 230300, '虎林市');
INSERT INTO `sys_address_area` VALUES (230382, 0, 100, 230300, '密山市');
INSERT INTO `sys_address_area` VALUES (230401, 0, 100, 230400, '市辖区');
INSERT INTO `sys_address_area` VALUES (230402, 0, 100, 230400, '向阳区');
INSERT INTO `sys_address_area` VALUES (230403, 0, 100, 230400, '工农区');
INSERT INTO `sys_address_area` VALUES (230404, 0, 100, 230400, '南山区');
INSERT INTO `sys_address_area` VALUES (230405, 0, 100, 230400, '兴安区');
INSERT INTO `sys_address_area` VALUES (230406, 0, 100, 230400, '东山区');
INSERT INTO `sys_address_area` VALUES (230407, 0, 100, 230400, '兴山区');
INSERT INTO `sys_address_area` VALUES (230421, 0, 100, 230400, '萝北县');
INSERT INTO `sys_address_area` VALUES (230422, 0, 100, 230400, '绥滨县');
INSERT INTO `sys_address_area` VALUES (230501, 0, 100, 230500, '市辖区');
INSERT INTO `sys_address_area` VALUES (230502, 0, 100, 230500, '尖山区');
INSERT INTO `sys_address_area` VALUES (230503, 0, 100, 230500, '岭东区');
INSERT INTO `sys_address_area` VALUES (230505, 0, 100, 230500, '四方台区');
INSERT INTO `sys_address_area` VALUES (230506, 0, 100, 230500, '宝山区');
INSERT INTO `sys_address_area` VALUES (230521, 0, 100, 230500, '集贤县');
INSERT INTO `sys_address_area` VALUES (230522, 0, 100, 230500, '友谊县');
INSERT INTO `sys_address_area` VALUES (230523, 0, 100, 230500, '宝清县');
INSERT INTO `sys_address_area` VALUES (230524, 0, 100, 230500, '饶河县');
INSERT INTO `sys_address_area` VALUES (230601, 0, 100, 230600, '市辖区');
INSERT INTO `sys_address_area` VALUES (230602, 0, 100, 230600, '萨尔图区');
INSERT INTO `sys_address_area` VALUES (230603, 0, 100, 230600, '龙凤区');
INSERT INTO `sys_address_area` VALUES (230604, 0, 100, 230600, '让胡路区');
INSERT INTO `sys_address_area` VALUES (230605, 0, 100, 230600, '红岗区');
INSERT INTO `sys_address_area` VALUES (230606, 0, 100, 230600, '大同区');
INSERT INTO `sys_address_area` VALUES (230621, 0, 100, 230600, '肇州县');
INSERT INTO `sys_address_area` VALUES (230622, 0, 100, 230600, '肇源县');
INSERT INTO `sys_address_area` VALUES (230623, 0, 100, 230600, '林甸县');
INSERT INTO `sys_address_area` VALUES (230624, 0, 100, 230600, '杜尔伯特蒙古族自治县');
INSERT INTO `sys_address_area` VALUES (230701, 0, 100, 230700, '市辖区');
INSERT INTO `sys_address_area` VALUES (230702, 0, 100, 230700, '伊春区');
INSERT INTO `sys_address_area` VALUES (230703, 0, 100, 230700, '南岔区');
INSERT INTO `sys_address_area` VALUES (230704, 0, 100, 230700, '友好区');
INSERT INTO `sys_address_area` VALUES (230705, 0, 100, 230700, '西林区');
INSERT INTO `sys_address_area` VALUES (230706, 0, 100, 230700, '翠峦区');
INSERT INTO `sys_address_area` VALUES (230707, 0, 100, 230700, '新青区');
INSERT INTO `sys_address_area` VALUES (230708, 0, 100, 230700, '美溪区');
INSERT INTO `sys_address_area` VALUES (230709, 0, 100, 230700, '金山屯区');
INSERT INTO `sys_address_area` VALUES (230710, 0, 100, 230700, '五营区');
INSERT INTO `sys_address_area` VALUES (230711, 0, 100, 230700, '乌马河区');
INSERT INTO `sys_address_area` VALUES (230712, 0, 100, 230700, '汤旺河区');
INSERT INTO `sys_address_area` VALUES (230713, 0, 100, 230700, '带岭区');
INSERT INTO `sys_address_area` VALUES (230714, 0, 100, 230700, '乌伊岭区');
INSERT INTO `sys_address_area` VALUES (230715, 0, 100, 230700, '红星区');
INSERT INTO `sys_address_area` VALUES (230716, 0, 100, 230700, '上甘岭区');
INSERT INTO `sys_address_area` VALUES (230722, 0, 100, 230700, '嘉荫县');
INSERT INTO `sys_address_area` VALUES (230781, 0, 100, 230700, '铁力市');
INSERT INTO `sys_address_area` VALUES (230801, 0, 100, 230800, '市辖区');
INSERT INTO `sys_address_area` VALUES (230802, 0, 100, 230800, '永红区');
INSERT INTO `sys_address_area` VALUES (230803, 0, 100, 230800, '向阳区');
INSERT INTO `sys_address_area` VALUES (230804, 0, 100, 230800, '前进区');
INSERT INTO `sys_address_area` VALUES (230805, 0, 100, 230800, '东风区');
INSERT INTO `sys_address_area` VALUES (230811, 0, 100, 230800, '郊　区');
INSERT INTO `sys_address_area` VALUES (230822, 0, 100, 230800, '桦南县');
INSERT INTO `sys_address_area` VALUES (230826, 0, 100, 230800, '桦川县');
INSERT INTO `sys_address_area` VALUES (230828, 0, 100, 230800, '汤原县');
INSERT INTO `sys_address_area` VALUES (230833, 0, 100, 230800, '抚远县');
INSERT INTO `sys_address_area` VALUES (230881, 0, 100, 230800, '同江市');
INSERT INTO `sys_address_area` VALUES (230882, 0, 100, 230800, '富锦市');
INSERT INTO `sys_address_area` VALUES (230901, 0, 100, 230900, '市辖区');
INSERT INTO `sys_address_area` VALUES (230902, 0, 100, 230900, '新兴区');
INSERT INTO `sys_address_area` VALUES (230903, 0, 100, 230900, '桃山区');
INSERT INTO `sys_address_area` VALUES (230904, 0, 100, 230900, '茄子河区');
INSERT INTO `sys_address_area` VALUES (230921, 0, 100, 230900, '勃利县');
INSERT INTO `sys_address_area` VALUES (231001, 0, 100, 231000, '市辖区');
INSERT INTO `sys_address_area` VALUES (231002, 0, 100, 231000, '东安区');
INSERT INTO `sys_address_area` VALUES (231003, 0, 100, 231000, '阳明区');
INSERT INTO `sys_address_area` VALUES (231004, 0, 100, 231000, '爱民区');
INSERT INTO `sys_address_area` VALUES (231005, 0, 100, 231000, '西安区');
INSERT INTO `sys_address_area` VALUES (231024, 0, 100, 231000, '东宁县');
INSERT INTO `sys_address_area` VALUES (231025, 0, 100, 231000, '林口县');
INSERT INTO `sys_address_area` VALUES (231081, 0, 100, 231000, '绥芬河市');
INSERT INTO `sys_address_area` VALUES (231083, 0, 100, 231000, '海林市');
INSERT INTO `sys_address_area` VALUES (231084, 0, 100, 231000, '宁安市');
INSERT INTO `sys_address_area` VALUES (231085, 0, 100, 231000, '穆棱市');
INSERT INTO `sys_address_area` VALUES (231101, 0, 100, 231100, '市辖区');
INSERT INTO `sys_address_area` VALUES (231102, 0, 100, 231100, '爱辉区');
INSERT INTO `sys_address_area` VALUES (231121, 0, 100, 231100, '嫩江县');
INSERT INTO `sys_address_area` VALUES (231123, 0, 100, 231100, '逊克县');
INSERT INTO `sys_address_area` VALUES (231124, 0, 100, 231100, '孙吴县');
INSERT INTO `sys_address_area` VALUES (231181, 0, 100, 231100, '北安市');
INSERT INTO `sys_address_area` VALUES (231182, 0, 100, 231100, '五大连池市');
INSERT INTO `sys_address_area` VALUES (231201, 0, 100, 231200, '市辖区');
INSERT INTO `sys_address_area` VALUES (231202, 0, 100, 231200, '北林区');
INSERT INTO `sys_address_area` VALUES (231221, 0, 100, 231200, '望奎县');
INSERT INTO `sys_address_area` VALUES (231222, 0, 100, 231200, '兰西县');
INSERT INTO `sys_address_area` VALUES (231223, 0, 100, 231200, '青冈县');
INSERT INTO `sys_address_area` VALUES (231224, 0, 100, 231200, '庆安县');
INSERT INTO `sys_address_area` VALUES (231225, 0, 100, 231200, '明水县');
INSERT INTO `sys_address_area` VALUES (231226, 0, 100, 231200, '绥棱县');
INSERT INTO `sys_address_area` VALUES (231281, 0, 100, 231200, '安达市');
INSERT INTO `sys_address_area` VALUES (231282, 0, 100, 231200, '肇东市');
INSERT INTO `sys_address_area` VALUES (231283, 0, 100, 231200, '海伦市');
INSERT INTO `sys_address_area` VALUES (232721, 0, 100, 232700, '呼玛县');
INSERT INTO `sys_address_area` VALUES (232722, 0, 100, 232700, '塔河县');
INSERT INTO `sys_address_area` VALUES (232723, 0, 100, 232700, '漠河县');
INSERT INTO `sys_address_area` VALUES (310101, 0, 100, 310100, '黄浦区');
INSERT INTO `sys_address_area` VALUES (310103, 0, 100, 310100, '卢湾区');
INSERT INTO `sys_address_area` VALUES (310104, 0, 100, 310100, '徐汇区');
INSERT INTO `sys_address_area` VALUES (310105, 0, 100, 310100, '长宁区');
INSERT INTO `sys_address_area` VALUES (310106, 0, 100, 310100, '静安区');
INSERT INTO `sys_address_area` VALUES (310107, 0, 100, 310100, '普陀区');
INSERT INTO `sys_address_area` VALUES (310108, 0, 100, 310100, '闸北区');
INSERT INTO `sys_address_area` VALUES (310109, 0, 100, 310100, '虹口区');
INSERT INTO `sys_address_area` VALUES (310110, 0, 100, 310100, '杨浦区');
INSERT INTO `sys_address_area` VALUES (310112, 0, 100, 310100, '闵行区');
INSERT INTO `sys_address_area` VALUES (310113, 0, 100, 310100, '宝山区');
INSERT INTO `sys_address_area` VALUES (310114, 0, 100, 310100, '嘉定区');
INSERT INTO `sys_address_area` VALUES (310115, 0, 100, 310100, '浦东新区');
INSERT INTO `sys_address_area` VALUES (310116, 0, 100, 310100, '金山区');
INSERT INTO `sys_address_area` VALUES (310117, 0, 100, 310100, '松江区');
INSERT INTO `sys_address_area` VALUES (310118, 0, 100, 310100, '青浦区');
INSERT INTO `sys_address_area` VALUES (310119, 0, 100, 310100, '南汇区');
INSERT INTO `sys_address_area` VALUES (310120, 0, 100, 310100, '奉贤区');
INSERT INTO `sys_address_area` VALUES (310230, 0, 100, 310200, '崇明县');
INSERT INTO `sys_address_area` VALUES (320101, 0, 100, 320100, '市辖区');
INSERT INTO `sys_address_area` VALUES (320102, 0, 100, 320100, '玄武区');
INSERT INTO `sys_address_area` VALUES (320103, 0, 100, 320100, '白下区');
INSERT INTO `sys_address_area` VALUES (320104, 0, 100, 320100, '秦淮区');
INSERT INTO `sys_address_area` VALUES (320105, 0, 100, 320100, '建邺区');
INSERT INTO `sys_address_area` VALUES (320106, 0, 100, 320100, '鼓楼区');
INSERT INTO `sys_address_area` VALUES (320107, 0, 100, 320100, '下关区');
INSERT INTO `sys_address_area` VALUES (320111, 0, 100, 320100, '浦口区');
INSERT INTO `sys_address_area` VALUES (320113, 0, 100, 320100, '栖霞区');
INSERT INTO `sys_address_area` VALUES (320114, 0, 100, 320100, '雨花台区');
INSERT INTO `sys_address_area` VALUES (320115, 0, 100, 320100, '江宁区');
INSERT INTO `sys_address_area` VALUES (320116, 0, 100, 320100, '六合区');
INSERT INTO `sys_address_area` VALUES (320124, 0, 100, 320100, '溧水县');
INSERT INTO `sys_address_area` VALUES (320125, 0, 100, 320100, '高淳县');
INSERT INTO `sys_address_area` VALUES (320201, 0, 100, 320200, '市辖区');
INSERT INTO `sys_address_area` VALUES (320202, 0, 100, 320200, '崇安区');
INSERT INTO `sys_address_area` VALUES (320203, 0, 100, 320200, '南长区');
INSERT INTO `sys_address_area` VALUES (320204, 0, 100, 320200, '北塘区');
INSERT INTO `sys_address_area` VALUES (320205, 0, 100, 320200, '锡山区');
INSERT INTO `sys_address_area` VALUES (320206, 0, 100, 320200, '惠山区');
INSERT INTO `sys_address_area` VALUES (320211, 0, 100, 320200, '滨湖区');
INSERT INTO `sys_address_area` VALUES (320281, 0, 100, 320200, '江阴市');
INSERT INTO `sys_address_area` VALUES (320282, 0, 100, 320200, '宜兴市');
INSERT INTO `sys_address_area` VALUES (320301, 0, 100, 320300, '市辖区');
INSERT INTO `sys_address_area` VALUES (320302, 0, 100, 320300, '鼓楼区');
INSERT INTO `sys_address_area` VALUES (320303, 0, 100, 320300, '云龙区');
INSERT INTO `sys_address_area` VALUES (320304, 0, 100, 320300, '九里区');
INSERT INTO `sys_address_area` VALUES (320305, 0, 100, 320300, '贾汪区');
INSERT INTO `sys_address_area` VALUES (320311, 0, 100, 320300, '泉山区');
INSERT INTO `sys_address_area` VALUES (320321, 0, 100, 320300, '丰　县');
INSERT INTO `sys_address_area` VALUES (320322, 0, 100, 320300, '沛　县');
INSERT INTO `sys_address_area` VALUES (320323, 0, 100, 320300, '铜山县');
INSERT INTO `sys_address_area` VALUES (320324, 0, 100, 320300, '睢宁县');
INSERT INTO `sys_address_area` VALUES (320381, 0, 100, 320300, '新沂市');
INSERT INTO `sys_address_area` VALUES (320382, 0, 100, 320300, '邳州市');
INSERT INTO `sys_address_area` VALUES (320401, 0, 100, 320400, '市辖区');
INSERT INTO `sys_address_area` VALUES (320402, 0, 100, 320400, '天宁区');
INSERT INTO `sys_address_area` VALUES (320404, 0, 100, 320400, '钟楼区');
INSERT INTO `sys_address_area` VALUES (320405, 0, 100, 320400, '戚墅堰区');
INSERT INTO `sys_address_area` VALUES (320411, 0, 100, 320400, '新北区');
INSERT INTO `sys_address_area` VALUES (320412, 0, 100, 320400, '武进区');
INSERT INTO `sys_address_area` VALUES (320481, 0, 100, 320400, '溧阳市');
INSERT INTO `sys_address_area` VALUES (320482, 0, 100, 320400, '金坛市');
INSERT INTO `sys_address_area` VALUES (320501, 0, 100, 320500, '市辖区');
INSERT INTO `sys_address_area` VALUES (320502, 0, 100, 320500, '沧浪区');
INSERT INTO `sys_address_area` VALUES (320503, 0, 100, 320500, '平江区');
INSERT INTO `sys_address_area` VALUES (320504, 0, 100, 320500, '金阊区');
INSERT INTO `sys_address_area` VALUES (320505, 0, 100, 320500, '虎丘区');
INSERT INTO `sys_address_area` VALUES (320506, 0, 100, 320500, '吴中区');
INSERT INTO `sys_address_area` VALUES (320507, 0, 100, 320500, '相城区');
INSERT INTO `sys_address_area` VALUES (320581, 0, 100, 320500, '常熟市');
INSERT INTO `sys_address_area` VALUES (320582, 0, 100, 320500, '张家港市');
INSERT INTO `sys_address_area` VALUES (320583, 0, 100, 320500, '昆山市');
INSERT INTO `sys_address_area` VALUES (320584, 0, 100, 320500, '吴江市');
INSERT INTO `sys_address_area` VALUES (320585, 0, 100, 320500, '太仓市');
INSERT INTO `sys_address_area` VALUES (320601, 0, 100, 320600, '市辖区');
INSERT INTO `sys_address_area` VALUES (320602, 0, 100, 320600, '崇川区');
INSERT INTO `sys_address_area` VALUES (320611, 0, 100, 320600, '港闸区');
INSERT INTO `sys_address_area` VALUES (320621, 0, 100, 320600, '海安县');
INSERT INTO `sys_address_area` VALUES (320623, 0, 100, 320600, '如东县');
INSERT INTO `sys_address_area` VALUES (320681, 0, 100, 320600, '启东市');
INSERT INTO `sys_address_area` VALUES (320682, 0, 100, 320600, '如皋市');
INSERT INTO `sys_address_area` VALUES (320683, 0, 100, 320600, '通州市');
INSERT INTO `sys_address_area` VALUES (320684, 0, 100, 320600, '海门市');
INSERT INTO `sys_address_area` VALUES (320701, 0, 100, 320700, '市辖区');
INSERT INTO `sys_address_area` VALUES (320703, 0, 100, 320700, '连云区');
INSERT INTO `sys_address_area` VALUES (320705, 0, 100, 320700, '新浦区');
INSERT INTO `sys_address_area` VALUES (320706, 0, 100, 320700, '海州区');
INSERT INTO `sys_address_area` VALUES (320721, 0, 100, 320700, '赣榆县');
INSERT INTO `sys_address_area` VALUES (320722, 0, 100, 320700, '东海县');
INSERT INTO `sys_address_area` VALUES (320723, 0, 100, 320700, '灌云县');
INSERT INTO `sys_address_area` VALUES (320724, 0, 100, 320700, '灌南县');
INSERT INTO `sys_address_area` VALUES (320801, 0, 100, 320800, '市辖区');
INSERT INTO `sys_address_area` VALUES (320802, 0, 100, 320800, '清河区');
INSERT INTO `sys_address_area` VALUES (320803, 0, 100, 320800, '楚州区');
INSERT INTO `sys_address_area` VALUES (320804, 0, 100, 320800, '淮阴区');
INSERT INTO `sys_address_area` VALUES (320811, 0, 100, 320800, '清浦区');
INSERT INTO `sys_address_area` VALUES (320826, 0, 100, 320800, '涟水县');
INSERT INTO `sys_address_area` VALUES (320829, 0, 100, 320800, '洪泽县');
INSERT INTO `sys_address_area` VALUES (320830, 0, 100, 320800, '盱眙县');
INSERT INTO `sys_address_area` VALUES (320831, 0, 100, 320800, '金湖县');
INSERT INTO `sys_address_area` VALUES (320901, 0, 100, 320900, '市辖区');
INSERT INTO `sys_address_area` VALUES (320902, 0, 100, 320900, '亭湖区');
INSERT INTO `sys_address_area` VALUES (320903, 0, 100, 320900, '盐都区');
INSERT INTO `sys_address_area` VALUES (320921, 0, 100, 320900, '响水县');
INSERT INTO `sys_address_area` VALUES (320922, 0, 100, 320900, '滨海县');
INSERT INTO `sys_address_area` VALUES (320923, 0, 100, 320900, '阜宁县');
INSERT INTO `sys_address_area` VALUES (320924, 0, 100, 320900, '射阳县');
INSERT INTO `sys_address_area` VALUES (320925, 0, 100, 320900, '建湖县');
INSERT INTO `sys_address_area` VALUES (320981, 0, 100, 320900, '东台市');
INSERT INTO `sys_address_area` VALUES (320982, 0, 100, 320900, '大丰市');
INSERT INTO `sys_address_area` VALUES (321001, 0, 100, 321000, '市辖区');
INSERT INTO `sys_address_area` VALUES (321002, 0, 100, 321000, '广陵区');
INSERT INTO `sys_address_area` VALUES (321003, 0, 100, 321000, '邗江区');
INSERT INTO `sys_address_area` VALUES (321011, 0, 100, 321000, '郊　区');
INSERT INTO `sys_address_area` VALUES (321023, 0, 100, 321000, '宝应县');
INSERT INTO `sys_address_area` VALUES (321081, 0, 100, 321000, '仪征市');
INSERT INTO `sys_address_area` VALUES (321084, 0, 100, 321000, '高邮市');
INSERT INTO `sys_address_area` VALUES (321088, 0, 100, 321000, '江都市');
INSERT INTO `sys_address_area` VALUES (321101, 0, 100, 321100, '市辖区');
INSERT INTO `sys_address_area` VALUES (321102, 0, 100, 321100, '京口区');
INSERT INTO `sys_address_area` VALUES (321111, 0, 100, 321100, '润州区');
INSERT INTO `sys_address_area` VALUES (321112, 0, 100, 321100, '丹徒区');
INSERT INTO `sys_address_area` VALUES (321181, 0, 100, 321100, '丹阳市');
INSERT INTO `sys_address_area` VALUES (321182, 0, 100, 321100, '扬中市');
INSERT INTO `sys_address_area` VALUES (321183, 0, 100, 321100, '句容市');
INSERT INTO `sys_address_area` VALUES (321201, 0, 100, 321200, '市辖区');
INSERT INTO `sys_address_area` VALUES (321202, 0, 100, 321200, '海陵区');
INSERT INTO `sys_address_area` VALUES (321203, 0, 100, 321200, '高港区');
INSERT INTO `sys_address_area` VALUES (321281, 0, 100, 321200, '兴化市');
INSERT INTO `sys_address_area` VALUES (321282, 0, 100, 321200, '靖江市');
INSERT INTO `sys_address_area` VALUES (321283, 0, 100, 321200, '泰兴市');
INSERT INTO `sys_address_area` VALUES (321284, 0, 100, 321200, '姜堰市');
INSERT INTO `sys_address_area` VALUES (321301, 0, 100, 321300, '市辖区');
INSERT INTO `sys_address_area` VALUES (321302, 0, 100, 321300, '宿城区');
INSERT INTO `sys_address_area` VALUES (321311, 0, 100, 321300, '宿豫区');
INSERT INTO `sys_address_area` VALUES (321322, 0, 100, 321300, '沭阳县');
INSERT INTO `sys_address_area` VALUES (321323, 0, 100, 321300, '泗阳县');
INSERT INTO `sys_address_area` VALUES (321324, 0, 100, 321300, '泗洪县');
INSERT INTO `sys_address_area` VALUES (330101, 0, 100, 330100, '市辖区');
INSERT INTO `sys_address_area` VALUES (330102, 0, 100, 330100, '上城区');
INSERT INTO `sys_address_area` VALUES (330103, 0, 100, 330100, '下城区');
INSERT INTO `sys_address_area` VALUES (330104, 0, 100, 330100, '江干区');
INSERT INTO `sys_address_area` VALUES (330105, 0, 100, 330100, '拱墅区');
INSERT INTO `sys_address_area` VALUES (330106, 0, 100, 330100, '西湖区');
INSERT INTO `sys_address_area` VALUES (330108, 0, 100, 330100, '滨江区');
INSERT INTO `sys_address_area` VALUES (330109, 0, 100, 330100, '萧山区');
INSERT INTO `sys_address_area` VALUES (330110, 0, 100, 330100, '余杭区');
INSERT INTO `sys_address_area` VALUES (330122, 0, 100, 330100, '桐庐县');
INSERT INTO `sys_address_area` VALUES (330127, 0, 100, 330100, '淳安县');
INSERT INTO `sys_address_area` VALUES (330182, 0, 100, 330100, '建德市');
INSERT INTO `sys_address_area` VALUES (330183, 0, 100, 330100, '富阳市');
INSERT INTO `sys_address_area` VALUES (330185, 0, 100, 330100, '临安市');
INSERT INTO `sys_address_area` VALUES (330201, 0, 100, 330200, '市辖区');
INSERT INTO `sys_address_area` VALUES (330203, 0, 100, 330200, '海曙区');
INSERT INTO `sys_address_area` VALUES (330204, 0, 100, 330200, '江东区');
INSERT INTO `sys_address_area` VALUES (330205, 0, 100, 330200, '江北区');
INSERT INTO `sys_address_area` VALUES (330206, 0, 100, 330200, '北仑区');
INSERT INTO `sys_address_area` VALUES (330211, 0, 100, 330200, '镇海区');
INSERT INTO `sys_address_area` VALUES (330212, 0, 100, 330200, '鄞州区');
INSERT INTO `sys_address_area` VALUES (330225, 0, 100, 330200, '象山县');
INSERT INTO `sys_address_area` VALUES (330226, 0, 100, 330200, '宁海县');
INSERT INTO `sys_address_area` VALUES (330281, 0, 100, 330200, '余姚市');
INSERT INTO `sys_address_area` VALUES (330282, 0, 100, 330200, '慈溪市');
INSERT INTO `sys_address_area` VALUES (330283, 0, 100, 330200, '奉化市');
INSERT INTO `sys_address_area` VALUES (330301, 0, 100, 330300, '市辖区');
INSERT INTO `sys_address_area` VALUES (330302, 0, 100, 330300, '鹿城区');
INSERT INTO `sys_address_area` VALUES (330303, 0, 100, 330300, '龙湾区');
INSERT INTO `sys_address_area` VALUES (330304, 0, 100, 330300, '瓯海区');
INSERT INTO `sys_address_area` VALUES (330322, 0, 100, 330300, '洞头县');
INSERT INTO `sys_address_area` VALUES (330324, 0, 100, 330300, '永嘉县');
INSERT INTO `sys_address_area` VALUES (330326, 0, 100, 330300, '平阳县');
INSERT INTO `sys_address_area` VALUES (330327, 0, 100, 330300, '苍南县');
INSERT INTO `sys_address_area` VALUES (330328, 0, 100, 330300, '文成县');
INSERT INTO `sys_address_area` VALUES (330329, 0, 100, 330300, '泰顺县');
INSERT INTO `sys_address_area` VALUES (330381, 0, 100, 330300, '瑞安市');
INSERT INTO `sys_address_area` VALUES (330382, 0, 100, 330300, '乐清市');
INSERT INTO `sys_address_area` VALUES (330401, 0, 100, 330400, '市辖区');
INSERT INTO `sys_address_area` VALUES (330402, 0, 100, 330400, '秀城区');
INSERT INTO `sys_address_area` VALUES (330411, 0, 100, 330400, '秀洲区');
INSERT INTO `sys_address_area` VALUES (330421, 0, 100, 330400, '嘉善县');
INSERT INTO `sys_address_area` VALUES (330424, 0, 100, 330400, '海盐县');
INSERT INTO `sys_address_area` VALUES (330481, 0, 100, 330400, '海宁市');
INSERT INTO `sys_address_area` VALUES (330482, 0, 100, 330400, '平湖市');
INSERT INTO `sys_address_area` VALUES (330483, 0, 100, 330400, '桐乡市');
INSERT INTO `sys_address_area` VALUES (330501, 0, 100, 330500, '市辖区');
INSERT INTO `sys_address_area` VALUES (330502, 0, 100, 330500, '吴兴区');
INSERT INTO `sys_address_area` VALUES (330503, 0, 100, 330500, '南浔区');
INSERT INTO `sys_address_area` VALUES (330521, 0, 100, 330500, '德清县');
INSERT INTO `sys_address_area` VALUES (330522, 0, 100, 330500, '长兴县');
INSERT INTO `sys_address_area` VALUES (330523, 0, 100, 330500, '安吉县');
INSERT INTO `sys_address_area` VALUES (330601, 0, 100, 330600, '市辖区');
INSERT INTO `sys_address_area` VALUES (330602, 0, 100, 330600, '越城区');
INSERT INTO `sys_address_area` VALUES (330621, 0, 100, 330600, '绍兴县');
INSERT INTO `sys_address_area` VALUES (330624, 0, 100, 330600, '新昌县');
INSERT INTO `sys_address_area` VALUES (330681, 0, 100, 330600, '诸暨市');
INSERT INTO `sys_address_area` VALUES (330682, 0, 100, 330600, '上虞市');
INSERT INTO `sys_address_area` VALUES (330683, 0, 100, 330600, '嵊州市');
INSERT INTO `sys_address_area` VALUES (330701, 0, 100, 330700, '市辖区');
INSERT INTO `sys_address_area` VALUES (330702, 0, 100, 330700, '婺城区');
INSERT INTO `sys_address_area` VALUES (330703, 0, 100, 330700, '金东区');
INSERT INTO `sys_address_area` VALUES (330723, 0, 100, 330700, '武义县');
INSERT INTO `sys_address_area` VALUES (330726, 0, 100, 330700, '浦江县');
INSERT INTO `sys_address_area` VALUES (330727, 0, 100, 330700, '磐安县');
INSERT INTO `sys_address_area` VALUES (330781, 0, 100, 330700, '兰溪市');
INSERT INTO `sys_address_area` VALUES (330782, 0, 100, 330700, '义乌市');
INSERT INTO `sys_address_area` VALUES (330783, 0, 100, 330700, '东阳市');
INSERT INTO `sys_address_area` VALUES (330784, 0, 100, 330700, '永康市');
INSERT INTO `sys_address_area` VALUES (330801, 0, 100, 330800, '市辖区');
INSERT INTO `sys_address_area` VALUES (330802, 0, 100, 330800, '柯城区');
INSERT INTO `sys_address_area` VALUES (330803, 0, 100, 330800, '衢江区');
INSERT INTO `sys_address_area` VALUES (330822, 0, 100, 330800, '常山县');
INSERT INTO `sys_address_area` VALUES (330824, 0, 100, 330800, '开化县');
INSERT INTO `sys_address_area` VALUES (330825, 0, 100, 330800, '龙游县');
INSERT INTO `sys_address_area` VALUES (330881, 0, 100, 330800, '江山市');
INSERT INTO `sys_address_area` VALUES (330901, 0, 100, 330900, '市辖区');
INSERT INTO `sys_address_area` VALUES (330902, 0, 100, 330900, '定海区');
INSERT INTO `sys_address_area` VALUES (330903, 0, 100, 330900, '普陀区');
INSERT INTO `sys_address_area` VALUES (330921, 0, 100, 330900, '岱山县');
INSERT INTO `sys_address_area` VALUES (330922, 0, 100, 330900, '嵊泗县');
INSERT INTO `sys_address_area` VALUES (331001, 0, 100, 331000, '市辖区');
INSERT INTO `sys_address_area` VALUES (331002, 0, 100, 331000, '椒江区');
INSERT INTO `sys_address_area` VALUES (331003, 0, 100, 331000, '黄岩区');
INSERT INTO `sys_address_area` VALUES (331004, 0, 100, 331000, '路桥区');
INSERT INTO `sys_address_area` VALUES (331021, 0, 100, 331000, '玉环县');
INSERT INTO `sys_address_area` VALUES (331022, 0, 100, 331000, '三门县');
INSERT INTO `sys_address_area` VALUES (331023, 0, 100, 331000, '天台县');
INSERT INTO `sys_address_area` VALUES (331024, 0, 100, 331000, '仙居县');
INSERT INTO `sys_address_area` VALUES (331081, 0, 100, 331000, '温岭市');
INSERT INTO `sys_address_area` VALUES (331082, 0, 100, 331000, '临海市');
INSERT INTO `sys_address_area` VALUES (331101, 0, 100, 331100, '市辖区');
INSERT INTO `sys_address_area` VALUES (331102, 0, 100, 331100, '莲都区');
INSERT INTO `sys_address_area` VALUES (331121, 0, 100, 331100, '青田县');
INSERT INTO `sys_address_area` VALUES (331122, 0, 100, 331100, '缙云县');
INSERT INTO `sys_address_area` VALUES (331123, 0, 100, 331100, '遂昌县');
INSERT INTO `sys_address_area` VALUES (331124, 0, 100, 331100, '松阳县');
INSERT INTO `sys_address_area` VALUES (331125, 0, 100, 331100, '云和县');
INSERT INTO `sys_address_area` VALUES (331126, 0, 100, 331100, '庆元县');
INSERT INTO `sys_address_area` VALUES (331127, 0, 100, 331100, '景宁畲族自治县');
INSERT INTO `sys_address_area` VALUES (331181, 0, 100, 331100, '龙泉市');
INSERT INTO `sys_address_area` VALUES (340101, 0, 100, 340100, '市辖区');
INSERT INTO `sys_address_area` VALUES (340102, 0, 100, 340100, '瑶海区');
INSERT INTO `sys_address_area` VALUES (340103, 0, 100, 340100, '庐阳区');
INSERT INTO `sys_address_area` VALUES (340104, 0, 100, 340100, '蜀山区');
INSERT INTO `sys_address_area` VALUES (340111, 0, 100, 340100, '包河区');
INSERT INTO `sys_address_area` VALUES (340121, 0, 100, 340100, '长丰县');
INSERT INTO `sys_address_area` VALUES (340122, 0, 100, 340100, '肥东县');
INSERT INTO `sys_address_area` VALUES (340123, 0, 100, 340100, '肥西县');
INSERT INTO `sys_address_area` VALUES (340201, 0, 100, 340200, '市辖区');
INSERT INTO `sys_address_area` VALUES (340202, 0, 100, 340200, '镜湖区');
INSERT INTO `sys_address_area` VALUES (340203, 0, 100, 340200, '马塘区');
INSERT INTO `sys_address_area` VALUES (340204, 0, 100, 340200, '新芜区');
INSERT INTO `sys_address_area` VALUES (340207, 0, 100, 340200, '鸠江区');
INSERT INTO `sys_address_area` VALUES (340221, 0, 100, 340200, '芜湖县');
INSERT INTO `sys_address_area` VALUES (340222, 0, 100, 340200, '繁昌县');
INSERT INTO `sys_address_area` VALUES (340223, 0, 100, 340200, '南陵县');
INSERT INTO `sys_address_area` VALUES (340301, 0, 100, 340300, '市辖区');
INSERT INTO `sys_address_area` VALUES (340302, 0, 100, 340300, '龙子湖区');
INSERT INTO `sys_address_area` VALUES (340303, 0, 100, 340300, '蚌山区');
INSERT INTO `sys_address_area` VALUES (340304, 0, 100, 340300, '禹会区');
INSERT INTO `sys_address_area` VALUES (340311, 0, 100, 340300, '淮上区');
INSERT INTO `sys_address_area` VALUES (340321, 0, 100, 340300, '怀远县');
INSERT INTO `sys_address_area` VALUES (340322, 0, 100, 340300, '五河县');
INSERT INTO `sys_address_area` VALUES (340323, 0, 100, 340300, '固镇县');
INSERT INTO `sys_address_area` VALUES (340401, 0, 100, 340400, '市辖区');
INSERT INTO `sys_address_area` VALUES (340402, 0, 100, 340400, '大通区');
INSERT INTO `sys_address_area` VALUES (340403, 0, 100, 340400, '田家庵区');
INSERT INTO `sys_address_area` VALUES (340404, 0, 100, 340400, '谢家集区');
INSERT INTO `sys_address_area` VALUES (340405, 0, 100, 340400, '八公山区');
INSERT INTO `sys_address_area` VALUES (340406, 0, 100, 340400, '潘集区');
INSERT INTO `sys_address_area` VALUES (340421, 0, 100, 340400, '凤台县');
INSERT INTO `sys_address_area` VALUES (340501, 0, 100, 340500, '市辖区');
INSERT INTO `sys_address_area` VALUES (340502, 0, 100, 340500, '金家庄区');
INSERT INTO `sys_address_area` VALUES (340503, 0, 100, 340500, '花山区');
INSERT INTO `sys_address_area` VALUES (340504, 0, 100, 340500, '雨山区');
INSERT INTO `sys_address_area` VALUES (340521, 0, 100, 340500, '当涂县');
INSERT INTO `sys_address_area` VALUES (340601, 0, 100, 340600, '市辖区');
INSERT INTO `sys_address_area` VALUES (340602, 0, 100, 340600, '杜集区');
INSERT INTO `sys_address_area` VALUES (340603, 0, 100, 340600, '相山区');
INSERT INTO `sys_address_area` VALUES (340604, 0, 100, 340600, '烈山区');
INSERT INTO `sys_address_area` VALUES (340621, 0, 100, 340600, '濉溪县');
INSERT INTO `sys_address_area` VALUES (340701, 0, 100, 340700, '市辖区');
INSERT INTO `sys_address_area` VALUES (340702, 0, 100, 340700, '铜官山区');
INSERT INTO `sys_address_area` VALUES (340703, 0, 100, 340700, '狮子山区');
INSERT INTO `sys_address_area` VALUES (340711, 0, 100, 340700, '郊　区');
INSERT INTO `sys_address_area` VALUES (340721, 0, 100, 340700, '铜陵县');
INSERT INTO `sys_address_area` VALUES (340801, 0, 100, 340800, '市辖区');
INSERT INTO `sys_address_area` VALUES (340802, 0, 100, 340800, '迎江区');
INSERT INTO `sys_address_area` VALUES (340803, 0, 100, 340800, '大观区');
INSERT INTO `sys_address_area` VALUES (340811, 0, 100, 340800, '郊　区');
INSERT INTO `sys_address_area` VALUES (340822, 0, 100, 340800, '怀宁县');
INSERT INTO `sys_address_area` VALUES (340823, 0, 100, 340800, '枞阳县');
INSERT INTO `sys_address_area` VALUES (340824, 0, 100, 340800, '潜山县');
INSERT INTO `sys_address_area` VALUES (340825, 0, 100, 340800, '太湖县');
INSERT INTO `sys_address_area` VALUES (340826, 0, 100, 340800, '宿松县');
INSERT INTO `sys_address_area` VALUES (340827, 0, 100, 340800, '望江县');
INSERT INTO `sys_address_area` VALUES (340828, 0, 100, 340800, '岳西县');
INSERT INTO `sys_address_area` VALUES (340881, 0, 100, 340800, '桐城市');
INSERT INTO `sys_address_area` VALUES (341001, 0, 100, 341000, '市辖区');
INSERT INTO `sys_address_area` VALUES (341002, 0, 100, 341000, '屯溪区');
INSERT INTO `sys_address_area` VALUES (341003, 0, 100, 341000, '黄山区');
INSERT INTO `sys_address_area` VALUES (341004, 0, 100, 341000, '徽州区');
INSERT INTO `sys_address_area` VALUES (341021, 0, 100, 341000, '歙　县');
INSERT INTO `sys_address_area` VALUES (341022, 0, 100, 341000, '休宁县');
INSERT INTO `sys_address_area` VALUES (341023, 0, 100, 341000, '黟　县');
INSERT INTO `sys_address_area` VALUES (341024, 0, 100, 341000, '祁门县');
INSERT INTO `sys_address_area` VALUES (341101, 0, 100, 341100, '市辖区');
INSERT INTO `sys_address_area` VALUES (341102, 0, 100, 341100, '琅琊区');
INSERT INTO `sys_address_area` VALUES (341103, 0, 100, 341100, '南谯区');
INSERT INTO `sys_address_area` VALUES (341122, 0, 100, 341100, '来安县');
INSERT INTO `sys_address_area` VALUES (341124, 0, 100, 341100, '全椒县');
INSERT INTO `sys_address_area` VALUES (341125, 0, 100, 341100, '定远县');
INSERT INTO `sys_address_area` VALUES (341126, 0, 100, 341100, '凤阳县');
INSERT INTO `sys_address_area` VALUES (341181, 0, 100, 341100, '天长市');
INSERT INTO `sys_address_area` VALUES (341182, 0, 100, 341100, '明光市');
INSERT INTO `sys_address_area` VALUES (341201, 0, 100, 341200, '市辖区');
INSERT INTO `sys_address_area` VALUES (341202, 0, 100, 341200, '颍州区');
INSERT INTO `sys_address_area` VALUES (341203, 0, 100, 341200, '颍东区');
INSERT INTO `sys_address_area` VALUES (341204, 0, 100, 341200, '颍泉区');
INSERT INTO `sys_address_area` VALUES (341221, 0, 100, 341200, '临泉县');
INSERT INTO `sys_address_area` VALUES (341222, 0, 100, 341200, '太和县');
INSERT INTO `sys_address_area` VALUES (341225, 0, 100, 341200, '阜南县');
INSERT INTO `sys_address_area` VALUES (341226, 0, 100, 341200, '颍上县');
INSERT INTO `sys_address_area` VALUES (341282, 0, 100, 341200, '界首市');
INSERT INTO `sys_address_area` VALUES (341301, 0, 100, 341300, '市辖区');
INSERT INTO `sys_address_area` VALUES (341302, 0, 100, 341300, '墉桥区');
INSERT INTO `sys_address_area` VALUES (341321, 0, 100, 341300, '砀山县');
INSERT INTO `sys_address_area` VALUES (341322, 0, 100, 341300, '萧　县');
INSERT INTO `sys_address_area` VALUES (341323, 0, 100, 341300, '灵璧县');
INSERT INTO `sys_address_area` VALUES (341324, 0, 100, 341300, '泗　县');
INSERT INTO `sys_address_area` VALUES (341401, 0, 100, 341400, '市辖区');
INSERT INTO `sys_address_area` VALUES (341402, 0, 100, 341400, '居巢区');
INSERT INTO `sys_address_area` VALUES (341421, 0, 100, 341400, '庐江县');
INSERT INTO `sys_address_area` VALUES (341422, 0, 100, 341400, '无为县');
INSERT INTO `sys_address_area` VALUES (341423, 0, 100, 341400, '含山县');
INSERT INTO `sys_address_area` VALUES (341424, 0, 100, 341400, '和　县');
INSERT INTO `sys_address_area` VALUES (341501, 0, 100, 341500, '市辖区');
INSERT INTO `sys_address_area` VALUES (341502, 0, 100, 341500, '金安区');
INSERT INTO `sys_address_area` VALUES (341503, 0, 100, 341500, '裕安区');
INSERT INTO `sys_address_area` VALUES (341521, 0, 100, 341500, '寿　县');
INSERT INTO `sys_address_area` VALUES (341522, 0, 100, 341500, '霍邱县');
INSERT INTO `sys_address_area` VALUES (341523, 0, 100, 341500, '舒城县');
INSERT INTO `sys_address_area` VALUES (341524, 0, 100, 341500, '金寨县');
INSERT INTO `sys_address_area` VALUES (341525, 0, 100, 341500, '霍山县');
INSERT INTO `sys_address_area` VALUES (341601, 0, 100, 341600, '市辖区');
INSERT INTO `sys_address_area` VALUES (341602, 0, 100, 341600, '谯城区');
INSERT INTO `sys_address_area` VALUES (341621, 0, 100, 341600, '涡阳县');
INSERT INTO `sys_address_area` VALUES (341622, 0, 100, 341600, '蒙城县');
INSERT INTO `sys_address_area` VALUES (341623, 0, 100, 341600, '利辛县');
INSERT INTO `sys_address_area` VALUES (341701, 0, 100, 341700, '市辖区');
INSERT INTO `sys_address_area` VALUES (341702, 0, 100, 341700, '贵池区');
INSERT INTO `sys_address_area` VALUES (341721, 0, 100, 341700, '东至县');
INSERT INTO `sys_address_area` VALUES (341722, 0, 100, 341700, '石台县');
INSERT INTO `sys_address_area` VALUES (341723, 0, 100, 341700, '青阳县');
INSERT INTO `sys_address_area` VALUES (341801, 0, 100, 341800, '市辖区');
INSERT INTO `sys_address_area` VALUES (341802, 0, 100, 341800, '宣州区');
INSERT INTO `sys_address_area` VALUES (341821, 0, 100, 341800, '郎溪县');
INSERT INTO `sys_address_area` VALUES (341822, 0, 100, 341800, '广德县');
INSERT INTO `sys_address_area` VALUES (341823, 0, 100, 341800, '泾　县');
INSERT INTO `sys_address_area` VALUES (341824, 0, 100, 341800, '绩溪县');
INSERT INTO `sys_address_area` VALUES (341825, 0, 100, 341800, '旌德县');
INSERT INTO `sys_address_area` VALUES (341881, 0, 100, 341800, '宁国市');
INSERT INTO `sys_address_area` VALUES (350101, 0, 100, 350100, '市辖区');
INSERT INTO `sys_address_area` VALUES (350102, 0, 100, 350100, '鼓楼区');
INSERT INTO `sys_address_area` VALUES (350103, 0, 100, 350100, '台江区');
INSERT INTO `sys_address_area` VALUES (350104, 0, 100, 350100, '仓山区');
INSERT INTO `sys_address_area` VALUES (350105, 0, 100, 350100, '马尾区');
INSERT INTO `sys_address_area` VALUES (350111, 0, 100, 350100, '晋安区');
INSERT INTO `sys_address_area` VALUES (350121, 0, 100, 350100, '闽侯县');
INSERT INTO `sys_address_area` VALUES (350122, 0, 100, 350100, '连江县');
INSERT INTO `sys_address_area` VALUES (350123, 0, 100, 350100, '罗源县');
INSERT INTO `sys_address_area` VALUES (350124, 0, 100, 350100, '闽清县');
INSERT INTO `sys_address_area` VALUES (350125, 0, 100, 350100, '永泰县');
INSERT INTO `sys_address_area` VALUES (350128, 0, 100, 350100, '平潭县');
INSERT INTO `sys_address_area` VALUES (350181, 0, 100, 350100, '福清市');
INSERT INTO `sys_address_area` VALUES (350182, 0, 100, 350100, '长乐市');
INSERT INTO `sys_address_area` VALUES (350201, 0, 100, 350200, '市辖区');
INSERT INTO `sys_address_area` VALUES (350203, 0, 100, 350200, '思明区');
INSERT INTO `sys_address_area` VALUES (350205, 0, 100, 350200, '海沧区');
INSERT INTO `sys_address_area` VALUES (350206, 0, 100, 350200, '湖里区');
INSERT INTO `sys_address_area` VALUES (350211, 0, 100, 350200, '集美区');
INSERT INTO `sys_address_area` VALUES (350212, 0, 100, 350200, '同安区');
INSERT INTO `sys_address_area` VALUES (350213, 0, 100, 350200, '翔安区');
INSERT INTO `sys_address_area` VALUES (350301, 0, 100, 350300, '市辖区');
INSERT INTO `sys_address_area` VALUES (350302, 0, 100, 350300, '城厢区');
INSERT INTO `sys_address_area` VALUES (350303, 0, 100, 350300, '涵江区');
INSERT INTO `sys_address_area` VALUES (350304, 0, 100, 350300, '荔城区');
INSERT INTO `sys_address_area` VALUES (350305, 0, 100, 350300, '秀屿区');
INSERT INTO `sys_address_area` VALUES (350322, 0, 100, 350300, '仙游县');
INSERT INTO `sys_address_area` VALUES (350401, 0, 100, 350400, '市辖区');
INSERT INTO `sys_address_area` VALUES (350402, 0, 100, 350400, '梅列区');
INSERT INTO `sys_address_area` VALUES (350403, 0, 100, 350400, '三元区');
INSERT INTO `sys_address_area` VALUES (350421, 0, 100, 350400, '明溪县');
INSERT INTO `sys_address_area` VALUES (350423, 0, 100, 350400, '清流县');
INSERT INTO `sys_address_area` VALUES (350424, 0, 100, 350400, '宁化县');
INSERT INTO `sys_address_area` VALUES (350425, 0, 100, 350400, '大田县');
INSERT INTO `sys_address_area` VALUES (350426, 0, 100, 350400, '尤溪县');
INSERT INTO `sys_address_area` VALUES (350427, 0, 100, 350400, '沙　县');
INSERT INTO `sys_address_area` VALUES (350428, 0, 100, 350400, '将乐县');
INSERT INTO `sys_address_area` VALUES (350429, 0, 100, 350400, '泰宁县');
INSERT INTO `sys_address_area` VALUES (350430, 0, 100, 350400, '建宁县');
INSERT INTO `sys_address_area` VALUES (350481, 0, 100, 350400, '永安市');
INSERT INTO `sys_address_area` VALUES (350501, 0, 100, 350500, '市辖区');
INSERT INTO `sys_address_area` VALUES (350502, 0, 100, 350500, '鲤城区');
INSERT INTO `sys_address_area` VALUES (350503, 0, 100, 350500, '丰泽区');
INSERT INTO `sys_address_area` VALUES (350504, 0, 100, 350500, '洛江区');
INSERT INTO `sys_address_area` VALUES (350505, 0, 100, 350500, '泉港区');
INSERT INTO `sys_address_area` VALUES (350521, 0, 100, 350500, '惠安县');
INSERT INTO `sys_address_area` VALUES (350524, 0, 100, 350500, '安溪县');
INSERT INTO `sys_address_area` VALUES (350525, 0, 100, 350500, '永春县');
INSERT INTO `sys_address_area` VALUES (350526, 0, 100, 350500, '德化县');
INSERT INTO `sys_address_area` VALUES (350527, 0, 100, 350500, '金门县');
INSERT INTO `sys_address_area` VALUES (350581, 0, 100, 350500, '石狮市');
INSERT INTO `sys_address_area` VALUES (350582, 0, 100, 350500, '晋江市');
INSERT INTO `sys_address_area` VALUES (350583, 0, 100, 350500, '南安市');
INSERT INTO `sys_address_area` VALUES (350601, 0, 100, 350600, '市辖区');
INSERT INTO `sys_address_area` VALUES (350602, 0, 100, 350600, '芗城区');
INSERT INTO `sys_address_area` VALUES (350603, 0, 100, 350600, '龙文区');
INSERT INTO `sys_address_area` VALUES (350622, 0, 100, 350600, '云霄县');
INSERT INTO `sys_address_area` VALUES (350623, 0, 100, 350600, '漳浦县');
INSERT INTO `sys_address_area` VALUES (350624, 0, 100, 350600, '诏安县');
INSERT INTO `sys_address_area` VALUES (350625, 0, 100, 350600, '长泰县');
INSERT INTO `sys_address_area` VALUES (350626, 0, 100, 350600, '东山县');
INSERT INTO `sys_address_area` VALUES (350627, 0, 100, 350600, '南靖县');
INSERT INTO `sys_address_area` VALUES (350628, 0, 100, 350600, '平和县');
INSERT INTO `sys_address_area` VALUES (350629, 0, 100, 350600, '华安县');
INSERT INTO `sys_address_area` VALUES (350681, 0, 100, 350600, '龙海市');
INSERT INTO `sys_address_area` VALUES (350701, 0, 100, 350700, '市辖区');
INSERT INTO `sys_address_area` VALUES (350702, 0, 100, 350700, '延平区');
INSERT INTO `sys_address_area` VALUES (350721, 0, 100, 350700, '顺昌县');
INSERT INTO `sys_address_area` VALUES (350722, 0, 100, 350700, '浦城县');
INSERT INTO `sys_address_area` VALUES (350723, 0, 100, 350700, '光泽县');
INSERT INTO `sys_address_area` VALUES (350724, 0, 100, 350700, '松溪县');
INSERT INTO `sys_address_area` VALUES (350725, 0, 100, 350700, '政和县');
INSERT INTO `sys_address_area` VALUES (350781, 0, 100, 350700, '邵武市');
INSERT INTO `sys_address_area` VALUES (350782, 0, 100, 350700, '武夷山市');
INSERT INTO `sys_address_area` VALUES (350783, 0, 100, 350700, '建瓯市');
INSERT INTO `sys_address_area` VALUES (350784, 0, 100, 350700, '建阳市');
INSERT INTO `sys_address_area` VALUES (350801, 0, 100, 350800, '市辖区');
INSERT INTO `sys_address_area` VALUES (350802, 0, 100, 350800, '新罗区');
INSERT INTO `sys_address_area` VALUES (350821, 0, 100, 350800, '长汀县');
INSERT INTO `sys_address_area` VALUES (350822, 0, 100, 350800, '永定县');
INSERT INTO `sys_address_area` VALUES (350823, 0, 100, 350800, '上杭县');
INSERT INTO `sys_address_area` VALUES (350824, 0, 100, 350800, '武平县');
INSERT INTO `sys_address_area` VALUES (350825, 0, 100, 350800, '连城县');
INSERT INTO `sys_address_area` VALUES (350881, 0, 100, 350800, '漳平市');
INSERT INTO `sys_address_area` VALUES (350901, 0, 100, 350900, '市辖区');
INSERT INTO `sys_address_area` VALUES (350902, 0, 100, 350900, '蕉城区');
INSERT INTO `sys_address_area` VALUES (350921, 0, 100, 350900, '霞浦县');
INSERT INTO `sys_address_area` VALUES (350922, 0, 100, 350900, '古田县');
INSERT INTO `sys_address_area` VALUES (350923, 0, 100, 350900, '屏南县');
INSERT INTO `sys_address_area` VALUES (350924, 0, 100, 350900, '寿宁县');
INSERT INTO `sys_address_area` VALUES (350925, 0, 100, 350900, '周宁县');
INSERT INTO `sys_address_area` VALUES (350926, 0, 100, 350900, '柘荣县');
INSERT INTO `sys_address_area` VALUES (350981, 0, 100, 350900, '福安市');
INSERT INTO `sys_address_area` VALUES (350982, 0, 100, 350900, '福鼎市');
INSERT INTO `sys_address_area` VALUES (360101, 0, 100, 360100, '市辖区');
INSERT INTO `sys_address_area` VALUES (360102, 0, 100, 360100, '东湖区');
INSERT INTO `sys_address_area` VALUES (360103, 0, 100, 360100, '西湖区');
INSERT INTO `sys_address_area` VALUES (360104, 0, 100, 360100, '青云谱区');
INSERT INTO `sys_address_area` VALUES (360105, 0, 100, 360100, '湾里区');
INSERT INTO `sys_address_area` VALUES (360111, 0, 100, 360100, '青山湖区');
INSERT INTO `sys_address_area` VALUES (360121, 0, 100, 360100, '南昌县');
INSERT INTO `sys_address_area` VALUES (360122, 0, 100, 360100, '新建县');
INSERT INTO `sys_address_area` VALUES (360123, 0, 100, 360100, '安义县');
INSERT INTO `sys_address_area` VALUES (360124, 0, 100, 360100, '进贤县');
INSERT INTO `sys_address_area` VALUES (360201, 0, 100, 360200, '市辖区');
INSERT INTO `sys_address_area` VALUES (360202, 0, 100, 360200, '昌江区');
INSERT INTO `sys_address_area` VALUES (360203, 0, 100, 360200, '珠山区');
INSERT INTO `sys_address_area` VALUES (360222, 0, 100, 360200, '浮梁县');
INSERT INTO `sys_address_area` VALUES (360281, 0, 100, 360200, '乐平市');
INSERT INTO `sys_address_area` VALUES (360301, 0, 100, 360300, '市辖区');
INSERT INTO `sys_address_area` VALUES (360302, 0, 100, 360300, '安源区');
INSERT INTO `sys_address_area` VALUES (360313, 0, 100, 360300, '湘东区');
INSERT INTO `sys_address_area` VALUES (360321, 0, 100, 360300, '莲花县');
INSERT INTO `sys_address_area` VALUES (360322, 0, 100, 360300, '上栗县');
INSERT INTO `sys_address_area` VALUES (360323, 0, 100, 360300, '芦溪县');
INSERT INTO `sys_address_area` VALUES (360401, 0, 100, 360400, '市辖区');
INSERT INTO `sys_address_area` VALUES (360402, 0, 100, 360400, '庐山区');
INSERT INTO `sys_address_area` VALUES (360403, 0, 100, 360400, '浔阳区');
INSERT INTO `sys_address_area` VALUES (360421, 0, 100, 360400, '九江县');
INSERT INTO `sys_address_area` VALUES (360423, 0, 100, 360400, '武宁县');
INSERT INTO `sys_address_area` VALUES (360424, 0, 100, 360400, '修水县');
INSERT INTO `sys_address_area` VALUES (360425, 0, 100, 360400, '永修县');
INSERT INTO `sys_address_area` VALUES (360426, 0, 100, 360400, '德安县');
INSERT INTO `sys_address_area` VALUES (360427, 0, 100, 360400, '星子县');
INSERT INTO `sys_address_area` VALUES (360428, 0, 100, 360400, '都昌县');
INSERT INTO `sys_address_area` VALUES (360429, 0, 100, 360400, '湖口县');
INSERT INTO `sys_address_area` VALUES (360430, 0, 100, 360400, '彭泽县');
INSERT INTO `sys_address_area` VALUES (360481, 0, 100, 360400, '瑞昌市');
INSERT INTO `sys_address_area` VALUES (360501, 0, 100, 360500, '市辖区');
INSERT INTO `sys_address_area` VALUES (360502, 0, 100, 360500, '渝水区');
INSERT INTO `sys_address_area` VALUES (360521, 0, 100, 360500, '分宜县');
INSERT INTO `sys_address_area` VALUES (360601, 0, 100, 360600, '市辖区');
INSERT INTO `sys_address_area` VALUES (360602, 0, 100, 360600, '月湖区');
INSERT INTO `sys_address_area` VALUES (360622, 0, 100, 360600, '余江县');
INSERT INTO `sys_address_area` VALUES (360681, 0, 100, 360600, '贵溪市');
INSERT INTO `sys_address_area` VALUES (360701, 0, 100, 360700, '市辖区');
INSERT INTO `sys_address_area` VALUES (360702, 0, 100, 360700, '章贡区');
INSERT INTO `sys_address_area` VALUES (360721, 0, 100, 360700, '赣　县');
INSERT INTO `sys_address_area` VALUES (360722, 0, 100, 360700, '信丰县');
INSERT INTO `sys_address_area` VALUES (360723, 0, 100, 360700, '大余县');
INSERT INTO `sys_address_area` VALUES (360724, 0, 100, 360700, '上犹县');
INSERT INTO `sys_address_area` VALUES (360725, 0, 100, 360700, '崇义县');
INSERT INTO `sys_address_area` VALUES (360726, 0, 100, 360700, '安远县');
INSERT INTO `sys_address_area` VALUES (360727, 0, 100, 360700, '龙南县');
INSERT INTO `sys_address_area` VALUES (360728, 0, 100, 360700, '定南县');
INSERT INTO `sys_address_area` VALUES (360729, 0, 100, 360700, '全南县');
INSERT INTO `sys_address_area` VALUES (360730, 0, 100, 360700, '宁都县');
INSERT INTO `sys_address_area` VALUES (360731, 0, 100, 360700, '于都县');
INSERT INTO `sys_address_area` VALUES (360732, 0, 100, 360700, '兴国县');
INSERT INTO `sys_address_area` VALUES (360733, 0, 100, 360700, '会昌县');
INSERT INTO `sys_address_area` VALUES (360734, 0, 100, 360700, '寻乌县');
INSERT INTO `sys_address_area` VALUES (360735, 0, 100, 360700, '石城县');
INSERT INTO `sys_address_area` VALUES (360781, 0, 100, 360700, '瑞金市');
INSERT INTO `sys_address_area` VALUES (360782, 0, 100, 360700, '南康市');
INSERT INTO `sys_address_area` VALUES (360801, 0, 100, 360800, '市辖区');
INSERT INTO `sys_address_area` VALUES (360802, 0, 100, 360800, '吉州区');
INSERT INTO `sys_address_area` VALUES (360803, 0, 100, 360800, '青原区');
INSERT INTO `sys_address_area` VALUES (360821, 0, 100, 360800, '吉安县');
INSERT INTO `sys_address_area` VALUES (360822, 0, 100, 360800, '吉水县');
INSERT INTO `sys_address_area` VALUES (360823, 0, 100, 360800, '峡江县');
INSERT INTO `sys_address_area` VALUES (360824, 0, 100, 360800, '新干县');
INSERT INTO `sys_address_area` VALUES (360825, 0, 100, 360800, '永丰县');
INSERT INTO `sys_address_area` VALUES (360826, 0, 100, 360800, '泰和县');
INSERT INTO `sys_address_area` VALUES (360827, 0, 100, 360800, '遂川县');
INSERT INTO `sys_address_area` VALUES (360828, 0, 100, 360800, '万安县');
INSERT INTO `sys_address_area` VALUES (360829, 0, 100, 360800, '安福县');
INSERT INTO `sys_address_area` VALUES (360830, 0, 100, 360800, '永新县');
INSERT INTO `sys_address_area` VALUES (360881, 0, 100, 360800, '井冈山市');
INSERT INTO `sys_address_area` VALUES (360901, 0, 100, 360900, '市辖区');
INSERT INTO `sys_address_area` VALUES (360902, 0, 100, 360900, '袁州区');
INSERT INTO `sys_address_area` VALUES (360921, 0, 100, 360900, '奉新县');
INSERT INTO `sys_address_area` VALUES (360922, 0, 100, 360900, '万载县');
INSERT INTO `sys_address_area` VALUES (360923, 0, 100, 360900, '上高县');
INSERT INTO `sys_address_area` VALUES (360924, 0, 100, 360900, '宜丰县');
INSERT INTO `sys_address_area` VALUES (360925, 0, 100, 360900, '靖安县');
INSERT INTO `sys_address_area` VALUES (360926, 0, 100, 360900, '铜鼓县');
INSERT INTO `sys_address_area` VALUES (360981, 0, 100, 360900, '丰城市');
INSERT INTO `sys_address_area` VALUES (360982, 0, 100, 360900, '樟树市');
INSERT INTO `sys_address_area` VALUES (360983, 0, 100, 360900, '高安市');
INSERT INTO `sys_address_area` VALUES (361001, 0, 100, 361000, '市辖区');
INSERT INTO `sys_address_area` VALUES (361002, 0, 100, 361000, '临川区');
INSERT INTO `sys_address_area` VALUES (361021, 0, 100, 361000, '南城县');
INSERT INTO `sys_address_area` VALUES (361022, 0, 100, 361000, '黎川县');
INSERT INTO `sys_address_area` VALUES (361023, 0, 100, 361000, '南丰县');
INSERT INTO `sys_address_area` VALUES (361024, 0, 100, 361000, '崇仁县');
INSERT INTO `sys_address_area` VALUES (361025, 0, 100, 361000, '乐安县');
INSERT INTO `sys_address_area` VALUES (361026, 0, 100, 361000, '宜黄县');
INSERT INTO `sys_address_area` VALUES (361027, 0, 100, 361000, '金溪县');
INSERT INTO `sys_address_area` VALUES (361028, 0, 100, 361000, '资溪县');
INSERT INTO `sys_address_area` VALUES (361029, 0, 100, 361000, '东乡县');
INSERT INTO `sys_address_area` VALUES (361030, 0, 100, 361000, '广昌县');
INSERT INTO `sys_address_area` VALUES (361101, 0, 100, 361100, '市辖区');
INSERT INTO `sys_address_area` VALUES (361102, 0, 100, 361100, '信州区');
INSERT INTO `sys_address_area` VALUES (361121, 0, 100, 361100, '上饶县');
INSERT INTO `sys_address_area` VALUES (361122, 0, 100, 361100, '广丰县');
INSERT INTO `sys_address_area` VALUES (361123, 0, 100, 361100, '玉山县');
INSERT INTO `sys_address_area` VALUES (361124, 0, 100, 361100, '铅山县');
INSERT INTO `sys_address_area` VALUES (361125, 0, 100, 361100, '横峰县');
INSERT INTO `sys_address_area` VALUES (361126, 0, 100, 361100, '弋阳县');
INSERT INTO `sys_address_area` VALUES (361127, 0, 100, 361100, '余干县');
INSERT INTO `sys_address_area` VALUES (361128, 0, 100, 361100, '鄱阳县');
INSERT INTO `sys_address_area` VALUES (361129, 0, 100, 361100, '万年县');
INSERT INTO `sys_address_area` VALUES (361130, 0, 100, 361100, '婺源县');
INSERT INTO `sys_address_area` VALUES (361181, 0, 100, 361100, '德兴市');
INSERT INTO `sys_address_area` VALUES (370101, 0, 100, 370100, '市辖区');
INSERT INTO `sys_address_area` VALUES (370102, 0, 100, 370100, '历下区');
INSERT INTO `sys_address_area` VALUES (370103, 0, 100, 370100, '市中区');
INSERT INTO `sys_address_area` VALUES (370104, 0, 100, 370100, '槐荫区');
INSERT INTO `sys_address_area` VALUES (370105, 0, 100, 370100, '天桥区');
INSERT INTO `sys_address_area` VALUES (370112, 0, 100, 370100, '历城区');
INSERT INTO `sys_address_area` VALUES (370113, 0, 100, 370100, '长清区');
INSERT INTO `sys_address_area` VALUES (370124, 0, 100, 370100, '平阴县');
INSERT INTO `sys_address_area` VALUES (370125, 0, 100, 370100, '济阳县');
INSERT INTO `sys_address_area` VALUES (370126, 0, 100, 370100, '商河县');
INSERT INTO `sys_address_area` VALUES (370181, 0, 100, 370100, '章丘市');
INSERT INTO `sys_address_area` VALUES (370201, 0, 100, 370200, '市辖区');
INSERT INTO `sys_address_area` VALUES (370202, 0, 100, 370200, '市南区');
INSERT INTO `sys_address_area` VALUES (370203, 0, 100, 370200, '市北区');
INSERT INTO `sys_address_area` VALUES (370205, 0, 100, 370200, '四方区');
INSERT INTO `sys_address_area` VALUES (370211, 0, 100, 370200, '黄岛区');
INSERT INTO `sys_address_area` VALUES (370212, 0, 100, 370200, '崂山区');
INSERT INTO `sys_address_area` VALUES (370213, 0, 100, 370200, '李沧区');
INSERT INTO `sys_address_area` VALUES (370214, 0, 100, 370200, '城阳区');
INSERT INTO `sys_address_area` VALUES (370281, 0, 100, 370200, '胶州市');
INSERT INTO `sys_address_area` VALUES (370282, 0, 100, 370200, '即墨市');
INSERT INTO `sys_address_area` VALUES (370283, 0, 100, 370200, '平度市');
INSERT INTO `sys_address_area` VALUES (370284, 0, 100, 370200, '胶南市');
INSERT INTO `sys_address_area` VALUES (370285, 0, 100, 370200, '莱西市');
INSERT INTO `sys_address_area` VALUES (370301, 0, 100, 370300, '市辖区');
INSERT INTO `sys_address_area` VALUES (370302, 0, 100, 370300, '淄川区');
INSERT INTO `sys_address_area` VALUES (370303, 0, 100, 370300, '张店区');
INSERT INTO `sys_address_area` VALUES (370304, 0, 100, 370300, '博山区');
INSERT INTO `sys_address_area` VALUES (370305, 0, 100, 370300, '临淄区');
INSERT INTO `sys_address_area` VALUES (370306, 0, 100, 370300, '周村区');
INSERT INTO `sys_address_area` VALUES (370321, 0, 100, 370300, '桓台县');
INSERT INTO `sys_address_area` VALUES (370322, 0, 100, 370300, '高青县');
INSERT INTO `sys_address_area` VALUES (370323, 0, 100, 370300, '沂源县');
INSERT INTO `sys_address_area` VALUES (370401, 0, 100, 370400, '市辖区');
INSERT INTO `sys_address_area` VALUES (370402, 0, 100, 370400, '市中区');
INSERT INTO `sys_address_area` VALUES (370403, 0, 100, 370400, '薛城区');
INSERT INTO `sys_address_area` VALUES (370404, 0, 100, 370400, '峄城区');
INSERT INTO `sys_address_area` VALUES (370405, 0, 100, 370400, '台儿庄区');
INSERT INTO `sys_address_area` VALUES (370406, 0, 100, 370400, '山亭区');
INSERT INTO `sys_address_area` VALUES (370481, 0, 100, 370400, '滕州市');
INSERT INTO `sys_address_area` VALUES (370501, 0, 100, 370500, '市辖区');
INSERT INTO `sys_address_area` VALUES (370502, 0, 100, 370500, '东营区');
INSERT INTO `sys_address_area` VALUES (370503, 0, 100, 370500, '河口区');
INSERT INTO `sys_address_area` VALUES (370521, 0, 100, 370500, '垦利县');
INSERT INTO `sys_address_area` VALUES (370522, 0, 100, 370500, '利津县');
INSERT INTO `sys_address_area` VALUES (370523, 0, 100, 370500, '广饶县');
INSERT INTO `sys_address_area` VALUES (370601, 0, 100, 370600, '市辖区');
INSERT INTO `sys_address_area` VALUES (370602, 0, 100, 370600, '芝罘区');
INSERT INTO `sys_address_area` VALUES (370611, 0, 100, 370600, '福山区');
INSERT INTO `sys_address_area` VALUES (370612, 0, 100, 370600, '牟平区');
INSERT INTO `sys_address_area` VALUES (370613, 0, 100, 370600, '莱山区');
INSERT INTO `sys_address_area` VALUES (370634, 0, 100, 370600, '长岛县');
INSERT INTO `sys_address_area` VALUES (370681, 0, 100, 370600, '龙口市');
INSERT INTO `sys_address_area` VALUES (370682, 0, 100, 370600, '莱阳市');
INSERT INTO `sys_address_area` VALUES (370683, 0, 100, 370600, '莱州市');
INSERT INTO `sys_address_area` VALUES (370684, 0, 100, 370600, '蓬莱市');
INSERT INTO `sys_address_area` VALUES (370685, 0, 100, 370600, '招远市');
INSERT INTO `sys_address_area` VALUES (370686, 0, 100, 370600, '栖霞市');
INSERT INTO `sys_address_area` VALUES (370687, 0, 100, 370600, '海阳市');
INSERT INTO `sys_address_area` VALUES (370701, 0, 100, 370700, '市辖区');
INSERT INTO `sys_address_area` VALUES (370702, 0, 100, 370700, '潍城区');
INSERT INTO `sys_address_area` VALUES (370703, 0, 100, 370700, '寒亭区');
INSERT INTO `sys_address_area` VALUES (370704, 0, 100, 370700, '坊子区');
INSERT INTO `sys_address_area` VALUES (370705, 0, 100, 370700, '奎文区');
INSERT INTO `sys_address_area` VALUES (370724, 0, 100, 370700, '临朐县');
INSERT INTO `sys_address_area` VALUES (370725, 0, 100, 370700, '昌乐县');
INSERT INTO `sys_address_area` VALUES (370781, 0, 100, 370700, '青州市');
INSERT INTO `sys_address_area` VALUES (370782, 0, 100, 370700, '诸城市');
INSERT INTO `sys_address_area` VALUES (370783, 0, 100, 370700, '寿光市');
INSERT INTO `sys_address_area` VALUES (370784, 0, 100, 370700, '安丘市');
INSERT INTO `sys_address_area` VALUES (370785, 0, 100, 370700, '高密市');
INSERT INTO `sys_address_area` VALUES (370786, 0, 100, 370700, '昌邑市');
INSERT INTO `sys_address_area` VALUES (370801, 0, 100, 370800, '市辖区');
INSERT INTO `sys_address_area` VALUES (370802, 0, 100, 370800, '市中区');
INSERT INTO `sys_address_area` VALUES (370811, 0, 100, 370800, '任城区');
INSERT INTO `sys_address_area` VALUES (370826, 0, 100, 370800, '微山县');
INSERT INTO `sys_address_area` VALUES (370827, 0, 100, 370800, '鱼台县');
INSERT INTO `sys_address_area` VALUES (370828, 0, 100, 370800, '金乡县');
INSERT INTO `sys_address_area` VALUES (370829, 0, 100, 370800, '嘉祥县');
INSERT INTO `sys_address_area` VALUES (370830, 0, 100, 370800, '汶上县');
INSERT INTO `sys_address_area` VALUES (370831, 0, 100, 370800, '泗水县');
INSERT INTO `sys_address_area` VALUES (370832, 0, 100, 370800, '梁山县');
INSERT INTO `sys_address_area` VALUES (370881, 0, 100, 370800, '曲阜市');
INSERT INTO `sys_address_area` VALUES (370882, 0, 100, 370800, '兖州市');
INSERT INTO `sys_address_area` VALUES (370883, 0, 100, 370800, '邹城市');
INSERT INTO `sys_address_area` VALUES (370901, 0, 100, 370900, '市辖区');
INSERT INTO `sys_address_area` VALUES (370902, 0, 100, 370900, '泰山区');
INSERT INTO `sys_address_area` VALUES (370903, 0, 100, 370900, '岱岳区');
INSERT INTO `sys_address_area` VALUES (370921, 0, 100, 370900, '宁阳县');
INSERT INTO `sys_address_area` VALUES (370923, 0, 100, 370900, '东平县');
INSERT INTO `sys_address_area` VALUES (370982, 0, 100, 370900, '新泰市');
INSERT INTO `sys_address_area` VALUES (370983, 0, 100, 370900, '肥城市');
INSERT INTO `sys_address_area` VALUES (371001, 0, 100, 371000, '市辖区');
INSERT INTO `sys_address_area` VALUES (371002, 0, 100, 371000, '环翠区');
INSERT INTO `sys_address_area` VALUES (371081, 0, 100, 371000, '文登市');
INSERT INTO `sys_address_area` VALUES (371082, 0, 100, 371000, '荣成市');
INSERT INTO `sys_address_area` VALUES (371083, 0, 100, 371000, '乳山市');
INSERT INTO `sys_address_area` VALUES (371101, 0, 100, 371100, '市辖区');
INSERT INTO `sys_address_area` VALUES (371102, 0, 100, 371100, '东港区');
INSERT INTO `sys_address_area` VALUES (371103, 0, 100, 371100, '岚山区');
INSERT INTO `sys_address_area` VALUES (371121, 0, 100, 371100, '五莲县');
INSERT INTO `sys_address_area` VALUES (371122, 0, 100, 371100, '莒　县');
INSERT INTO `sys_address_area` VALUES (371201, 0, 100, 371200, '市辖区');
INSERT INTO `sys_address_area` VALUES (371202, 0, 100, 371200, '莱城区');
INSERT INTO `sys_address_area` VALUES (371203, 0, 100, 371200, '钢城区');
INSERT INTO `sys_address_area` VALUES (371301, 0, 100, 371300, '市辖区');
INSERT INTO `sys_address_area` VALUES (371302, 0, 100, 371300, '兰山区');
INSERT INTO `sys_address_area` VALUES (371311, 0, 100, 371300, '罗庄区');
INSERT INTO `sys_address_area` VALUES (371312, 0, 100, 371300, '河东区');
INSERT INTO `sys_address_area` VALUES (371321, 0, 100, 371300, '沂南县');
INSERT INTO `sys_address_area` VALUES (371322, 0, 100, 371300, '郯城县');
INSERT INTO `sys_address_area` VALUES (371323, 0, 100, 371300, '沂水县');
INSERT INTO `sys_address_area` VALUES (371324, 0, 100, 371300, '苍山县');
INSERT INTO `sys_address_area` VALUES (371325, 0, 100, 371300, '费　县');
INSERT INTO `sys_address_area` VALUES (371326, 0, 100, 371300, '平邑县');
INSERT INTO `sys_address_area` VALUES (371327, 0, 100, 371300, '莒南县');
INSERT INTO `sys_address_area` VALUES (371328, 0, 100, 371300, '蒙阴县');
INSERT INTO `sys_address_area` VALUES (371329, 0, 100, 371300, '临沭县');
INSERT INTO `sys_address_area` VALUES (371401, 0, 100, 371400, '市辖区');
INSERT INTO `sys_address_area` VALUES (371402, 0, 100, 371400, '德城区');
INSERT INTO `sys_address_area` VALUES (371421, 0, 100, 371400, '陵　县');
INSERT INTO `sys_address_area` VALUES (371422, 0, 100, 371400, '宁津县');
INSERT INTO `sys_address_area` VALUES (371423, 0, 100, 371400, '庆云县');
INSERT INTO `sys_address_area` VALUES (371424, 0, 100, 371400, '临邑县');
INSERT INTO `sys_address_area` VALUES (371425, 0, 100, 371400, '齐河县');
INSERT INTO `sys_address_area` VALUES (371426, 0, 100, 371400, '平原县');
INSERT INTO `sys_address_area` VALUES (371427, 0, 100, 371400, '夏津县');
INSERT INTO `sys_address_area` VALUES (371428, 0, 100, 371400, '武城县');
INSERT INTO `sys_address_area` VALUES (371481, 0, 100, 371400, '乐陵市');
INSERT INTO `sys_address_area` VALUES (371482, 0, 100, 371400, '禹城市');
INSERT INTO `sys_address_area` VALUES (371501, 0, 100, 371500, '市辖区');
INSERT INTO `sys_address_area` VALUES (371502, 0, 100, 371500, '东昌府区');
INSERT INTO `sys_address_area` VALUES (371521, 0, 100, 371500, '阳谷县');
INSERT INTO `sys_address_area` VALUES (371522, 0, 100, 371500, '莘　县');
INSERT INTO `sys_address_area` VALUES (371523, 0, 100, 371500, '茌平县');
INSERT INTO `sys_address_area` VALUES (371524, 0, 100, 371500, '东阿县');
INSERT INTO `sys_address_area` VALUES (371525, 0, 100, 371500, '冠　县');
INSERT INTO `sys_address_area` VALUES (371526, 0, 100, 371500, '高唐县');
INSERT INTO `sys_address_area` VALUES (371581, 0, 100, 371500, '临清市');
INSERT INTO `sys_address_area` VALUES (371601, 0, 100, 371600, '市辖区');
INSERT INTO `sys_address_area` VALUES (371602, 0, 100, 371600, '滨城区');
INSERT INTO `sys_address_area` VALUES (371621, 0, 100, 371600, '惠民县');
INSERT INTO `sys_address_area` VALUES (371622, 0, 100, 371600, '阳信县');
INSERT INTO `sys_address_area` VALUES (371623, 0, 100, 371600, '无棣县');
INSERT INTO `sys_address_area` VALUES (371624, 0, 100, 371600, '沾化县');
INSERT INTO `sys_address_area` VALUES (371625, 0, 100, 371600, '博兴县');
INSERT INTO `sys_address_area` VALUES (371626, 0, 100, 371600, '邹平县');
INSERT INTO `sys_address_area` VALUES (371701, 0, 100, 371700, '市辖区');
INSERT INTO `sys_address_area` VALUES (371702, 0, 100, 371700, '牡丹区');
INSERT INTO `sys_address_area` VALUES (371721, 0, 100, 371700, '曹　县');
INSERT INTO `sys_address_area` VALUES (371722, 0, 100, 371700, '单　县');
INSERT INTO `sys_address_area` VALUES (371723, 0, 100, 371700, '成武县');
INSERT INTO `sys_address_area` VALUES (371724, 0, 100, 371700, '巨野县');
INSERT INTO `sys_address_area` VALUES (371725, 0, 100, 371700, '郓城县');
INSERT INTO `sys_address_area` VALUES (371726, 0, 100, 371700, '鄄城县');
INSERT INTO `sys_address_area` VALUES (371727, 0, 100, 371700, '定陶县');
INSERT INTO `sys_address_area` VALUES (371728, 0, 100, 371700, '东明县');
INSERT INTO `sys_address_area` VALUES (410101, 0, 100, 410100, '市辖区');
INSERT INTO `sys_address_area` VALUES (410102, 0, 100, 410100, '中原区');
INSERT INTO `sys_address_area` VALUES (410103, 0, 100, 410100, '二七区');
INSERT INTO `sys_address_area` VALUES (410104, 0, 100, 410100, '管城回族区');
INSERT INTO `sys_address_area` VALUES (410105, 0, 100, 410100, '金水区');
INSERT INTO `sys_address_area` VALUES (410106, 0, 100, 410100, '上街区');
INSERT INTO `sys_address_area` VALUES (410108, 0, 100, 410100, '邙山区');
INSERT INTO `sys_address_area` VALUES (410122, 0, 100, 410100, '中牟县');
INSERT INTO `sys_address_area` VALUES (410181, 0, 100, 410100, '巩义市');
INSERT INTO `sys_address_area` VALUES (410182, 0, 100, 410100, '荥阳市');
INSERT INTO `sys_address_area` VALUES (410183, 0, 100, 410100, '新密市');
INSERT INTO `sys_address_area` VALUES (410184, 0, 100, 410100, '新郑市');
INSERT INTO `sys_address_area` VALUES (410185, 0, 100, 410100, '登封市');
INSERT INTO `sys_address_area` VALUES (410201, 0, 100, 410200, '市辖区');
INSERT INTO `sys_address_area` VALUES (410202, 0, 100, 410200, '龙亭区');
INSERT INTO `sys_address_area` VALUES (410203, 0, 100, 410200, '顺河回族区');
INSERT INTO `sys_address_area` VALUES (410204, 0, 100, 410200, '鼓楼区');
INSERT INTO `sys_address_area` VALUES (410205, 0, 100, 410200, '南关区');
INSERT INTO `sys_address_area` VALUES (410211, 0, 100, 410200, '郊　区');
INSERT INTO `sys_address_area` VALUES (410221, 0, 100, 410200, '杞　县');
INSERT INTO `sys_address_area` VALUES (410222, 0, 100, 410200, '通许县');
INSERT INTO `sys_address_area` VALUES (410223, 0, 100, 410200, '尉氏县');
INSERT INTO `sys_address_area` VALUES (410224, 0, 100, 410200, '开封县');
INSERT INTO `sys_address_area` VALUES (410225, 0, 100, 410200, '兰考县');
INSERT INTO `sys_address_area` VALUES (410301, 0, 100, 410300, '市辖区');
INSERT INTO `sys_address_area` VALUES (410302, 0, 100, 410300, '老城区');
INSERT INTO `sys_address_area` VALUES (410303, 0, 100, 410300, '西工区');
INSERT INTO `sys_address_area` VALUES (410304, 0, 100, 410300, '廛河回族区');
INSERT INTO `sys_address_area` VALUES (410305, 0, 100, 410300, '涧西区');
INSERT INTO `sys_address_area` VALUES (410306, 0, 100, 410300, '吉利区');
INSERT INTO `sys_address_area` VALUES (410307, 0, 100, 410300, '洛龙区');
INSERT INTO `sys_address_area` VALUES (410322, 0, 100, 410300, '孟津县');
INSERT INTO `sys_address_area` VALUES (410323, 0, 100, 410300, '新安县');
INSERT INTO `sys_address_area` VALUES (410324, 0, 100, 410300, '栾川县');
INSERT INTO `sys_address_area` VALUES (410325, 0, 100, 410300, '嵩　县');
INSERT INTO `sys_address_area` VALUES (410326, 0, 100, 410300, '汝阳县');
INSERT INTO `sys_address_area` VALUES (410327, 0, 100, 410300, '宜阳县');
INSERT INTO `sys_address_area` VALUES (410328, 0, 100, 410300, '洛宁县');
INSERT INTO `sys_address_area` VALUES (410329, 0, 100, 410300, '伊川县');
INSERT INTO `sys_address_area` VALUES (410381, 0, 100, 410300, '偃师市');
INSERT INTO `sys_address_area` VALUES (410401, 0, 100, 410400, '市辖区');
INSERT INTO `sys_address_area` VALUES (410402, 0, 100, 410400, '新华区');
INSERT INTO `sys_address_area` VALUES (410403, 0, 100, 410400, '卫东区');
INSERT INTO `sys_address_area` VALUES (410404, 0, 100, 410400, '石龙区');
INSERT INTO `sys_address_area` VALUES (410411, 0, 100, 410400, '湛河区');
INSERT INTO `sys_address_area` VALUES (410421, 0, 100, 410400, '宝丰县');
INSERT INTO `sys_address_area` VALUES (410422, 0, 100, 410400, '叶　县');
INSERT INTO `sys_address_area` VALUES (410423, 0, 100, 410400, '鲁山县');
INSERT INTO `sys_address_area` VALUES (410425, 0, 100, 410400, '郏　县');
INSERT INTO `sys_address_area` VALUES (410481, 0, 100, 410400, '舞钢市');
INSERT INTO `sys_address_area` VALUES (410482, 0, 100, 410400, '汝州市');
INSERT INTO `sys_address_area` VALUES (410501, 0, 100, 410500, '市辖区');
INSERT INTO `sys_address_area` VALUES (410502, 0, 100, 410500, '文峰区');
INSERT INTO `sys_address_area` VALUES (410503, 0, 100, 410500, '北关区');
INSERT INTO `sys_address_area` VALUES (410505, 0, 100, 410500, '殷都区');
INSERT INTO `sys_address_area` VALUES (410506, 0, 100, 410500, '龙安区');
INSERT INTO `sys_address_area` VALUES (410522, 0, 100, 410500, '安阳县');
INSERT INTO `sys_address_area` VALUES (410523, 0, 100, 410500, '汤阴县');
INSERT INTO `sys_address_area` VALUES (410526, 0, 100, 410500, '滑　县');
INSERT INTO `sys_address_area` VALUES (410527, 0, 100, 410500, '内黄县');
INSERT INTO `sys_address_area` VALUES (410581, 0, 100, 410500, '林州市');
INSERT INTO `sys_address_area` VALUES (410601, 0, 100, 410600, '市辖区');
INSERT INTO `sys_address_area` VALUES (410602, 0, 100, 410600, '鹤山区');
INSERT INTO `sys_address_area` VALUES (410603, 0, 100, 410600, '山城区');
INSERT INTO `sys_address_area` VALUES (410611, 0, 100, 410600, '淇滨区');
INSERT INTO `sys_address_area` VALUES (410621, 0, 100, 410600, '浚　县');
INSERT INTO `sys_address_area` VALUES (410622, 0, 100, 410600, '淇　县');
INSERT INTO `sys_address_area` VALUES (410701, 0, 100, 410700, '市辖区');
INSERT INTO `sys_address_area` VALUES (410702, 0, 100, 410700, '红旗区');
INSERT INTO `sys_address_area` VALUES (410703, 0, 100, 410700, '卫滨区');
INSERT INTO `sys_address_area` VALUES (410704, 0, 100, 410700, '凤泉区');
INSERT INTO `sys_address_area` VALUES (410711, 0, 100, 410700, '牧野区');
INSERT INTO `sys_address_area` VALUES (410721, 0, 100, 410700, '新乡县');
INSERT INTO `sys_address_area` VALUES (410724, 0, 100, 410700, '获嘉县');
INSERT INTO `sys_address_area` VALUES (410725, 0, 100, 410700, '原阳县');
INSERT INTO `sys_address_area` VALUES (410726, 0, 100, 410700, '延津县');
INSERT INTO `sys_address_area` VALUES (410727, 0, 100, 410700, '封丘县');
INSERT INTO `sys_address_area` VALUES (410728, 0, 100, 410700, '长垣县');
INSERT INTO `sys_address_area` VALUES (410781, 0, 100, 410700, '卫辉市');
INSERT INTO `sys_address_area` VALUES (410782, 0, 100, 410700, '辉县市');
INSERT INTO `sys_address_area` VALUES (410801, 0, 100, 410800, '市辖区');
INSERT INTO `sys_address_area` VALUES (410802, 0, 100, 410800, '解放区');
INSERT INTO `sys_address_area` VALUES (410803, 0, 100, 410800, '中站区');
INSERT INTO `sys_address_area` VALUES (410804, 0, 100, 410800, '马村区');
INSERT INTO `sys_address_area` VALUES (410811, 0, 100, 410800, '山阳区');
INSERT INTO `sys_address_area` VALUES (410821, 0, 100, 410800, '修武县');
INSERT INTO `sys_address_area` VALUES (410822, 0, 100, 410800, '博爱县');
INSERT INTO `sys_address_area` VALUES (410823, 0, 100, 410800, '武陟县');
INSERT INTO `sys_address_area` VALUES (410825, 0, 100, 410800, '温　县');
INSERT INTO `sys_address_area` VALUES (410881, 0, 100, 410800, '济源市');
INSERT INTO `sys_address_area` VALUES (410882, 0, 100, 410800, '沁阳市');
INSERT INTO `sys_address_area` VALUES (410883, 0, 100, 410800, '孟州市');
INSERT INTO `sys_address_area` VALUES (410901, 0, 100, 410900, '市辖区');
INSERT INTO `sys_address_area` VALUES (410902, 0, 100, 410900, '华龙区');
INSERT INTO `sys_address_area` VALUES (410922, 0, 100, 410900, '清丰县');
INSERT INTO `sys_address_area` VALUES (410923, 0, 100, 410900, '南乐县');
INSERT INTO `sys_address_area` VALUES (410926, 0, 100, 410900, '范　县');
INSERT INTO `sys_address_area` VALUES (410927, 0, 100, 410900, '台前县');
INSERT INTO `sys_address_area` VALUES (410928, 0, 100, 410900, '濮阳县');
INSERT INTO `sys_address_area` VALUES (411001, 0, 100, 411000, '市辖区');
INSERT INTO `sys_address_area` VALUES (411002, 0, 100, 411000, '魏都区');
INSERT INTO `sys_address_area` VALUES (411023, 0, 100, 411000, '许昌县');
INSERT INTO `sys_address_area` VALUES (411024, 0, 100, 411000, '鄢陵县');
INSERT INTO `sys_address_area` VALUES (411025, 0, 100, 411000, '襄城县');
INSERT INTO `sys_address_area` VALUES (411081, 0, 100, 411000, '禹州市');
INSERT INTO `sys_address_area` VALUES (411082, 0, 100, 411000, '长葛市');
INSERT INTO `sys_address_area` VALUES (411101, 0, 100, 411100, '市辖区');
INSERT INTO `sys_address_area` VALUES (411102, 0, 100, 411100, '源汇区');
INSERT INTO `sys_address_area` VALUES (411103, 0, 100, 411100, '郾城区');
INSERT INTO `sys_address_area` VALUES (411104, 0, 100, 411100, '召陵区');
INSERT INTO `sys_address_area` VALUES (411121, 0, 100, 411100, '舞阳县');
INSERT INTO `sys_address_area` VALUES (411122, 0, 100, 411100, '临颍县');
INSERT INTO `sys_address_area` VALUES (411201, 0, 100, 411200, '市辖区');
INSERT INTO `sys_address_area` VALUES (411202, 0, 100, 411200, '湖滨区');
INSERT INTO `sys_address_area` VALUES (411221, 0, 100, 411200, '渑池县');
INSERT INTO `sys_address_area` VALUES (411222, 0, 100, 411200, '陕　县');
INSERT INTO `sys_address_area` VALUES (411224, 0, 100, 411200, '卢氏县');
INSERT INTO `sys_address_area` VALUES (411281, 0, 100, 411200, '义马市');
INSERT INTO `sys_address_area` VALUES (411282, 0, 100, 411200, '灵宝市');
INSERT INTO `sys_address_area` VALUES (411301, 0, 100, 411300, '市辖区');
INSERT INTO `sys_address_area` VALUES (411302, 0, 100, 411300, '宛城区');
INSERT INTO `sys_address_area` VALUES (411303, 0, 100, 411300, '卧龙区');
INSERT INTO `sys_address_area` VALUES (411321, 0, 100, 411300, '南召县');
INSERT INTO `sys_address_area` VALUES (411322, 0, 100, 411300, '方城县');
INSERT INTO `sys_address_area` VALUES (411323, 0, 100, 411300, '西峡县');
INSERT INTO `sys_address_area` VALUES (411324, 0, 100, 411300, '镇平县');
INSERT INTO `sys_address_area` VALUES (411325, 0, 100, 411300, '内乡县');
INSERT INTO `sys_address_area` VALUES (411326, 0, 100, 411300, '淅川县');
INSERT INTO `sys_address_area` VALUES (411327, 0, 100, 411300, '社旗县');
INSERT INTO `sys_address_area` VALUES (411328, 0, 100, 411300, '唐河县');
INSERT INTO `sys_address_area` VALUES (411329, 0, 100, 411300, '新野县');
INSERT INTO `sys_address_area` VALUES (411330, 0, 100, 411300, '桐柏县');
INSERT INTO `sys_address_area` VALUES (411381, 0, 100, 411300, '邓州市');
INSERT INTO `sys_address_area` VALUES (411401, 0, 100, 411400, '市辖区');
INSERT INTO `sys_address_area` VALUES (411402, 0, 100, 411400, '梁园区');
INSERT INTO `sys_address_area` VALUES (411403, 0, 100, 411400, '睢阳区');
INSERT INTO `sys_address_area` VALUES (411421, 0, 100, 411400, '民权县');
INSERT INTO `sys_address_area` VALUES (411422, 0, 100, 411400, '睢　县');
INSERT INTO `sys_address_area` VALUES (411423, 0, 100, 411400, '宁陵县');
INSERT INTO `sys_address_area` VALUES (411424, 0, 100, 411400, '柘城县');
INSERT INTO `sys_address_area` VALUES (411425, 0, 100, 411400, '虞城县');
INSERT INTO `sys_address_area` VALUES (411426, 0, 100, 411400, '夏邑县');
INSERT INTO `sys_address_area` VALUES (411481, 0, 100, 411400, '永城市');
INSERT INTO `sys_address_area` VALUES (411501, 0, 100, 411500, '市辖区');
INSERT INTO `sys_address_area` VALUES (411502, 0, 100, 411500, '师河区');
INSERT INTO `sys_address_area` VALUES (411503, 0, 100, 411500, '平桥区');
INSERT INTO `sys_address_area` VALUES (411521, 0, 100, 411500, '罗山县');
INSERT INTO `sys_address_area` VALUES (411522, 0, 100, 411500, '光山县');
INSERT INTO `sys_address_area` VALUES (411523, 0, 100, 411500, '新　县');
INSERT INTO `sys_address_area` VALUES (411524, 0, 100, 411500, '商城县');
INSERT INTO `sys_address_area` VALUES (411525, 0, 100, 411500, '固始县');
INSERT INTO `sys_address_area` VALUES (411526, 0, 100, 411500, '潢川县');
INSERT INTO `sys_address_area` VALUES (411527, 0, 100, 411500, '淮滨县');
INSERT INTO `sys_address_area` VALUES (411528, 0, 100, 411500, '息　县');
INSERT INTO `sys_address_area` VALUES (411601, 0, 100, 411600, '市辖区');
INSERT INTO `sys_address_area` VALUES (411602, 0, 100, 411600, '川汇区');
INSERT INTO `sys_address_area` VALUES (411621, 0, 100, 411600, '扶沟县');
INSERT INTO `sys_address_area` VALUES (411622, 0, 100, 411600, '西华县');
INSERT INTO `sys_address_area` VALUES (411623, 0, 100, 411600, '商水县');
INSERT INTO `sys_address_area` VALUES (411624, 0, 100, 411600, '沈丘县');
INSERT INTO `sys_address_area` VALUES (411625, 0, 100, 411600, '郸城县');
INSERT INTO `sys_address_area` VALUES (411626, 0, 100, 411600, '淮阳县');
INSERT INTO `sys_address_area` VALUES (411627, 0, 100, 411600, '太康县');
INSERT INTO `sys_address_area` VALUES (411628, 0, 100, 411600, '鹿邑县');
INSERT INTO `sys_address_area` VALUES (411681, 0, 100, 411600, '项城市');
INSERT INTO `sys_address_area` VALUES (411701, 0, 100, 411700, '市辖区');
INSERT INTO `sys_address_area` VALUES (411702, 0, 100, 411700, '驿城区');
INSERT INTO `sys_address_area` VALUES (411721, 0, 100, 411700, '西平县');
INSERT INTO `sys_address_area` VALUES (411722, 0, 100, 411700, '上蔡县');
INSERT INTO `sys_address_area` VALUES (411723, 0, 100, 411700, '平舆县');
INSERT INTO `sys_address_area` VALUES (411724, 0, 100, 411700, '正阳县');
INSERT INTO `sys_address_area` VALUES (411725, 0, 100, 411700, '确山县');
INSERT INTO `sys_address_area` VALUES (411726, 0, 100, 411700, '泌阳县');
INSERT INTO `sys_address_area` VALUES (411727, 0, 100, 411700, '汝南县');
INSERT INTO `sys_address_area` VALUES (411728, 0, 100, 411700, '遂平县');
INSERT INTO `sys_address_area` VALUES (411729, 0, 100, 411700, '新蔡县');
INSERT INTO `sys_address_area` VALUES (420101, 0, 100, 420100, '市辖区');
INSERT INTO `sys_address_area` VALUES (420102, 0, 100, 420100, '江岸区');
INSERT INTO `sys_address_area` VALUES (420103, 0, 100, 420100, '江汉区');
INSERT INTO `sys_address_area` VALUES (420104, 0, 100, 420100, '乔口区');
INSERT INTO `sys_address_area` VALUES (420105, 0, 100, 420100, '汉阳区');
INSERT INTO `sys_address_area` VALUES (420106, 0, 100, 420100, '武昌区');
INSERT INTO `sys_address_area` VALUES (420107, 0, 100, 420100, '青山区');
INSERT INTO `sys_address_area` VALUES (420111, 0, 100, 420100, '洪山区');
INSERT INTO `sys_address_area` VALUES (420112, 0, 100, 420100, '东西湖区');
INSERT INTO `sys_address_area` VALUES (420113, 0, 100, 420100, '汉南区');
INSERT INTO `sys_address_area` VALUES (420114, 0, 100, 420100, '蔡甸区');
INSERT INTO `sys_address_area` VALUES (420115, 0, 100, 420100, '江夏区');
INSERT INTO `sys_address_area` VALUES (420116, 0, 100, 420100, '黄陂区');
INSERT INTO `sys_address_area` VALUES (420117, 0, 100, 420100, '新洲区');
INSERT INTO `sys_address_area` VALUES (420201, 0, 100, 420200, '市辖区');
INSERT INTO `sys_address_area` VALUES (420202, 0, 100, 420200, '黄石港区');
INSERT INTO `sys_address_area` VALUES (420203, 0, 100, 420200, '西塞山区');
INSERT INTO `sys_address_area` VALUES (420204, 0, 100, 420200, '下陆区');
INSERT INTO `sys_address_area` VALUES (420205, 0, 100, 420200, '铁山区');
INSERT INTO `sys_address_area` VALUES (420222, 0, 100, 420200, '阳新县');
INSERT INTO `sys_address_area` VALUES (420281, 0, 100, 420200, '大冶市');
INSERT INTO `sys_address_area` VALUES (420301, 0, 100, 420300, '市辖区');
INSERT INTO `sys_address_area` VALUES (420302, 0, 100, 420300, '茅箭区');
INSERT INTO `sys_address_area` VALUES (420303, 0, 100, 420300, '张湾区');
INSERT INTO `sys_address_area` VALUES (420321, 0, 100, 420300, '郧　县');
INSERT INTO `sys_address_area` VALUES (420322, 0, 100, 420300, '郧西县');
INSERT INTO `sys_address_area` VALUES (420323, 0, 100, 420300, '竹山县');
INSERT INTO `sys_address_area` VALUES (420324, 0, 100, 420300, '竹溪县');
INSERT INTO `sys_address_area` VALUES (420325, 0, 100, 420300, '房　县');
INSERT INTO `sys_address_area` VALUES (420381, 0, 100, 420300, '丹江口市');
INSERT INTO `sys_address_area` VALUES (420501, 0, 100, 420500, '市辖区');
INSERT INTO `sys_address_area` VALUES (420502, 0, 100, 420500, '西陵区');
INSERT INTO `sys_address_area` VALUES (420503, 0, 100, 420500, '伍家岗区');
INSERT INTO `sys_address_area` VALUES (420504, 0, 100, 420500, '点军区');
INSERT INTO `sys_address_area` VALUES (420505, 0, 100, 420500, '猇亭区');
INSERT INTO `sys_address_area` VALUES (420506, 0, 100, 420500, '夷陵区');
INSERT INTO `sys_address_area` VALUES (420525, 0, 100, 420500, '远安县');
INSERT INTO `sys_address_area` VALUES (420526, 0, 100, 420500, '兴山县');
INSERT INTO `sys_address_area` VALUES (420527, 0, 100, 420500, '秭归县');
INSERT INTO `sys_address_area` VALUES (420528, 0, 100, 420500, '长阳土家族自治县');
INSERT INTO `sys_address_area` VALUES (420529, 0, 100, 420500, '五峰土家族自治县');
INSERT INTO `sys_address_area` VALUES (420581, 0, 100, 420500, '宜都市');
INSERT INTO `sys_address_area` VALUES (420582, 0, 100, 420500, '当阳市');
INSERT INTO `sys_address_area` VALUES (420583, 0, 100, 420500, '枝江市');
INSERT INTO `sys_address_area` VALUES (420601, 0, 100, 420600, '市辖区');
INSERT INTO `sys_address_area` VALUES (420602, 0, 100, 420600, '襄城区');
INSERT INTO `sys_address_area` VALUES (420606, 0, 100, 420600, '樊城区');
INSERT INTO `sys_address_area` VALUES (420607, 0, 100, 420600, '襄阳区');
INSERT INTO `sys_address_area` VALUES (420624, 0, 100, 420600, '南漳县');
INSERT INTO `sys_address_area` VALUES (420625, 0, 100, 420600, '谷城县');
INSERT INTO `sys_address_area` VALUES (420626, 0, 100, 420600, '保康县');
INSERT INTO `sys_address_area` VALUES (420682, 0, 100, 420600, '老河口市');
INSERT INTO `sys_address_area` VALUES (420683, 0, 100, 420600, '枣阳市');
INSERT INTO `sys_address_area` VALUES (420684, 0, 100, 420600, '宜城市');
INSERT INTO `sys_address_area` VALUES (420701, 0, 100, 420700, '市辖区');
INSERT INTO `sys_address_area` VALUES (420702, 0, 100, 420700, '梁子湖区');
INSERT INTO `sys_address_area` VALUES (420703, 0, 100, 420700, '华容区');
INSERT INTO `sys_address_area` VALUES (420704, 0, 100, 420700, '鄂城区');
INSERT INTO `sys_address_area` VALUES (420801, 0, 100, 420800, '市辖区');
INSERT INTO `sys_address_area` VALUES (420802, 0, 100, 420800, '东宝区');
INSERT INTO `sys_address_area` VALUES (420804, 0, 100, 420800, '掇刀区');
INSERT INTO `sys_address_area` VALUES (420821, 0, 100, 420800, '京山县');
INSERT INTO `sys_address_area` VALUES (420822, 0, 100, 420800, '沙洋县');
INSERT INTO `sys_address_area` VALUES (420881, 0, 100, 420800, '钟祥市');
INSERT INTO `sys_address_area` VALUES (420901, 0, 100, 420900, '市辖区');
INSERT INTO `sys_address_area` VALUES (420902, 0, 100, 420900, '孝南区');
INSERT INTO `sys_address_area` VALUES (420921, 0, 100, 420900, '孝昌县');
INSERT INTO `sys_address_area` VALUES (420922, 0, 100, 420900, '大悟县');
INSERT INTO `sys_address_area` VALUES (420923, 0, 100, 420900, '云梦县');
INSERT INTO `sys_address_area` VALUES (420981, 0, 100, 420900, '应城市');
INSERT INTO `sys_address_area` VALUES (420982, 0, 100, 420900, '安陆市');
INSERT INTO `sys_address_area` VALUES (420984, 0, 100, 420900, '汉川市');
INSERT INTO `sys_address_area` VALUES (421001, 0, 100, 421000, '市辖区');
INSERT INTO `sys_address_area` VALUES (421002, 0, 100, 421000, '沙市区');
INSERT INTO `sys_address_area` VALUES (421003, 0, 100, 421000, '荆州区');
INSERT INTO `sys_address_area` VALUES (421022, 0, 100, 421000, '公安县');
INSERT INTO `sys_address_area` VALUES (421023, 0, 100, 421000, '监利县');
INSERT INTO `sys_address_area` VALUES (421024, 0, 100, 421000, '江陵县');
INSERT INTO `sys_address_area` VALUES (421081, 0, 100, 421000, '石首市');
INSERT INTO `sys_address_area` VALUES (421083, 0, 100, 421000, '洪湖市');
INSERT INTO `sys_address_area` VALUES (421087, 0, 100, 421000, '松滋市');
INSERT INTO `sys_address_area` VALUES (421101, 0, 100, 421100, '市辖区');
INSERT INTO `sys_address_area` VALUES (421102, 0, 100, 421100, '黄州区');
INSERT INTO `sys_address_area` VALUES (421121, 0, 100, 421100, '团风县');
INSERT INTO `sys_address_area` VALUES (421122, 0, 100, 421100, '红安县');
INSERT INTO `sys_address_area` VALUES (421123, 0, 100, 421100, '罗田县');
INSERT INTO `sys_address_area` VALUES (421124, 0, 100, 421100, '英山县');
INSERT INTO `sys_address_area` VALUES (421125, 0, 100, 421100, '浠水县');
INSERT INTO `sys_address_area` VALUES (421126, 0, 100, 421100, '蕲春县');
INSERT INTO `sys_address_area` VALUES (421127, 0, 100, 421100, '黄梅县');
INSERT INTO `sys_address_area` VALUES (421181, 0, 100, 421100, '麻城市');
INSERT INTO `sys_address_area` VALUES (421182, 0, 100, 421100, '武穴市');
INSERT INTO `sys_address_area` VALUES (421201, 0, 100, 421200, '市辖区');
INSERT INTO `sys_address_area` VALUES (421202, 0, 100, 421200, '咸安区');
INSERT INTO `sys_address_area` VALUES (421221, 0, 100, 421200, '嘉鱼县');
INSERT INTO `sys_address_area` VALUES (421222, 0, 100, 421200, '通城县');
INSERT INTO `sys_address_area` VALUES (421223, 0, 100, 421200, '崇阳县');
INSERT INTO `sys_address_area` VALUES (421224, 0, 100, 421200, '通山县');
INSERT INTO `sys_address_area` VALUES (421281, 0, 100, 421200, '赤壁市');
INSERT INTO `sys_address_area` VALUES (421301, 0, 100, 421300, '市辖区');
INSERT INTO `sys_address_area` VALUES (421302, 0, 100, 421300, '曾都区');
INSERT INTO `sys_address_area` VALUES (421381, 0, 100, 421300, '广水市');
INSERT INTO `sys_address_area` VALUES (422801, 0, 100, 422800, '恩施市');
INSERT INTO `sys_address_area` VALUES (422802, 0, 100, 422800, '利川市');
INSERT INTO `sys_address_area` VALUES (422822, 0, 100, 422800, '建始县');
INSERT INTO `sys_address_area` VALUES (422823, 0, 100, 422800, '巴东县');
INSERT INTO `sys_address_area` VALUES (422825, 0, 100, 422800, '宣恩县');
INSERT INTO `sys_address_area` VALUES (422826, 0, 100, 422800, '咸丰县');
INSERT INTO `sys_address_area` VALUES (422827, 0, 100, 422800, '来凤县');
INSERT INTO `sys_address_area` VALUES (422828, 0, 100, 422800, '鹤峰县');
INSERT INTO `sys_address_area` VALUES (429004, 0, 100, 429000, '仙桃市');
INSERT INTO `sys_address_area` VALUES (429005, 0, 100, 429000, '潜江市');
INSERT INTO `sys_address_area` VALUES (429006, 0, 100, 429000, '天门市');
INSERT INTO `sys_address_area` VALUES (429021, 0, 100, 429000, '神农架林区');
INSERT INTO `sys_address_area` VALUES (430101, 0, 100, 430100, '市辖区');
INSERT INTO `sys_address_area` VALUES (430102, 0, 100, 430100, '芙蓉区');
INSERT INTO `sys_address_area` VALUES (430103, 0, 100, 430100, '天心区');
INSERT INTO `sys_address_area` VALUES (430104, 0, 100, 430100, '岳麓区');
INSERT INTO `sys_address_area` VALUES (430105, 0, 100, 430100, '开福区');
INSERT INTO `sys_address_area` VALUES (430111, 0, 100, 430100, '雨花区');
INSERT INTO `sys_address_area` VALUES (430121, 0, 100, 430100, '长沙县');
INSERT INTO `sys_address_area` VALUES (430122, 0, 100, 430100, '望城县');
INSERT INTO `sys_address_area` VALUES (430124, 0, 100, 430100, '宁乡县');
INSERT INTO `sys_address_area` VALUES (430181, 0, 100, 430100, '浏阳市');
INSERT INTO `sys_address_area` VALUES (430201, 0, 100, 430200, '市辖区');
INSERT INTO `sys_address_area` VALUES (430202, 0, 100, 430200, '荷塘区');
INSERT INTO `sys_address_area` VALUES (430203, 0, 100, 430200, '芦淞区');
INSERT INTO `sys_address_area` VALUES (430204, 0, 100, 430200, '石峰区');
INSERT INTO `sys_address_area` VALUES (430211, 0, 100, 430200, '天元区');
INSERT INTO `sys_address_area` VALUES (430221, 0, 100, 430200, '株洲县');
INSERT INTO `sys_address_area` VALUES (430223, 0, 100, 430200, '攸　县');
INSERT INTO `sys_address_area` VALUES (430224, 0, 100, 430200, '茶陵县');
INSERT INTO `sys_address_area` VALUES (430225, 0, 100, 430200, '炎陵县');
INSERT INTO `sys_address_area` VALUES (430281, 0, 100, 430200, '醴陵市');
INSERT INTO `sys_address_area` VALUES (430301, 0, 100, 430300, '市辖区');
INSERT INTO `sys_address_area` VALUES (430302, 0, 100, 430300, '雨湖区');
INSERT INTO `sys_address_area` VALUES (430304, 0, 100, 430300, '岳塘区');
INSERT INTO `sys_address_area` VALUES (430321, 0, 100, 430300, '湘潭县');
INSERT INTO `sys_address_area` VALUES (430381, 0, 100, 430300, '湘乡市');
INSERT INTO `sys_address_area` VALUES (430382, 0, 100, 430300, '韶山市');
INSERT INTO `sys_address_area` VALUES (430401, 0, 100, 430400, '市辖区');
INSERT INTO `sys_address_area` VALUES (430405, 0, 100, 430400, '珠晖区');
INSERT INTO `sys_address_area` VALUES (430406, 0, 100, 430400, '雁峰区');
INSERT INTO `sys_address_area` VALUES (430407, 0, 100, 430400, '石鼓区');
INSERT INTO `sys_address_area` VALUES (430408, 0, 100, 430400, '蒸湘区');
INSERT INTO `sys_address_area` VALUES (430412, 0, 100, 430400, '南岳区');
INSERT INTO `sys_address_area` VALUES (430421, 0, 100, 430400, '衡阳县');
INSERT INTO `sys_address_area` VALUES (430422, 0, 100, 430400, '衡南县');
INSERT INTO `sys_address_area` VALUES (430423, 0, 100, 430400, '衡山县');
INSERT INTO `sys_address_area` VALUES (430424, 0, 100, 430400, '衡东县');
INSERT INTO `sys_address_area` VALUES (430426, 0, 100, 430400, '祁东县');
INSERT INTO `sys_address_area` VALUES (430481, 0, 100, 430400, '耒阳市');
INSERT INTO `sys_address_area` VALUES (430482, 0, 100, 430400, '常宁市');
INSERT INTO `sys_address_area` VALUES (430501, 0, 100, 430500, '市辖区');
INSERT INTO `sys_address_area` VALUES (430502, 0, 100, 430500, '双清区');
INSERT INTO `sys_address_area` VALUES (430503, 0, 100, 430500, '大祥区');
INSERT INTO `sys_address_area` VALUES (430511, 0, 100, 430500, '北塔区');
INSERT INTO `sys_address_area` VALUES (430521, 0, 100, 430500, '邵东县');
INSERT INTO `sys_address_area` VALUES (430522, 0, 100, 430500, '新邵县');
INSERT INTO `sys_address_area` VALUES (430523, 0, 100, 430500, '邵阳县');
INSERT INTO `sys_address_area` VALUES (430524, 0, 100, 430500, '隆回县');
INSERT INTO `sys_address_area` VALUES (430525, 0, 100, 430500, '洞口县');
INSERT INTO `sys_address_area` VALUES (430527, 0, 100, 430500, '绥宁县');
INSERT INTO `sys_address_area` VALUES (430528, 0, 100, 430500, '新宁县');
INSERT INTO `sys_address_area` VALUES (430529, 0, 100, 430500, '城步苗族自治县');
INSERT INTO `sys_address_area` VALUES (430581, 0, 100, 430500, '武冈市');
INSERT INTO `sys_address_area` VALUES (430601, 0, 100, 430600, '市辖区');
INSERT INTO `sys_address_area` VALUES (430602, 0, 100, 430600, '岳阳楼区');
INSERT INTO `sys_address_area` VALUES (430603, 0, 100, 430600, '云溪区');
INSERT INTO `sys_address_area` VALUES (430611, 0, 100, 430600, '君山区');
INSERT INTO `sys_address_area` VALUES (430621, 0, 100, 430600, '岳阳县');
INSERT INTO `sys_address_area` VALUES (430623, 0, 100, 430600, '华容县');
INSERT INTO `sys_address_area` VALUES (430624, 0, 100, 430600, '湘阴县');
INSERT INTO `sys_address_area` VALUES (430626, 0, 100, 430600, '平江县');
INSERT INTO `sys_address_area` VALUES (430681, 0, 100, 430600, '汨罗市');
INSERT INTO `sys_address_area` VALUES (430682, 0, 100, 430600, '临湘市');
INSERT INTO `sys_address_area` VALUES (430701, 0, 100, 430700, '市辖区');
INSERT INTO `sys_address_area` VALUES (430702, 0, 100, 430700, '武陵区');
INSERT INTO `sys_address_area` VALUES (430703, 0, 100, 430700, '鼎城区');
INSERT INTO `sys_address_area` VALUES (430721, 0, 100, 430700, '安乡县');
INSERT INTO `sys_address_area` VALUES (430722, 0, 100, 430700, '汉寿县');
INSERT INTO `sys_address_area` VALUES (430723, 0, 100, 430700, '澧　县');
INSERT INTO `sys_address_area` VALUES (430724, 0, 100, 430700, '临澧县');
INSERT INTO `sys_address_area` VALUES (430725, 0, 100, 430700, '桃源县');
INSERT INTO `sys_address_area` VALUES (430726, 0, 100, 430700, '石门县');
INSERT INTO `sys_address_area` VALUES (430781, 0, 100, 430700, '津市市');
INSERT INTO `sys_address_area` VALUES (430801, 0, 100, 430800, '市辖区');
INSERT INTO `sys_address_area` VALUES (430802, 0, 100, 430800, '永定区');
INSERT INTO `sys_address_area` VALUES (430811, 0, 100, 430800, '武陵源区');
INSERT INTO `sys_address_area` VALUES (430821, 0, 100, 430800, '慈利县');
INSERT INTO `sys_address_area` VALUES (430822, 0, 100, 430800, '桑植县');
INSERT INTO `sys_address_area` VALUES (430901, 0, 100, 430900, '市辖区');
INSERT INTO `sys_address_area` VALUES (430902, 0, 100, 430900, '资阳区');
INSERT INTO `sys_address_area` VALUES (430903, 0, 100, 430900, '赫山区');
INSERT INTO `sys_address_area` VALUES (430921, 0, 100, 430900, '南　县');
INSERT INTO `sys_address_area` VALUES (430922, 0, 100, 430900, '桃江县');
INSERT INTO `sys_address_area` VALUES (430923, 0, 100, 430900, '安化县');
INSERT INTO `sys_address_area` VALUES (430981, 0, 100, 430900, '沅江市');
INSERT INTO `sys_address_area` VALUES (431001, 0, 100, 431000, '市辖区');
INSERT INTO `sys_address_area` VALUES (431002, 0, 100, 431000, '北湖区');
INSERT INTO `sys_address_area` VALUES (431003, 0, 100, 431000, '苏仙区');
INSERT INTO `sys_address_area` VALUES (431021, 0, 100, 431000, '桂阳县');
INSERT INTO `sys_address_area` VALUES (431022, 0, 100, 431000, '宜章县');
INSERT INTO `sys_address_area` VALUES (431023, 0, 100, 431000, '永兴县');
INSERT INTO `sys_address_area` VALUES (431024, 0, 100, 431000, '嘉禾县');
INSERT INTO `sys_address_area` VALUES (431025, 0, 100, 431000, '临武县');
INSERT INTO `sys_address_area` VALUES (431026, 0, 100, 431000, '汝城县');
INSERT INTO `sys_address_area` VALUES (431027, 0, 100, 431000, '桂东县');
INSERT INTO `sys_address_area` VALUES (431028, 0, 100, 431000, '安仁县');
INSERT INTO `sys_address_area` VALUES (431081, 0, 100, 431000, '资兴市');
INSERT INTO `sys_address_area` VALUES (431101, 0, 100, 431100, '市辖区');
INSERT INTO `sys_address_area` VALUES (431102, 0, 100, 431100, '芝山区');
INSERT INTO `sys_address_area` VALUES (431103, 0, 100, 431100, '冷水滩区');
INSERT INTO `sys_address_area` VALUES (431121, 0, 100, 431100, '祁阳县');
INSERT INTO `sys_address_area` VALUES (431122, 0, 100, 431100, '东安县');
INSERT INTO `sys_address_area` VALUES (431123, 0, 100, 431100, '双牌县');
INSERT INTO `sys_address_area` VALUES (431124, 0, 100, 431100, '道　县');
INSERT INTO `sys_address_area` VALUES (431125, 0, 100, 431100, '江永县');
INSERT INTO `sys_address_area` VALUES (431126, 0, 100, 431100, '宁远县');
INSERT INTO `sys_address_area` VALUES (431127, 0, 100, 431100, '蓝山县');
INSERT INTO `sys_address_area` VALUES (431128, 0, 100, 431100, '新田县');
INSERT INTO `sys_address_area` VALUES (431129, 0, 100, 431100, '江华瑶族自治县');
INSERT INTO `sys_address_area` VALUES (431201, 0, 100, 431200, '市辖区');
INSERT INTO `sys_address_area` VALUES (431202, 0, 100, 431200, '鹤城区');
INSERT INTO `sys_address_area` VALUES (431221, 0, 100, 431200, '中方县');
INSERT INTO `sys_address_area` VALUES (431222, 0, 100, 431200, '沅陵县');
INSERT INTO `sys_address_area` VALUES (431223, 0, 100, 431200, '辰溪县');
INSERT INTO `sys_address_area` VALUES (431224, 0, 100, 431200, '溆浦县');
INSERT INTO `sys_address_area` VALUES (431225, 0, 100, 431200, '会同县');
INSERT INTO `sys_address_area` VALUES (431226, 0, 100, 431200, '麻阳苗族自治县');
INSERT INTO `sys_address_area` VALUES (431227, 0, 100, 431200, '新晃侗族自治县');
INSERT INTO `sys_address_area` VALUES (431228, 0, 100, 431200, '芷江侗族自治县');
INSERT INTO `sys_address_area` VALUES (431229, 0, 100, 431200, '靖州苗族侗族自治县');
INSERT INTO `sys_address_area` VALUES (431230, 0, 100, 431200, '通道侗族自治县');
INSERT INTO `sys_address_area` VALUES (431281, 0, 100, 431200, '洪江市');
INSERT INTO `sys_address_area` VALUES (431301, 0, 100, 431300, '市辖区');
INSERT INTO `sys_address_area` VALUES (431302, 0, 100, 431300, '娄星区');
INSERT INTO `sys_address_area` VALUES (431321, 0, 100, 431300, '双峰县');
INSERT INTO `sys_address_area` VALUES (431322, 0, 100, 431300, '新化县');
INSERT INTO `sys_address_area` VALUES (431381, 0, 100, 431300, '冷水江市');
INSERT INTO `sys_address_area` VALUES (431382, 0, 100, 431300, '涟源市');
INSERT INTO `sys_address_area` VALUES (433101, 0, 100, 433100, '吉首市');
INSERT INTO `sys_address_area` VALUES (433122, 0, 100, 433100, '泸溪县');
INSERT INTO `sys_address_area` VALUES (433123, 0, 100, 433100, '凤凰县');
INSERT INTO `sys_address_area` VALUES (433124, 0, 100, 433100, '花垣县');
INSERT INTO `sys_address_area` VALUES (433125, 0, 100, 433100, '保靖县');
INSERT INTO `sys_address_area` VALUES (433126, 0, 100, 433100, '古丈县');
INSERT INTO `sys_address_area` VALUES (433127, 0, 100, 433100, '永顺县');
INSERT INTO `sys_address_area` VALUES (433130, 0, 100, 433100, '龙山县');
INSERT INTO `sys_address_area` VALUES (440101, 0, 100, 440100, '市辖区');
INSERT INTO `sys_address_area` VALUES (440102, 0, 100, 440100, '东山区');
INSERT INTO `sys_address_area` VALUES (440103, 0, 100, 440100, '荔湾区');
INSERT INTO `sys_address_area` VALUES (440104, 0, 100, 440100, '越秀区');
INSERT INTO `sys_address_area` VALUES (440105, 0, 100, 440100, '海珠区');
INSERT INTO `sys_address_area` VALUES (440106, 0, 100, 440100, '天河区');
INSERT INTO `sys_address_area` VALUES (440107, 0, 100, 440100, '芳村区');
INSERT INTO `sys_address_area` VALUES (440111, 0, 100, 440100, '白云区');
INSERT INTO `sys_address_area` VALUES (440112, 0, 100, 440100, '黄埔区');
INSERT INTO `sys_address_area` VALUES (440113, 0, 100, 440100, '番禺区');
INSERT INTO `sys_address_area` VALUES (440114, 0, 100, 440100, '花都区');
INSERT INTO `sys_address_area` VALUES (440183, 0, 100, 440100, '增城市');
INSERT INTO `sys_address_area` VALUES (440184, 0, 100, 440100, '从化市');
INSERT INTO `sys_address_area` VALUES (440201, 0, 100, 440200, '市辖区');
INSERT INTO `sys_address_area` VALUES (440203, 0, 100, 440200, '武江区');
INSERT INTO `sys_address_area` VALUES (440204, 0, 100, 440200, '浈江区');
INSERT INTO `sys_address_area` VALUES (440205, 0, 100, 440200, '曲江区');
INSERT INTO `sys_address_area` VALUES (440222, 0, 100, 440200, '始兴县');
INSERT INTO `sys_address_area` VALUES (440224, 0, 100, 440200, '仁化县');
INSERT INTO `sys_address_area` VALUES (440229, 0, 100, 440200, '翁源县');
INSERT INTO `sys_address_area` VALUES (440232, 0, 100, 440200, '乳源瑶族自治县');
INSERT INTO `sys_address_area` VALUES (440233, 0, 100, 440200, '新丰县');
INSERT INTO `sys_address_area` VALUES (440281, 0, 100, 440200, '乐昌市');
INSERT INTO `sys_address_area` VALUES (440282, 0, 100, 440200, '南雄市');
INSERT INTO `sys_address_area` VALUES (440301, 0, 100, 440300, '市辖区');
INSERT INTO `sys_address_area` VALUES (440303, 0, 100, 440300, '罗湖区');
INSERT INTO `sys_address_area` VALUES (440304, 0, 100, 440300, '福田区');
INSERT INTO `sys_address_area` VALUES (440305, 0, 100, 440300, '南山区');
INSERT INTO `sys_address_area` VALUES (440306, 0, 100, 440300, '宝安区');
INSERT INTO `sys_address_area` VALUES (440307, 0, 100, 440300, '龙岗区');
INSERT INTO `sys_address_area` VALUES (440308, 0, 100, 440300, '盐田区');
INSERT INTO `sys_address_area` VALUES (440401, 0, 100, 440400, '市辖区');
INSERT INTO `sys_address_area` VALUES (440402, 0, 100, 440400, '香洲区');
INSERT INTO `sys_address_area` VALUES (440403, 0, 100, 440400, '斗门区');
INSERT INTO `sys_address_area` VALUES (440404, 0, 100, 440400, '金湾区');
INSERT INTO `sys_address_area` VALUES (440501, 0, 100, 440500, '市辖区');
INSERT INTO `sys_address_area` VALUES (440507, 0, 100, 440500, '龙湖区');
INSERT INTO `sys_address_area` VALUES (440511, 0, 100, 440500, '金平区');
INSERT INTO `sys_address_area` VALUES (440512, 0, 100, 440500, '濠江区');
INSERT INTO `sys_address_area` VALUES (440513, 0, 100, 440500, '潮阳区');
INSERT INTO `sys_address_area` VALUES (440514, 0, 100, 440500, '潮南区');
INSERT INTO `sys_address_area` VALUES (440515, 0, 100, 440500, '澄海区');
INSERT INTO `sys_address_area` VALUES (440523, 0, 100, 440500, '南澳县');
INSERT INTO `sys_address_area` VALUES (440601, 0, 100, 440600, '市辖区');
INSERT INTO `sys_address_area` VALUES (440604, 0, 100, 440600, '禅城区');
INSERT INTO `sys_address_area` VALUES (440605, 0, 100, 440600, '南海区');
INSERT INTO `sys_address_area` VALUES (440606, 0, 100, 440600, '顺德区');
INSERT INTO `sys_address_area` VALUES (440607, 0, 100, 440600, '三水区');
INSERT INTO `sys_address_area` VALUES (440608, 0, 100, 440600, '高明区');
INSERT INTO `sys_address_area` VALUES (440701, 0, 100, 440700, '市辖区');
INSERT INTO `sys_address_area` VALUES (440703, 0, 100, 440700, '蓬江区');
INSERT INTO `sys_address_area` VALUES (440704, 0, 100, 440700, '江海区');
INSERT INTO `sys_address_area` VALUES (440705, 0, 100, 440700, '新会区');
INSERT INTO `sys_address_area` VALUES (440781, 0, 100, 440700, '台山市');
INSERT INTO `sys_address_area` VALUES (440783, 0, 100, 440700, '开平市');
INSERT INTO `sys_address_area` VALUES (440784, 0, 100, 440700, '鹤山市');
INSERT INTO `sys_address_area` VALUES (440785, 0, 100, 440700, '恩平市');
INSERT INTO `sys_address_area` VALUES (440801, 0, 100, 440800, '市辖区');
INSERT INTO `sys_address_area` VALUES (440802, 0, 100, 440800, '赤坎区');
INSERT INTO `sys_address_area` VALUES (440803, 0, 100, 440800, '霞山区');
INSERT INTO `sys_address_area` VALUES (440804, 0, 100, 440800, '坡头区');
INSERT INTO `sys_address_area` VALUES (440811, 0, 100, 440800, '麻章区');
INSERT INTO `sys_address_area` VALUES (440823, 0, 100, 440800, '遂溪县');
INSERT INTO `sys_address_area` VALUES (440825, 0, 100, 440800, '徐闻县');
INSERT INTO `sys_address_area` VALUES (440881, 0, 100, 440800, '廉江市');
INSERT INTO `sys_address_area` VALUES (440882, 0, 100, 440800, '雷州市');
INSERT INTO `sys_address_area` VALUES (440883, 0, 100, 440800, '吴川市');
INSERT INTO `sys_address_area` VALUES (440901, 0, 100, 440900, '市辖区');
INSERT INTO `sys_address_area` VALUES (440902, 0, 100, 440900, '茂南区');
INSERT INTO `sys_address_area` VALUES (440903, 0, 100, 440900, '茂港区');
INSERT INTO `sys_address_area` VALUES (440923, 0, 100, 440900, '电白县');
INSERT INTO `sys_address_area` VALUES (440981, 0, 100, 440900, '高州市');
INSERT INTO `sys_address_area` VALUES (440982, 0, 100, 440900, '化州市');
INSERT INTO `sys_address_area` VALUES (440983, 0, 100, 440900, '信宜市');
INSERT INTO `sys_address_area` VALUES (441201, 0, 100, 441200, '市辖区');
INSERT INTO `sys_address_area` VALUES (441202, 0, 100, 441200, '端州区');
INSERT INTO `sys_address_area` VALUES (441203, 0, 100, 441200, '鼎湖区');
INSERT INTO `sys_address_area` VALUES (441223, 0, 100, 441200, '广宁县');
INSERT INTO `sys_address_area` VALUES (441224, 0, 100, 441200, '怀集县');
INSERT INTO `sys_address_area` VALUES (441225, 0, 100, 441200, '封开县');
INSERT INTO `sys_address_area` VALUES (441226, 0, 100, 441200, '德庆县');
INSERT INTO `sys_address_area` VALUES (441283, 0, 100, 441200, '高要市');
INSERT INTO `sys_address_area` VALUES (441284, 0, 100, 441200, '四会市');
INSERT INTO `sys_address_area` VALUES (441301, 0, 100, 441300, '市辖区');
INSERT INTO `sys_address_area` VALUES (441302, 0, 100, 441300, '惠城区');
INSERT INTO `sys_address_area` VALUES (441303, 0, 100, 441300, '惠阳区');
INSERT INTO `sys_address_area` VALUES (441322, 0, 100, 441300, '博罗县');
INSERT INTO `sys_address_area` VALUES (441323, 0, 100, 441300, '惠东县');
INSERT INTO `sys_address_area` VALUES (441324, 0, 100, 441300, '龙门县');
INSERT INTO `sys_address_area` VALUES (441401, 0, 100, 441400, '市辖区');
INSERT INTO `sys_address_area` VALUES (441402, 0, 100, 441400, '梅江区');
INSERT INTO `sys_address_area` VALUES (441421, 0, 100, 441400, '梅　县');
INSERT INTO `sys_address_area` VALUES (441422, 0, 100, 441400, '大埔县');
INSERT INTO `sys_address_area` VALUES (441423, 0, 100, 441400, '丰顺县');
INSERT INTO `sys_address_area` VALUES (441424, 0, 100, 441400, '五华县');
INSERT INTO `sys_address_area` VALUES (441426, 0, 100, 441400, '平远县');
INSERT INTO `sys_address_area` VALUES (441427, 0, 100, 441400, '蕉岭县');
INSERT INTO `sys_address_area` VALUES (441481, 0, 100, 441400, '兴宁市');
INSERT INTO `sys_address_area` VALUES (441501, 0, 100, 441500, '市辖区');
INSERT INTO `sys_address_area` VALUES (441502, 0, 100, 441500, '城　区');
INSERT INTO `sys_address_area` VALUES (441521, 0, 100, 441500, '海丰县');
INSERT INTO `sys_address_area` VALUES (441523, 0, 100, 441500, '陆河县');
INSERT INTO `sys_address_area` VALUES (441581, 0, 100, 441500, '陆丰市');
INSERT INTO `sys_address_area` VALUES (441601, 0, 100, 441600, '市辖区');
INSERT INTO `sys_address_area` VALUES (441602, 0, 100, 441600, '源城区');
INSERT INTO `sys_address_area` VALUES (441621, 0, 100, 441600, '紫金县');
INSERT INTO `sys_address_area` VALUES (441622, 0, 100, 441600, '龙川县');
INSERT INTO `sys_address_area` VALUES (441623, 0, 100, 441600, '连平县');
INSERT INTO `sys_address_area` VALUES (441624, 0, 100, 441600, '和平县');
INSERT INTO `sys_address_area` VALUES (441625, 0, 100, 441600, '东源县');
INSERT INTO `sys_address_area` VALUES (441701, 0, 100, 441700, '市辖区');
INSERT INTO `sys_address_area` VALUES (441702, 0, 100, 441700, '江城区');
INSERT INTO `sys_address_area` VALUES (441721, 0, 100, 441700, '阳西县');
INSERT INTO `sys_address_area` VALUES (441723, 0, 100, 441700, '阳东县');
INSERT INTO `sys_address_area` VALUES (441781, 0, 100, 441700, '阳春市');
INSERT INTO `sys_address_area` VALUES (441801, 0, 100, 441800, '市辖区');
INSERT INTO `sys_address_area` VALUES (441802, 0, 100, 441800, '清城区');
INSERT INTO `sys_address_area` VALUES (441821, 0, 100, 441800, '佛冈县');
INSERT INTO `sys_address_area` VALUES (441823, 0, 100, 441800, '阳山县');
INSERT INTO `sys_address_area` VALUES (441825, 0, 100, 441800, '连山壮族瑶族自治县');
INSERT INTO `sys_address_area` VALUES (441826, 0, 100, 441800, '连南瑶族自治县');
INSERT INTO `sys_address_area` VALUES (441827, 0, 100, 441800, '清新县');
INSERT INTO `sys_address_area` VALUES (441881, 0, 100, 441800, '英德市');
INSERT INTO `sys_address_area` VALUES (441882, 0, 100, 441800, '连州市');
INSERT INTO `sys_address_area` VALUES (445101, 0, 100, 445100, '市辖区');
INSERT INTO `sys_address_area` VALUES (445102, 0, 100, 445100, '湘桥区');
INSERT INTO `sys_address_area` VALUES (445121, 0, 100, 445100, '潮安县');
INSERT INTO `sys_address_area` VALUES (445122, 0, 100, 445100, '饶平县');
INSERT INTO `sys_address_area` VALUES (445201, 0, 100, 445200, '市辖区');
INSERT INTO `sys_address_area` VALUES (445202, 0, 100, 445200, '榕城区');
INSERT INTO `sys_address_area` VALUES (445221, 0, 100, 445200, '揭东县');
INSERT INTO `sys_address_area` VALUES (445222, 0, 100, 445200, '揭西县');
INSERT INTO `sys_address_area` VALUES (445224, 0, 100, 445200, '惠来县');
INSERT INTO `sys_address_area` VALUES (445281, 0, 100, 445200, '普宁市');
INSERT INTO `sys_address_area` VALUES (445301, 0, 100, 445300, '市辖区');
INSERT INTO `sys_address_area` VALUES (445302, 0, 100, 445300, '云城区');
INSERT INTO `sys_address_area` VALUES (445321, 0, 100, 445300, '新兴县');
INSERT INTO `sys_address_area` VALUES (445322, 0, 100, 445300, '郁南县');
INSERT INTO `sys_address_area` VALUES (445323, 0, 100, 445300, '云安县');
INSERT INTO `sys_address_area` VALUES (445381, 0, 100, 445300, '罗定市');
INSERT INTO `sys_address_area` VALUES (450101, 0, 100, 450100, '市辖区');
INSERT INTO `sys_address_area` VALUES (450102, 0, 100, 450100, '兴宁区');
INSERT INTO `sys_address_area` VALUES (450103, 0, 100, 450100, '青秀区');
INSERT INTO `sys_address_area` VALUES (450105, 0, 100, 450100, '江南区');
INSERT INTO `sys_address_area` VALUES (450107, 0, 100, 450100, '西乡塘区');
INSERT INTO `sys_address_area` VALUES (450108, 0, 100, 450100, '良庆区');
INSERT INTO `sys_address_area` VALUES (450109, 0, 100, 450100, '邕宁区');
INSERT INTO `sys_address_area` VALUES (450122, 0, 100, 450100, '武鸣县');
INSERT INTO `sys_address_area` VALUES (450123, 0, 100, 450100, '隆安县');
INSERT INTO `sys_address_area` VALUES (450124, 0, 100, 450100, '马山县');
INSERT INTO `sys_address_area` VALUES (450125, 0, 100, 450100, '上林县');
INSERT INTO `sys_address_area` VALUES (450126, 0, 100, 450100, '宾阳县');
INSERT INTO `sys_address_area` VALUES (450127, 0, 100, 450100, '横　县');
INSERT INTO `sys_address_area` VALUES (450201, 0, 100, 450200, '市辖区');
INSERT INTO `sys_address_area` VALUES (450202, 0, 100, 450200, '城中区');
INSERT INTO `sys_address_area` VALUES (450203, 0, 100, 450200, '鱼峰区');
INSERT INTO `sys_address_area` VALUES (450204, 0, 100, 450200, '柳南区');
INSERT INTO `sys_address_area` VALUES (450205, 0, 100, 450200, '柳北区');
INSERT INTO `sys_address_area` VALUES (450221, 0, 100, 450200, '柳江县');
INSERT INTO `sys_address_area` VALUES (450222, 0, 100, 450200, '柳城县');
INSERT INTO `sys_address_area` VALUES (450223, 0, 100, 450200, '鹿寨县');
INSERT INTO `sys_address_area` VALUES (450224, 0, 100, 450200, '融安县');
INSERT INTO `sys_address_area` VALUES (450225, 0, 100, 450200, '融水苗族自治县');
INSERT INTO `sys_address_area` VALUES (450226, 0, 100, 450200, '三江侗族自治县');
INSERT INTO `sys_address_area` VALUES (450301, 0, 100, 450300, '市辖区');
INSERT INTO `sys_address_area` VALUES (450302, 0, 100, 450300, '秀峰区');
INSERT INTO `sys_address_area` VALUES (450303, 0, 100, 450300, '叠彩区');
INSERT INTO `sys_address_area` VALUES (450304, 0, 100, 450300, '象山区');
INSERT INTO `sys_address_area` VALUES (450305, 0, 100, 450300, '七星区');
INSERT INTO `sys_address_area` VALUES (450311, 0, 100, 450300, '雁山区');
INSERT INTO `sys_address_area` VALUES (450321, 0, 100, 450300, '阳朔县');
INSERT INTO `sys_address_area` VALUES (450322, 0, 100, 450300, '临桂县');
INSERT INTO `sys_address_area` VALUES (450323, 0, 100, 450300, '灵川县');
INSERT INTO `sys_address_area` VALUES (450324, 0, 100, 450300, '全州县');
INSERT INTO `sys_address_area` VALUES (450325, 0, 100, 450300, '兴安县');
INSERT INTO `sys_address_area` VALUES (450326, 0, 100, 450300, '永福县');
INSERT INTO `sys_address_area` VALUES (450327, 0, 100, 450300, '灌阳县');
INSERT INTO `sys_address_area` VALUES (450328, 0, 100, 450300, '龙胜各族自治县');
INSERT INTO `sys_address_area` VALUES (450329, 0, 100, 450300, '资源县');
INSERT INTO `sys_address_area` VALUES (450330, 0, 100, 450300, '平乐县');
INSERT INTO `sys_address_area` VALUES (450331, 0, 100, 450300, '荔蒲县');
INSERT INTO `sys_address_area` VALUES (450332, 0, 100, 450300, '恭城瑶族自治县');
INSERT INTO `sys_address_area` VALUES (450401, 0, 100, 450400, '市辖区');
INSERT INTO `sys_address_area` VALUES (450403, 0, 100, 450400, '万秀区');
INSERT INTO `sys_address_area` VALUES (450404, 0, 100, 450400, '蝶山区');
INSERT INTO `sys_address_area` VALUES (450405, 0, 100, 450400, '长洲区');
INSERT INTO `sys_address_area` VALUES (450421, 0, 100, 450400, '苍梧县');
INSERT INTO `sys_address_area` VALUES (450422, 0, 100, 450400, '藤　县');
INSERT INTO `sys_address_area` VALUES (450423, 0, 100, 450400, '蒙山县');
INSERT INTO `sys_address_area` VALUES (450481, 0, 100, 450400, '岑溪市');
INSERT INTO `sys_address_area` VALUES (450501, 0, 100, 450500, '市辖区');
INSERT INTO `sys_address_area` VALUES (450502, 0, 100, 450500, '海城区');
INSERT INTO `sys_address_area` VALUES (450503, 0, 100, 450500, '银海区');
INSERT INTO `sys_address_area` VALUES (450512, 0, 100, 450500, '铁山港区');
INSERT INTO `sys_address_area` VALUES (450521, 0, 100, 450500, '合浦县');
INSERT INTO `sys_address_area` VALUES (450601, 0, 100, 450600, '市辖区');
INSERT INTO `sys_address_area` VALUES (450602, 0, 100, 450600, '港口区');
INSERT INTO `sys_address_area` VALUES (450603, 0, 100, 450600, '防城区');
INSERT INTO `sys_address_area` VALUES (450621, 0, 100, 450600, '上思县');
INSERT INTO `sys_address_area` VALUES (450681, 0, 100, 450600, '东兴市');
INSERT INTO `sys_address_area` VALUES (450701, 0, 100, 450700, '市辖区');
INSERT INTO `sys_address_area` VALUES (450702, 0, 100, 450700, '钦南区');
INSERT INTO `sys_address_area` VALUES (450703, 0, 100, 450700, '钦北区');
INSERT INTO `sys_address_area` VALUES (450721, 0, 100, 450700, '灵山县');
INSERT INTO `sys_address_area` VALUES (450722, 0, 100, 450700, '浦北县');
INSERT INTO `sys_address_area` VALUES (450801, 0, 100, 450800, '市辖区');
INSERT INTO `sys_address_area` VALUES (450802, 0, 100, 450800, '港北区');
INSERT INTO `sys_address_area` VALUES (450803, 0, 100, 450800, '港南区');
INSERT INTO `sys_address_area` VALUES (450804, 0, 100, 450800, '覃塘区');
INSERT INTO `sys_address_area` VALUES (450821, 0, 100, 450800, '平南县');
INSERT INTO `sys_address_area` VALUES (450881, 0, 100, 450800, '桂平市');
INSERT INTO `sys_address_area` VALUES (450901, 0, 100, 450900, '市辖区');
INSERT INTO `sys_address_area` VALUES (450902, 0, 100, 450900, '玉州区');
INSERT INTO `sys_address_area` VALUES (450921, 0, 100, 450900, '容　县');
INSERT INTO `sys_address_area` VALUES (450922, 0, 100, 450900, '陆川县');
INSERT INTO `sys_address_area` VALUES (450923, 0, 100, 450900, '博白县');
INSERT INTO `sys_address_area` VALUES (450924, 0, 100, 450900, '兴业县');
INSERT INTO `sys_address_area` VALUES (450981, 0, 100, 450900, '北流市');
INSERT INTO `sys_address_area` VALUES (451001, 0, 100, 451000, '市辖区');
INSERT INTO `sys_address_area` VALUES (451002, 0, 100, 451000, '右江区');
INSERT INTO `sys_address_area` VALUES (451021, 0, 100, 451000, '田阳县');
INSERT INTO `sys_address_area` VALUES (451022, 0, 100, 451000, '田东县');
INSERT INTO `sys_address_area` VALUES (451023, 0, 100, 451000, '平果县');
INSERT INTO `sys_address_area` VALUES (451024, 0, 100, 451000, '德保县');
INSERT INTO `sys_address_area` VALUES (451025, 0, 100, 451000, '靖西县');
INSERT INTO `sys_address_area` VALUES (451026, 0, 100, 451000, '那坡县');
INSERT INTO `sys_address_area` VALUES (451027, 0, 100, 451000, '凌云县');
INSERT INTO `sys_address_area` VALUES (451028, 0, 100, 451000, '乐业县');
INSERT INTO `sys_address_area` VALUES (451029, 0, 100, 451000, '田林县');
INSERT INTO `sys_address_area` VALUES (451030, 0, 100, 451000, '西林县');
INSERT INTO `sys_address_area` VALUES (451031, 0, 100, 451000, '隆林各族自治县');
INSERT INTO `sys_address_area` VALUES (451101, 0, 100, 451100, '市辖区');
INSERT INTO `sys_address_area` VALUES (451102, 0, 100, 451100, '八步区');
INSERT INTO `sys_address_area` VALUES (451121, 0, 100, 451100, '昭平县');
INSERT INTO `sys_address_area` VALUES (451122, 0, 100, 451100, '钟山县');
INSERT INTO `sys_address_area` VALUES (451123, 0, 100, 451100, '富川瑶族自治县');
INSERT INTO `sys_address_area` VALUES (451201, 0, 100, 451200, '市辖区');
INSERT INTO `sys_address_area` VALUES (451202, 0, 100, 451200, '金城江区');
INSERT INTO `sys_address_area` VALUES (451221, 0, 100, 451200, '南丹县');
INSERT INTO `sys_address_area` VALUES (451222, 0, 100, 451200, '天峨县');
INSERT INTO `sys_address_area` VALUES (451223, 0, 100, 451200, '凤山县');
INSERT INTO `sys_address_area` VALUES (451224, 0, 100, 451200, '东兰县');
INSERT INTO `sys_address_area` VALUES (451225, 0, 100, 451200, '罗城仫佬族自治县');
INSERT INTO `sys_address_area` VALUES (451226, 0, 100, 451200, '环江毛南族自治县');
INSERT INTO `sys_address_area` VALUES (451227, 0, 100, 451200, '巴马瑶族自治县');
INSERT INTO `sys_address_area` VALUES (451228, 0, 100, 451200, '都安瑶族自治县');
INSERT INTO `sys_address_area` VALUES (451229, 0, 100, 451200, '大化瑶族自治县');
INSERT INTO `sys_address_area` VALUES (451281, 0, 100, 451200, '宜州市');
INSERT INTO `sys_address_area` VALUES (451301, 0, 100, 451300, '市辖区');
INSERT INTO `sys_address_area` VALUES (451302, 0, 100, 451300, '兴宾区');
INSERT INTO `sys_address_area` VALUES (451321, 0, 100, 451300, '忻城县');
INSERT INTO `sys_address_area` VALUES (451322, 0, 100, 451300, '象州县');
INSERT INTO `sys_address_area` VALUES (451323, 0, 100, 451300, '武宣县');
INSERT INTO `sys_address_area` VALUES (451324, 0, 100, 451300, '金秀瑶族自治县');
INSERT INTO `sys_address_area` VALUES (451381, 0, 100, 451300, '合山市');
INSERT INTO `sys_address_area` VALUES (451401, 0, 100, 451400, '市辖区');
INSERT INTO `sys_address_area` VALUES (451402, 0, 100, 451400, '江洲区');
INSERT INTO `sys_address_area` VALUES (451421, 0, 100, 451400, '扶绥县');
INSERT INTO `sys_address_area` VALUES (451422, 0, 100, 451400, '宁明县');
INSERT INTO `sys_address_area` VALUES (451423, 0, 100, 451400, '龙州县');
INSERT INTO `sys_address_area` VALUES (451424, 0, 100, 451400, '大新县');
INSERT INTO `sys_address_area` VALUES (451425, 0, 100, 451400, '天等县');
INSERT INTO `sys_address_area` VALUES (451481, 0, 100, 451400, '凭祥市');
INSERT INTO `sys_address_area` VALUES (460101, 0, 100, 460100, '市辖区');
INSERT INTO `sys_address_area` VALUES (460105, 0, 100, 460100, '秀英区');
INSERT INTO `sys_address_area` VALUES (460106, 0, 100, 460100, '龙华区');
INSERT INTO `sys_address_area` VALUES (460107, 0, 100, 460100, '琼山区');
INSERT INTO `sys_address_area` VALUES (460108, 0, 100, 460100, '美兰区');
INSERT INTO `sys_address_area` VALUES (460201, 0, 100, 460200, '市辖区');
INSERT INTO `sys_address_area` VALUES (469001, 0, 100, 469000, '五指山市');
INSERT INTO `sys_address_area` VALUES (469002, 0, 100, 469000, '琼海市');
INSERT INTO `sys_address_area` VALUES (469003, 0, 100, 469000, '儋州市');
INSERT INTO `sys_address_area` VALUES (469005, 0, 100, 469000, '文昌市');
INSERT INTO `sys_address_area` VALUES (469006, 0, 100, 469000, '万宁市');
INSERT INTO `sys_address_area` VALUES (469007, 0, 100, 469000, '东方市');
INSERT INTO `sys_address_area` VALUES (469025, 0, 100, 469000, '定安县');
INSERT INTO `sys_address_area` VALUES (469026, 0, 100, 469000, '屯昌县');
INSERT INTO `sys_address_area` VALUES (469027, 0, 100, 469000, '澄迈县');
INSERT INTO `sys_address_area` VALUES (469028, 0, 100, 469000, '临高县');
INSERT INTO `sys_address_area` VALUES (469030, 0, 100, 469000, '白沙黎族自治县');
INSERT INTO `sys_address_area` VALUES (469031, 0, 100, 469000, '昌江黎族自治县');
INSERT INTO `sys_address_area` VALUES (469033, 0, 100, 469000, '乐东黎族自治县');
INSERT INTO `sys_address_area` VALUES (469034, 0, 100, 469000, '陵水黎族自治县');
INSERT INTO `sys_address_area` VALUES (469035, 0, 100, 469000, '保亭黎族苗族自治县');
INSERT INTO `sys_address_area` VALUES (469036, 0, 100, 469000, '琼中黎族苗族自治县');
INSERT INTO `sys_address_area` VALUES (469037, 0, 100, 469000, '西沙群岛');
INSERT INTO `sys_address_area` VALUES (469038, 0, 100, 469000, '南沙群岛');
INSERT INTO `sys_address_area` VALUES (469039, 0, 100, 469000, '中沙群岛的岛礁及其海域');
INSERT INTO `sys_address_area` VALUES (500101, 0, 100, 500100, '万州区');
INSERT INTO `sys_address_area` VALUES (500102, 0, 100, 500100, '涪陵区');
INSERT INTO `sys_address_area` VALUES (500103, 0, 100, 500100, '渝中区');
INSERT INTO `sys_address_area` VALUES (500104, 0, 100, 500100, '大渡口区');
INSERT INTO `sys_address_area` VALUES (500105, 0, 100, 500100, '江北区');
INSERT INTO `sys_address_area` VALUES (500106, 0, 100, 500100, '沙坪坝区');
INSERT INTO `sys_address_area` VALUES (500107, 0, 100, 500100, '九龙坡区');
INSERT INTO `sys_address_area` VALUES (500108, 0, 100, 500100, '南岸区');
INSERT INTO `sys_address_area` VALUES (500109, 0, 100, 500100, '北碚区');
INSERT INTO `sys_address_area` VALUES (500110, 0, 100, 500100, '万盛区');
INSERT INTO `sys_address_area` VALUES (500111, 0, 100, 500100, '双桥区');
INSERT INTO `sys_address_area` VALUES (500112, 0, 100, 500100, '渝北区');
INSERT INTO `sys_address_area` VALUES (500113, 0, 100, 500100, '巴南区');
INSERT INTO `sys_address_area` VALUES (500114, 0, 100, 500100, '黔江区');
INSERT INTO `sys_address_area` VALUES (500115, 0, 100, 500100, '长寿区');
INSERT INTO `sys_address_area` VALUES (500222, 0, 100, 500200, '綦江县');
INSERT INTO `sys_address_area` VALUES (500223, 0, 100, 500200, '潼南县');
INSERT INTO `sys_address_area` VALUES (500224, 0, 100, 500200, '铜梁县');
INSERT INTO `sys_address_area` VALUES (500225, 0, 100, 500200, '大足县');
INSERT INTO `sys_address_area` VALUES (500226, 0, 100, 500200, '荣昌县');
INSERT INTO `sys_address_area` VALUES (500227, 0, 100, 500200, '璧山县');
INSERT INTO `sys_address_area` VALUES (500228, 0, 100, 500200, '梁平县');
INSERT INTO `sys_address_area` VALUES (500229, 0, 100, 500200, '城口县');
INSERT INTO `sys_address_area` VALUES (500230, 0, 100, 500200, '丰都县');
INSERT INTO `sys_address_area` VALUES (500231, 0, 100, 500200, '垫江县');
INSERT INTO `sys_address_area` VALUES (500232, 0, 100, 500200, '武隆县');
INSERT INTO `sys_address_area` VALUES (500233, 0, 100, 500200, '忠　县');
INSERT INTO `sys_address_area` VALUES (500234, 0, 100, 500200, '开　县');
INSERT INTO `sys_address_area` VALUES (500235, 0, 100, 500200, '云阳县');
INSERT INTO `sys_address_area` VALUES (500236, 0, 100, 500200, '奉节县');
INSERT INTO `sys_address_area` VALUES (500237, 0, 100, 500200, '巫山县');
INSERT INTO `sys_address_area` VALUES (500238, 0, 100, 500200, '巫溪县');
INSERT INTO `sys_address_area` VALUES (500240, 0, 100, 500200, '石柱土家族自治县');
INSERT INTO `sys_address_area` VALUES (500241, 0, 100, 500200, '秀山土家族苗族自治县');
INSERT INTO `sys_address_area` VALUES (500242, 0, 100, 500200, '酉阳土家族苗族自治县');
INSERT INTO `sys_address_area` VALUES (500243, 0, 100, 500200, '彭水苗族土家族自治县');
INSERT INTO `sys_address_area` VALUES (500381, 0, 100, 500300, '江津市');
INSERT INTO `sys_address_area` VALUES (500382, 0, 100, 500300, '合川市');
INSERT INTO `sys_address_area` VALUES (500383, 0, 100, 500300, '永川市');
INSERT INTO `sys_address_area` VALUES (500384, 0, 100, 500300, '南川市');
INSERT INTO `sys_address_area` VALUES (510101, 0, 100, 510100, '市辖区');
INSERT INTO `sys_address_area` VALUES (510104, 0, 100, 510100, '锦江区');
INSERT INTO `sys_address_area` VALUES (510105, 0, 100, 510100, '青羊区');
INSERT INTO `sys_address_area` VALUES (510106, 0, 100, 510100, '金牛区');
INSERT INTO `sys_address_area` VALUES (510107, 0, 100, 510100, '武侯区');
INSERT INTO `sys_address_area` VALUES (510108, 0, 100, 510100, '成华区');
INSERT INTO `sys_address_area` VALUES (510112, 0, 100, 510100, '龙泉驿区');
INSERT INTO `sys_address_area` VALUES (510113, 0, 100, 510100, '青白江区');
INSERT INTO `sys_address_area` VALUES (510114, 0, 100, 510100, '新都区');
INSERT INTO `sys_address_area` VALUES (510115, 0, 100, 510100, '温江县');
INSERT INTO `sys_address_area` VALUES (510121, 0, 100, 510100, '金堂县');
INSERT INTO `sys_address_area` VALUES (510122, 0, 100, 510100, '双流县');
INSERT INTO `sys_address_area` VALUES (510124, 0, 100, 510100, '郫　县');
INSERT INTO `sys_address_area` VALUES (510129, 0, 100, 510100, '大邑县');
INSERT INTO `sys_address_area` VALUES (510131, 0, 100, 510100, '蒲江县');
INSERT INTO `sys_address_area` VALUES (510132, 0, 100, 510100, '新津县');
INSERT INTO `sys_address_area` VALUES (510181, 0, 100, 510100, '都江堰市');
INSERT INTO `sys_address_area` VALUES (510182, 0, 100, 510100, '彭州市');
INSERT INTO `sys_address_area` VALUES (510183, 0, 100, 510100, '邛崃市');
INSERT INTO `sys_address_area` VALUES (510184, 0, 100, 510100, '崇州市');
INSERT INTO `sys_address_area` VALUES (510301, 0, 100, 510300, '市辖区');
INSERT INTO `sys_address_area` VALUES (510302, 0, 100, 510300, '自流井区');
INSERT INTO `sys_address_area` VALUES (510303, 0, 100, 510300, '贡井区');
INSERT INTO `sys_address_area` VALUES (510304, 0, 100, 510300, '大安区');
INSERT INTO `sys_address_area` VALUES (510311, 0, 100, 510300, '沿滩区');
INSERT INTO `sys_address_area` VALUES (510321, 0, 100, 510300, '荣　县');
INSERT INTO `sys_address_area` VALUES (510322, 0, 100, 510300, '富顺县');
INSERT INTO `sys_address_area` VALUES (510401, 0, 100, 510400, '市辖区');
INSERT INTO `sys_address_area` VALUES (510402, 0, 100, 510400, '东　区');
INSERT INTO `sys_address_area` VALUES (510403, 0, 100, 510400, '西　区');
INSERT INTO `sys_address_area` VALUES (510411, 0, 100, 510400, '仁和区');
INSERT INTO `sys_address_area` VALUES (510421, 0, 100, 510400, '米易县');
INSERT INTO `sys_address_area` VALUES (510422, 0, 100, 510400, '盐边县');
INSERT INTO `sys_address_area` VALUES (510501, 0, 100, 510500, '市辖区');
INSERT INTO `sys_address_area` VALUES (510502, 0, 100, 510500, '江阳区');
INSERT INTO `sys_address_area` VALUES (510503, 0, 100, 510500, '纳溪区');
INSERT INTO `sys_address_area` VALUES (510504, 0, 100, 510500, '龙马潭区');
INSERT INTO `sys_address_area` VALUES (510521, 0, 100, 510500, '泸　县');
INSERT INTO `sys_address_area` VALUES (510522, 0, 100, 510500, '合江县');
INSERT INTO `sys_address_area` VALUES (510524, 0, 100, 510500, '叙永县');
INSERT INTO `sys_address_area` VALUES (510525, 0, 100, 510500, '古蔺县');
INSERT INTO `sys_address_area` VALUES (510601, 0, 100, 510600, '市辖区');
INSERT INTO `sys_address_area` VALUES (510603, 0, 100, 510600, '旌阳区');
INSERT INTO `sys_address_area` VALUES (510623, 0, 100, 510600, '中江县');
INSERT INTO `sys_address_area` VALUES (510626, 0, 100, 510600, '罗江县');
INSERT INTO `sys_address_area` VALUES (510681, 0, 100, 510600, '广汉市');
INSERT INTO `sys_address_area` VALUES (510682, 0, 100, 510600, '什邡市');
INSERT INTO `sys_address_area` VALUES (510683, 0, 100, 510600, '绵竹市');
INSERT INTO `sys_address_area` VALUES (510701, 0, 100, 510700, '市辖区');
INSERT INTO `sys_address_area` VALUES (510703, 0, 100, 510700, '涪城区');
INSERT INTO `sys_address_area` VALUES (510704, 0, 100, 510700, '游仙区');
INSERT INTO `sys_address_area` VALUES (510722, 0, 100, 510700, '三台县');
INSERT INTO `sys_address_area` VALUES (510723, 0, 100, 510700, '盐亭县');
INSERT INTO `sys_address_area` VALUES (510724, 0, 100, 510700, '安　县');
INSERT INTO `sys_address_area` VALUES (510725, 0, 100, 510700, '梓潼县');
INSERT INTO `sys_address_area` VALUES (510726, 0, 100, 510700, '北川羌族自治县');
INSERT INTO `sys_address_area` VALUES (510727, 0, 100, 510700, '平武县');
INSERT INTO `sys_address_area` VALUES (510781, 0, 100, 510700, '江油市');
INSERT INTO `sys_address_area` VALUES (510801, 0, 100, 510800, '市辖区');
INSERT INTO `sys_address_area` VALUES (510802, 0, 100, 510800, '市中区');
INSERT INTO `sys_address_area` VALUES (510811, 0, 100, 510800, '元坝区');
INSERT INTO `sys_address_area` VALUES (510812, 0, 100, 510800, '朝天区');
INSERT INTO `sys_address_area` VALUES (510821, 0, 100, 510800, '旺苍县');
INSERT INTO `sys_address_area` VALUES (510822, 0, 100, 510800, '青川县');
INSERT INTO `sys_address_area` VALUES (510823, 0, 100, 510800, '剑阁县');
INSERT INTO `sys_address_area` VALUES (510824, 0, 100, 510800, '苍溪县');
INSERT INTO `sys_address_area` VALUES (510901, 0, 100, 510900, '市辖区');
INSERT INTO `sys_address_area` VALUES (510903, 0, 100, 510900, '船山区');
INSERT INTO `sys_address_area` VALUES (510904, 0, 100, 510900, '安居区');
INSERT INTO `sys_address_area` VALUES (510921, 0, 100, 510900, '蓬溪县');
INSERT INTO `sys_address_area` VALUES (510922, 0, 100, 510900, '射洪县');
INSERT INTO `sys_address_area` VALUES (510923, 0, 100, 510900, '大英县');
INSERT INTO `sys_address_area` VALUES (511001, 0, 100, 511000, '市辖区');
INSERT INTO `sys_address_area` VALUES (511002, 0, 100, 511000, '市中区');
INSERT INTO `sys_address_area` VALUES (511011, 0, 100, 511000, '东兴区');
INSERT INTO `sys_address_area` VALUES (511024, 0, 100, 511000, '威远县');
INSERT INTO `sys_address_area` VALUES (511025, 0, 100, 511000, '资中县');
INSERT INTO `sys_address_area` VALUES (511028, 0, 100, 511000, '隆昌县');
INSERT INTO `sys_address_area` VALUES (511101, 0, 100, 511100, '市辖区');
INSERT INTO `sys_address_area` VALUES (511102, 0, 100, 511100, '市中区');
INSERT INTO `sys_address_area` VALUES (511111, 0, 100, 511100, '沙湾区');
INSERT INTO `sys_address_area` VALUES (511112, 0, 100, 511100, '五通桥区');
INSERT INTO `sys_address_area` VALUES (511113, 0, 100, 511100, '金口河区');
INSERT INTO `sys_address_area` VALUES (511123, 0, 100, 511100, '犍为县');
INSERT INTO `sys_address_area` VALUES (511124, 0, 100, 511100, '井研县');
INSERT INTO `sys_address_area` VALUES (511126, 0, 100, 511100, '夹江县');
INSERT INTO `sys_address_area` VALUES (511129, 0, 100, 511100, '沐川县');
INSERT INTO `sys_address_area` VALUES (511132, 0, 100, 511100, '峨边彝族自治县');
INSERT INTO `sys_address_area` VALUES (511133, 0, 100, 511100, '马边彝族自治县');
INSERT INTO `sys_address_area` VALUES (511181, 0, 100, 511100, '峨眉山市');
INSERT INTO `sys_address_area` VALUES (511301, 0, 100, 511300, '市辖区');
INSERT INTO `sys_address_area` VALUES (511302, 0, 100, 511300, '顺庆区');
INSERT INTO `sys_address_area` VALUES (511303, 0, 100, 511300, '高坪区');
INSERT INTO `sys_address_area` VALUES (511304, 0, 100, 511300, '嘉陵区');
INSERT INTO `sys_address_area` VALUES (511321, 0, 100, 511300, '南部县');
INSERT INTO `sys_address_area` VALUES (511322, 0, 100, 511300, '营山县');
INSERT INTO `sys_address_area` VALUES (511323, 0, 100, 511300, '蓬安县');
INSERT INTO `sys_address_area` VALUES (511324, 0, 100, 511300, '仪陇县');
INSERT INTO `sys_address_area` VALUES (511325, 0, 100, 511300, '西充县');
INSERT INTO `sys_address_area` VALUES (511381, 0, 100, 511300, '阆中市');
INSERT INTO `sys_address_area` VALUES (511401, 0, 100, 511400, '市辖区');
INSERT INTO `sys_address_area` VALUES (511402, 0, 100, 511400, '东坡区');
INSERT INTO `sys_address_area` VALUES (511421, 0, 100, 511400, '仁寿县');
INSERT INTO `sys_address_area` VALUES (511422, 0, 100, 511400, '彭山县');
INSERT INTO `sys_address_area` VALUES (511423, 0, 100, 511400, '洪雅县');
INSERT INTO `sys_address_area` VALUES (511424, 0, 100, 511400, '丹棱县');
INSERT INTO `sys_address_area` VALUES (511425, 0, 100, 511400, '青神县');
INSERT INTO `sys_address_area` VALUES (511501, 0, 100, 511500, '市辖区');
INSERT INTO `sys_address_area` VALUES (511502, 0, 100, 511500, '翠屏区');
INSERT INTO `sys_address_area` VALUES (511521, 0, 100, 511500, '宜宾县');
INSERT INTO `sys_address_area` VALUES (511522, 0, 100, 511500, '南溪县');
INSERT INTO `sys_address_area` VALUES (511523, 0, 100, 511500, '江安县');
INSERT INTO `sys_address_area` VALUES (511524, 0, 100, 511500, '长宁县');
INSERT INTO `sys_address_area` VALUES (511525, 0, 100, 511500, '高　县');
INSERT INTO `sys_address_area` VALUES (511526, 0, 100, 511500, '珙　县');
INSERT INTO `sys_address_area` VALUES (511527, 0, 100, 511500, '筠连县');
INSERT INTO `sys_address_area` VALUES (511528, 0, 100, 511500, '兴文县');
INSERT INTO `sys_address_area` VALUES (511529, 0, 100, 511500, '屏山县');
INSERT INTO `sys_address_area` VALUES (511601, 0, 100, 511600, '市辖区');
INSERT INTO `sys_address_area` VALUES (511602, 0, 100, 511600, '广安区');
INSERT INTO `sys_address_area` VALUES (511621, 0, 100, 511600, '岳池县');
INSERT INTO `sys_address_area` VALUES (511622, 0, 100, 511600, '武胜县');
INSERT INTO `sys_address_area` VALUES (511623, 0, 100, 511600, '邻水县');
INSERT INTO `sys_address_area` VALUES (511681, 0, 100, 511600, '华莹市');
INSERT INTO `sys_address_area` VALUES (511701, 0, 100, 511700, '市辖区');
INSERT INTO `sys_address_area` VALUES (511702, 0, 100, 511700, '通川区');
INSERT INTO `sys_address_area` VALUES (511721, 0, 100, 511700, '达　县');
INSERT INTO `sys_address_area` VALUES (511722, 0, 100, 511700, '宣汉县');
INSERT INTO `sys_address_area` VALUES (511723, 0, 100, 511700, '开江县');
INSERT INTO `sys_address_area` VALUES (511724, 0, 100, 511700, '大竹县');
INSERT INTO `sys_address_area` VALUES (511725, 0, 100, 511700, '渠　县');
INSERT INTO `sys_address_area` VALUES (511781, 0, 100, 511700, '万源市');
INSERT INTO `sys_address_area` VALUES (511801, 0, 100, 511800, '市辖区');
INSERT INTO `sys_address_area` VALUES (511802, 0, 100, 511800, '雨城区');
INSERT INTO `sys_address_area` VALUES (511821, 0, 100, 511800, '名山县');
INSERT INTO `sys_address_area` VALUES (511822, 0, 100, 511800, '荥经县');
INSERT INTO `sys_address_area` VALUES (511823, 0, 100, 511800, '汉源县');
INSERT INTO `sys_address_area` VALUES (511824, 0, 100, 511800, '石棉县');
INSERT INTO `sys_address_area` VALUES (511825, 0, 100, 511800, '天全县');
INSERT INTO `sys_address_area` VALUES (511826, 0, 100, 511800, '芦山县');
INSERT INTO `sys_address_area` VALUES (511827, 0, 100, 511800, '宝兴县');
INSERT INTO `sys_address_area` VALUES (511901, 0, 100, 511900, '市辖区');
INSERT INTO `sys_address_area` VALUES (511902, 0, 100, 511900, '巴州区');
INSERT INTO `sys_address_area` VALUES (511921, 0, 100, 511900, '通江县');
INSERT INTO `sys_address_area` VALUES (511922, 0, 100, 511900, '南江县');
INSERT INTO `sys_address_area` VALUES (511923, 0, 100, 511900, '平昌县');
INSERT INTO `sys_address_area` VALUES (512001, 0, 100, 512000, '市辖区');
INSERT INTO `sys_address_area` VALUES (512002, 0, 100, 512000, '雁江区');
INSERT INTO `sys_address_area` VALUES (512021, 0, 100, 512000, '安岳县');
INSERT INTO `sys_address_area` VALUES (512022, 0, 100, 512000, '乐至县');
INSERT INTO `sys_address_area` VALUES (512081, 0, 100, 512000, '简阳市');
INSERT INTO `sys_address_area` VALUES (513221, 0, 100, 513200, '汶川县');
INSERT INTO `sys_address_area` VALUES (513222, 0, 100, 513200, '理　县');
INSERT INTO `sys_address_area` VALUES (513223, 0, 100, 513200, '茂　县');
INSERT INTO `sys_address_area` VALUES (513224, 0, 100, 513200, '松潘县');
INSERT INTO `sys_address_area` VALUES (513225, 0, 100, 513200, '九寨沟县');
INSERT INTO `sys_address_area` VALUES (513226, 0, 100, 513200, '金川县');
INSERT INTO `sys_address_area` VALUES (513227, 0, 100, 513200, '小金县');
INSERT INTO `sys_address_area` VALUES (513228, 0, 100, 513200, '黑水县');
INSERT INTO `sys_address_area` VALUES (513229, 0, 100, 513200, '马尔康县');
INSERT INTO `sys_address_area` VALUES (513230, 0, 100, 513200, '壤塘县');
INSERT INTO `sys_address_area` VALUES (513231, 0, 100, 513200, '阿坝县');
INSERT INTO `sys_address_area` VALUES (513232, 0, 100, 513200, '若尔盖县');
INSERT INTO `sys_address_area` VALUES (513233, 0, 100, 513200, '红原县');
INSERT INTO `sys_address_area` VALUES (513321, 0, 100, 513300, '康定县');
INSERT INTO `sys_address_area` VALUES (513322, 0, 100, 513300, '泸定县');
INSERT INTO `sys_address_area` VALUES (513323, 0, 100, 513300, '丹巴县');
INSERT INTO `sys_address_area` VALUES (513324, 0, 100, 513300, '九龙县');
INSERT INTO `sys_address_area` VALUES (513325, 0, 100, 513300, '雅江县');
INSERT INTO `sys_address_area` VALUES (513326, 0, 100, 513300, '道孚县');
INSERT INTO `sys_address_area` VALUES (513327, 0, 100, 513300, '炉霍县');
INSERT INTO `sys_address_area` VALUES (513328, 0, 100, 513300, '甘孜县');
INSERT INTO `sys_address_area` VALUES (513329, 0, 100, 513300, '新龙县');
INSERT INTO `sys_address_area` VALUES (513330, 0, 100, 513300, '德格县');
INSERT INTO `sys_address_area` VALUES (513331, 0, 100, 513300, '白玉县');
INSERT INTO `sys_address_area` VALUES (513332, 0, 100, 513300, '石渠县');
INSERT INTO `sys_address_area` VALUES (513333, 0, 100, 513300, '色达县');
INSERT INTO `sys_address_area` VALUES (513334, 0, 100, 513300, '理塘县');
INSERT INTO `sys_address_area` VALUES (513335, 0, 100, 513300, '巴塘县');
INSERT INTO `sys_address_area` VALUES (513336, 0, 100, 513300, '乡城县');
INSERT INTO `sys_address_area` VALUES (513337, 0, 100, 513300, '稻城县');
INSERT INTO `sys_address_area` VALUES (513338, 0, 100, 513300, '得荣县');
INSERT INTO `sys_address_area` VALUES (513401, 0, 100, 513400, '西昌市');
INSERT INTO `sys_address_area` VALUES (513422, 0, 100, 513400, '木里藏族自治县');
INSERT INTO `sys_address_area` VALUES (513423, 0, 100, 513400, '盐源县');
INSERT INTO `sys_address_area` VALUES (513424, 0, 100, 513400, '德昌县');
INSERT INTO `sys_address_area` VALUES (513425, 0, 100, 513400, '会理县');
INSERT INTO `sys_address_area` VALUES (513426, 0, 100, 513400, '会东县');
INSERT INTO `sys_address_area` VALUES (513427, 0, 100, 513400, '宁南县');
INSERT INTO `sys_address_area` VALUES (513428, 0, 100, 513400, '普格县');
INSERT INTO `sys_address_area` VALUES (513429, 0, 100, 513400, '布拖县');
INSERT INTO `sys_address_area` VALUES (513430, 0, 100, 513400, '金阳县');
INSERT INTO `sys_address_area` VALUES (513431, 0, 100, 513400, '昭觉县');
INSERT INTO `sys_address_area` VALUES (513432, 0, 100, 513400, '喜德县');
INSERT INTO `sys_address_area` VALUES (513433, 0, 100, 513400, '冕宁县');
INSERT INTO `sys_address_area` VALUES (513434, 0, 100, 513400, '越西县');
INSERT INTO `sys_address_area` VALUES (513435, 0, 100, 513400, '甘洛县');
INSERT INTO `sys_address_area` VALUES (513436, 0, 100, 513400, '美姑县');
INSERT INTO `sys_address_area` VALUES (513437, 0, 100, 513400, '雷波县');
INSERT INTO `sys_address_area` VALUES (520101, 0, 100, 520100, '市辖区');
INSERT INTO `sys_address_area` VALUES (520102, 0, 100, 520100, '南明区');
INSERT INTO `sys_address_area` VALUES (520103, 0, 100, 520100, '云岩区');
INSERT INTO `sys_address_area` VALUES (520111, 0, 100, 520100, '花溪区');
INSERT INTO `sys_address_area` VALUES (520112, 0, 100, 520100, '乌当区');
INSERT INTO `sys_address_area` VALUES (520113, 0, 100, 520100, '白云区');
INSERT INTO `sys_address_area` VALUES (520114, 0, 100, 520100, '小河区');
INSERT INTO `sys_address_area` VALUES (520121, 0, 100, 520100, '开阳县');
INSERT INTO `sys_address_area` VALUES (520122, 0, 100, 520100, '息烽县');
INSERT INTO `sys_address_area` VALUES (520123, 0, 100, 520100, '修文县');
INSERT INTO `sys_address_area` VALUES (520181, 0, 100, 520100, '清镇市');
INSERT INTO `sys_address_area` VALUES (520201, 0, 100, 520200, '钟山区');
INSERT INTO `sys_address_area` VALUES (520203, 0, 100, 520200, '六枝特区');
INSERT INTO `sys_address_area` VALUES (520221, 0, 100, 520200, '水城县');
INSERT INTO `sys_address_area` VALUES (520222, 0, 100, 520200, '盘　县');
INSERT INTO `sys_address_area` VALUES (520301, 0, 100, 520300, '市辖区');
INSERT INTO `sys_address_area` VALUES (520302, 0, 100, 520300, '红花岗区');
INSERT INTO `sys_address_area` VALUES (520303, 0, 100, 520300, '汇川区');
INSERT INTO `sys_address_area` VALUES (520321, 0, 100, 520300, '遵义县');
INSERT INTO `sys_address_area` VALUES (520322, 0, 100, 520300, '桐梓县');
INSERT INTO `sys_address_area` VALUES (520323, 0, 100, 520300, '绥阳县');
INSERT INTO `sys_address_area` VALUES (520324, 0, 100, 520300, '正安县');
INSERT INTO `sys_address_area` VALUES (520325, 0, 100, 520300, '道真仡佬族苗族自治县');
INSERT INTO `sys_address_area` VALUES (520326, 0, 100, 520300, '务川仡佬族苗族自治县');
INSERT INTO `sys_address_area` VALUES (520327, 0, 100, 520300, '凤冈县');
INSERT INTO `sys_address_area` VALUES (520328, 0, 100, 520300, '湄潭县');
INSERT INTO `sys_address_area` VALUES (520329, 0, 100, 520300, '余庆县');
INSERT INTO `sys_address_area` VALUES (520330, 0, 100, 520300, '习水县');
INSERT INTO `sys_address_area` VALUES (520381, 0, 100, 520300, '赤水市');
INSERT INTO `sys_address_area` VALUES (520382, 0, 100, 520300, '仁怀市');
INSERT INTO `sys_address_area` VALUES (520401, 0, 100, 520400, '市辖区');
INSERT INTO `sys_address_area` VALUES (520402, 0, 100, 520400, '西秀区');
INSERT INTO `sys_address_area` VALUES (520421, 0, 100, 520400, '平坝县');
INSERT INTO `sys_address_area` VALUES (520422, 0, 100, 520400, '普定县');
INSERT INTO `sys_address_area` VALUES (520423, 0, 100, 520400, '镇宁布依族苗族自治县');
INSERT INTO `sys_address_area` VALUES (520424, 0, 100, 520400, '关岭布依族苗族自治县');
INSERT INTO `sys_address_area` VALUES (520425, 0, 100, 520400, '紫云苗族布依族自治县');
INSERT INTO `sys_address_area` VALUES (522201, 0, 100, 522200, '铜仁市');
INSERT INTO `sys_address_area` VALUES (522222, 0, 100, 522200, '江口县');
INSERT INTO `sys_address_area` VALUES (522223, 0, 100, 522200, '玉屏侗族自治县');
INSERT INTO `sys_address_area` VALUES (522224, 0, 100, 522200, '石阡县');
INSERT INTO `sys_address_area` VALUES (522225, 0, 100, 522200, '思南县');
INSERT INTO `sys_address_area` VALUES (522226, 0, 100, 522200, '印江土家族苗族自治县');
INSERT INTO `sys_address_area` VALUES (522227, 0, 100, 522200, '德江县');
INSERT INTO `sys_address_area` VALUES (522228, 0, 100, 522200, '沿河土家族自治县');
INSERT INTO `sys_address_area` VALUES (522229, 0, 100, 522200, '松桃苗族自治县');
INSERT INTO `sys_address_area` VALUES (522230, 0, 100, 522200, '万山特区');
INSERT INTO `sys_address_area` VALUES (522301, 0, 100, 522300, '兴义市');
INSERT INTO `sys_address_area` VALUES (522322, 0, 100, 522300, '兴仁县');
INSERT INTO `sys_address_area` VALUES (522323, 0, 100, 522300, '普安县');
INSERT INTO `sys_address_area` VALUES (522324, 0, 100, 522300, '晴隆县');
INSERT INTO `sys_address_area` VALUES (522325, 0, 100, 522300, '贞丰县');
INSERT INTO `sys_address_area` VALUES (522326, 0, 100, 522300, '望谟县');
INSERT INTO `sys_address_area` VALUES (522327, 0, 100, 522300, '册亨县');
INSERT INTO `sys_address_area` VALUES (522328, 0, 100, 522300, '安龙县');
INSERT INTO `sys_address_area` VALUES (522401, 0, 100, 522400, '毕节市');
INSERT INTO `sys_address_area` VALUES (522422, 0, 100, 522400, '大方县');
INSERT INTO `sys_address_area` VALUES (522423, 0, 100, 522400, '黔西县');
INSERT INTO `sys_address_area` VALUES (522424, 0, 100, 522400, '金沙县');
INSERT INTO `sys_address_area` VALUES (522425, 0, 100, 522400, '织金县');
INSERT INTO `sys_address_area` VALUES (522426, 0, 100, 522400, '纳雍县');
INSERT INTO `sys_address_area` VALUES (522427, 0, 100, 522400, '威宁彝族回族苗族自治县');
INSERT INTO `sys_address_area` VALUES (522428, 0, 100, 522400, '赫章县');
INSERT INTO `sys_address_area` VALUES (522601, 0, 100, 522600, '凯里市');
INSERT INTO `sys_address_area` VALUES (522622, 0, 100, 522600, '黄平县');
INSERT INTO `sys_address_area` VALUES (522623, 0, 100, 522600, '施秉县');
INSERT INTO `sys_address_area` VALUES (522624, 0, 100, 522600, '三穗县');
INSERT INTO `sys_address_area` VALUES (522625, 0, 100, 522600, '镇远县');
INSERT INTO `sys_address_area` VALUES (522626, 0, 100, 522600, '岑巩县');
INSERT INTO `sys_address_area` VALUES (522627, 0, 100, 522600, '天柱县');
INSERT INTO `sys_address_area` VALUES (522628, 0, 100, 522600, '锦屏县');
INSERT INTO `sys_address_area` VALUES (522629, 0, 100, 522600, '剑河县');
INSERT INTO `sys_address_area` VALUES (522630, 0, 100, 522600, '台江县');
INSERT INTO `sys_address_area` VALUES (522631, 0, 100, 522600, '黎平县');
INSERT INTO `sys_address_area` VALUES (522632, 0, 100, 522600, '榕江县');
INSERT INTO `sys_address_area` VALUES (522633, 0, 100, 522600, '从江县');
INSERT INTO `sys_address_area` VALUES (522634, 0, 100, 522600, '雷山县');
INSERT INTO `sys_address_area` VALUES (522635, 0, 100, 522600, '麻江县');
INSERT INTO `sys_address_area` VALUES (522636, 0, 100, 522600, '丹寨县');
INSERT INTO `sys_address_area` VALUES (522701, 0, 100, 522700, '都匀市');
INSERT INTO `sys_address_area` VALUES (522702, 0, 100, 522700, '福泉市');
INSERT INTO `sys_address_area` VALUES (522722, 0, 100, 522700, '荔波县');
INSERT INTO `sys_address_area` VALUES (522723, 0, 100, 522700, '贵定县');
INSERT INTO `sys_address_area` VALUES (522725, 0, 100, 522700, '瓮安县');
INSERT INTO `sys_address_area` VALUES (522726, 0, 100, 522700, '独山县');
INSERT INTO `sys_address_area` VALUES (522727, 0, 100, 522700, '平塘县');
INSERT INTO `sys_address_area` VALUES (522728, 0, 100, 522700, '罗甸县');
INSERT INTO `sys_address_area` VALUES (522729, 0, 100, 522700, '长顺县');
INSERT INTO `sys_address_area` VALUES (522730, 0, 100, 522700, '龙里县');
INSERT INTO `sys_address_area` VALUES (522731, 0, 100, 522700, '惠水县');
INSERT INTO `sys_address_area` VALUES (522732, 0, 100, 522700, '三都水族自治县');
INSERT INTO `sys_address_area` VALUES (530101, 0, 100, 530100, '市辖区');
INSERT INTO `sys_address_area` VALUES (530102, 0, 100, 530100, '五华区');
INSERT INTO `sys_address_area` VALUES (530103, 0, 100, 530100, '盘龙区');
INSERT INTO `sys_address_area` VALUES (530111, 0, 100, 530100, '官渡区');
INSERT INTO `sys_address_area` VALUES (530112, 0, 100, 530100, '西山区');
INSERT INTO `sys_address_area` VALUES (530113, 0, 100, 530100, '东川区');
INSERT INTO `sys_address_area` VALUES (530121, 0, 100, 530100, '呈贡县');
INSERT INTO `sys_address_area` VALUES (530122, 0, 100, 530100, '晋宁县');
INSERT INTO `sys_address_area` VALUES (530124, 0, 100, 530100, '富民县');
INSERT INTO `sys_address_area` VALUES (530125, 0, 100, 530100, '宜良县');
INSERT INTO `sys_address_area` VALUES (530126, 0, 100, 530100, '石林彝族自治县');
INSERT INTO `sys_address_area` VALUES (530127, 0, 100, 530100, '嵩明县');
INSERT INTO `sys_address_area` VALUES (530128, 0, 100, 530100, '禄劝彝族苗族自治县');
INSERT INTO `sys_address_area` VALUES (530129, 0, 100, 530100, '寻甸回族彝族自治县');
INSERT INTO `sys_address_area` VALUES (530181, 0, 100, 530100, '安宁市');
INSERT INTO `sys_address_area` VALUES (530301, 0, 100, 530300, '市辖区');
INSERT INTO `sys_address_area` VALUES (530302, 0, 100, 530300, '麒麟区');
INSERT INTO `sys_address_area` VALUES (530321, 0, 100, 530300, '马龙县');
INSERT INTO `sys_address_area` VALUES (530322, 0, 100, 530300, '陆良县');
INSERT INTO `sys_address_area` VALUES (530323, 0, 100, 530300, '师宗县');
INSERT INTO `sys_address_area` VALUES (530324, 0, 100, 530300, '罗平县');
INSERT INTO `sys_address_area` VALUES (530325, 0, 100, 530300, '富源县');
INSERT INTO `sys_address_area` VALUES (530326, 0, 100, 530300, '会泽县');
INSERT INTO `sys_address_area` VALUES (530328, 0, 100, 530300, '沾益县');
INSERT INTO `sys_address_area` VALUES (530381, 0, 100, 530300, '宣威市');
INSERT INTO `sys_address_area` VALUES (530401, 0, 100, 530400, '市辖区');
INSERT INTO `sys_address_area` VALUES (530402, 0, 100, 530400, '红塔区');
INSERT INTO `sys_address_area` VALUES (530421, 0, 100, 530400, '江川县');
INSERT INTO `sys_address_area` VALUES (530422, 0, 100, 530400, '澄江县');
INSERT INTO `sys_address_area` VALUES (530423, 0, 100, 530400, '通海县');
INSERT INTO `sys_address_area` VALUES (530424, 0, 100, 530400, '华宁县');
INSERT INTO `sys_address_area` VALUES (530425, 0, 100, 530400, '易门县');
INSERT INTO `sys_address_area` VALUES (530426, 0, 100, 530400, '峨山彝族自治县');
INSERT INTO `sys_address_area` VALUES (530427, 0, 100, 530400, '新平彝族傣族自治县');
INSERT INTO `sys_address_area` VALUES (530428, 0, 100, 530400, '元江哈尼族彝族傣族自治县');
INSERT INTO `sys_address_area` VALUES (530501, 0, 100, 530500, '市辖区');
INSERT INTO `sys_address_area` VALUES (530502, 0, 100, 530500, '隆阳区');
INSERT INTO `sys_address_area` VALUES (530521, 0, 100, 530500, '施甸县');
INSERT INTO `sys_address_area` VALUES (530522, 0, 100, 530500, '腾冲县');
INSERT INTO `sys_address_area` VALUES (530523, 0, 100, 530500, '龙陵县');
INSERT INTO `sys_address_area` VALUES (530524, 0, 100, 530500, '昌宁县');
INSERT INTO `sys_address_area` VALUES (530601, 0, 100, 530600, '市辖区');
INSERT INTO `sys_address_area` VALUES (530602, 0, 100, 530600, '昭阳区');
INSERT INTO `sys_address_area` VALUES (530621, 0, 100, 530600, '鲁甸县');
INSERT INTO `sys_address_area` VALUES (530622, 0, 100, 530600, '巧家县');
INSERT INTO `sys_address_area` VALUES (530623, 0, 100, 530600, '盐津县');
INSERT INTO `sys_address_area` VALUES (530624, 0, 100, 530600, '大关县');
INSERT INTO `sys_address_area` VALUES (530625, 0, 100, 530600, '永善县');
INSERT INTO `sys_address_area` VALUES (530626, 0, 100, 530600, '绥江县');
INSERT INTO `sys_address_area` VALUES (530627, 0, 100, 530600, '镇雄县');
INSERT INTO `sys_address_area` VALUES (530628, 0, 100, 530600, '彝良县');
INSERT INTO `sys_address_area` VALUES (530629, 0, 100, 530600, '威信县');
INSERT INTO `sys_address_area` VALUES (530630, 0, 100, 530600, '水富县');
INSERT INTO `sys_address_area` VALUES (530701, 0, 100, 530700, '市辖区');
INSERT INTO `sys_address_area` VALUES (530702, 0, 100, 530700, '古城区');
INSERT INTO `sys_address_area` VALUES (530721, 0, 100, 530700, '玉龙纳西族自治县');
INSERT INTO `sys_address_area` VALUES (530722, 0, 100, 530700, '永胜县');
INSERT INTO `sys_address_area` VALUES (530723, 0, 100, 530700, '华坪县');
INSERT INTO `sys_address_area` VALUES (530724, 0, 100, 530700, '宁蒗彝族自治县');
INSERT INTO `sys_address_area` VALUES (530801, 0, 100, 530800, '市辖区');
INSERT INTO `sys_address_area` VALUES (530802, 0, 100, 530800, '翠云区');
INSERT INTO `sys_address_area` VALUES (530821, 0, 100, 530800, '普洱哈尼族彝族自治县');
INSERT INTO `sys_address_area` VALUES (530822, 0, 100, 530800, '墨江哈尼族自治县');
INSERT INTO `sys_address_area` VALUES (530823, 0, 100, 530800, '景东彝族自治县');
INSERT INTO `sys_address_area` VALUES (530824, 0, 100, 530800, '景谷傣族彝族自治县');
INSERT INTO `sys_address_area` VALUES (530825, 0, 100, 530800, '镇沅彝族哈尼族拉祜族自治县');
INSERT INTO `sys_address_area` VALUES (530826, 0, 100, 530800, '江城哈尼族彝族自治县');
INSERT INTO `sys_address_area` VALUES (530827, 0, 100, 530800, '孟连傣族拉祜族佤族自治县');
INSERT INTO `sys_address_area` VALUES (530828, 0, 100, 530800, '澜沧拉祜族自治县');
INSERT INTO `sys_address_area` VALUES (530829, 0, 100, 530800, '西盟佤族自治县');
INSERT INTO `sys_address_area` VALUES (530901, 0, 100, 530900, '市辖区');
INSERT INTO `sys_address_area` VALUES (530902, 0, 100, 530900, '临翔区');
INSERT INTO `sys_address_area` VALUES (530921, 0, 100, 530900, '凤庆县');
INSERT INTO `sys_address_area` VALUES (530922, 0, 100, 530900, '云　县');
INSERT INTO `sys_address_area` VALUES (530923, 0, 100, 530900, '永德县');
INSERT INTO `sys_address_area` VALUES (530924, 0, 100, 530900, '镇康县');
INSERT INTO `sys_address_area` VALUES (530925, 0, 100, 530900, '双江拉祜族佤族布朗族傣族自治县');
INSERT INTO `sys_address_area` VALUES (530926, 0, 100, 530900, '耿马傣族佤族自治县');
INSERT INTO `sys_address_area` VALUES (530927, 0, 100, 530900, '沧源佤族自治县');
INSERT INTO `sys_address_area` VALUES (532301, 0, 100, 532300, '楚雄市');
INSERT INTO `sys_address_area` VALUES (532322, 0, 100, 532300, '双柏县');
INSERT INTO `sys_address_area` VALUES (532323, 0, 100, 532300, '牟定县');
INSERT INTO `sys_address_area` VALUES (532324, 0, 100, 532300, '南华县');
INSERT INTO `sys_address_area` VALUES (532325, 0, 100, 532300, '姚安县');
INSERT INTO `sys_address_area` VALUES (532326, 0, 100, 532300, '大姚县');
INSERT INTO `sys_address_area` VALUES (532327, 0, 100, 532300, '永仁县');
INSERT INTO `sys_address_area` VALUES (532328, 0, 100, 532300, '元谋县');
INSERT INTO `sys_address_area` VALUES (532329, 0, 100, 532300, '武定县');
INSERT INTO `sys_address_area` VALUES (532331, 0, 100, 532300, '禄丰县');
INSERT INTO `sys_address_area` VALUES (532501, 0, 100, 532500, '个旧市');
INSERT INTO `sys_address_area` VALUES (532502, 0, 100, 532500, '开远市');
INSERT INTO `sys_address_area` VALUES (532522, 0, 100, 532500, '蒙自县');
INSERT INTO `sys_address_area` VALUES (532523, 0, 100, 532500, '屏边苗族自治县');
INSERT INTO `sys_address_area` VALUES (532524, 0, 100, 532500, '建水县');
INSERT INTO `sys_address_area` VALUES (532525, 0, 100, 532500, '石屏县');
INSERT INTO `sys_address_area` VALUES (532526, 0, 100, 532500, '弥勒县');
INSERT INTO `sys_address_area` VALUES (532527, 0, 100, 532500, '泸西县');
INSERT INTO `sys_address_area` VALUES (532528, 0, 100, 532500, '元阳县');
INSERT INTO `sys_address_area` VALUES (532529, 0, 100, 532500, '红河县');
INSERT INTO `sys_address_area` VALUES (532530, 0, 100, 532500, '金平苗族瑶族傣族自治县');
INSERT INTO `sys_address_area` VALUES (532531, 0, 100, 532500, '绿春县');
INSERT INTO `sys_address_area` VALUES (532532, 0, 100, 532500, '河口瑶族自治县');
INSERT INTO `sys_address_area` VALUES (532621, 0, 100, 532600, '文山县');
INSERT INTO `sys_address_area` VALUES (532622, 0, 100, 532600, '砚山县');
INSERT INTO `sys_address_area` VALUES (532623, 0, 100, 532600, '西畴县');
INSERT INTO `sys_address_area` VALUES (532624, 0, 100, 532600, '麻栗坡县');
INSERT INTO `sys_address_area` VALUES (532625, 0, 100, 532600, '马关县');
INSERT INTO `sys_address_area` VALUES (532626, 0, 100, 532600, '丘北县');
INSERT INTO `sys_address_area` VALUES (532627, 0, 100, 532600, '广南县');
INSERT INTO `sys_address_area` VALUES (532628, 0, 100, 532600, '富宁县');
INSERT INTO `sys_address_area` VALUES (532801, 0, 100, 532800, '景洪市');
INSERT INTO `sys_address_area` VALUES (532822, 0, 100, 532800, '勐海县');
INSERT INTO `sys_address_area` VALUES (532823, 0, 100, 532800, '勐腊县');
INSERT INTO `sys_address_area` VALUES (532901, 0, 100, 532900, '大理市');
INSERT INTO `sys_address_area` VALUES (532922, 0, 100, 532900, '漾濞彝族自治县');
INSERT INTO `sys_address_area` VALUES (532923, 0, 100, 532900, '祥云县');
INSERT INTO `sys_address_area` VALUES (532924, 0, 100, 532900, '宾川县');
INSERT INTO `sys_address_area` VALUES (532925, 0, 100, 532900, '弥渡县');
INSERT INTO `sys_address_area` VALUES (532926, 0, 100, 532900, '南涧彝族自治县');
INSERT INTO `sys_address_area` VALUES (532927, 0, 100, 532900, '巍山彝族回族自治县');
INSERT INTO `sys_address_area` VALUES (532928, 0, 100, 532900, '永平县');
INSERT INTO `sys_address_area` VALUES (532929, 0, 100, 532900, '云龙县');
INSERT INTO `sys_address_area` VALUES (532930, 0, 100, 532900, '洱源县');
INSERT INTO `sys_address_area` VALUES (532931, 0, 100, 532900, '剑川县');
INSERT INTO `sys_address_area` VALUES (532932, 0, 100, 532900, '鹤庆县');
INSERT INTO `sys_address_area` VALUES (533102, 0, 100, 533100, '瑞丽市');
INSERT INTO `sys_address_area` VALUES (533103, 0, 100, 533100, '潞西市');
INSERT INTO `sys_address_area` VALUES (533122, 0, 100, 533100, '梁河县');
INSERT INTO `sys_address_area` VALUES (533123, 0, 100, 533100, '盈江县');
INSERT INTO `sys_address_area` VALUES (533124, 0, 100, 533100, '陇川县');
INSERT INTO `sys_address_area` VALUES (533321, 0, 100, 533300, '泸水县');
INSERT INTO `sys_address_area` VALUES (533323, 0, 100, 533300, '福贡县');
INSERT INTO `sys_address_area` VALUES (533324, 0, 100, 533300, '贡山独龙族怒族自治县');
INSERT INTO `sys_address_area` VALUES (533325, 0, 100, 533300, '兰坪白族普米族自治县');
INSERT INTO `sys_address_area` VALUES (533421, 0, 100, 533400, '香格里拉县');
INSERT INTO `sys_address_area` VALUES (533422, 0, 100, 533400, '德钦县');
INSERT INTO `sys_address_area` VALUES (533423, 0, 100, 533400, '维西傈僳族自治县');
INSERT INTO `sys_address_area` VALUES (540101, 0, 100, 540100, '市辖区');
INSERT INTO `sys_address_area` VALUES (540102, 0, 100, 540100, '城关区');
INSERT INTO `sys_address_area` VALUES (540121, 0, 100, 540100, '林周县');
INSERT INTO `sys_address_area` VALUES (540122, 0, 100, 540100, '当雄县');
INSERT INTO `sys_address_area` VALUES (540123, 0, 100, 540100, '尼木县');
INSERT INTO `sys_address_area` VALUES (540124, 0, 100, 540100, '曲水县');
INSERT INTO `sys_address_area` VALUES (540125, 0, 100, 540100, '堆龙德庆县');
INSERT INTO `sys_address_area` VALUES (540126, 0, 100, 540100, '达孜县');
INSERT INTO `sys_address_area` VALUES (540127, 0, 100, 540100, '墨竹工卡县');
INSERT INTO `sys_address_area` VALUES (542121, 0, 100, 542100, '昌都县');
INSERT INTO `sys_address_area` VALUES (542122, 0, 100, 542100, '江达县');
INSERT INTO `sys_address_area` VALUES (542123, 0, 100, 542100, '贡觉县');
INSERT INTO `sys_address_area` VALUES (542124, 0, 100, 542100, '类乌齐县');
INSERT INTO `sys_address_area` VALUES (542125, 0, 100, 542100, '丁青县');
INSERT INTO `sys_address_area` VALUES (542126, 0, 100, 542100, '察雅县');
INSERT INTO `sys_address_area` VALUES (542127, 0, 100, 542100, '八宿县');
INSERT INTO `sys_address_area` VALUES (542128, 0, 100, 542100, '左贡县');
INSERT INTO `sys_address_area` VALUES (542129, 0, 100, 542100, '芒康县');
INSERT INTO `sys_address_area` VALUES (542132, 0, 100, 542100, '洛隆县');
INSERT INTO `sys_address_area` VALUES (542133, 0, 100, 542100, '边坝县');
INSERT INTO `sys_address_area` VALUES (542221, 0, 100, 542200, '乃东县');
INSERT INTO `sys_address_area` VALUES (542222, 0, 100, 542200, '扎囊县');
INSERT INTO `sys_address_area` VALUES (542223, 0, 100, 542200, '贡嘎县');
INSERT INTO `sys_address_area` VALUES (542224, 0, 100, 542200, '桑日县');
INSERT INTO `sys_address_area` VALUES (542225, 0, 100, 542200, '琼结县');
INSERT INTO `sys_address_area` VALUES (542226, 0, 100, 542200, '曲松县');
INSERT INTO `sys_address_area` VALUES (542227, 0, 100, 542200, '措美县');
INSERT INTO `sys_address_area` VALUES (542228, 0, 100, 542200, '洛扎县');
INSERT INTO `sys_address_area` VALUES (542229, 0, 100, 542200, '加查县');
INSERT INTO `sys_address_area` VALUES (542231, 0, 100, 542200, '隆子县');
INSERT INTO `sys_address_area` VALUES (542232, 0, 100, 542200, '错那县');
INSERT INTO `sys_address_area` VALUES (542233, 0, 100, 542200, '浪卡子县');
INSERT INTO `sys_address_area` VALUES (542301, 0, 100, 542300, '日喀则市');
INSERT INTO `sys_address_area` VALUES (542322, 0, 100, 542300, '南木林县');
INSERT INTO `sys_address_area` VALUES (542323, 0, 100, 542300, '江孜县');
INSERT INTO `sys_address_area` VALUES (542324, 0, 100, 542300, '定日县');
INSERT INTO `sys_address_area` VALUES (542325, 0, 100, 542300, '萨迦县');
INSERT INTO `sys_address_area` VALUES (542326, 0, 100, 542300, '拉孜县');
INSERT INTO `sys_address_area` VALUES (542327, 0, 100, 542300, '昂仁县');
INSERT INTO `sys_address_area` VALUES (542328, 0, 100, 542300, '谢通门县');
INSERT INTO `sys_address_area` VALUES (542329, 0, 100, 542300, '白朗县');
INSERT INTO `sys_address_area` VALUES (542330, 0, 100, 542300, '仁布县');
INSERT INTO `sys_address_area` VALUES (542331, 0, 100, 542300, '康马县');
INSERT INTO `sys_address_area` VALUES (542332, 0, 100, 542300, '定结县');
INSERT INTO `sys_address_area` VALUES (542333, 0, 100, 542300, '仲巴县');
INSERT INTO `sys_address_area` VALUES (542334, 0, 100, 542300, '亚东县');
INSERT INTO `sys_address_area` VALUES (542335, 0, 100, 542300, '吉隆县');
INSERT INTO `sys_address_area` VALUES (542336, 0, 100, 542300, '聂拉木县');
INSERT INTO `sys_address_area` VALUES (542337, 0, 100, 542300, '萨嘎县');
INSERT INTO `sys_address_area` VALUES (542338, 0, 100, 542300, '岗巴县');
INSERT INTO `sys_address_area` VALUES (542421, 0, 100, 542400, '那曲县');
INSERT INTO `sys_address_area` VALUES (542422, 0, 100, 542400, '嘉黎县');
INSERT INTO `sys_address_area` VALUES (542423, 0, 100, 542400, '比如县');
INSERT INTO `sys_address_area` VALUES (542424, 0, 100, 542400, '聂荣县');
INSERT INTO `sys_address_area` VALUES (542425, 0, 100, 542400, '安多县');
INSERT INTO `sys_address_area` VALUES (542426, 0, 100, 542400, '申扎县');
INSERT INTO `sys_address_area` VALUES (542427, 0, 100, 542400, '索　县');
INSERT INTO `sys_address_area` VALUES (542428, 0, 100, 542400, '班戈县');
INSERT INTO `sys_address_area` VALUES (542429, 0, 100, 542400, '巴青县');
INSERT INTO `sys_address_area` VALUES (542430, 0, 100, 542400, '尼玛县');
INSERT INTO `sys_address_area` VALUES (542521, 0, 100, 542500, '普兰县');
INSERT INTO `sys_address_area` VALUES (542522, 0, 100, 542500, '札达县');
INSERT INTO `sys_address_area` VALUES (542523, 0, 100, 542500, '噶尔县');
INSERT INTO `sys_address_area` VALUES (542524, 0, 100, 542500, '日土县');
INSERT INTO `sys_address_area` VALUES (542525, 0, 100, 542500, '革吉县');
INSERT INTO `sys_address_area` VALUES (542526, 0, 100, 542500, '改则县');
INSERT INTO `sys_address_area` VALUES (542527, 0, 100, 542500, '措勤县');
INSERT INTO `sys_address_area` VALUES (542621, 0, 100, 542600, '林芝县');
INSERT INTO `sys_address_area` VALUES (542622, 0, 100, 542600, '工布江达县');
INSERT INTO `sys_address_area` VALUES (542623, 0, 100, 542600, '米林县');
INSERT INTO `sys_address_area` VALUES (542624, 0, 100, 542600, '墨脱县');
INSERT INTO `sys_address_area` VALUES (542625, 0, 100, 542600, '波密县');
INSERT INTO `sys_address_area` VALUES (542626, 0, 100, 542600, '察隅县');
INSERT INTO `sys_address_area` VALUES (542627, 0, 100, 542600, '朗　县');
INSERT INTO `sys_address_area` VALUES (610101, 0, 100, 610100, '市辖区');
INSERT INTO `sys_address_area` VALUES (610102, 0, 100, 610100, '新城区');
INSERT INTO `sys_address_area` VALUES (610103, 0, 100, 610100, '碑林区');
INSERT INTO `sys_address_area` VALUES (610104, 0, 100, 610100, '莲湖区');
INSERT INTO `sys_address_area` VALUES (610111, 0, 100, 610100, '灞桥区');
INSERT INTO `sys_address_area` VALUES (610112, 0, 100, 610100, '未央区');
INSERT INTO `sys_address_area` VALUES (610113, 0, 100, 610100, '雁塔区');
INSERT INTO `sys_address_area` VALUES (610114, 0, 100, 610100, '阎良区');
INSERT INTO `sys_address_area` VALUES (610115, 0, 100, 610100, '临潼区');
INSERT INTO `sys_address_area` VALUES (610116, 0, 100, 610100, '长安区');
INSERT INTO `sys_address_area` VALUES (610122, 0, 100, 610100, '蓝田县');
INSERT INTO `sys_address_area` VALUES (610124, 0, 100, 610100, '周至县');
INSERT INTO `sys_address_area` VALUES (610125, 0, 100, 610100, '户　县');
INSERT INTO `sys_address_area` VALUES (610126, 0, 100, 610100, '高陵县');
INSERT INTO `sys_address_area` VALUES (610201, 0, 100, 610200, '市辖区');
INSERT INTO `sys_address_area` VALUES (610202, 0, 100, 610200, '王益区');
INSERT INTO `sys_address_area` VALUES (610203, 0, 100, 610200, '印台区');
INSERT INTO `sys_address_area` VALUES (610204, 0, 100, 610200, '耀州区');
INSERT INTO `sys_address_area` VALUES (610222, 0, 100, 610200, '宜君县');
INSERT INTO `sys_address_area` VALUES (610301, 0, 100, 610300, '市辖区');
INSERT INTO `sys_address_area` VALUES (610302, 0, 100, 610300, '渭滨区');
INSERT INTO `sys_address_area` VALUES (610303, 0, 100, 610300, '金台区');
INSERT INTO `sys_address_area` VALUES (610304, 0, 100, 610300, '陈仓区');
INSERT INTO `sys_address_area` VALUES (610322, 0, 100, 610300, '凤翔县');
INSERT INTO `sys_address_area` VALUES (610323, 0, 100, 610300, '岐山县');
INSERT INTO `sys_address_area` VALUES (610324, 0, 100, 610300, '扶风县');
INSERT INTO `sys_address_area` VALUES (610326, 0, 100, 610300, '眉　县');
INSERT INTO `sys_address_area` VALUES (610327, 0, 100, 610300, '陇　县');
INSERT INTO `sys_address_area` VALUES (610328, 0, 100, 610300, '千阳县');
INSERT INTO `sys_address_area` VALUES (610329, 0, 100, 610300, '麟游县');
INSERT INTO `sys_address_area` VALUES (610330, 0, 100, 610300, '凤　县');
INSERT INTO `sys_address_area` VALUES (610331, 0, 100, 610300, '太白县');
INSERT INTO `sys_address_area` VALUES (610401, 0, 100, 610400, '市辖区');
INSERT INTO `sys_address_area` VALUES (610402, 0, 100, 610400, '秦都区');
INSERT INTO `sys_address_area` VALUES (610403, 0, 100, 610400, '杨凌区');
INSERT INTO `sys_address_area` VALUES (610404, 0, 100, 610400, '渭城区');
INSERT INTO `sys_address_area` VALUES (610422, 0, 100, 610400, '三原县');
INSERT INTO `sys_address_area` VALUES (610423, 0, 100, 610400, '泾阳县');
INSERT INTO `sys_address_area` VALUES (610424, 0, 100, 610400, '乾　县');
INSERT INTO `sys_address_area` VALUES (610425, 0, 100, 610400, '礼泉县');
INSERT INTO `sys_address_area` VALUES (610426, 0, 100, 610400, '永寿县');
INSERT INTO `sys_address_area` VALUES (610427, 0, 100, 610400, '彬　县');
INSERT INTO `sys_address_area` VALUES (610428, 0, 100, 610400, '长武县');
INSERT INTO `sys_address_area` VALUES (610429, 0, 100, 610400, '旬邑县');
INSERT INTO `sys_address_area` VALUES (610430, 0, 100, 610400, '淳化县');
INSERT INTO `sys_address_area` VALUES (610431, 0, 100, 610400, '武功县');
INSERT INTO `sys_address_area` VALUES (610481, 0, 100, 610400, '兴平市');
INSERT INTO `sys_address_area` VALUES (610501, 0, 100, 610500, '市辖区');
INSERT INTO `sys_address_area` VALUES (610502, 0, 100, 610500, '临渭区');
INSERT INTO `sys_address_area` VALUES (610521, 0, 100, 610500, '华　县');
INSERT INTO `sys_address_area` VALUES (610522, 0, 100, 610500, '潼关县');
INSERT INTO `sys_address_area` VALUES (610523, 0, 100, 610500, '大荔县');
INSERT INTO `sys_address_area` VALUES (610524, 0, 100, 610500, '合阳县');
INSERT INTO `sys_address_area` VALUES (610525, 0, 100, 610500, '澄城县');
INSERT INTO `sys_address_area` VALUES (610526, 0, 100, 610500, '蒲城县');
INSERT INTO `sys_address_area` VALUES (610527, 0, 100, 610500, '白水县');
INSERT INTO `sys_address_area` VALUES (610528, 0, 100, 610500, '富平县');
INSERT INTO `sys_address_area` VALUES (610581, 0, 100, 610500, '韩城市');
INSERT INTO `sys_address_area` VALUES (610582, 0, 100, 610500, '华阴市');
INSERT INTO `sys_address_area` VALUES (610601, 0, 100, 610600, '市辖区');
INSERT INTO `sys_address_area` VALUES (610602, 0, 100, 610600, '宝塔区');
INSERT INTO `sys_address_area` VALUES (610621, 0, 100, 610600, '延长县');
INSERT INTO `sys_address_area` VALUES (610622, 0, 100, 610600, '延川县');
INSERT INTO `sys_address_area` VALUES (610623, 0, 100, 610600, '子长县');
INSERT INTO `sys_address_area` VALUES (610624, 0, 100, 610600, '安塞县');
INSERT INTO `sys_address_area` VALUES (610625, 0, 100, 610600, '志丹县');
INSERT INTO `sys_address_area` VALUES (610626, 0, 100, 610600, '吴旗县');
INSERT INTO `sys_address_area` VALUES (610627, 0, 100, 610600, '甘泉县');
INSERT INTO `sys_address_area` VALUES (610628, 0, 100, 610600, '富　县');
INSERT INTO `sys_address_area` VALUES (610629, 0, 100, 610600, '洛川县');
INSERT INTO `sys_address_area` VALUES (610630, 0, 100, 610600, '宜川县');
INSERT INTO `sys_address_area` VALUES (610631, 0, 100, 610600, '黄龙县');
INSERT INTO `sys_address_area` VALUES (610632, 0, 100, 610600, '黄陵县');
INSERT INTO `sys_address_area` VALUES (610701, 0, 100, 610700, '市辖区');
INSERT INTO `sys_address_area` VALUES (610702, 0, 100, 610700, '汉台区');
INSERT INTO `sys_address_area` VALUES (610721, 0, 100, 610700, '南郑县');
INSERT INTO `sys_address_area` VALUES (610722, 0, 100, 610700, '城固县');
INSERT INTO `sys_address_area` VALUES (610723, 0, 100, 610700, '洋　县');
INSERT INTO `sys_address_area` VALUES (610724, 0, 100, 610700, '西乡县');
INSERT INTO `sys_address_area` VALUES (610725, 0, 100, 610700, '勉　县');
INSERT INTO `sys_address_area` VALUES (610726, 0, 100, 610700, '宁强县');
INSERT INTO `sys_address_area` VALUES (610727, 0, 100, 610700, '略阳县');
INSERT INTO `sys_address_area` VALUES (610728, 0, 100, 610700, '镇巴县');
INSERT INTO `sys_address_area` VALUES (610729, 0, 100, 610700, '留坝县');
INSERT INTO `sys_address_area` VALUES (610730, 0, 100, 610700, '佛坪县');
INSERT INTO `sys_address_area` VALUES (610801, 0, 100, 610800, '市辖区');
INSERT INTO `sys_address_area` VALUES (610802, 0, 100, 610800, '榆阳区');
INSERT INTO `sys_address_area` VALUES (610821, 0, 100, 610800, '神木县');
INSERT INTO `sys_address_area` VALUES (610822, 0, 100, 610800, '府谷县');
INSERT INTO `sys_address_area` VALUES (610823, 0, 100, 610800, '横山县');
INSERT INTO `sys_address_area` VALUES (610824, 0, 100, 610800, '靖边县');
INSERT INTO `sys_address_area` VALUES (610825, 0, 100, 610800, '定边县');
INSERT INTO `sys_address_area` VALUES (610826, 0, 100, 610800, '绥德县');
INSERT INTO `sys_address_area` VALUES (610827, 0, 100, 610800, '米脂县');
INSERT INTO `sys_address_area` VALUES (610828, 0, 100, 610800, '佳　县');
INSERT INTO `sys_address_area` VALUES (610829, 0, 100, 610800, '吴堡县');
INSERT INTO `sys_address_area` VALUES (610830, 0, 100, 610800, '清涧县');
INSERT INTO `sys_address_area` VALUES (610831, 0, 100, 610800, '子洲县');
INSERT INTO `sys_address_area` VALUES (610901, 0, 100, 610900, '市辖区');
INSERT INTO `sys_address_area` VALUES (610902, 0, 100, 610900, '汉滨区');
INSERT INTO `sys_address_area` VALUES (610921, 0, 100, 610900, '汉阴县');
INSERT INTO `sys_address_area` VALUES (610922, 0, 100, 610900, '石泉县');
INSERT INTO `sys_address_area` VALUES (610923, 0, 100, 610900, '宁陕县');
INSERT INTO `sys_address_area` VALUES (610924, 0, 100, 610900, '紫阳县');
INSERT INTO `sys_address_area` VALUES (610925, 0, 100, 610900, '岚皋县');
INSERT INTO `sys_address_area` VALUES (610926, 0, 100, 610900, '平利县');
INSERT INTO `sys_address_area` VALUES (610927, 0, 100, 610900, '镇坪县');
INSERT INTO `sys_address_area` VALUES (610928, 0, 100, 610900, '旬阳县');
INSERT INTO `sys_address_area` VALUES (610929, 0, 100, 610900, '白河县');
INSERT INTO `sys_address_area` VALUES (611001, 0, 100, 611000, '市辖区');
INSERT INTO `sys_address_area` VALUES (611002, 0, 100, 611000, '商州区');
INSERT INTO `sys_address_area` VALUES (611021, 0, 100, 611000, '洛南县');
INSERT INTO `sys_address_area` VALUES (611022, 0, 100, 611000, '丹凤县');
INSERT INTO `sys_address_area` VALUES (611023, 0, 100, 611000, '商南县');
INSERT INTO `sys_address_area` VALUES (611024, 0, 100, 611000, '山阳县');
INSERT INTO `sys_address_area` VALUES (611025, 0, 100, 611000, '镇安县');
INSERT INTO `sys_address_area` VALUES (611026, 0, 100, 611000, '柞水县');
INSERT INTO `sys_address_area` VALUES (620101, 0, 100, 620100, '市辖区');
INSERT INTO `sys_address_area` VALUES (620102, 0, 100, 620100, '城关区');
INSERT INTO `sys_address_area` VALUES (620103, 0, 100, 620100, '七里河区');
INSERT INTO `sys_address_area` VALUES (620104, 0, 100, 620100, '西固区');
INSERT INTO `sys_address_area` VALUES (620105, 0, 100, 620100, '安宁区');
INSERT INTO `sys_address_area` VALUES (620111, 0, 100, 620100, '红古区');
INSERT INTO `sys_address_area` VALUES (620121, 0, 100, 620100, '永登县');
INSERT INTO `sys_address_area` VALUES (620122, 0, 100, 620100, '皋兰县');
INSERT INTO `sys_address_area` VALUES (620123, 0, 100, 620100, '榆中县');
INSERT INTO `sys_address_area` VALUES (620201, 0, 100, 620200, '市辖区');
INSERT INTO `sys_address_area` VALUES (620301, 0, 100, 620300, '市辖区');
INSERT INTO `sys_address_area` VALUES (620302, 0, 100, 620300, '金川区');
INSERT INTO `sys_address_area` VALUES (620321, 0, 100, 620300, '永昌县');
INSERT INTO `sys_address_area` VALUES (620401, 0, 100, 620400, '市辖区');
INSERT INTO `sys_address_area` VALUES (620402, 0, 100, 620400, '白银区');
INSERT INTO `sys_address_area` VALUES (620403, 0, 100, 620400, '平川区');
INSERT INTO `sys_address_area` VALUES (620421, 0, 100, 620400, '靖远县');
INSERT INTO `sys_address_area` VALUES (620422, 0, 100, 620400, '会宁县');
INSERT INTO `sys_address_area` VALUES (620423, 0, 100, 620400, '景泰县');
INSERT INTO `sys_address_area` VALUES (620501, 0, 100, 620500, '市辖区');
INSERT INTO `sys_address_area` VALUES (620502, 0, 100, 620500, '秦城区');
INSERT INTO `sys_address_area` VALUES (620503, 0, 100, 620500, '北道区');
INSERT INTO `sys_address_area` VALUES (620521, 0, 100, 620500, '清水县');
INSERT INTO `sys_address_area` VALUES (620522, 0, 100, 620500, '秦安县');
INSERT INTO `sys_address_area` VALUES (620523, 0, 100, 620500, '甘谷县');
INSERT INTO `sys_address_area` VALUES (620524, 0, 100, 620500, '武山县');
INSERT INTO `sys_address_area` VALUES (620525, 0, 100, 620500, '张家川回族自治县');
INSERT INTO `sys_address_area` VALUES (620601, 0, 100, 620600, '市辖区');
INSERT INTO `sys_address_area` VALUES (620602, 0, 100, 620600, '凉州区');
INSERT INTO `sys_address_area` VALUES (620621, 0, 100, 620600, '民勤县');
INSERT INTO `sys_address_area` VALUES (620622, 0, 100, 620600, '古浪县');
INSERT INTO `sys_address_area` VALUES (620623, 0, 100, 620600, '天祝藏族自治县');
INSERT INTO `sys_address_area` VALUES (620701, 0, 100, 620700, '市辖区');
INSERT INTO `sys_address_area` VALUES (620702, 0, 100, 620700, '甘州区');
INSERT INTO `sys_address_area` VALUES (620721, 0, 100, 620700, '肃南裕固族自治县');
INSERT INTO `sys_address_area` VALUES (620722, 0, 100, 620700, '民乐县');
INSERT INTO `sys_address_area` VALUES (620723, 0, 100, 620700, '临泽县');
INSERT INTO `sys_address_area` VALUES (620724, 0, 100, 620700, '高台县');
INSERT INTO `sys_address_area` VALUES (620725, 0, 100, 620700, '山丹县');
INSERT INTO `sys_address_area` VALUES (620801, 0, 100, 620800, '市辖区');
INSERT INTO `sys_address_area` VALUES (620802, 0, 100, 620800, '崆峒区');
INSERT INTO `sys_address_area` VALUES (620821, 0, 100, 620800, '泾川县');
INSERT INTO `sys_address_area` VALUES (620822, 0, 100, 620800, '灵台县');
INSERT INTO `sys_address_area` VALUES (620823, 0, 100, 620800, '崇信县');
INSERT INTO `sys_address_area` VALUES (620824, 0, 100, 620800, '华亭县');
INSERT INTO `sys_address_area` VALUES (620825, 0, 100, 620800, '庄浪县');
INSERT INTO `sys_address_area` VALUES (620826, 0, 100, 620800, '静宁县');
INSERT INTO `sys_address_area` VALUES (620901, 0, 100, 620900, '市辖区');
INSERT INTO `sys_address_area` VALUES (620902, 0, 100, 620900, '肃州区');
INSERT INTO `sys_address_area` VALUES (620921, 0, 100, 620900, '金塔县');
INSERT INTO `sys_address_area` VALUES (620922, 0, 100, 620900, '安西县');
INSERT INTO `sys_address_area` VALUES (620923, 0, 100, 620900, '肃北蒙古族自治县');
INSERT INTO `sys_address_area` VALUES (620924, 0, 100, 620900, '阿克塞哈萨克族自治县');
INSERT INTO `sys_address_area` VALUES (620981, 0, 100, 620900, '玉门市');
INSERT INTO `sys_address_area` VALUES (620982, 0, 100, 620900, '敦煌市');
INSERT INTO `sys_address_area` VALUES (621001, 0, 100, 621000, '市辖区');
INSERT INTO `sys_address_area` VALUES (621002, 0, 100, 621000, '西峰区');
INSERT INTO `sys_address_area` VALUES (621021, 0, 100, 621000, '庆城县');
INSERT INTO `sys_address_area` VALUES (621022, 0, 100, 621000, '环　县');
INSERT INTO `sys_address_area` VALUES (621023, 0, 100, 621000, '华池县');
INSERT INTO `sys_address_area` VALUES (621024, 0, 100, 621000, '合水县');
INSERT INTO `sys_address_area` VALUES (621025, 0, 100, 621000, '正宁县');
INSERT INTO `sys_address_area` VALUES (621026, 0, 100, 621000, '宁　县');
INSERT INTO `sys_address_area` VALUES (621027, 0, 100, 621000, '镇原县');
INSERT INTO `sys_address_area` VALUES (621101, 0, 100, 621100, '市辖区');
INSERT INTO `sys_address_area` VALUES (621102, 0, 100, 621100, '安定区');
INSERT INTO `sys_address_area` VALUES (621121, 0, 100, 621100, '通渭县');
INSERT INTO `sys_address_area` VALUES (621122, 0, 100, 621100, '陇西县');
INSERT INTO `sys_address_area` VALUES (621123, 0, 100, 621100, '渭源县');
INSERT INTO `sys_address_area` VALUES (621124, 0, 100, 621100, '临洮县');
INSERT INTO `sys_address_area` VALUES (621125, 0, 100, 621100, '漳　县');
INSERT INTO `sys_address_area` VALUES (621126, 0, 100, 621100, '岷　县');
INSERT INTO `sys_address_area` VALUES (621201, 0, 100, 621200, '市辖区');
INSERT INTO `sys_address_area` VALUES (621202, 0, 100, 621200, '武都区');
INSERT INTO `sys_address_area` VALUES (621221, 0, 100, 621200, '成　县');
INSERT INTO `sys_address_area` VALUES (621222, 0, 100, 621200, '文　县');
INSERT INTO `sys_address_area` VALUES (621223, 0, 100, 621200, '宕昌县');
INSERT INTO `sys_address_area` VALUES (621224, 0, 100, 621200, '康　县');
INSERT INTO `sys_address_area` VALUES (621225, 0, 100, 621200, '西和县');
INSERT INTO `sys_address_area` VALUES (621226, 0, 100, 621200, '礼　县');
INSERT INTO `sys_address_area` VALUES (621227, 0, 100, 621200, '徽　县');
INSERT INTO `sys_address_area` VALUES (621228, 0, 100, 621200, '两当县');
INSERT INTO `sys_address_area` VALUES (622901, 0, 100, 622900, '临夏市');
INSERT INTO `sys_address_area` VALUES (622921, 0, 100, 622900, '临夏县');
INSERT INTO `sys_address_area` VALUES (622922, 0, 100, 622900, '康乐县');
INSERT INTO `sys_address_area` VALUES (622923, 0, 100, 622900, '永靖县');
INSERT INTO `sys_address_area` VALUES (622924, 0, 100, 622900, '广河县');
INSERT INTO `sys_address_area` VALUES (622925, 0, 100, 622900, '和政县');
INSERT INTO `sys_address_area` VALUES (622926, 0, 100, 622900, '东乡族自治县');
INSERT INTO `sys_address_area` VALUES (622927, 0, 100, 622900, '积石山保安族东乡族撒拉族自治县');
INSERT INTO `sys_address_area` VALUES (623001, 0, 100, 623000, '合作市');
INSERT INTO `sys_address_area` VALUES (623021, 0, 100, 623000, '临潭县');
INSERT INTO `sys_address_area` VALUES (623022, 0, 100, 623000, '卓尼县');
INSERT INTO `sys_address_area` VALUES (623023, 0, 100, 623000, '舟曲县');
INSERT INTO `sys_address_area` VALUES (623024, 0, 100, 623000, '迭部县');
INSERT INTO `sys_address_area` VALUES (623025, 0, 100, 623000, '玛曲县');
INSERT INTO `sys_address_area` VALUES (623026, 0, 100, 623000, '碌曲县');
INSERT INTO `sys_address_area` VALUES (623027, 0, 100, 623000, '夏河县');
INSERT INTO `sys_address_area` VALUES (630101, 0, 100, 630100, '市辖区');
INSERT INTO `sys_address_area` VALUES (630102, 0, 100, 630100, '城东区');
INSERT INTO `sys_address_area` VALUES (630103, 0, 100, 630100, '城中区');
INSERT INTO `sys_address_area` VALUES (630104, 0, 100, 630100, '城西区');
INSERT INTO `sys_address_area` VALUES (630105, 0, 100, 630100, '城北区');
INSERT INTO `sys_address_area` VALUES (630121, 0, 100, 630100, '大通回族土族自治县');
INSERT INTO `sys_address_area` VALUES (630122, 0, 100, 630100, '湟中县');
INSERT INTO `sys_address_area` VALUES (630123, 0, 100, 630100, '湟源县');
INSERT INTO `sys_address_area` VALUES (632121, 0, 100, 632100, '平安县');
INSERT INTO `sys_address_area` VALUES (632122, 0, 100, 632100, '民和回族土族自治县');
INSERT INTO `sys_address_area` VALUES (632123, 0, 100, 632100, '乐都县');
INSERT INTO `sys_address_area` VALUES (632126, 0, 100, 632100, '互助土族自治县');
INSERT INTO `sys_address_area` VALUES (632127, 0, 100, 632100, '化隆回族自治县');
INSERT INTO `sys_address_area` VALUES (632128, 0, 100, 632100, '循化撒拉族自治县');
INSERT INTO `sys_address_area` VALUES (632221, 0, 100, 632200, '门源回族自治县');
INSERT INTO `sys_address_area` VALUES (632222, 0, 100, 632200, '祁连县');
INSERT INTO `sys_address_area` VALUES (632223, 0, 100, 632200, '海晏县');
INSERT INTO `sys_address_area` VALUES (632224, 0, 100, 632200, '刚察县');
INSERT INTO `sys_address_area` VALUES (632321, 0, 100, 632300, '同仁县');
INSERT INTO `sys_address_area` VALUES (632322, 0, 100, 632300, '尖扎县');
INSERT INTO `sys_address_area` VALUES (632323, 0, 100, 632300, '泽库县');
INSERT INTO `sys_address_area` VALUES (632324, 0, 100, 632300, '河南蒙古族自治县');
INSERT INTO `sys_address_area` VALUES (632521, 0, 100, 632500, '共和县');
INSERT INTO `sys_address_area` VALUES (632522, 0, 100, 632500, '同德县');
INSERT INTO `sys_address_area` VALUES (632523, 0, 100, 632500, '贵德县');
INSERT INTO `sys_address_area` VALUES (632524, 0, 100, 632500, '兴海县');
INSERT INTO `sys_address_area` VALUES (632525, 0, 100, 632500, '贵南县');
INSERT INTO `sys_address_area` VALUES (632621, 0, 100, 632600, '玛沁县');
INSERT INTO `sys_address_area` VALUES (632622, 0, 100, 632600, '班玛县');
INSERT INTO `sys_address_area` VALUES (632623, 0, 100, 632600, '甘德县');
INSERT INTO `sys_address_area` VALUES (632624, 0, 100, 632600, '达日县');
INSERT INTO `sys_address_area` VALUES (632625, 0, 100, 632600, '久治县');
INSERT INTO `sys_address_area` VALUES (632626, 0, 100, 632600, '玛多县');
INSERT INTO `sys_address_area` VALUES (632721, 0, 100, 632700, '玉树县');
INSERT INTO `sys_address_area` VALUES (632722, 0, 100, 632700, '杂多县');
INSERT INTO `sys_address_area` VALUES (632723, 0, 100, 632700, '称多县');
INSERT INTO `sys_address_area` VALUES (632724, 0, 100, 632700, '治多县');
INSERT INTO `sys_address_area` VALUES (632725, 0, 100, 632700, '囊谦县');
INSERT INTO `sys_address_area` VALUES (632726, 0, 100, 632700, '曲麻莱县');
INSERT INTO `sys_address_area` VALUES (632801, 0, 100, 632800, '格尔木市');
INSERT INTO `sys_address_area` VALUES (632802, 0, 100, 632800, '德令哈市');
INSERT INTO `sys_address_area` VALUES (632821, 0, 100, 632800, '乌兰县');
INSERT INTO `sys_address_area` VALUES (632822, 0, 100, 632800, '都兰县');
INSERT INTO `sys_address_area` VALUES (632823, 0, 100, 632800, '天峻县');
INSERT INTO `sys_address_area` VALUES (640101, 0, 100, 640100, '市辖区');
INSERT INTO `sys_address_area` VALUES (640104, 0, 100, 640100, '兴庆区');
INSERT INTO `sys_address_area` VALUES (640105, 0, 100, 640100, '西夏区');
INSERT INTO `sys_address_area` VALUES (640106, 0, 100, 640100, '金凤区');
INSERT INTO `sys_address_area` VALUES (640121, 0, 100, 640100, '永宁县');
INSERT INTO `sys_address_area` VALUES (640122, 0, 100, 640100, '贺兰县');
INSERT INTO `sys_address_area` VALUES (640181, 0, 100, 640100, '灵武市');
INSERT INTO `sys_address_area` VALUES (640201, 0, 100, 640200, '市辖区');
INSERT INTO `sys_address_area` VALUES (640202, 0, 100, 640200, '大武口区');
INSERT INTO `sys_address_area` VALUES (640205, 0, 100, 640200, '惠农区');
INSERT INTO `sys_address_area` VALUES (640221, 0, 100, 640200, '平罗县');
INSERT INTO `sys_address_area` VALUES (640301, 0, 100, 640300, '市辖区');
INSERT INTO `sys_address_area` VALUES (640302, 0, 100, 640300, '利通区');
INSERT INTO `sys_address_area` VALUES (640323, 0, 100, 640300, '盐池县');
INSERT INTO `sys_address_area` VALUES (640324, 0, 100, 640300, '同心县');
INSERT INTO `sys_address_area` VALUES (640381, 0, 100, 640300, '青铜峡市');
INSERT INTO `sys_address_area` VALUES (640401, 0, 100, 640400, '市辖区');
INSERT INTO `sys_address_area` VALUES (640402, 0, 100, 640400, '原州区');
INSERT INTO `sys_address_area` VALUES (640422, 0, 100, 640400, '西吉县');
INSERT INTO `sys_address_area` VALUES (640423, 0, 100, 640400, '隆德县');
INSERT INTO `sys_address_area` VALUES (640424, 0, 100, 640400, '泾源县');
INSERT INTO `sys_address_area` VALUES (640425, 0, 100, 640400, '彭阳县');
INSERT INTO `sys_address_area` VALUES (640501, 0, 100, 640500, '市辖区');
INSERT INTO `sys_address_area` VALUES (640502, 0, 100, 640500, '沙坡头区');
INSERT INTO `sys_address_area` VALUES (640521, 0, 100, 640500, '中宁县');
INSERT INTO `sys_address_area` VALUES (640522, 0, 100, 640400, '海原县');
INSERT INTO `sys_address_area` VALUES (650101, 0, 100, 650100, '市辖区');
INSERT INTO `sys_address_area` VALUES (650102, 0, 100, 650100, '天山区');
INSERT INTO `sys_address_area` VALUES (650103, 0, 100, 650100, '沙依巴克区');
INSERT INTO `sys_address_area` VALUES (650104, 0, 100, 650100, '新市区');
INSERT INTO `sys_address_area` VALUES (650105, 0, 100, 650100, '水磨沟区');
INSERT INTO `sys_address_area` VALUES (650106, 0, 100, 650100, '头屯河区');
INSERT INTO `sys_address_area` VALUES (650107, 0, 100, 650100, '达坂城区');
INSERT INTO `sys_address_area` VALUES (650108, 0, 100, 650100, '东山区');
INSERT INTO `sys_address_area` VALUES (650121, 0, 100, 650100, '乌鲁木齐县');
INSERT INTO `sys_address_area` VALUES (650201, 0, 100, 650200, '市辖区');
INSERT INTO `sys_address_area` VALUES (650202, 0, 100, 650200, '独山子区');
INSERT INTO `sys_address_area` VALUES (650203, 0, 100, 650200, '克拉玛依区');
INSERT INTO `sys_address_area` VALUES (650204, 0, 100, 650200, '白碱滩区');
INSERT INTO `sys_address_area` VALUES (650205, 0, 100, 650200, '乌尔禾区');
INSERT INTO `sys_address_area` VALUES (652101, 0, 100, 652100, '吐鲁番市');
INSERT INTO `sys_address_area` VALUES (652122, 0, 100, 652100, '鄯善县');
INSERT INTO `sys_address_area` VALUES (652123, 0, 100, 652100, '托克逊县');
INSERT INTO `sys_address_area` VALUES (652201, 0, 100, 652200, '哈密市');
INSERT INTO `sys_address_area` VALUES (652222, 0, 100, 652200, '巴里坤哈萨克自治县');
INSERT INTO `sys_address_area` VALUES (652223, 0, 100, 652200, '伊吾县');
INSERT INTO `sys_address_area` VALUES (652301, 0, 100, 652300, '昌吉市');
INSERT INTO `sys_address_area` VALUES (652302, 0, 100, 652300, '阜康市');
INSERT INTO `sys_address_area` VALUES (652303, 0, 100, 652300, '米泉市');
INSERT INTO `sys_address_area` VALUES (652323, 0, 100, 652300, '呼图壁县');
INSERT INTO `sys_address_area` VALUES (652324, 0, 100, 652300, '玛纳斯县');
INSERT INTO `sys_address_area` VALUES (652325, 0, 100, 652300, '奇台县');
INSERT INTO `sys_address_area` VALUES (652327, 0, 100, 652300, '吉木萨尔县');
INSERT INTO `sys_address_area` VALUES (652328, 0, 100, 652300, '木垒哈萨克自治县');
INSERT INTO `sys_address_area` VALUES (652701, 0, 100, 652700, '博乐市');
INSERT INTO `sys_address_area` VALUES (652722, 0, 100, 652700, '精河县');
INSERT INTO `sys_address_area` VALUES (652723, 0, 100, 652700, '温泉县');
INSERT INTO `sys_address_area` VALUES (652801, 0, 100, 652800, '库尔勒市');
INSERT INTO `sys_address_area` VALUES (652822, 0, 100, 652800, '轮台县');
INSERT INTO `sys_address_area` VALUES (652823, 0, 100, 652800, '尉犁县');
INSERT INTO `sys_address_area` VALUES (652824, 0, 100, 652800, '若羌县');
INSERT INTO `sys_address_area` VALUES (652825, 0, 100, 652800, '且末县');
INSERT INTO `sys_address_area` VALUES (652826, 0, 100, 652800, '焉耆回族自治县');
INSERT INTO `sys_address_area` VALUES (652827, 0, 100, 652800, '和静县');
INSERT INTO `sys_address_area` VALUES (652828, 0, 100, 652800, '和硕县');
INSERT INTO `sys_address_area` VALUES (652829, 0, 100, 652800, '博湖县');
INSERT INTO `sys_address_area` VALUES (652901, 0, 100, 652900, '阿克苏市');
INSERT INTO `sys_address_area` VALUES (652922, 0, 100, 652900, '温宿县');
INSERT INTO `sys_address_area` VALUES (652923, 0, 100, 652900, '库车县');
INSERT INTO `sys_address_area` VALUES (652924, 0, 100, 652900, '沙雅县');
INSERT INTO `sys_address_area` VALUES (652925, 0, 100, 652900, '新和县');
INSERT INTO `sys_address_area` VALUES (652926, 0, 100, 652900, '拜城县');
INSERT INTO `sys_address_area` VALUES (652927, 0, 100, 652900, '乌什县');
INSERT INTO `sys_address_area` VALUES (652928, 0, 100, 652900, '阿瓦提县');
INSERT INTO `sys_address_area` VALUES (652929, 0, 100, 652900, '柯坪县');
INSERT INTO `sys_address_area` VALUES (653001, 0, 100, 653000, '阿图什市');
INSERT INTO `sys_address_area` VALUES (653022, 0, 100, 653000, '阿克陶县');
INSERT INTO `sys_address_area` VALUES (653023, 0, 100, 653000, '阿合奇县');
INSERT INTO `sys_address_area` VALUES (653024, 0, 100, 653000, '乌恰县');
INSERT INTO `sys_address_area` VALUES (653101, 0, 100, 653100, '喀什市');
INSERT INTO `sys_address_area` VALUES (653121, 0, 100, 653100, '疏附县');
INSERT INTO `sys_address_area` VALUES (653122, 0, 100, 653100, '疏勒县');
INSERT INTO `sys_address_area` VALUES (653123, 0, 100, 653100, '英吉沙县');
INSERT INTO `sys_address_area` VALUES (653124, 0, 100, 653100, '泽普县');
INSERT INTO `sys_address_area` VALUES (653125, 0, 100, 653100, '莎车县');
INSERT INTO `sys_address_area` VALUES (653126, 0, 100, 653100, '叶城县');
INSERT INTO `sys_address_area` VALUES (653127, 0, 100, 653100, '麦盖提县');
INSERT INTO `sys_address_area` VALUES (653128, 0, 100, 653100, '岳普湖县');
INSERT INTO `sys_address_area` VALUES (653129, 0, 100, 653100, '伽师县');
INSERT INTO `sys_address_area` VALUES (653130, 0, 100, 653100, '巴楚县');
INSERT INTO `sys_address_area` VALUES (653131, 0, 100, 653100, '塔什库尔干塔吉克自治县');
INSERT INTO `sys_address_area` VALUES (653201, 0, 100, 653200, '和田市');
INSERT INTO `sys_address_area` VALUES (653221, 0, 100, 653200, '和田县');
INSERT INTO `sys_address_area` VALUES (653222, 0, 100, 653200, '墨玉县');
INSERT INTO `sys_address_area` VALUES (653223, 0, 100, 653200, '皮山县');
INSERT INTO `sys_address_area` VALUES (653224, 0, 100, 653200, '洛浦县');
INSERT INTO `sys_address_area` VALUES (653225, 0, 100, 653200, '策勒县');
INSERT INTO `sys_address_area` VALUES (653226, 0, 100, 653200, '于田县');
INSERT INTO `sys_address_area` VALUES (653227, 0, 100, 653200, '民丰县');
INSERT INTO `sys_address_area` VALUES (654002, 0, 100, 654000, '伊宁市');
INSERT INTO `sys_address_area` VALUES (654003, 0, 100, 654000, '奎屯市');
INSERT INTO `sys_address_area` VALUES (654021, 0, 100, 654000, '伊宁县');
INSERT INTO `sys_address_area` VALUES (654022, 0, 100, 654000, '察布查尔锡伯自治县');
INSERT INTO `sys_address_area` VALUES (654023, 0, 100, 654000, '霍城县');
INSERT INTO `sys_address_area` VALUES (654024, 0, 100, 654000, '巩留县');
INSERT INTO `sys_address_area` VALUES (654025, 0, 100, 654000, '新源县');
INSERT INTO `sys_address_area` VALUES (654026, 0, 100, 654000, '昭苏县');
INSERT INTO `sys_address_area` VALUES (654027, 0, 100, 654000, '特克斯县');
INSERT INTO `sys_address_area` VALUES (654028, 0, 100, 654000, '尼勒克县');
INSERT INTO `sys_address_area` VALUES (654201, 0, 100, 654200, '塔城市');
INSERT INTO `sys_address_area` VALUES (654202, 0, 100, 654200, '乌苏市');
INSERT INTO `sys_address_area` VALUES (654221, 0, 100, 654200, '额敏县');
INSERT INTO `sys_address_area` VALUES (654223, 0, 100, 654200, '沙湾县');
INSERT INTO `sys_address_area` VALUES (654224, 0, 100, 654200, '托里县');
INSERT INTO `sys_address_area` VALUES (654225, 0, 100, 654200, '裕民县');
INSERT INTO `sys_address_area` VALUES (654226, 0, 100, 654200, '和布克赛尔蒙古自治县');
INSERT INTO `sys_address_area` VALUES (654301, 0, 100, 654300, '阿勒泰市');
INSERT INTO `sys_address_area` VALUES (654321, 0, 100, 654300, '布尔津县');
INSERT INTO `sys_address_area` VALUES (654322, 0, 100, 654300, '富蕴县');
INSERT INTO `sys_address_area` VALUES (654323, 0, 100, 654300, '福海县');
INSERT INTO `sys_address_area` VALUES (654324, 0, 100, 654300, '哈巴河县');
INSERT INTO `sys_address_area` VALUES (654325, 0, 100, 654300, '青河县');
INSERT INTO `sys_address_area` VALUES (654326, 0, 100, 654300, '吉木乃县');
INSERT INTO `sys_address_area` VALUES (659001, 0, 100, 659000, '石河子市');
INSERT INTO `sys_address_area` VALUES (659002, 0, 100, 659000, '阿拉尔市');
INSERT INTO `sys_address_area` VALUES (659003, 0, 100, 659000, '图木舒克市');
INSERT INTO `sys_address_area` VALUES (659004, 0, 100, 659000, '五家渠市');

-- ----------------------------
-- Table structure for sys_address_city
-- ----------------------------
DROP TABLE IF EXISTS `sys_address_city`;
CREATE TABLE `sys_address_city`  (
  `city_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '城市ID：[1,8388607]',
  `show` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可见：[0,2]0为仅表单可见，1为仅表单和搜索时可见 ，2为均可见',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `province_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所属省份ID：[1,8388607]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '城市名称：[0,16]',
  PRIMARY KEY (`city_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 659001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '城市：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_address_city
-- ----------------------------
INSERT INTO `sys_address_city` VALUES (110100, 0, 100, 110000, '市辖区');
INSERT INTO `sys_address_city` VALUES (110200, 0, 100, 110000, '县');
INSERT INTO `sys_address_city` VALUES (120100, 0, 100, 120000, '市辖区');
INSERT INTO `sys_address_city` VALUES (120200, 0, 100, 120000, '县');
INSERT INTO `sys_address_city` VALUES (130100, 0, 100, 130000, '石家庄市');
INSERT INTO `sys_address_city` VALUES (130200, 0, 100, 130000, '唐山市');
INSERT INTO `sys_address_city` VALUES (130300, 0, 100, 130000, '秦皇岛市');
INSERT INTO `sys_address_city` VALUES (130400, 0, 100, 130000, '邯郸市');
INSERT INTO `sys_address_city` VALUES (130500, 0, 100, 130000, '邢台市');
INSERT INTO `sys_address_city` VALUES (130600, 0, 100, 130000, '保定市');
INSERT INTO `sys_address_city` VALUES (130700, 0, 100, 130000, '张家口市');
INSERT INTO `sys_address_city` VALUES (130800, 0, 100, 130000, '承德市');
INSERT INTO `sys_address_city` VALUES (130900, 0, 100, 130000, '沧州市');
INSERT INTO `sys_address_city` VALUES (131000, 0, 100, 130000, '廊坊市');
INSERT INTO `sys_address_city` VALUES (131100, 0, 100, 130000, '衡水市');
INSERT INTO `sys_address_city` VALUES (140100, 0, 100, 140000, '太原市');
INSERT INTO `sys_address_city` VALUES (140200, 0, 100, 140000, '大同市');
INSERT INTO `sys_address_city` VALUES (140300, 0, 100, 140000, '阳泉市');
INSERT INTO `sys_address_city` VALUES (140400, 0, 100, 140000, '长治市');
INSERT INTO `sys_address_city` VALUES (140500, 0, 100, 140000, '晋城市');
INSERT INTO `sys_address_city` VALUES (140600, 0, 100, 140000, '朔州市');
INSERT INTO `sys_address_city` VALUES (140700, 0, 100, 140000, '晋中市');
INSERT INTO `sys_address_city` VALUES (140800, 0, 100, 140000, '运城市');
INSERT INTO `sys_address_city` VALUES (140900, 0, 100, 140000, '忻州市');
INSERT INTO `sys_address_city` VALUES (141000, 0, 100, 140000, '临汾市');
INSERT INTO `sys_address_city` VALUES (141100, 0, 100, 140000, '吕梁市');
INSERT INTO `sys_address_city` VALUES (150100, 0, 100, 150000, '呼和浩特市');
INSERT INTO `sys_address_city` VALUES (150200, 0, 100, 150000, '包头市');
INSERT INTO `sys_address_city` VALUES (150300, 0, 100, 150000, '乌海市');
INSERT INTO `sys_address_city` VALUES (150400, 0, 100, 150000, '赤峰市');
INSERT INTO `sys_address_city` VALUES (150500, 0, 100, 150000, '通辽市');
INSERT INTO `sys_address_city` VALUES (150600, 0, 100, 150000, '鄂尔多斯市');
INSERT INTO `sys_address_city` VALUES (150700, 0, 100, 150000, '呼伦贝尔市');
INSERT INTO `sys_address_city` VALUES (150800, 0, 100, 150000, '巴彦淖尔市');
INSERT INTO `sys_address_city` VALUES (150900, 0, 100, 150000, '乌兰察布市');
INSERT INTO `sys_address_city` VALUES (152200, 0, 100, 150000, '兴安盟');
INSERT INTO `sys_address_city` VALUES (152500, 0, 100, 150000, '锡林郭勒盟');
INSERT INTO `sys_address_city` VALUES (152900, 0, 100, 150000, '阿拉善盟');
INSERT INTO `sys_address_city` VALUES (210100, 0, 100, 210000, '沈阳市');
INSERT INTO `sys_address_city` VALUES (210200, 0, 100, 210000, '大连市');
INSERT INTO `sys_address_city` VALUES (210300, 0, 100, 210000, '鞍山市');
INSERT INTO `sys_address_city` VALUES (210400, 0, 100, 210000, '抚顺市');
INSERT INTO `sys_address_city` VALUES (210500, 0, 100, 210000, '本溪市');
INSERT INTO `sys_address_city` VALUES (210600, 0, 100, 210000, '丹东市');
INSERT INTO `sys_address_city` VALUES (210700, 0, 100, 210000, '锦州市');
INSERT INTO `sys_address_city` VALUES (210800, 0, 100, 210000, '营口市');
INSERT INTO `sys_address_city` VALUES (210900, 0, 100, 210000, '阜新市');
INSERT INTO `sys_address_city` VALUES (211000, 0, 100, 210000, '辽阳市');
INSERT INTO `sys_address_city` VALUES (211100, 0, 100, 210000, '盘锦市');
INSERT INTO `sys_address_city` VALUES (211200, 0, 100, 210000, '铁岭市');
INSERT INTO `sys_address_city` VALUES (211300, 0, 100, 210000, '朝阳市');
INSERT INTO `sys_address_city` VALUES (211400, 0, 100, 210000, '葫芦岛市');
INSERT INTO `sys_address_city` VALUES (220100, 0, 100, 220000, '长春市');
INSERT INTO `sys_address_city` VALUES (220200, 0, 100, 220000, '吉林市');
INSERT INTO `sys_address_city` VALUES (220300, 0, 100, 220000, '四平市');
INSERT INTO `sys_address_city` VALUES (220400, 0, 100, 220000, '辽源市');
INSERT INTO `sys_address_city` VALUES (220500, 0, 100, 220000, '通化市');
INSERT INTO `sys_address_city` VALUES (220600, 0, 100, 220000, '白山市');
INSERT INTO `sys_address_city` VALUES (220700, 0, 100, 220000, '松原市');
INSERT INTO `sys_address_city` VALUES (220800, 0, 100, 220000, '白城市');
INSERT INTO `sys_address_city` VALUES (222400, 0, 100, 220000, '延边朝鲜族自治州');
INSERT INTO `sys_address_city` VALUES (230100, 0, 100, 230000, '哈尔滨市');
INSERT INTO `sys_address_city` VALUES (230200, 0, 100, 230000, '齐齐哈尔市');
INSERT INTO `sys_address_city` VALUES (230300, 0, 100, 230000, '鸡西市');
INSERT INTO `sys_address_city` VALUES (230400, 0, 100, 230000, '鹤岗市');
INSERT INTO `sys_address_city` VALUES (230500, 0, 100, 230000, '双鸭山市');
INSERT INTO `sys_address_city` VALUES (230600, 0, 100, 230000, '大庆市');
INSERT INTO `sys_address_city` VALUES (230700, 0, 100, 230000, '伊春市');
INSERT INTO `sys_address_city` VALUES (230800, 0, 100, 230000, '佳木斯市');
INSERT INTO `sys_address_city` VALUES (230900, 0, 100, 230000, '七台河市');
INSERT INTO `sys_address_city` VALUES (231000, 0, 100, 230000, '牡丹江市');
INSERT INTO `sys_address_city` VALUES (231100, 0, 100, 230000, '黑河市');
INSERT INTO `sys_address_city` VALUES (231200, 0, 100, 230000, '绥化市');
INSERT INTO `sys_address_city` VALUES (232700, 0, 100, 230000, '大兴安岭地区');
INSERT INTO `sys_address_city` VALUES (310100, 0, 100, 310000, '市辖区');
INSERT INTO `sys_address_city` VALUES (310200, 0, 100, 310000, '县');
INSERT INTO `sys_address_city` VALUES (320100, 0, 100, 320000, '南京市');
INSERT INTO `sys_address_city` VALUES (320200, 0, 100, 320000, '无锡市');
INSERT INTO `sys_address_city` VALUES (320300, 0, 100, 320000, '徐州市');
INSERT INTO `sys_address_city` VALUES (320400, 0, 100, 320000, '常州市');
INSERT INTO `sys_address_city` VALUES (320500, 0, 100, 320000, '苏州市');
INSERT INTO `sys_address_city` VALUES (320600, 0, 100, 320000, '南通市');
INSERT INTO `sys_address_city` VALUES (320700, 0, 100, 320000, '连云港市');
INSERT INTO `sys_address_city` VALUES (320800, 0, 100, 320000, '淮安市');
INSERT INTO `sys_address_city` VALUES (320900, 0, 100, 320000, '盐城市');
INSERT INTO `sys_address_city` VALUES (321000, 0, 100, 320000, '扬州市');
INSERT INTO `sys_address_city` VALUES (321100, 0, 100, 320000, '镇江市');
INSERT INTO `sys_address_city` VALUES (321200, 0, 100, 320000, '泰州市');
INSERT INTO `sys_address_city` VALUES (321300, 0, 100, 320000, '宿迁市');
INSERT INTO `sys_address_city` VALUES (330100, 0, 100, 330000, '杭州市');
INSERT INTO `sys_address_city` VALUES (330200, 0, 100, 330000, '宁波市');
INSERT INTO `sys_address_city` VALUES (330300, 0, 100, 330000, '温州市');
INSERT INTO `sys_address_city` VALUES (330400, 0, 100, 330000, '嘉兴市');
INSERT INTO `sys_address_city` VALUES (330500, 0, 100, 330000, '湖州市');
INSERT INTO `sys_address_city` VALUES (330600, 0, 100, 330000, '绍兴市');
INSERT INTO `sys_address_city` VALUES (330700, 0, 100, 330000, '金华市');
INSERT INTO `sys_address_city` VALUES (330800, 0, 100, 330000, '衢州市');
INSERT INTO `sys_address_city` VALUES (330900, 0, 100, 330000, '舟山市');
INSERT INTO `sys_address_city` VALUES (331000, 0, 100, 330000, '台州市');
INSERT INTO `sys_address_city` VALUES (331100, 0, 100, 330000, '丽水市');
INSERT INTO `sys_address_city` VALUES (340100, 0, 100, 340000, '合肥市');
INSERT INTO `sys_address_city` VALUES (340200, 0, 100, 340000, '芜湖市');
INSERT INTO `sys_address_city` VALUES (340300, 0, 100, 340000, '蚌埠市');
INSERT INTO `sys_address_city` VALUES (340400, 0, 100, 340000, '淮南市');
INSERT INTO `sys_address_city` VALUES (340500, 0, 100, 340000, '马鞍山市');
INSERT INTO `sys_address_city` VALUES (340600, 0, 100, 340000, '淮北市');
INSERT INTO `sys_address_city` VALUES (340700, 0, 100, 340000, '铜陵市');
INSERT INTO `sys_address_city` VALUES (340800, 0, 100, 340000, '安庆市');
INSERT INTO `sys_address_city` VALUES (341000, 0, 100, 340000, '黄山市');
INSERT INTO `sys_address_city` VALUES (341100, 0, 100, 340000, '滁州市');
INSERT INTO `sys_address_city` VALUES (341200, 0, 100, 340000, '阜阳市');
INSERT INTO `sys_address_city` VALUES (341300, 0, 100, 340000, '宿州市');
INSERT INTO `sys_address_city` VALUES (341400, 0, 100, 340000, '巢湖市');
INSERT INTO `sys_address_city` VALUES (341500, 0, 100, 340000, '六安市');
INSERT INTO `sys_address_city` VALUES (341600, 0, 100, 340000, '亳州市');
INSERT INTO `sys_address_city` VALUES (341700, 0, 100, 340000, '池州市');
INSERT INTO `sys_address_city` VALUES (341800, 0, 100, 340000, '宣城市');
INSERT INTO `sys_address_city` VALUES (350100, 0, 100, 350000, '福州市');
INSERT INTO `sys_address_city` VALUES (350200, 0, 100, 350000, '厦门市');
INSERT INTO `sys_address_city` VALUES (350300, 0, 100, 350000, '莆田市');
INSERT INTO `sys_address_city` VALUES (350400, 0, 100, 350000, '三明市');
INSERT INTO `sys_address_city` VALUES (350500, 0, 100, 350000, '泉州市');
INSERT INTO `sys_address_city` VALUES (350600, 0, 100, 350000, '漳州市');
INSERT INTO `sys_address_city` VALUES (350700, 0, 100, 350000, '南平市');
INSERT INTO `sys_address_city` VALUES (350800, 0, 100, 350000, '龙岩市');
INSERT INTO `sys_address_city` VALUES (350900, 0, 100, 350000, '宁德市');
INSERT INTO `sys_address_city` VALUES (360100, 0, 100, 360000, '南昌市');
INSERT INTO `sys_address_city` VALUES (360200, 0, 100, 360000, '景德镇市');
INSERT INTO `sys_address_city` VALUES (360300, 0, 100, 360000, '萍乡市');
INSERT INTO `sys_address_city` VALUES (360400, 0, 100, 360000, '九江市');
INSERT INTO `sys_address_city` VALUES (360500, 0, 100, 360000, '新余市');
INSERT INTO `sys_address_city` VALUES (360600, 0, 100, 360000, '鹰潭市');
INSERT INTO `sys_address_city` VALUES (360700, 0, 100, 360000, '赣州市');
INSERT INTO `sys_address_city` VALUES (360800, 0, 100, 360000, '吉安市');
INSERT INTO `sys_address_city` VALUES (360900, 0, 100, 360000, '宜春市');
INSERT INTO `sys_address_city` VALUES (361000, 0, 100, 360000, '抚州市');
INSERT INTO `sys_address_city` VALUES (361100, 0, 100, 360000, '上饶市');
INSERT INTO `sys_address_city` VALUES (370100, 0, 100, 370000, '济南市');
INSERT INTO `sys_address_city` VALUES (370200, 0, 100, 370000, '青岛市');
INSERT INTO `sys_address_city` VALUES (370300, 0, 100, 370000, '淄博市');
INSERT INTO `sys_address_city` VALUES (370400, 0, 100, 370000, '枣庄市');
INSERT INTO `sys_address_city` VALUES (370500, 0, 100, 370000, '东营市');
INSERT INTO `sys_address_city` VALUES (370600, 0, 100, 370000, '烟台市');
INSERT INTO `sys_address_city` VALUES (370700, 0, 100, 370000, '潍坊市');
INSERT INTO `sys_address_city` VALUES (370800, 0, 100, 370000, '济宁市');
INSERT INTO `sys_address_city` VALUES (370900, 0, 100, 370000, '泰安市');
INSERT INTO `sys_address_city` VALUES (371000, 0, 100, 370000, '威海市');
INSERT INTO `sys_address_city` VALUES (371100, 0, 100, 370000, '日照市');
INSERT INTO `sys_address_city` VALUES (371200, 0, 100, 370000, '莱芜市');
INSERT INTO `sys_address_city` VALUES (371300, 0, 100, 370000, '临沂市');
INSERT INTO `sys_address_city` VALUES (371400, 0, 100, 370000, '德州市');
INSERT INTO `sys_address_city` VALUES (371500, 0, 100, 370000, '聊城市');
INSERT INTO `sys_address_city` VALUES (371600, 0, 100, 370000, '滨州市');
INSERT INTO `sys_address_city` VALUES (371700, 0, 100, 370000, '荷泽市');
INSERT INTO `sys_address_city` VALUES (410100, 0, 100, 410000, '郑州市');
INSERT INTO `sys_address_city` VALUES (410200, 0, 100, 410000, '开封市');
INSERT INTO `sys_address_city` VALUES (410300, 0, 100, 410000, '洛阳市');
INSERT INTO `sys_address_city` VALUES (410400, 0, 100, 410000, '平顶山市');
INSERT INTO `sys_address_city` VALUES (410500, 0, 100, 410000, '安阳市');
INSERT INTO `sys_address_city` VALUES (410600, 0, 100, 410000, '鹤壁市');
INSERT INTO `sys_address_city` VALUES (410700, 0, 100, 410000, '新乡市');
INSERT INTO `sys_address_city` VALUES (410800, 0, 100, 410000, '焦作市');
INSERT INTO `sys_address_city` VALUES (410900, 0, 100, 410000, '濮阳市');
INSERT INTO `sys_address_city` VALUES (411000, 0, 100, 410000, '许昌市');
INSERT INTO `sys_address_city` VALUES (411100, 0, 100, 410000, '漯河市');
INSERT INTO `sys_address_city` VALUES (411200, 0, 100, 410000, '三门峡市');
INSERT INTO `sys_address_city` VALUES (411300, 0, 100, 410000, '南阳市');
INSERT INTO `sys_address_city` VALUES (411400, 0, 100, 410000, '商丘市');
INSERT INTO `sys_address_city` VALUES (411500, 0, 100, 410000, '信阳市');
INSERT INTO `sys_address_city` VALUES (411600, 0, 100, 410000, '周口市');
INSERT INTO `sys_address_city` VALUES (411700, 0, 100, 410000, '驻马店市');
INSERT INTO `sys_address_city` VALUES (420100, 0, 100, 420000, '武汉市');
INSERT INTO `sys_address_city` VALUES (420200, 0, 100, 420000, '黄石市');
INSERT INTO `sys_address_city` VALUES (420300, 0, 100, 420000, '十堰市');
INSERT INTO `sys_address_city` VALUES (420500, 0, 100, 420000, '宜昌市');
INSERT INTO `sys_address_city` VALUES (420600, 0, 100, 420000, '襄樊市');
INSERT INTO `sys_address_city` VALUES (420700, 0, 100, 420000, '鄂州市');
INSERT INTO `sys_address_city` VALUES (420800, 0, 100, 420000, '荆门市');
INSERT INTO `sys_address_city` VALUES (420900, 0, 100, 420000, '孝感市');
INSERT INTO `sys_address_city` VALUES (421000, 0, 100, 420000, '荆州市');
INSERT INTO `sys_address_city` VALUES (421100, 0, 100, 420000, '黄冈市');
INSERT INTO `sys_address_city` VALUES (421200, 0, 100, 420000, '咸宁市');
INSERT INTO `sys_address_city` VALUES (421300, 0, 100, 420000, '随州市');
INSERT INTO `sys_address_city` VALUES (422800, 0, 100, 420000, '恩施土家族苗族自治州');
INSERT INTO `sys_address_city` VALUES (429000, 0, 100, 420000, '省直辖行政单位');
INSERT INTO `sys_address_city` VALUES (430100, 0, 100, 430000, '长沙市');
INSERT INTO `sys_address_city` VALUES (430200, 0, 100, 430000, '株洲市');
INSERT INTO `sys_address_city` VALUES (430300, 0, 100, 430000, '湘潭市');
INSERT INTO `sys_address_city` VALUES (430400, 0, 100, 430000, '衡阳市');
INSERT INTO `sys_address_city` VALUES (430500, 0, 100, 430000, '邵阳市');
INSERT INTO `sys_address_city` VALUES (430600, 0, 100, 430000, '岳阳市');
INSERT INTO `sys_address_city` VALUES (430700, 0, 100, 430000, '常德市');
INSERT INTO `sys_address_city` VALUES (430800, 0, 100, 430000, '张家界市');
INSERT INTO `sys_address_city` VALUES (430900, 0, 100, 430000, '益阳市');
INSERT INTO `sys_address_city` VALUES (431000, 0, 100, 430000, '郴州市');
INSERT INTO `sys_address_city` VALUES (431100, 0, 100, 430000, '永州市');
INSERT INTO `sys_address_city` VALUES (431200, 0, 100, 430000, '怀化市');
INSERT INTO `sys_address_city` VALUES (431300, 0, 100, 430000, '娄底市');
INSERT INTO `sys_address_city` VALUES (433100, 0, 100, 430000, '湘西土家族苗族自治州');
INSERT INTO `sys_address_city` VALUES (440100, 0, 100, 440000, '广州市');
INSERT INTO `sys_address_city` VALUES (440200, 0, 100, 440000, '韶关市');
INSERT INTO `sys_address_city` VALUES (440300, 0, 100, 440000, '深圳市');
INSERT INTO `sys_address_city` VALUES (440400, 0, 100, 440000, '珠海市');
INSERT INTO `sys_address_city` VALUES (440500, 0, 100, 440000, '汕头市');
INSERT INTO `sys_address_city` VALUES (440600, 0, 100, 440000, '佛山市');
INSERT INTO `sys_address_city` VALUES (440700, 0, 100, 440000, '江门市');
INSERT INTO `sys_address_city` VALUES (440800, 0, 100, 440000, '湛江市');
INSERT INTO `sys_address_city` VALUES (440900, 0, 100, 440000, '茂名市');
INSERT INTO `sys_address_city` VALUES (441200, 0, 100, 440000, '肇庆市');
INSERT INTO `sys_address_city` VALUES (441300, 0, 100, 440000, '惠州市');
INSERT INTO `sys_address_city` VALUES (441400, 0, 100, 440000, '梅州市');
INSERT INTO `sys_address_city` VALUES (441500, 0, 100, 440000, '汕尾市');
INSERT INTO `sys_address_city` VALUES (441600, 0, 100, 440000, '河源市');
INSERT INTO `sys_address_city` VALUES (441700, 0, 100, 440000, '阳江市');
INSERT INTO `sys_address_city` VALUES (441800, 0, 100, 440000, '清远市');
INSERT INTO `sys_address_city` VALUES (441900, 0, 100, 440000, '东莞市');
INSERT INTO `sys_address_city` VALUES (442000, 0, 100, 440000, '中山市');
INSERT INTO `sys_address_city` VALUES (445100, 0, 100, 440000, '潮州市');
INSERT INTO `sys_address_city` VALUES (445200, 0, 100, 440000, '揭阳市');
INSERT INTO `sys_address_city` VALUES (445300, 0, 100, 440000, '云浮市');
INSERT INTO `sys_address_city` VALUES (450100, 0, 100, 450000, '南宁市');
INSERT INTO `sys_address_city` VALUES (450200, 0, 100, 450000, '柳州市');
INSERT INTO `sys_address_city` VALUES (450300, 0, 100, 450000, '桂林市');
INSERT INTO `sys_address_city` VALUES (450400, 0, 100, 450000, '梧州市');
INSERT INTO `sys_address_city` VALUES (450500, 0, 100, 450000, '北海市');
INSERT INTO `sys_address_city` VALUES (450600, 0, 100, 450000, '防城港市');
INSERT INTO `sys_address_city` VALUES (450700, 0, 100, 450000, '钦州市');
INSERT INTO `sys_address_city` VALUES (450800, 0, 100, 450000, '贵港市');
INSERT INTO `sys_address_city` VALUES (450900, 0, 100, 450000, '玉林市');
INSERT INTO `sys_address_city` VALUES (451000, 0, 100, 450000, '百色市');
INSERT INTO `sys_address_city` VALUES (451100, 0, 100, 450000, '贺州市');
INSERT INTO `sys_address_city` VALUES (451200, 0, 100, 450000, '河池市');
INSERT INTO `sys_address_city` VALUES (451300, 0, 100, 450000, '来宾市');
INSERT INTO `sys_address_city` VALUES (451400, 0, 100, 450000, '崇左市');
INSERT INTO `sys_address_city` VALUES (460100, 0, 100, 460000, '海口市');
INSERT INTO `sys_address_city` VALUES (460200, 0, 100, 460000, '三亚市');
INSERT INTO `sys_address_city` VALUES (469000, 0, 100, 460000, '省直辖县级行政单位');
INSERT INTO `sys_address_city` VALUES (500100, 0, 100, 500000, '市辖区');
INSERT INTO `sys_address_city` VALUES (500200, 0, 100, 500000, '县');
INSERT INTO `sys_address_city` VALUES (500300, 0, 100, 500000, '市');
INSERT INTO `sys_address_city` VALUES (510100, 0, 100, 510000, '成都市');
INSERT INTO `sys_address_city` VALUES (510300, 0, 100, 510000, '自贡市');
INSERT INTO `sys_address_city` VALUES (510400, 0, 100, 510000, '攀枝花市');
INSERT INTO `sys_address_city` VALUES (510500, 0, 100, 510000, '泸州市');
INSERT INTO `sys_address_city` VALUES (510600, 0, 100, 510000, '德阳市');
INSERT INTO `sys_address_city` VALUES (510700, 0, 100, 510000, '绵阳市');
INSERT INTO `sys_address_city` VALUES (510800, 0, 100, 510000, '广元市');
INSERT INTO `sys_address_city` VALUES (510900, 0, 100, 510000, '遂宁市');
INSERT INTO `sys_address_city` VALUES (511000, 0, 100, 510000, '内江市');
INSERT INTO `sys_address_city` VALUES (511100, 0, 100, 510000, '乐山市');
INSERT INTO `sys_address_city` VALUES (511300, 0, 100, 510000, '南充市');
INSERT INTO `sys_address_city` VALUES (511400, 0, 100, 510000, '眉山市');
INSERT INTO `sys_address_city` VALUES (511500, 0, 100, 510000, '宜宾市');
INSERT INTO `sys_address_city` VALUES (511600, 0, 100, 510000, '广安市');
INSERT INTO `sys_address_city` VALUES (511700, 0, 100, 510000, '达州市');
INSERT INTO `sys_address_city` VALUES (511800, 0, 100, 510000, '雅安市');
INSERT INTO `sys_address_city` VALUES (511900, 0, 100, 510000, '巴中市');
INSERT INTO `sys_address_city` VALUES (512000, 0, 100, 510000, '资阳市');
INSERT INTO `sys_address_city` VALUES (513200, 0, 100, 510000, '阿坝藏族羌族自治州');
INSERT INTO `sys_address_city` VALUES (513300, 0, 100, 510000, '甘孜藏族自治州');
INSERT INTO `sys_address_city` VALUES (513400, 0, 100, 510000, '凉山彝族自治州');
INSERT INTO `sys_address_city` VALUES (520100, 0, 100, 520000, '贵阳市');
INSERT INTO `sys_address_city` VALUES (520200, 0, 100, 520000, '六盘水市');
INSERT INTO `sys_address_city` VALUES (520300, 0, 100, 520000, '遵义市');
INSERT INTO `sys_address_city` VALUES (520400, 0, 100, 520000, '安顺市');
INSERT INTO `sys_address_city` VALUES (522200, 0, 100, 520000, '铜仁地区');
INSERT INTO `sys_address_city` VALUES (522300, 0, 100, 520000, '黔西南布依族苗族自治州');
INSERT INTO `sys_address_city` VALUES (522400, 0, 100, 520000, '毕节地区');
INSERT INTO `sys_address_city` VALUES (522600, 0, 100, 520000, '黔东南苗族侗族自治州');
INSERT INTO `sys_address_city` VALUES (522700, 0, 100, 520000, '黔南布依族苗族自治州');
INSERT INTO `sys_address_city` VALUES (530100, 0, 100, 530000, '昆明市');
INSERT INTO `sys_address_city` VALUES (530300, 0, 100, 530000, '曲靖市');
INSERT INTO `sys_address_city` VALUES (530400, 0, 100, 530000, '玉溪市');
INSERT INTO `sys_address_city` VALUES (530500, 0, 100, 530000, '保山市');
INSERT INTO `sys_address_city` VALUES (530600, 0, 100, 530000, '昭通市');
INSERT INTO `sys_address_city` VALUES (530700, 0, 100, 530000, '丽江市');
INSERT INTO `sys_address_city` VALUES (530800, 0, 100, 530000, '思茅市');
INSERT INTO `sys_address_city` VALUES (530900, 0, 100, 530000, '临沧市');
INSERT INTO `sys_address_city` VALUES (532300, 0, 100, 530000, '楚雄彝族自治州');
INSERT INTO `sys_address_city` VALUES (532500, 0, 100, 530000, '红河哈尼族彝族自治州');
INSERT INTO `sys_address_city` VALUES (532600, 0, 100, 530000, '文山壮族苗族自治州');
INSERT INTO `sys_address_city` VALUES (532800, 0, 100, 530000, '西双版纳傣族自治州');
INSERT INTO `sys_address_city` VALUES (532900, 0, 100, 530000, '大理白族自治州');
INSERT INTO `sys_address_city` VALUES (533100, 0, 100, 530000, '德宏傣族景颇族自治州');
INSERT INTO `sys_address_city` VALUES (533300, 0, 100, 530000, '怒江傈僳族自治州');
INSERT INTO `sys_address_city` VALUES (533400, 0, 100, 530000, '迪庆藏族自治州');
INSERT INTO `sys_address_city` VALUES (540100, 0, 100, 540000, '拉萨市');
INSERT INTO `sys_address_city` VALUES (542100, 0, 100, 540000, '昌都地区');
INSERT INTO `sys_address_city` VALUES (542200, 0, 100, 540000, '山南地区');
INSERT INTO `sys_address_city` VALUES (542300, 0, 100, 540000, '日喀则地区');
INSERT INTO `sys_address_city` VALUES (542400, 0, 100, 540000, '那曲地区');
INSERT INTO `sys_address_city` VALUES (542500, 0, 100, 540000, '阿里地区');
INSERT INTO `sys_address_city` VALUES (542600, 0, 100, 540000, '林芝地区');
INSERT INTO `sys_address_city` VALUES (610100, 0, 100, 610000, '西安市');
INSERT INTO `sys_address_city` VALUES (610200, 0, 100, 610000, '铜川市');
INSERT INTO `sys_address_city` VALUES (610300, 0, 100, 610000, '宝鸡市');
INSERT INTO `sys_address_city` VALUES (610400, 0, 100, 610000, '咸阳市');
INSERT INTO `sys_address_city` VALUES (610500, 0, 100, 610000, '渭南市');
INSERT INTO `sys_address_city` VALUES (610600, 0, 100, 610000, '延安市');
INSERT INTO `sys_address_city` VALUES (610700, 0, 100, 610000, '汉中市');
INSERT INTO `sys_address_city` VALUES (610800, 0, 100, 610000, '榆林市');
INSERT INTO `sys_address_city` VALUES (610900, 0, 100, 610000, '安康市');
INSERT INTO `sys_address_city` VALUES (611000, 0, 100, 610000, '商洛市');
INSERT INTO `sys_address_city` VALUES (620100, 0, 100, 620000, '兰州市');
INSERT INTO `sys_address_city` VALUES (620200, 0, 100, 620000, '嘉峪关市');
INSERT INTO `sys_address_city` VALUES (620300, 0, 100, 620000, '金昌市');
INSERT INTO `sys_address_city` VALUES (620400, 0, 100, 620000, '白银市');
INSERT INTO `sys_address_city` VALUES (620500, 0, 100, 620000, '天水市');
INSERT INTO `sys_address_city` VALUES (620600, 0, 100, 620000, '武威市');
INSERT INTO `sys_address_city` VALUES (620700, 0, 100, 620000, '张掖市');
INSERT INTO `sys_address_city` VALUES (620800, 0, 100, 620000, '平凉市');
INSERT INTO `sys_address_city` VALUES (620900, 0, 100, 620000, '酒泉市');
INSERT INTO `sys_address_city` VALUES (621000, 0, 100, 620000, '庆阳市');
INSERT INTO `sys_address_city` VALUES (621100, 0, 100, 620000, '定西市');
INSERT INTO `sys_address_city` VALUES (621200, 0, 100, 620000, '陇南市');
INSERT INTO `sys_address_city` VALUES (622900, 0, 100, 620000, '临夏回族自治州');
INSERT INTO `sys_address_city` VALUES (623000, 0, 100, 620000, '甘南藏族自治州');
INSERT INTO `sys_address_city` VALUES (630100, 0, 100, 630000, '西宁市');
INSERT INTO `sys_address_city` VALUES (632100, 0, 100, 630000, '海东地区');
INSERT INTO `sys_address_city` VALUES (632200, 0, 100, 630000, '海北藏族自治州');
INSERT INTO `sys_address_city` VALUES (632300, 0, 100, 630000, '黄南藏族自治州');
INSERT INTO `sys_address_city` VALUES (632500, 0, 100, 630000, '海南藏族自治州');
INSERT INTO `sys_address_city` VALUES (632600, 0, 100, 630000, '果洛藏族自治州');
INSERT INTO `sys_address_city` VALUES (632700, 0, 100, 630000, '玉树藏族自治州');
INSERT INTO `sys_address_city` VALUES (632800, 0, 100, 630000, '海西蒙古族藏族自治州');
INSERT INTO `sys_address_city` VALUES (640100, 0, 100, 640000, '银川市');
INSERT INTO `sys_address_city` VALUES (640200, 0, 100, 640000, '石嘴山市');
INSERT INTO `sys_address_city` VALUES (640300, 0, 100, 640000, '吴忠市');
INSERT INTO `sys_address_city` VALUES (640400, 0, 100, 640000, '固原市');
INSERT INTO `sys_address_city` VALUES (640500, 0, 100, 640000, '中卫市');
INSERT INTO `sys_address_city` VALUES (650100, 0, 100, 650000, '乌鲁木齐市');
INSERT INTO `sys_address_city` VALUES (650200, 0, 100, 650000, '克拉玛依市');
INSERT INTO `sys_address_city` VALUES (652100, 0, 100, 650000, '吐鲁番地区');
INSERT INTO `sys_address_city` VALUES (652200, 0, 100, 650000, '哈密地区');
INSERT INTO `sys_address_city` VALUES (652300, 0, 100, 650000, '昌吉回族自治州');
INSERT INTO `sys_address_city` VALUES (652700, 0, 100, 650000, '博尔塔拉蒙古自治州');
INSERT INTO `sys_address_city` VALUES (652800, 0, 100, 650000, '巴音郭楞蒙古自治州');
INSERT INTO `sys_address_city` VALUES (652900, 0, 100, 650000, '阿克苏地区');
INSERT INTO `sys_address_city` VALUES (653000, 0, 100, 650000, '克孜勒苏柯尔克孜自治州');
INSERT INTO `sys_address_city` VALUES (653100, 0, 100, 650000, '喀什地区');
INSERT INTO `sys_address_city` VALUES (653200, 0, 100, 650000, '和田地区');
INSERT INTO `sys_address_city` VALUES (654000, 0, 100, 650000, '伊犁哈萨克自治州');
INSERT INTO `sys_address_city` VALUES (654200, 0, 100, 650000, '塔城地区');
INSERT INTO `sys_address_city` VALUES (654300, 0, 100, 650000, '阿勒泰地区');
INSERT INTO `sys_address_city` VALUES (659000, 0, 100, 650000, '省直辖行政单位');

-- ----------------------------
-- Table structure for sys_address_province
-- ----------------------------
DROP TABLE IF EXISTS `sys_address_province`;
CREATE TABLE `sys_address_province`  (
  `province_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '省份ID：[1,8388607]',
  `show` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可见：[0,2]0为仅表单可见，1为仅表单和搜索时可见 ，2为均可见',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省份名称：[0,16]',
  PRIMARY KEY (`province_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 820001 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '省份：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_address_province
-- ----------------------------
INSERT INTO `sys_address_province` VALUES (110000, 0, 100, '北京市');
INSERT INTO `sys_address_province` VALUES (120000, 0, 100, '天津市');
INSERT INTO `sys_address_province` VALUES (130000, 0, 100, '河北省');
INSERT INTO `sys_address_province` VALUES (140000, 0, 100, '山西省');
INSERT INTO `sys_address_province` VALUES (150000, 0, 100, '内蒙古自治区');
INSERT INTO `sys_address_province` VALUES (210000, 0, 100, '辽宁省');
INSERT INTO `sys_address_province` VALUES (220000, 0, 100, '吉林省');
INSERT INTO `sys_address_province` VALUES (230000, 0, 100, '黑龙江省');
INSERT INTO `sys_address_province` VALUES (310000, 0, 100, '上海市');
INSERT INTO `sys_address_province` VALUES (320000, 0, 100, '江苏省');
INSERT INTO `sys_address_province` VALUES (330000, 0, 100, '浙江省');
INSERT INTO `sys_address_province` VALUES (340000, 0, 100, '安徽省');
INSERT INTO `sys_address_province` VALUES (350000, 0, 100, '福建省');
INSERT INTO `sys_address_province` VALUES (360000, 0, 100, '江西省');
INSERT INTO `sys_address_province` VALUES (370000, 0, 100, '山东省');
INSERT INTO `sys_address_province` VALUES (410000, 0, 100, '河南省');
INSERT INTO `sys_address_province` VALUES (420000, 0, 100, '湖北省');
INSERT INTO `sys_address_province` VALUES (430000, 0, 100, '湖南省');
INSERT INTO `sys_address_province` VALUES (440000, 0, 100, '广东省');
INSERT INTO `sys_address_province` VALUES (450000, 0, 100, '广西壮族自治区');
INSERT INTO `sys_address_province` VALUES (460000, 0, 100, '海南省');
INSERT INTO `sys_address_province` VALUES (500000, 0, 100, '重庆市');
INSERT INTO `sys_address_province` VALUES (510000, 0, 100, '四川省');
INSERT INTO `sys_address_province` VALUES (520000, 0, 100, '贵州省');
INSERT INTO `sys_address_province` VALUES (530000, 0, 100, '云南省');
INSERT INTO `sys_address_province` VALUES (540000, 0, 100, '西藏自治区');
INSERT INTO `sys_address_province` VALUES (610000, 0, 100, '陕西省');
INSERT INTO `sys_address_province` VALUES (620000, 0, 100, '甘肃省');
INSERT INTO `sys_address_province` VALUES (630000, 0, 100, '青海省');
INSERT INTO `sys_address_province` VALUES (640000, 0, 100, '宁夏回族自治区');
INSERT INTO `sys_address_province` VALUES (650000, 0, 100, '新疆维吾尔自治区');
INSERT INTO `sys_address_province` VALUES (710000, 0, 100, '台湾省');
INSERT INTO `sys_address_province` VALUES (810000, 0, 100, '香港特别行政区');
INSERT INTO `sys_address_province` VALUES (820000, 0, 100, '澳门特别行政区');

-- ----------------------------
-- Table structure for sys_app
-- ----------------------------
DROP TABLE IF EXISTS `sys_app`;
CREATE TABLE `sys_app`  (
  `app_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '应用序号：[0,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可用：[0,1]在未审核状态下， 该应用授权为不可用(0否|1是)',
  `encrypt` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '加解密方式：[0,10](1明文模式|2兼容模式|3安全模式)',
  `times_allow` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '每日允许请求次数：[0,32767]用于限制应用每日可授权次数',
  `times_today` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '今日请求次数：[0,32767]用于记录今日请求授权次数，判断授权次数是否超限',
  `max_age` smallint(5) UNSIGNED NOT NULL DEFAULT 1825 COMMENT '有效期时长：[0,32767]授权应用可以使用的时长，超时需重新申请。单位：天',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '持有者ID：[0,8388607]该客户端所有人的ID(user_account.nickname)',
  `times_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '请求总次数：[0,2147483647]用于记录授权总次数',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '上次使用时间：用于记录上次授权时间，防止频繁操作',
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
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用信息：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_app
-- ----------------------------

-- ----------------------------
-- Table structure for sys_app_refresh
-- ----------------------------
DROP TABLE IF EXISTS `sys_app_refresh`;
CREATE TABLE `sys_app_refresh`  (
  `refresh_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '刷新Token的ID：[0,2147483647]',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]表示当前Token绑定的用户uid(user_account.nickname)',
  `time_create` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间：用来判断刷新令牌有效期',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：用来判断是否频繁刷新访问牌',
  `appid` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '应用ID：[0,16]',
  `refresh_token` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '刷新令牌：[0,32]用来刷新访问牌，保留30天',
  PRIMARY KEY (`refresh_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '应用刷新：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_app_refresh
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置ID：[0,2147483647]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量名：[0,16]',
  `type` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'string' COMMENT '数据类型：[0,16](string,文本型|number,数字型|boolean,布尔型)',
  `title` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量标题：[0,16]可以用中文名',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量值：[0,255]',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '变量描述：[0,255]描述该变量的作用',
  `model` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '数据模型：json格式，用于单选、多选模式',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'theme_name', 'string', '主题风格', 'default', '用于配置系统默认主题风格', '');
INSERT INTO `sys_config` VALUES (2, 'theme_color', 'string', '主题色', 'blue', '用于配置系统默认主题色调', '[{\n   \"name\":\"红\",\n   \"value\": \"red\"\n},{\n   \"name\":\"黄\",\n   \"value\": \"yellow\"\n},{\n   \"name\":\"绿\",\n   \"value\": \"green\"\n},{\n   \"name\":\"蓝\",\n   \"value\": \"blue\"\n},{\n   \"name\":\"紫\",\n   \"value\": \"purple\"\n}\n]');
INSERT INTO `sys_config` VALUES (3, 'sys_lang', 'string', '系统语言', 'zh_cn', '用于配置系统默认语言', '[{\n   \"name\":\"英文\",\n   \"value\": \"en\"\n},{\n   \"name\":\"简体中文\",\n   \"value\": \"zh_cn\"\n},{\n   \"name\":\"繁体中文\",\n   \"value\": \"zh_tw\"\n},{\n   \"name\":\"英文\",\n   \"value\": \"en\"\n},{\n   \"name\":\"日文\",\n   \"value\": \"ja\"\n},{\n   \"name\":\"韩文\",\n   \"value\": \"ko\"\n}\n]');
INSERT INTO `sys_config` VALUES (4, 'sys_lang_list', 'string', '系统支持语言', 'zh_cn en', '', '');

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
) ENGINE = MyISAM AUTO_INCREMENT = 55 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统语言：用于开发站点多国语' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_lang
-- ----------------------------
INSERT INTO `sys_lang` VALUES (1, 'web_name', 'MM', '超级美眉', '', '', '');
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
INSERT INTO `sys_lang` VALUES (20, 'title_document', 'Secondary development document', '二次开发文档', '', '', '');
INSERT INTO `sys_lang` VALUES (21, 'desc_document', 'Have mature program architecture and perfect development documents', '拥有成熟的程序架构和完善的开发文档', '', '', '');
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
INSERT INTO `sys_lang` VALUES (46, 'title_profile', 'Company Profile', '企业简介', '', '', '');
INSERT INTO `sys_lang` VALUES (47, 'content_profile_1', '', '深圳图灵魔方信息科技有限公司专注于科技信息咨询和移动应用开发领域，主要开发电商、社交、区块链相关应用。“图灵魔方”在应用设计和开发领域是为数不多的拥有自主研发框架和高级技术，能够在业内中更快速开发出优质应用。', '', '', '');
INSERT INTO `sys_lang` VALUES (48, 'content_profile_2', '', '原来我们只是为其他开发公司所服务，现在我们直接为需求方服务，不仅价格实惠，还更能实现理想的应用效果。', '', '', '');
INSERT INTO `sys_lang` VALUES (49, 'title_framework', 'MM', '超级美眉', '', '', '');
INSERT INTO `sys_lang` VALUES (50, 'desc_framework', 'Framework', '应用框架', '', '', '');
INSERT INTO `sys_lang` VALUES (51, 'content_framework', '', '这是用JavaScript编程语言开发的商业级应用框架，适用于大型商城、中小型游戏、社交软件开发，框架简化了对函数和数据的调用，让开发应用变得更加轻松、灵活。全新的架构体让多人协作开发和升级维护更加容易，是未来理想的选择。', '', '', '');
INSERT INTO `sys_lang` VALUES (52, 'title_latest_product', 'Latest Product', '最近产品', '', '', '');
INSERT INTO `sys_lang` VALUES (53, 'title_latest_event', 'Latest event', '最近事件', '', '', '');
INSERT INTO `sys_lang` VALUES (54, 'btn_view_all', 'View all', '查看全部', '', '', '');

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message`  (
  `message_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息ID：[0,2147483647]用于记录和识别消息',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言标题：[0,255]',
  `note` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '留言内容：',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统消息：' ROW_FORMAT = Dynamic;

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
  `position` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'top' COMMENT '展现位置：[0,125]top顶部、bottom底部、side侧边，main主要，quick快捷，menu菜单，多个位置用逗号隔开',
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
-- Table structure for url_info
-- ----------------------------
DROP TABLE IF EXISTS `url_info`;
CREATE TABLE `url_info`  (
  `url_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '网址ID',
  `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网址键',
  `url_redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '重定向地址',
  `time_create` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  PRIMARY KEY (`url_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of url_info
-- ----------------------------

-- ----------------------------
-- Table structure for url_log
-- ----------------------------
DROP TABLE IF EXISTS `url_log`;
CREATE TABLE `url_log`  (
  `log_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '网址ID',
  `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网址键',
  `time_create` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '查询参数：用来校验推广者身份，平台等',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问源IP：用来判断是否刷的流量',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of url_log
-- ----------------------------

-- ----------------------------
-- Table structure for url_share
-- ----------------------------
DROP TABLE IF EXISTS `url_share`;
CREATE TABLE `url_share`  (
  `share_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分享ID',
  `user_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建者ID：一般为经纪人ID',
  `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由键：用于匹配路由做跳转',
  `url_redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '转发网址：',
  `time_create` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  PRIMARY KEY (`share_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of url_share
-- ----------------------------

-- ----------------------------
-- Table structure for url_share_log
-- ----------------------------
DROP TABLE IF EXISTS `url_share_log`;
CREATE TABLE `url_share_log`  (
  `log_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '网址ID',
  `key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '网址键',
  `time_create` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  `time_update` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '分享者ID：一般为网红的账号',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '查询参数：用来校验推广者身份，平台等',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问源IP：用来判断是否刷的流量',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of url_share_log
-- ----------------------------

-- ----------------------------
-- Table structure for user_account
-- ----------------------------
DROP TABLE IF EXISTS `user_account`;
CREATE TABLE `user_account`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID：[0,8388607]用户获取其他与用户相关的数据',
  `state` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '账户状态：[0,10](1可用|2异常|3已冻结|4已注销)',
  `vip` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员级别：[0,10]用于确定用户访问权限',
  `gm` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员级别：[0,10]用于确定用户管理权限',
  `mc` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '商家级别：[0,10]用于确定商家用户的管理权限',
  `group_id` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所在用户组：[0,32767]决定用户身份和权限(user_group)',
  `admin_id` smallint(6) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所在管理组：[0,32767]决定用户身份和权限(user_admin)',
  `referee_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '推荐人ID：[0,8388607]用于推荐注册时积分奖级(user_account.nickname.user_id)',
  `login_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '上次登录时间：',
  `salt` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '短验证：[0,6]',
  `invite_code` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邀请注册码：[0,8]随着用户注册而生成',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码：[0,11]用户的手机号码，用于找回密码时或登录时',
  `phone_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '手机认证：[0,1](0未认证|1审核中|2已认证)',
  `username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名：[0,16]用户登录时所用的账户名称',
  `nickname` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '昵称：[0,16]',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码：[0,32]用户登录所需的密码，由6-16位数字或英文组成',
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '邮箱：[0,64]用户的邮箱，用于找回密码时或登录时',
  `email_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '邮箱认证：[0,1](0未认证|1审核中|2已认证)',
  `login_ip` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上次登录IP：[0,128]',
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个性签名：[0,255]',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像地址：[0,255]',
  `friends` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '好友：多个好友ID用“,”分隔',
  `create_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间：',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户账户：用于保存用户登录信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_account
-- ----------------------------
INSERT INTO `user_account` VALUES (1, 1, 14, 5, 5, 1, 1, 0, '2021-02-06 15:11:45', 'mm2020', '000000', NULL, 0, 'admin', '管理员', '0cf6066acc83160a6c65282835399c40', '', 0, '127.0.0.1', NULL, NULL, NULL, '2020-11-11 11:10:28');
INSERT INTO `user_account` VALUES (2, 1, 3, 5, 4, 0, 0, 0, '2021-02-06 13:06:21', 'mm2020', '775825', '', 0, 'wenwu', '文武', '0cf6066acc83160a6c65282835399c40', '', 0, '', '', '', '', '2020-11-11 11:10:45');
INSERT INTO `user_account` VALUES (3, 1, 1, 2, 3, 0, 0, 0, '2021-03-21 02:36:20', '', '', NULL, 0, 'test', '小李子', '', '', 0, NULL, NULL, NULL, NULL, '2021-01-29 15:15:16');

-- ----------------------------
-- Table structure for user_address
-- ----------------------------
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address`  (
  `address_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '地址ID：[0,8388607]',
  `province` mediumint(9) UNSIGNED NOT NULL DEFAULT 0 COMMENT '省：[0,8388607]',
  `city` mediumint(9) UNSIGNED NOT NULL DEFAULT 0 COMMENT '市：[0,8388607]',
  `area` mediumint(9) UNSIGNED NOT NULL DEFAULT 0 COMMENT '区：[0,8388607]',
  `sex` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '收件人性别：[0,1](0女|1男)',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人电话：[0,11]',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人姓名：[0,32]',
  `house_number` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '门牌号：[0,125]',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件地址：[0,255]',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]表示该地址是哪个用户的(user_account.nickname)',
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收货地址：用于保存用户的收件信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_address
-- ----------------------------

-- ----------------------------
-- Table structure for user_admin
-- ----------------------------
DROP TABLE IF EXISTS `user_admin`;
CREATE TABLE `user_admin`  (
  `admin_id` smallint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '管理组ID：[1,1000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `type` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类：[0,12]用于区分用户组使用范围',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '管理组名称：[0,16]',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该用户组的特点或权限范围',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图标：[0,255]用于标识用户组',
  PRIMARY KEY (`admin_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '管理组：用于判断用户后台管理鉴权' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_admin
-- ----------------------------
INSERT INTO `user_admin` VALUES (1, 100, NULL, '站长', NULL, NULL);
INSERT INTO `user_admin` VALUES (2, 100, NULL, '管理员', NULL, NULL);
INSERT INTO `user_admin` VALUES (3, 100, NULL, '财务', NULL, NULL);
INSERT INTO `user_admin` VALUES (4, 100, NULL, '客服', NULL, NULL);
INSERT INTO `user_admin` VALUES (5, 100, NULL, '文案', NULL, NULL);
INSERT INTO `user_admin` VALUES (6, 100, NULL, '推广员', NULL, NULL);

-- ----------------------------
-- Table structure for user_count
-- ----------------------------
DROP TABLE IF EXISTS `user_count`;
CREATE TABLE `user_count`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]',
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
  `coin` decimal(16, 8) NOT NULL COMMENT '货币：用于游戏或数字货币业务',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户统计：用于统计用户等级、经验、积分等' ROW_FORMAT = Fixed;

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
  `next_group_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '下级用户组ID：[1,8388607]决定用户升级后所属用户组',
  `exp` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '升级所需经验：[0,2147483647]用于确定用户的升级',
  `discount` double(3, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '折扣：用于确定用户的消费折扣',
  `bonus` double(3, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '奖励比例：用于确定用户的积分奖励',
  `app` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用：[0,12]用于区分用户组使用范围，cms内容管理系统、bbs社区、mall商城',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名称：[0,16]',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述：[0,255]描述该用户组的特点或权限范围',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图标：[0,255]用于标识用户组',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户组：用于用户前端身份和鉴权' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_group
-- ----------------------------
INSERT INTO `user_group` VALUES (1, 0, 1, 2, 0, 0.00, 0.00, 'mall', '普通会员', '通过消费积分评估，用于激励用户消费', NULL);
INSERT INTO `user_group` VALUES (2, 0, 2, 3, 5000, 0.98, 0.00, 'mall', '黄金会员', '通过消费积分评估，用于激励用户消费', NULL);
INSERT INTO `user_group` VALUES (3, 0, 3, 4, 20000, 0.97, 1.50, 'mall', '白金会员', '通过消费积分评估，用于激励用户消费', NULL);
INSERT INTO `user_group` VALUES (4, 0, 4, 5, 100000, 0.95, 2.00, 'mall', '钻石会员', '通过消费积分评估，用于激励用户消费', NULL);
INSERT INTO `user_group` VALUES (5, 0, 5, 0, 500000, 0.90, 3.00, 'mall', '至尊会员', '通过消费积分评估，用于激励用户消费', NULL);
INSERT INTO `user_group` VALUES (6, 0, 1, 2, 0, 0.00, 0.00, 'bbs', '学徒', '通过IQ值评估，激励用户评论和发表', NULL);
INSERT INTO `user_group` VALUES (7, 0, 2, 3, 120, 0.98, 0.00, 'bbs', '才子', '通过IQ值评估，激励用户评论和发表', NULL);
INSERT INTO `user_group` VALUES (8, 0, 3, 4, 140, 0.97, 1.50, 'bbs', '达人', '通过IQ值评估，激励用户评论和发表', NULL);
INSERT INTO `user_group` VALUES (9, 0, 4, 5, 160, 0.95, 2.00, 'bbs', '导师', '通过IQ值评估，激励用户评论和发表', NULL);
INSERT INTO `user_group` VALUES (10, 0, 5, 0, 180, 0.90, 3.00, 'bbs', '贤者', '通过IQ值评估，激励用户评论和发表', NULL);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]',
  `sex` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '性别：[0,2](0未设置|1男|2女)',
  `idcard_state` smallint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '身份实名认证：[0,10](1未认证|2认证中|3认证通过)',
  `age` smallint(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '年龄：[0,150]',
  `province_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '省份ID：[0,2147483647]用户所在地的省份(sys_address_province)',
  `city_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '所在城市ID：[0,2147483647](sys_address_city)',
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
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息：用于保存用户个人信息，如年龄、住址等' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------

-- ----------------------------
-- Table structure for user_message
-- ----------------------------
DROP TABLE IF EXISTS `user_message`;
CREATE TABLE `user_message`  (
  `message_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息ID：[0,2147483647]用于记录和识别消息',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言标题：[0,255]',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '留言内容：',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言者手机：[0,11]',
  `email` varchar(125) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言者邮箱：[0,125]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '留言者姓名：[0,16]',
  `time_create` timestamp(0) NULL DEFAULT NULL COMMENT '留言时间',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户留言：' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_message
-- ----------------------------
INSERT INTO `user_message` VALUES (1, NULL, '你好', NULL, NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (2, NULL, '你好', NULL, NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (3, NULL, '111', '18823759846', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (4, NULL, '你好', NULL, NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (5, NULL, '你好', '15817188815', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (6, NULL, '111', '18823759846', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (7, NULL, '你好', '15817188815', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (8, NULL, '111', '18823759846', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (9, NULL, '111', '18823759846', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (10, NULL, '111', '18823759846', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (11, NULL, '111', '18823759846', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (12, NULL, '111', '18823759846', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (13, '', 'fdsfgsdf', '18823759846', '', '', NULL);
INSERT INTO `user_message` VALUES (14, '', 'ngfnfgngfn', '18823759846', '', '', NULL);
INSERT INTO `user_message` VALUES (15, '', 'ngfnfgngfn', '18823759846', '', '', NULL);
INSERT INTO `user_message` VALUES (16, '', '321132', '12312313245', '', '', NULL);
INSERT INTO `user_message` VALUES (17, '', '123123132', '18079307448', '', '', NULL);
INSERT INTO `user_message` VALUES (18, '', '12132312132', '18079307448', '', '', NULL);
INSERT INTO `user_message` VALUES (19, '', 'DERER', '15817188815', '', '', NULL);
INSERT INTO `user_message` VALUES (20, '', 'DERER', '15817188815', '', '', NULL);
INSERT INTO `user_message` VALUES (21, '', 'DERER', '15817188815', '', '', NULL);
INSERT INTO `user_message` VALUES (22, '', 'DERER', '15817188815', '', '', NULL);
INSERT INTO `user_message` VALUES (23, '', 'DEEE', '12312133331', '', '', NULL);
INSERT INTO `user_message` VALUES (24, '', '12132312312312312321321312312321', '18079307448', '', '', NULL);
INSERT INTO `user_message` VALUES (25, '', '213123132132', '18079307448', '', '', NULL);
INSERT INTO `user_message` VALUES (26, '', '123123123', '18079307448', '', '', NULL);
INSERT INTO `user_message` VALUES (27, '', '132123', '12312312312', '', '', NULL);
INSERT INTO `user_message` VALUES (28, NULL, '123312312', '18079307448', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (29, NULL, '12213213213', '18079307448', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (30, NULL, '123231213', '18079307448', NULL, NULL, NULL);
INSERT INTO `user_message` VALUES (31, NULL, '4444', NULL, '22121@qq.com', NULL, NULL);
INSERT INTO `user_message` VALUES (32, NULL, '', '15817188815', NULL, '123123', NULL);
INSERT INTO `user_message` VALUES (33, NULL, '', '15817188815', NULL, '123123', NULL);
INSERT INTO `user_message` VALUES (34, NULL, '', '15817188815', NULL, 'name', NULL);
INSERT INTO `user_message` VALUES (35, NULL, '', '15817188815', NULL, 'name', NULL);
INSERT INTO `user_message` VALUES (36, NULL, '', '15817188815', NULL, 'ceshi', NULL);

-- ----------------------------
-- Table structure for user_power
-- ----------------------------
DROP TABLE IF EXISTS `user_power`;
CREATE TABLE `user_power`  (
  `power_id` smallint(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `admin_id` smallint(4) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理组ID：[0,1000]',
  `display` smallint(4) UNSIGNED NOT NULL DEFAULT 100 COMMENT '显示顺序：[0,1000]',
  `name` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '名称：[0,16]',
  `path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '路由路径：用来确定访问权限的路由路径',
  `method` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法：(GET|POST|ALL)',
  `user_add` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加权限人',
  `user_set` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改权限人',
  `user_del` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除权限人',
  `user_get` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查看权限人',
  `field_set` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改可见字段',
  `field_add` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '添加可见字段',
  `field_del` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '删除可见字段',
  `field_get` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询可见字段',
  PRIMARY KEY (`power_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理组：用于判断用户后台管理鉴权' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_power
-- ----------------------------
INSERT INTO `user_power` VALUES (1, 0, 100, '', '/order/list', NULL, '管理员 录入员', '技术员', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_power` VALUES (2, 1, 100, '', '/order/edit', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `user_power` VALUES (3, 1, 100, '', '/order/dispose', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for user_sns
-- ----------------------------
DROP TABLE IF EXISTS `user_sns`;
CREATE TABLE `user_sns`  (
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[0,8388607]',
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
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '社交账户：用于保存用的社交平台账户，方便同步登录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_sns
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_app
-- ----------------------------
DROP TABLE IF EXISTS `wechat_app`;
CREATE TABLE `wechat_app`  (
  `app_id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '应用序号：[1,8388607]',
  `available` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否可用：[0,1]在未审核状态下， 该应用授权为不可用',
  `encrypt` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '加解密方式：[0,10]0明文模式，1兼容模式，2安全模式',
  `times_allow` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '每日允许请求次数：[0,32767]用于限制应用每日可授权次数',
  `times_today` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '今日请求次数：[0,32767]用于记录今日请求授权次数，判断授权次数是否超限',
  `max_age` smallint(5) UNSIGNED NOT NULL DEFAULT 1825 COMMENT '有效期时长：[0,32767]授权应用可以使用的时长，超时需重新申请（单位：天）',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '持有者ID：[1,8388607]该客户端所有人的ID',
  `times_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '请求总次数：[0,2147483647]用于记录授权总次数',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '应用名称：[0,16]用于用户登陆时显示授权应用',
  `appid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '应用ID：[0,16]用于应用授权访问时的账号',
  `token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息访问令牌：[0,32]用于访问应用时验证身份',
  `encoding_aes_key` varchar(43) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息加密钥匙：[16,43]用于给应用发送消息时的加密钥匙',
  `appsecret` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '应用密钥：[0,64]用于应用授权访问时的密码',
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '应用图标：[0,255]用于用户登录时显示',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息访问地址：[0,255]当接收到用户所发消息后回访该地址',
  `bind_ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '访问绑定IP：网站授权时确认重定向网址为已授权IP',
  `scope` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '允许使用的接口：多个接口用”，“分隔',
  `scope_not` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '不允许使用的接口：“多个接口用”，“分隔',
  `users` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '授权的用户：',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '上次使用时间：用于记录上次授权时间，防止频繁操作',
  PRIMARY KEY (`app_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信应用：用于管理微信公众号、小程序' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_app
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_app_refresh
-- ----------------------------
DROP TABLE IF EXISTS `wechat_app_refresh`;
CREATE TABLE `wechat_app_refresh`  (
  `refresh_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '刷新Token的ID：[1,2147483647]',
  `user_id` mediumint(8) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户ID：[1,8388607]表示当前Token绑定的用户uid',
  `appid` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '应用ID：[0,16]',
  `refresh_token` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '刷新令牌：[0,32]用来刷新访问牌，保留30天',
  `create_time` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '创建时间：用来判断刷新令牌有效期',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间：用来判断是否频繁刷新访问牌',
  PRIMARY KEY (`refresh_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信刷新访问牌：用于微信公众号Oauth2.0刷新临时访问牌Token' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_app_refresh
-- ----------------------------

-- ----------------------------
-- Table structure for wechat_contact
-- ----------------------------
DROP TABLE IF EXISTS `wechat_contact`;
CREATE TABLE `wechat_contact`  (
  `contact_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '联系人ID',
  `appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用ID',
  `account` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人账户',
  `nickname` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人昵称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人头像',
  PRIMARY KEY (`contact_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_contact
-- ----------------------------
INSERT INTO `wechat_contact` VALUES (1, NULL, 'wxid_wg7yzezkwl1w22', '邱文武', 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132');

-- ----------------------------
-- Table structure for wechat_message
-- ----------------------------
DROP TABLE IF EXISTS `wechat_message`;
CREATE TABLE `wechat_message`  (
  `message_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '消息ID：[1,2147483647]',
  `end` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '结束会话：[0,1]1已结束,0为未结束会话,如果未结束则查询当前正文',
  `stage` smallint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '阶段：[null,9]第1阶段用于补全信息，第二阶段用于校验信息',
  `msgid` bigint(20) NULL DEFAULT NULL COMMENT '微信消息ID：来自微信公众号的消息ID',
  `update_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '会话更新时间：',
  `create_time` datetime(0) NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '会话创建时间：',
  `group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户群组：[0,64]',
  `msg_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息类型：[0,16]',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发信人名称',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '会话类型：[0,16]一般情况下，1永久会话/群、2临时会话/群',
  `cmd` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所使用的指令：[0,24]',
  `appid` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用ID：绑定到该服务下的应用',
  `from_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会话发起人：[0,64]',
  `to_user` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会话接收人：[0,64]',
  `robot` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务的机器人：[0,64]',
  `chatid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '聊天ID：用于消息回复和推送消息',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '发信人头像',
  `check` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '复查指令：[0,255]当用户再驱动指令而缺少参数时，执行该语句',
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词句：[0,255]除指令外，过滤、抽取后的词句',
  `form` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '表单：用于记录用户已填参数',
  `content_last` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '最后会话：记录用户最后一次会话内容',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '会话正文：',
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注信息：',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 152 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '微信消息：用于查询和保存聊天记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wechat_message
-- ----------------------------
INSERT INTO `wechat_message` VALUES (1, 1, 1, 123123123123123120, '2020-03-25 20:56:34', '2020-03-25 20:56:33', '0', 'text', NULL, '0', 'robot', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, '', '{}', NULL, '你好', NULL);
INSERT INTO `wechat_message` VALUES (2, 1, 1, 123123123123123120, '2020-03-25 20:56:59', '2020-03-25 20:56:58', '0', 'text', NULL, '0', 'robot', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, '', '{}', NULL, '你吃饭了没', NULL);
INSERT INTO `wechat_message` VALUES (3, 1, 1, 123123123123123120, '2020-03-25 23:02:47', '2020-03-25 20:57:10', '0', 'text', NULL, '0', 'job', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, 'sex', '{\"job\":\"找工\",\"salary\":\"3000\",\"city\":\"广州\",\"district\":\"白云区\",\"qualification\":\"大专\",\"sex\":\"\",\"age\":\"\"}', '取消', '找工作\r\n3000\r\n广州\r\n你来自哪里\r\n南山\r\n白云区\r\n取消', NULL);
INSERT INTO `wechat_message` VALUES (11, 1, 1, 1666666666, '2020-03-25 23:04:51', '2020-03-25 23:03:51', '0', 'text', NULL, '0', 'robot', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, NULL, NULL, '大额入及', '大额\r\n大额入及', NULL);
INSERT INTO `wechat_message` VALUES (12, 1, 1, 1666666667, '2020-03-25 23:05:03', '2020-03-25 23:05:03', '0', 'text', NULL, '0', 'robot', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, NULL, NULL, '入及', '入及', NULL);
INSERT INTO `wechat_message` VALUES (13, 1, 1, 1666666667, '2020-03-25 23:05:55', '2020-03-25 23:05:55', '0', 'text', NULL, '0', 'robot', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, NULL, NULL, '你好啊', '你好啊', NULL);
INSERT INTO `wechat_message` VALUES (14, 1, 1, 1666666667, '2020-03-25 23:06:04', '2020-03-25 23:06:04', '0', 'text', NULL, '0', 'robot', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, NULL, NULL, '你好啊', '你好啊', NULL);
INSERT INTO `wechat_message` VALUES (15, 1, 1, 1666666667, '2020-03-25 23:07:26', '2020-03-25 23:07:26', '0', 'text', NULL, '0', 'robot', 'wxab1b19e19011cd8b', 'ToUserName', 'FromUserName', NULL, NULL, NULL, NULL, NULL, NULL, '你好啊', '你好啊', NULL);
INSERT INTO `wechat_message` VALUES (16, 1, 1, 8885184570387295698, '2020-03-26 00:15:20', '2020-03-26 00:15:20', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '测', '测', NULL);
INSERT INTO `wechat_message` VALUES (17, 1, 1, 902220725814092109, '2020-03-26 00:17:11', '2020-03-26 00:17:11', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '测试', '测试', NULL);
INSERT INTO `wechat_message` VALUES (18, 1, 1, 8019750982523878921, '2020-03-26 00:17:58', '2020-03-26 00:17:58', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '你好吗', '你好吗', NULL);
INSERT INTO `wechat_message` VALUES (19, 1, 1, 8446256408784160095, '2020-03-26 00:18:19', '2020-03-26 00:18:19', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '你好吗', '你好吗', NULL);
INSERT INTO `wechat_message` VALUES (20, 1, 1, 1517530491324230855, '2020-03-26 00:18:40', '2020-03-26 00:18:38', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '今年几岁了？', '今年几岁了？', NULL);
INSERT INTO `wechat_message` VALUES (21, 1, 1, 3304123879422656054, '2020-03-26 00:21:53', '2020-03-26 00:20:11', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (22, 1, 1, 89831966301413514, '2020-03-26 00:22:35', '2020-03-26 00:22:35', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (23, 1, 1, 2800878487938990945, '2020-03-26 00:37:39', '2020-03-26 00:37:38', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '测试', '测试', NULL);
INSERT INTO `wechat_message` VALUES (24, 1, 1, 7917085166162102249, '2020-03-26 00:37:43', '2020-03-26 00:37:42', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (25, 1, 1, 2792275690081835012, '2020-03-26 00:40:40', '2020-03-26 00:40:40', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈哈', '哈哈', NULL);
INSERT INTO `wechat_message` VALUES (26, 1, 1, 6526926786518103546, '2020-03-26 00:40:51', '2020-03-26 00:40:50', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (27, 1, 1, 8604926456729290261, '2020-03-26 00:41:29', '2020-03-26 00:41:28', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (28, 1, 1, 6824699859974457610, '2020-03-26 00:42:24', '2020-03-26 00:42:24', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (29, 1, 1, 6888846335821177107, '2020-03-26 00:47:16', '2020-03-26 00:45:55', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (30, 1, 1, 1234982659375789199, '2020-03-26 00:48:35', '2020-03-26 00:48:35', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '123', '123', NULL);
INSERT INTO `wechat_message` VALUES (31, 1, 1, 1730116660882376378, '2020-03-26 00:49:22', '2020-03-26 00:49:21', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈', '哈', NULL);
INSERT INTO `wechat_message` VALUES (32, 1, 1, 839448490763769400, '2020-03-26 00:49:52', '2020-03-26 00:49:51', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '呢', '呢', NULL);
INSERT INTO `wechat_message` VALUES (33, 1, 1, 2688526984709414390, '2020-03-26 00:50:31', '2020-03-26 00:50:14', '', '7', '邱文武', '1', 'robot_tuli', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '呢', '呢', NULL);
INSERT INTO `wechat_message` VALUES (34, 1, 1, 8982712519546123170, '2020-03-26 00:51:05', '2020-03-26 00:50:37', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '哈哈', '1234\r\n哈哈', NULL);
INSERT INTO `wechat_message` VALUES (35, 1, 1, 1721677942995769291, '2020-03-26 01:18:42', '2020-03-26 00:51:10', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '哈\r\n错误\r\n分析eth', NULL);
INSERT INTO `wechat_message` VALUES (36, 1, 1, 144104652154946671, '2020-03-26 01:24:26', '2020-03-26 01:20:27', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (37, 1, 1, 5856443996837254300, '2020-03-26 01:30:15', '2020-03-26 01:30:14', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (38, 1, 1, 5482459153380055874, '2020-03-26 01:31:50', '2020-03-26 01:31:14', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (39, 1, 1, 6421200943220396847, '2020-03-26 01:32:19', '2020-03-26 01:32:19', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析btc', '分析btc', NULL);
INSERT INTO `wechat_message` VALUES (40, 1, 1, 8959380354227411410, '2020-03-26 01:32:42', '2020-03-26 01:32:42', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析btc', '分析btc', NULL);
INSERT INTO `wechat_message` VALUES (41, 1, 1, 5699997532605526252, '2020-03-26 01:34:32', '2020-03-26 01:34:31', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析btc', '分析btc', NULL);
INSERT INTO `wechat_message` VALUES (42, 1, 1, 7077783038058861241, '2020-03-26 01:35:24', '2020-03-26 01:35:23', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析btc', '分析btc', NULL);
INSERT INTO `wechat_message` VALUES (43, 1, 1, 4878249583617272303, '2020-03-26 01:36:17', '2020-03-26 01:36:15', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析btc', '分析btc', NULL);
INSERT INTO `wechat_message` VALUES (44, 1, 1, 8249665810493006962, '2020-03-26 01:37:16', '2020-03-26 01:37:15', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析btc', '分析btc', NULL);
INSERT INTO `wechat_message` VALUES (45, 1, 1, 423033836613272128, '2020-03-26 01:38:41', '2020-03-26 01:37:33', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析ltc', '分析\r\n分析ltc', NULL);
INSERT INTO `wechat_message` VALUES (46, 1, 1, 1606785881198770498, '2020-03-26 01:39:20', '2020-03-26 01:39:19', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析ltc', '分析ltc', NULL);
INSERT INTO `wechat_message` VALUES (47, 1, 1, 5725110629290267409, '2020-03-26 01:42:08', '2020-03-26 01:42:04', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析数字货币', '分析数字货币', NULL);
INSERT INTO `wechat_message` VALUES (48, 1, 1, 5415088652434722601, '2020-03-26 01:42:49', '2020-03-26 01:42:48', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (49, 1, 1, 2924170109944753947, '2020-03-26 01:46:24', '2020-03-26 01:46:23', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (50, 1, 1, 4966597991245268379, '2020-03-26 01:47:03', '2020-03-26 01:47:02', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析bsv', '分析bsv', NULL);
INSERT INTO `wechat_message` VALUES (51, 1, 1, 4585824095503878684, '2020-03-26 01:48:01', '2020-03-26 01:48:01', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析bsv', '分析bsv', NULL);
INSERT INTO `wechat_message` VALUES (52, 1, 1, 3551905899688754166, '2020-03-26 01:50:42', '2020-03-26 01:50:41', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (53, 1, 1, 6711876027003625291, '2020-03-26 01:51:03', '2020-03-26 01:51:03', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (54, 1, 1, 6498860391746365600, '2020-03-26 01:52:01', '2020-03-26 01:51:57', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析数字货币', '分析数字货币', NULL);
INSERT INTO `wechat_message` VALUES (55, 1, 1, 1933219242846823552, '2020-03-26 01:52:16', '2020-03-26 01:52:15', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (56, 1, 1, 8015598292439708101, '2020-03-26 01:53:59', '2020-03-26 01:53:58', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (57, 1, 1, 5129828517174374126, '2020-03-26 01:54:17', '2020-03-26 01:54:16', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (58, 1, 1, 1533465824047713289, '2020-03-26 01:54:32', '2020-03-26 01:54:31', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (59, 1, 1, 7083662319122410118, '2020-03-26 01:54:43', '2020-03-26 01:54:42', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (60, 1, 1, 6354079679743644934, '2020-03-26 01:54:49', '2020-03-26 01:54:48', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (61, 1, 1, 5503018479119795542, '2020-03-26 01:56:28', '2020-03-26 01:54:55', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (62, 1, 1, 998991426419278163, '2020-03-26 01:56:34', '2020-03-26 01:56:33', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (63, 1, 1, 7482138976559123443, '2020-03-26 02:00:18', '2020-03-26 01:56:39', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash\n\n\n', '分析dash\n\n\n\n\r\n分析dash\n\n\n', NULL);
INSERT INTO `wechat_message` VALUES (64, 1, 1, 826787873519391340, '2020-03-26 02:01:02', '2020-03-26 02:00:36', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2020-03-15', '分析dash 2020-03-15', NULL);
INSERT INTO `wechat_message` VALUES (65, 1, 1, 6494858394858620814, '2020-03-26 02:01:27', '2020-03-26 02:01:26', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2020-03-15', '分析dash 2020-03-15', NULL);
INSERT INTO `wechat_message` VALUES (66, 1, 1, 609426533183928022, '2020-03-26 02:04:14', '2020-03-26 02:04:13', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2020-01-15', '分析dash 2020-01-15', NULL);
INSERT INTO `wechat_message` VALUES (67, 1, 1, 2044912625587568607, '2020-03-26 02:05:30', '2020-03-26 02:05:29', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-10-15', '分析dash 2019-10-15', NULL);
INSERT INTO `wechat_message` VALUES (68, 1, 1, 4338548473894446051, '2020-03-26 02:08:35', '2020-03-26 02:08:34', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-10-15', '分析dash 2019-10-15', NULL);
INSERT INTO `wechat_message` VALUES (69, 1, 1, 4426994541323372932, '2020-03-26 02:08:55', '2020-03-26 02:08:54', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-10-15', '分析dash 2019-10-15', NULL);
INSERT INTO `wechat_message` VALUES (70, 1, 1, 6505669614147252727, '2020-03-26 02:10:31', '2020-03-26 02:10:30', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-10-15', '分析dash 2019-10-15', NULL);
INSERT INTO `wechat_message` VALUES (71, 1, 1, 4135794826084135219, '2020-03-26 02:11:11', '2020-03-26 02:11:10', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-10-15', '分析dash 2019-10-15', NULL);
INSERT INTO `wechat_message` VALUES (72, 1, 1, 1732926432538734296, '2020-03-26 02:12:14', '2020-03-26 02:12:13', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-10-15', '分析dash 2019-10-15', NULL);
INSERT INTO `wechat_message` VALUES (73, 1, 1, 5028754642971627229, '2020-03-26 02:12:53', '2020-03-26 02:12:52', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-10-15', '分析dash 2019-10-15', NULL);
INSERT INTO `wechat_message` VALUES (74, 1, 1, 7548013340603760442, '2020-03-26 02:17:08', '2020-03-26 02:17:07', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-12-15', '分析dash 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (75, 1, 1, 2790188934011540984, '2020-03-26 02:18:52', '2020-03-26 02:18:51', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-12-15', '分析dash 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (76, 1, 1, 8017947012616807654, '2020-03-26 02:19:43', '2020-03-26 02:19:42', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-12-15', '分析dash 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (77, 1, 1, 7163267102038469758, '2020-03-26 02:20:34', '2020-03-26 02:20:34', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-12-15', '分析dash 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (78, 1, 1, 5727859549744328371, '2020-03-26 02:21:56', '2020-03-26 02:21:55', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-12-15', '分析dash 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (79, 1, 1, 3708289853116433413, '2020-03-26 02:22:19', '2020-03-26 02:22:19', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash 2019-12-15', '分析dash 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (80, 1, 1, 2032813869918690579, '2020-03-26 02:23:13', '2020-03-26 02:23:12', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-15', '分析eth 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (81, 1, 1, 4441980699011984829, '2020-03-26 02:24:44', '2020-03-26 02:24:43', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-15', '分析eth 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (82, 1, 1, 1160410279411828614, '2020-03-26 02:25:42', '2020-03-26 02:25:41', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-15', '分析eth 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (83, 1, 1, 2665596421549867062, '2020-03-26 02:30:02', '2020-03-26 02:30:01', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-15', '分析eth 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (84, 1, 1, 4759763775097254318, '2020-03-26 02:31:18', '2020-03-26 02:31:17', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-15', '分析eth 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (85, 1, 1, 4783507614577762960, '2020-03-26 02:38:04', '2020-03-26 02:38:04', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-15', '分析eth 2019-12-15', NULL);
INSERT INTO `wechat_message` VALUES (86, 1, 1, 5478686923581431490, '2020-03-26 02:38:29', '2020-03-26 02:38:19', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-18', ' 2019-12-18\r\n分析eth 2019-12-18', NULL);
INSERT INTO `wechat_message` VALUES (87, 1, 1, 3528422706463914907, '2020-03-26 02:38:38', '2020-03-26 02:38:37', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-12-20', '分析eth 2019-12-20', NULL);
INSERT INTO `wechat_message` VALUES (88, 1, 1, 3667900520651445562, '2020-03-26 02:39:02', '2020-03-26 02:39:01', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (89, 1, 1, 3867217965037855720, '2020-03-26 02:40:27', '2020-03-26 02:40:26', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (90, 1, 1, 6344061900614720965, '2020-03-26 02:40:33', '2020-03-26 02:40:32', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (91, 1, 1, 3391160236832069664, '2020-03-26 02:40:49', '2020-03-26 02:40:48', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (92, 1, 1, 2804090346450537155, '2020-03-26 02:40:54', '2020-03-26 02:40:53', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (93, 1, 1, 2204797190282139981, '2020-03-26 02:42:54', '2020-03-26 02:42:53', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (94, 1, 1, 2313218241873514030, '2020-03-26 02:42:59', '2020-03-26 02:42:58', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (95, 1, 1, 5403382032962501136, '2020-03-26 02:43:05', '2020-03-26 02:43:05', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (96, 1, 1, 2687230925971503455, '2020-03-26 02:43:15', '2020-03-26 02:43:15', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (97, 1, 1, 2362649835093284639, '2020-03-26 02:44:31', '2020-03-26 02:44:30', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (98, 1, 1, 7287368955852995704, '2020-03-26 02:44:37', '2020-03-26 02:44:36', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (99, 1, 1, 5953195673599431457, '2020-03-26 02:44:59', '2020-03-26 02:44:58', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (100, 1, 1, 5060235331844605949, '2020-03-26 02:45:08', '2020-03-26 02:45:08', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-08-15', '分析eth 2019-08-15', NULL);
INSERT INTO `wechat_message` VALUES (101, 1, 1, 8495265965288417050, '2020-03-26 02:45:13', '2020-03-26 02:45:13', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-08-15', '分析eth 2019-08-15', NULL);
INSERT INTO `wechat_message` VALUES (102, 1, 1, 3640389136717528861, '2020-03-26 02:45:29', '2020-03-26 02:45:28', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-08-15', '分析eth 2019-08-15', NULL);
INSERT INTO `wechat_message` VALUES (103, 1, 1, 2580855265544048461, '2020-03-26 02:45:47', '2020-03-26 02:45:46', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-08-16', '分析eth 2019-08-16', NULL);
INSERT INTO `wechat_message` VALUES (104, 1, 1, 8670608723342999539, '2020-03-26 02:45:57', '2020-03-26 02:45:56', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-08-01', '分析eth 2019-08-01', NULL);
INSERT INTO `wechat_message` VALUES (105, 1, 1, 1152968825827233282, '2020-03-26 02:46:05', '2020-03-26 02:46:04', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-07-01', '分析eth 2019-07-01', NULL);
INSERT INTO `wechat_message` VALUES (106, 1, 1, 117724632298850951, '2020-03-26 02:46:26', '2020-03-26 02:46:25', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-07-01', '分析eth 2019-07-01', NULL);
INSERT INTO `wechat_message` VALUES (107, 1, 1, 5078815180593717572, '2020-03-26 02:47:16', '2020-03-26 02:47:15', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-07-01', '分析eth 2019-07-01', NULL);
INSERT INTO `wechat_message` VALUES (108, 1, 1, 7619369813651383839, '2020-03-26 02:47:24', '2020-03-26 02:47:23', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-07-15', '分析eth 2019-07-15', NULL);
INSERT INTO `wechat_message` VALUES (109, 1, 1, 4397527825338265882, '2020-03-26 02:47:36', '2020-03-26 02:47:35', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-07-25', '分析eth 2019-07-25', NULL);
INSERT INTO `wechat_message` VALUES (110, 1, 1, 997193678279652807, '2020-03-26 02:47:54', '2020-03-26 02:47:53', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-02', '分析eth 2019-05-02', NULL);
INSERT INTO `wechat_message` VALUES (111, 1, 1, 3057978124590446386, '2020-03-26 02:48:02', '2020-03-26 02:48:01', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-01', '分析eth 2019-05-01', NULL);
INSERT INTO `wechat_message` VALUES (112, 1, 1, 1577882355071783736, '2020-03-26 02:48:17', '2020-03-26 02:48:16', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-01', '分析eth 2019-05-01', NULL);
INSERT INTO `wechat_message` VALUES (113, 1, 1, 2983776911890438877, '2020-03-26 02:57:24', '2020-03-26 02:54:53', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-01', '分析eth 2019-05-01', NULL);
INSERT INTO `wechat_message` VALUES (114, 1, 1, 5344157690759922266, '2020-03-26 02:57:57', '2020-03-26 02:57:56', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-01', '分析eth 2019-05-01', NULL);
INSERT INTO `wechat_message` VALUES (115, 1, 1, 5730877024201336347, '2020-03-26 02:58:02', '2020-03-26 02:58:01', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-01', '分析eth 2019-05-01', NULL);
INSERT INTO `wechat_message` VALUES (116, 1, 1, 8364483954029714207, '2020-03-26 02:58:13', '2020-03-26 02:58:13', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-01', '分析eth 2019-05-01', NULL);
INSERT INTO `wechat_message` VALUES (117, 1, 1, 4688715114965693089, '2020-03-26 02:58:27', '2020-03-26 02:58:27', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-01', '分析eth 2019-05-01', NULL);
INSERT INTO `wechat_message` VALUES (118, 1, 1, 4081907058513283404, '2020-03-26 02:58:37', '2020-03-26 02:58:36', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (119, 1, 1, 2739529355435348146, '2020-03-26 03:01:02', '2020-03-26 03:01:01', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2019-05-15', '分析eth 2019-05-15', NULL);
INSERT INTO `wechat_message` VALUES (120, 1, 1, 5194498259574421029, '2020-03-26 03:01:36', '2020-03-26 03:01:35', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2020-03-26', '分析eth 2020-03-26', NULL);
INSERT INTO `wechat_message` VALUES (121, 1, 1, 8657050225527712115, '2020-03-26 03:03:08', '2020-03-26 03:03:07', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2020-03-26', '分析eth 2020-03-26', NULL);
INSERT INTO `wechat_message` VALUES (122, 1, 1, 2013625562311494299, '2020-03-26 03:03:16', '2020-03-26 03:03:15', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2020-03-26', '分析eth 2020-03-26', NULL);
INSERT INTO `wechat_message` VALUES (123, 1, 1, 6020849872335379750, '2020-03-26 03:04:22', '2020-03-26 03:04:21', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2020-03-26', '分析eth 2020-03-26', NULL);
INSERT INTO `wechat_message` VALUES (124, 1, 1, 6548031824275545506, '2020-03-26 03:04:30', '2020-03-26 03:04:29', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth 2020-03-12', '分析eth 2020-03-12', NULL);
INSERT INTO `wechat_message` VALUES (125, 1, 1, 22694080871512972, '2020-03-26 03:09:30', '2020-03-26 03:09:29', '', 'text', NULL, '1', 'coin_query', 'wxab1b19e19011cd8b', 'gh_c41337e972b2', 'oxn1OtzdF4ra66ObrkYJQ3Ahy5nc', NULL, NULL, NULL, NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (126, 1, 1, 2816104950422275260, '2020-03-26 03:09:40', '2020-03-26 03:09:39', '', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (127, 1, 1, 3514296409753112562, '2020-03-26 03:10:11', '2020-03-26 03:10:10', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (128, 1, 1, 2039935504451378186, '2020-03-26 03:14:38', '2020-03-26 03:14:37', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (129, 1, 1, 8829132319674239851, '2020-03-26 03:35:39', '2020-03-26 03:35:38', '22206374376@chatroom', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '@命天子 分析btc', '@命天子 分析btc', NULL);
INSERT INTO `wechat_message` VALUES (130, 1, 1, 2730980813921891247, '2020-03-26 03:39:43', '2020-03-26 03:39:42', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (131, 1, 1, 7544599722373244552, '2020-03-26 03:40:23', '2020-03-26 03:40:22', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析比特币', '分析比特币', NULL);
INSERT INTO `wechat_message` VALUES (132, 1, 1, 3176046160289055104, '2020-03-26 03:41:12', '2020-03-26 03:41:11', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eos', '分析eos', NULL);
INSERT INTO `wechat_message` VALUES (133, 1, 1, 2654755371865151538, '2020-03-26 03:42:22', '2020-03-26 03:42:21', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eos', '分析eos', NULL);
INSERT INTO `wechat_message` VALUES (134, 1, 1, 7116031489943745569, '2020-03-26 04:01:19', '2020-03-26 04:01:19', '22206374376@chatroom', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '你好吗？', '你好吗？', NULL);
INSERT INTO `wechat_message` VALUES (135, 1, 1, 1777011081620933646, '2020-03-26 04:01:53', '2020-03-26 04:01:53', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (136, 1, 1, 6782010833896012502, '2020-03-26 04:02:01', '2020-03-26 04:02:01', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (137, 1, 1, 6210610241758869776, '2020-03-26 04:02:14', '2020-03-26 04:02:14', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (138, 1, 1, 5561740669388838793, '2020-03-26 04:02:22', '2020-03-26 04:02:22', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析dash', '分析dash', NULL);
INSERT INTO `wechat_message` VALUES (139, 1, 3, 681472550297785656, '2020-03-26 04:05:25', '2020-03-26 04:02:49', '22206374376@chatroom', '7', '邱文武', '1', 'job', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, 'job', '{\"job\":\"前端开发工程师\",\"salary\":\"12000\",\"city\":\"深圳\",\"district\":\"南山区\",\"qualification\":\"大专\",\"sex\":\"男\",\"age\":\"29\"}', '没有了', '找工作\r\n12000\r\n深圳\r\n@AI小幸南山区\r\n大专\r\n男\r\n29\r\n对的\r\n有\r\n职位错了\r\n前端开发工程师\r\n没有了', NULL);
INSERT INTO `wechat_message` VALUES (140, 1, 1, 341102809515858747, '2020-03-26 04:07:29', '2020-03-26 04:07:15', '22206374376@chatroom', '7', '邱文武', '1', 'job', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, 'job', '{\"job\":\"\",\"salary\":\"\",\"city\":\"\",\"district\":\"\",\"qualification\":\"\",\"sex\":\"\",\"age\":\"\"}', '取消指令', '求职\r\n取消指令', NULL);
INSERT INTO `wechat_message` VALUES (141, 1, 1, 3620531940501302555, '2020-03-26 04:11:35', '2020-03-26 04:07:37', '22206374376@chatroom', '7', '邱文武', '1', 'job', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, 'salary', '{\"job\":\"找工\",\"salary\":\"\",\"city\":\"\",\"district\":\"\",\"qualification\":\"\",\"sex\":\"\",\"age\":\"\"}', '取消指令', '找工作\r\n我想找工作\r\n求职\r\n取消指令', NULL);
INSERT INTO `wechat_message` VALUES (142, 1, 1, 7813451549758718730, '2020-03-26 04:11:54', '2020-03-26 04:11:43', '22206374376@chatroom', '7', '邱文武', '1', 'job', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, 'job', '{\"job\":\"\",\"salary\":\"\",\"city\":\"\",\"district\":\"\",\"qualification\":\"\",\"sex\":\"\",\"age\":\"\"}', '取消指令', '求职\r\n取消指令', NULL);
INSERT INTO `wechat_message` VALUES (143, 1, 1, 4297598921208693521, '2020-03-26 04:12:43', '2020-03-26 04:12:07', '22206374376@chatroom', '7', '邱文武', '1', 'job', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, 'job', '{\"job\":\"\",\"salary\":\"\",\"city\":\"\",\"district\":\"\",\"qualification\":\"\",\"sex\":\"\",\"age\":\"\"}', '取消指令', '找工作\r\n分析eth\r\n取消指令', NULL);
INSERT INTO `wechat_message` VALUES (144, 1, 1, 3452861168520089065, '2020-03-26 04:12:50', '2020-03-26 04:12:50', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (145, 1, 1, 3684262345237093396, '2020-03-26 04:13:07', '2020-03-26 04:13:07', '22206374376@chatroom', '7', '邱文武', '1', 'coin_query', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '分析eth', '分析eth', NULL);
INSERT INTO `wechat_message` VALUES (146, 1, 1, 633157024320170549, '2020-03-26 04:26:53', '2020-03-26 04:26:52', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '你好吗？', '你好吗？', NULL);
INSERT INTO `wechat_message` VALUES (147, 1, 1, 4998281077291212333, '2020-03-26 04:29:43', '2020-03-26 04:29:42', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '你好吗？', '你好吗？', NULL);
INSERT INTO `wechat_message` VALUES (148, 1, 1, 7303123150310816478, '2020-03-26 04:29:52', '2020-03-26 04:29:52', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '今年多大了？', '今年多大了？', NULL);
INSERT INTO `wechat_message` VALUES (149, 1, 1, 1905265181783963303, '2020-03-26 04:30:24', '2020-03-26 04:30:07', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '你几岁了？', '额\r\n你几岁了？', NULL);
INSERT INTO `wechat_message` VALUES (150, 1, 1, 1381821460453449843, '2020-03-26 04:31:26', '2020-03-26 04:31:25', '', '7', '邱文武', '1', 'robot', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '转入了', '转入了', NULL);
INSERT INTO `wechat_message` VALUES (151, 1, 1, 7481405962747960317, '2020-03-26 04:31:40', '2020-03-26 04:31:40', '', '7', '邱文武', '1', 'redirect', 'wxab1b19e19011cd8b', 'wxid_wg7yzezkwl1w22', '', NULL, NULL, 'http://wx.qlogo.cn/mmhead/ver_1/cuUnCvPkicP5lf4dPyUgSt8gg1VmSlIUgia3ia2jvXGswIa7ay893NxNaDYpK7M7AME3Fn3ibbn05dJcsoMTwx3uY9Pdr75icsvtbT9oD4UtWOSk/132', NULL, NULL, NULL, '转入了', '转入了', NULL);

SET FOREIGN_KEY_CHECKS = 1;
