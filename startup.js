require("mm_logs");
const { Base } = require('mm_expand');

/**
 * 进程类
 */
class Process extends Base {
	/**
	 * 构造函数
	 * @param {Object} config 配置参数
	 */
	constructor(config) {
		super(config);
		/**
		 * 响应超时时长
		 */
		this.config = {
			timeout: 5000,
			interval: 1
		};

		/**
		 * 消息队列
		 */
		this.dict_message = [];

		/**
		 * 进程集群
		 */
		this.cluster = null;
		
		//  设置配置
		this.set_config(config, {});
	}
}

/**
 * 新建ID
 * @param {String} key 主键
 * @return {String} 返回ID
 */
Process.prototype.new_id = function(key = "id") {
	var timestamp = Date.now();
	var num = Math.floor(Math.random() * 1000) + 1;
	return key + "_" + timestamp + "_" + num;
};

/**
 * 请求消息
 * @param {String} method 请求方法
 * @param {Object} params 请求的参数
 * @return {Object} 响应结果
 */
Process.prototype.req = function(method, params) {
	var id = this.new_id();
	var data = {
		id,
		method,
		params,
		status: 0,
		pid: process.pid
	}
	this.send(data);
	this.dict_message[id] = data;
	return new Promise((resolve, reject) => {
		this.wait_res(id, resolve, reject);
	})
};

/**
 * 等待响应
 * @param {String} id 响应ID
 * @param {Function} resolve 正确响应返回函数
 * @param {Function} reject 错误响应返回函数
 */
Process.prototype.wait_res = function(id, resolve, reject) {
	var {
		interval,
		timeout
	} = this.config;

	// 总尝试次数
	var count = timeout / interval;

	var i = 0;
	var timer = setInterval(() => {
		var o = this.dict_message[id];
		if (!o) {
			resolve(null);
			clearInterval(timer);
		} else if (o.status) {
			delete this.dict_message[id];
			clearInterval(timer);
			resolve(o.result);
		} else if (i > count) {
			delete this.dict_message[id];
			clearInterval(timer);
			reject(new Error('timeout'));
		}
		i++;
	}, interval);
};

/**
 * 发送消息
 * @param {Object} json
 */
Process.prototype.send = function(json, pid) {
	if (pid && this.cluster) {
		var ws = this.cluster.workers;
		for (var id in ws) {
			var o = ws[id];
			if (o.process.pid == pid) {
				json.pid = process.pid;
				o.process.send(json);
			}
		}
	} else {
		process.send(json);
	}
};

/**
 * 运行处理
 * @param {Object} json
 */
Process.prototype.handle = function(json) {
	var id = json.id;
	if (json.result && id) {
		// 如果收到的是对请求响应的结果，就给它赋值
		var lt = this.dict_message;
		for (var k in lt) {
			if (id === k) {
				lt[k].result = json.result;
				lt[k].status = json.status || 200;
				break;
			}
		}
	} else {
		// 如果收到的是请求，就给它做处理并响应
		var method = json.method;
		if (method) {
			if (this[method]) {
				this.cmd(method, json.params).then((result) => {
					if (result) {
						var obj = {};
						if (id) {
							obj.id = id
						}
						obj.result = result;
						this.send(obj, json.pid);
					}
				});
			}
		}
	}
};

$.worker = new Process();
$.master = new Process();

function startup() {

}


module.exports = startup;
