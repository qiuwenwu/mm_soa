const cluster = require('cluster');
const Koa = require('koa');
const numCPUs = require('os').cpus().length;
const Base = require('./base.js');

/**
 * SOA服务类
 */
class Soa extends Base {
	/**
	 * 构造函数
	 * @param {Object} config 配置参数
	 * @param {Object} options 附加选项
	 */
	constructor(config, options) {
		super(Object.assign({
			web: {
				host: '0.0.0.0',
				port: 5000
			}
		}, config), options);
	}
}

/**
 * 主执行(主要)
 * @param {Object} ctx 请求上下文
 * @param {Function} next 跳过函数
 * @return {Object} 返回执行结果
 */
Base.prototype.run_main = async function(ctx, next) {
	console.log('执行了');
	this.worker_req('req', "你好啊", {
		req: ctx.request
	});
};

/**
 * 主进程请求消息(主要)
 * @param {Object} method 方法名
 * @param {Object} param 参数
 * @param {Object} other 其他参数
 * @return {Object} 返回执行结果
 */
Base.prototype.master_req_main = async function(method, param, other) {
	console.log('请求了');
	// 通知主进程接收到了请求。
	return await process.send({
		method,
		param,
		other
	});
};

/**
 * 主进程请求消息
 * @param {Object} method 方法名
 * @param {Object} param 参数
 * @param {Object} other 其他参数
 * @return {Object} 返回执行结果
 */
Base.prototype.master_req = async function(method, param, other) {
	return await this.do('master_req', method, param, other);
};

/**
 * 主进程响应消息(主要)
 * @param {Object} ret 响应结果
 * @return {Object} 返回执行结果
 */
Base.prototype.master_res_main = async function(ret) {
	console.log('响应了');
	master_req.send(ret);
};

/**
 * 主进程响应消息
 * @param {Object} ret 响应结果
 * @return {Object} 返回执行结果
 */
Base.prototype.master_res = async function(ret) {
	return await this.do('master_res', ret);
};

/**
 * 工作进程请求消息(主要)
 * @param {Object} method 方法名
 * @param {Object} param 参数
 * @param {Object} other 其他参数
 * @return {Object} 返回执行结果
 */
Base.prototype.worker_req_main = async function(method, param, other) {
	console.log('worker请求了');
	// 通知主进程接收到了请求。
	process.send({
		method,
		param,
		other
	});
};

/**
 * 工作进程请求消息
 * @param {Object} method 方法名
 * @param {Object} param 参数
 * @param {Object} other 其他参数
 * @return {Object} 返回执行结果
 */
Base.prototype.worker_req = async function(method, param, other) {
	return await this.do('worker_req', method, param, other);
};

/**
 * 工作进程响应消息(主要)
 * @param {Object} method 方法名
 * @param {Object} param 参数
 * @param {Object} other 其他参数
 * @return {Object} 返回执行结果
 */
Base.prototype.worker_res_main = async function(name, param, other) {
	console.log('响应了');
	console.log(name, param, other);
	worker.send('你好');
};

/**
 * 工作进程响应消息
 * @param {Object} method 方法名
 * @param {Object} param 参数
 * @param {Object} other 其他参数
 * @return {Object} 返回执行结果
 */
Base.prototype.worker_res = async function(method, param, other) {
	return await this.do('worker_res', method, param, other);
};


/**
 * 初始化(主要)
 */
Soa.prototype.init_main = function() {
	if (cluster.isMaster) {
		console.log(`主进程 ${process.pid} 正在运行`);

		// 衍生工作进程。
		for (let i = 0; i < numCPUs; i++) {
			cluster.fork();
		}

		for (const id in cluster.workers) {
			cluster.workers[id].on('message', (msg) => {
				this.master_res(msg);
			});
		}

		cluster.on('fork', (worker) => {
			console.log('工作进程已关闭:', worker.isDead());
		});

		cluster.on('exit', (worker, code, signal) => {
			console.log('工作进程已关闭:', worker.isDead());
		});
	} else if (cluster.isWorker) {
		var app = new Koa();
		app.use((ctx, next) => {
			this.run(ctx, next);
		});
		// 工作进程可以共享任何 TCP 连接。在这种情况下，它是一个 HTTP 服务器。
		var {
			port,
			host
		} = this.config.web;

		app.listen(port, host);
	}
}

module.exports = Soa;
