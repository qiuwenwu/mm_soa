require("mm_logs");
require('mm_tpl');
require("mm_https");
require('mm_crypto');
require('mm_matchs');
require("mm_timer");
$.Html = require('mm_html');
$.binPath = __dirname.fullname() + "/";
$.redis_admin = require("mm_redis").redis_admin;
$.mongodb_admin = require("mm_mongodb").mongodb_admin;
$.mysql_admin = require('mm_mysql').mysql_admin;

const Com = require('./com/index.js');
const Middleware = require('./middleware/index.js');

/**
 * 容器类
 * @class
 */
class Bin {
	/**
	 * 构造函数
	 * @param {Object} config 配置参数
	 * @param {Object} option 附加选项
	 */
	constructor(config, option) {
	}
}

/**
 * @param {Object} server 服务
 */
Bin.prototype.new = function(server) {
	this.com = new Com(server.config);
	this.com.init();

	this.middleware = new Middleware(server.config);
	this.middleware.init();
};

/**
 * 初始化
 * @param {Object} server 服务
 * @param {String} process_type 进程类型: worker为工作进程、master为主进程
 */
Bin.prototype.init = function(server, process_type = "worker") {
	this.load_middleware(server, process_type);
};

/**
 * 加载中间件
 * @param {Object} server 服务
 */
Bin.prototype.load_middleware = function(server, process_type) {
	var list = this.middleware.list;
	for(var i = 0; i < list.length; i++){
		var o = list[i];
		if(o.process_type !== process_type){
			o.func = require(o.func_file);
			if(o.func){
				o.func(server);
			}
		}
	}
};

module.exports = Bin;
