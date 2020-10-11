const Index = require('mm_machine').Index;
const Drive = require('./drive');

/**
 * App插件类
 * @extends {Index}
 * @class 
 */
class App extends Index {
	/**
	 * 构造函数
	 * @param {Object} scope 作用域
	 * @param {String} title 标题
	 * @constructor
	 */
	constructor(scope, title) {
		super(scope, __dirname);
		this.Drive = Drive;
		this.type = "app";
		this.title = title;
	}
}

/**
 * 执行程序
 * @param {Object} param1 参数1
 * @param {Object} param2 参数2
 * @return {Object} 返回执行结果
 */
App.prototype.run = function(param1, param2) {
	var ret;
	var lt = this.list;
	for (var i = 0, o; o = lt[i++];) {
		if (o.onOff) {
			ret = o.run(param1, param2);
			if (ret && o.end) {
				break;
			}
		}
	}
	return ret;
};

/**
 * 聊天（通过聊天的方式驱动插件, 用于机器人开发）
 * @param {String} from_user 发送消息人
 * @param {String} to_user 接收消息人
 * @param {String} content 内容
 * @param {String} group 群组 如果是个人，群组为空
 * @param {Number} type 群类型, 1永久会话/群、2临时会话/群
 * @param {String} msg_type 消息类型, event事件型、message消息型。默认消息型
 * @param {Object} 数据管理器
 * @return {String} 回复内容
 */
App.prototype.chat = async function(from_user, to_user, group, content, type, msg_type, db) {
	var ret = "";
	var lt = this.list;
	for (var i = 0, o; o = lt[i++];) {
		if (o.onOff) {
			ret = await o.chat(from_user, to_user, group, content, type, msg_type, db);
			if (ret) {
				break;
			}
		}
	}
	return ret;
};

/**
 * 指令（类似命令提示符）
 * @param {String} content 指令内容
 * @return {String} 执行结果
 */
App.prototype.cmd = async function(content) {
	var ret = "";
	var lt = this.list;
	for (var i = 0, o; o = lt[i++];) {
		if (o.onOff) {
			var cmd = o.config.cmd;
			if (cmd && content.startsWith(cmd)) {
				ret = await o.cmd(content.replace(cmd, ''));
				if (ret) {
					break;
				}
			}
		}
	}
	return ret;
};

/**
 * 执行插件方法
 * @param {String} name 插件名称
 * @param {String} method 方法名称
 * @param {Object} option 配置参数
 * @return {String} 执行结果
 */
App.prototype.exec = function(name, method, option) {
	var ret = "";
	var lt = this.list;
	for (var i = 0, o; o = lt[i++];) {
		var name = o.config.name;
		if (o.onOff && name === name) {
			var func = o[method];
			if (func) {
				ret = func(option);
			}
			break;
		}
	}
	return ret;
};

/**
 * 初始化插件
 * @param {Object} option 配置参数
 * @return {String} 执行结果
 */
App.prototype.init = function(option) {
	var ret = "";
	var lt = this.list;
	for (var i = 0, o; o = lt[i++];) {
		ret = o.init(option);
	}
	return ret;
};

App.prototype.sort = function() {
	this.list.sortBy('sort');
};

/**
 * 加载插件
 * @param {String} path 检索路径
 * @param {Boolean} isApp 是否APP
 */
App.prototype.load = function(path) {
	if (!path) {
		path = '/' + this.scope + "/";
	}
	var list = this.list;
	var list_scope = $.dir.get(path);
	
	// 遍历目录路径
	
	list_scope.map(function(o) {
		var file = './app.json'.fullname(o);
		if (file.hasFile()) {
			var obj = new Drive(o);
			obj.load(file);
			if (obj.config.name) {
				list.push(obj);
			}
		}
	});
};

exports.App = App;


/**
 * 创建全局管理器
 */
if (!$.pool.app) {
	$.pool.app = {};
}

/**
 * app管理器, 用于管理插件
 * @param {string} scope 作用域
 * @param {string} title 标题
 * @return {Object} 返回一个缓存类
 */
function app_admin(scope, title) {
	if (!scope) {
		scope = $.val.scope + '';
	}
	var obj = $.pool.app[scope];
	if (!obj) {
		$.pool.app[scope] = new App(scope, title);
		obj = $.pool.app[scope];
	}
	return obj;
}

/**
 * @module 导出app管理器
 */
exports.app_admin = app_admin;
