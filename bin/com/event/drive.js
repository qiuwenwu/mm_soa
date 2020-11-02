const Item = require('mm_machine').Item;

/**
 * Event事件驱动类
 * @extends {Item}
 * @class
 */
class Drive extends Item {
	/**
	 * 构造函数
	 * @param {String} dir 当前目录
	 * @constructor
	 */
	constructor(dir) {
		super(dir, __dirname);
		this.default_file = "./event.json";

		// 开关，开启可使用使用
		this.onOff = true;

		/* 通用项 */
		// 配置参数
		this.config = {
			// 标题, 介绍事件作用
			"title": "示例事件",
			// 描述, 用于描述该事件有什么用的
			"description": "描述事件使用方法",
			// 名称, 由中英文和下“_”组成, 用于卸载事件
			"name": "demo",
			// 目标
			"target": "",
			// 阶段, 分执行前before、验证check、主要main、渲染render、执行后after阶段
			"stage": "main",
			// 文件路径, 当调用函数不存在时，会先从文件中加载
			"func_file": "./main.js",
			// 回调函数名 用于决定调用脚本的哪个函数
			"func_name": "main",
			// 执行顺序, 数字越小，越优先执行
			"sort": 100,
			// 中断循环
			"end": true,
			// 请求方法
			"method": "ALL"
		};
	}
}

/**
 * 新建脚本
 * @param {String} 文件
 */
Drive.prototype.new_script = function(file) {
	var fl = __dirname + "/script.js";
	if (fl.hasFile()) {
		var text = fl.loadText();
		if (text) {
			var l = $.slash;
			var arr = file.split(l);
			arr = arr.slice(arr.indexOf('app'));
			var app_name = arr[1];
			var event_name = arr[3];
			if (event_name === 'client') {
				text = text.replaceAll('{0}', app_name + '_' + event_name);
			} else if (event_name === 'manage') {
				text = text.replaceAll('{0}', app_name + '_' + event_name);
			} else {
				text = text.replaceAll('{0}', event_name);
			}
			file.saveText(text);
		}
	}
};


/**
 * 新建脚本
 * @param {String} 文件
 */
Drive.prototype.new_config = function(file) {
	var fl = __dirname + "/config.tpl.json";
	if (fl.hasFile()) {
		var text = fl.loadText();
		if (text) {
			var l = $.slash;
			var arr = file.split(l);
			arr = arr.slice(arr.indexOf('app'));
			var app_name = arr[1];
			var event_name = arr[3];
			if (event_name === 'client') {
				text = text.replaceAll('{0}', app_name + '_' + event_name);
				text = text.replaceAll('{1}', '/api/' + app_name + '*');
			} else if (event_name === 'manage') {
				text = text.replaceAll('{0}', app_name + '_' + event_name);
				text = text.replaceAll('{1}', '/apis/' + app_name + '*');
			} else {
				text = text.replaceAll('{0}', event_name);
				text = text.replaceAll('{1}', '/' + event_name + '*');
			}
			
			file.saveText(text);
		}
	}
};

/**
 * 执行事件
 * @param {Object} ctx 请求上下文
 * @param {Object} db 数据管理器
 * @return {Object} 执行结果
 */
Drive.prototype.run = async function(ctx, db) {
	var ret = await this.main(ctx, db);
	return ret;
};

/**
 * 脚本主函数
 * @param {Object} ctx 请求上下文
 * @param {Object} db 数据管理器
 * @return {Object} 执行结果
 */
Drive.prototype.main = async function(ctx, db) {
	return null;
};

module.exports = Drive;
