const cluster = require('cluster');
const Koa = require('koa');
$.binPath = __dirname.fullname();
const {
	Base
} = require('mm_expand');
const Bin = require('./bin/index.js');
const startup = require('./startup.js');

var bin = new Bin();

/**
 * SOA服务类
 */
class Soa extends Base {
	/**
	 * 构造函数
	 * @param {Object} config 配置参数
	 */
	constructor(config, server = new Koa()) {
		super({
			/**
			 * 路径配置
			 * @type {Object}
			 */
			path: {
				/**
				 * 程序根目录路
				 * @type {String}
				 */
				root: $.runPath.fullname(),
				/**
				 * 应用根目录
				 * @type {String}
				 */
				app: "./app".fullname(),
				/**
				 * 公共模块目录
				 * @type {String}
				 */
				com: "./com".fullname(),
				/**
				 * 中间件目录
				 * @type {String}
				 */
				middleware: "./middleware".fullname(),
				/**
				 * 静态文件跟目录
				 * @type {String}
				 */
				static: './bin/static'.fullname(__dirname)
			},
			"master": {
				/**
				 * 系统服务监听地址
				 * @type {String}
				 */
				"host": "0.0.0.0",
				/**
				 * 系统服务监听端口
				 * @type {Number}
				 */
				"port": 10001
			},
			/**
			 * web服务配置
			 * @type {Object}
			 */
			"web": {
				/**
				 * 监听地址
				 * @type {String}
				 */
				"host": "0.0.0.0",
				/**
				 * 监听端口
				 * @type {Number}
				 */
				"port": 8000,
				/**
				 * 是否输出操作日志
				 * @type {Boolean}
				 */
				"log": false,
				/**
				 * 进程数, 0为根据CPU核心数创建线程数
				 * @type {Number}
				 */
				"process_num": 1,
				/**
				 * 是否启用压缩
				 * @type {Boolean}
				 */
				"compress": false,
				/**
				 * 是否启用websocket通讯
				 * @type {Boolean}
				 */
				"websocket": true,
				/**
				 * 是否启用静态文件处理器
				 * @type {Boolean}
				 */
				"static": true,
				/**
				 * 使用外事件
				 * @type {Boolean}
				 */
				"event": true
			},
			/**
			 * 系统项
			 * @type {Object}
			 */
			"sys": {
				/**
				 * 服务端名称
				 * @type {String}
				 */
				"name": "mm",
				/**
				 * 服务端中文名
				 * @type {String}
				 */
				"title": "超级美眉",
				/**
				 * 系统使用的语言
				 * @type {String}
				 */
				"lang": "zh",
				/**
				 * 缓存方式, 选填 redis, cache, memory
				 * @type {String}
				 */
				"cache": "redis",
				/**
				 * 数据存储方式
				 * @type {String}
				 */
				"db": "mysql",
				/**
				 * 数据库管理器
				 * @type {Boolean}
				 */
				"db_admin": true,
				/**
				 * 是否引用com函数
				 * @type {Boolean}
				 */
				"com": true,
				/**
				 * 是否启用定时任务服务
				 * @type {Boolean}
				 */
				"task": true
			},
			/**
			 * 外缓存配置
			 */
			"redis": {
				/**
				 * 服务器地址
				 * @type {String}
				 */
				"host": "127.0.0.1",
				/**
				 * 端口号
				 * @type {Number}
				 */
				"port": 6379,
				/**
				 * 密码
				 * @type {String}
				 */
				"password": "asd123",
				/**
				 * 选用的数据库0-9
				 * @type {Number}
				 */
				"database": 0,
				/**
				 * 键前缀
				 * @type {String}
				 */
				"prefix": "mm_"
			},
			/**
			 * Mysql数据库存储配置
			 */
			"mysql": {
				/**
				 * 服务器地址
				 * @type {String}
				 */
				"host": "127.0.0.1",
				/**
				 * 端口号
				 * @type {Number}
				 */
				"port": 3306,
				/**
				 * 用户名
				 * @type {String}
				 */
				"user": "root",
				/**
				 * 密码
				 * @type {String}
				 */
				"password": "asd123",
				/**
				 * 数据库名称
				 * @type {String}
				 */
				"database": "mm"
			},
			/**
			 * mongo数据库存储配置
			 */
			"mongodb": {
				/**
				 * 服务器地址
				 * @type {String}
				 */
				"host": "localhost",
				/**
				 * 端口号
				 * @type {Number}
				 */
				"port": 27017,
				/**
				 * 数据库名
				 * @type {String}
				 */
				"database": "mm",
				/**
				 * 用户名
				 * @type {String}
				 */
				"user": "admin",
				/**
				 * 密码
				 * @type {String}
				 */
				"password": "asd123"
			},
			/**
			 * 重定向
			 */
			"redirect": {
				// 将m.开头的域名指向到/phone/路由路径
				"m.*": "/phone/",
				"pad.*": "/pad/",
				"tv.*": "/tv/"
			},
			/**
			 * 代理
			 */
			"proxy": {}
		});
		this.set_config(config, {});

		$.push(server, this, true);
		$.push($.config, this.config, true);
		bin.new(server);
		return server;
	}
}

/**
 * 获取IP
 * @param {Object} os 当前系统信息
 * @return {String} 返回局域网IP
 */
Soa.prototype.getIP = function(os) {
	var IPv4;
	var obj = os.networkInterfaces();
	for (var k in obj) {
		var arr = obj[k].reverse();
		for (var i = 0; i < arr.length; i++) {
			if (arr[i].family == 'IPv4') {
				IPv4 = arr[i].address;
				break;
			}
		}
		break;
	}
	return IPv4;
}

/**
 * 初始化(主要)
 */
Soa.prototype.init_main = function() {
	// 工作进程可以共享任何 TCP 连接。在这种情况下，它是一个 HTTP 服务器。
	var {
		port,
		host,
		process_num
	} = this.config.web;
	bin.init(this, 'common_before');
	if (cluster.isMaster) {
		var os = require('os');
		// 获取要开展的进程数
		var len = process_num || os.cpus().length;
		var h = host == '0.0.0.0' ? this.getIP(os) : host;

		var m = this.config.master;

		$.log.info('欢迎使用' + this.config.sys.title);
		console.log('访问地址', `http://${h}:${port}`);
		console.log('主程地址', `http://${m.host}:${m.port}`);

		// 衍生工作进程。
		for (let i = 0; i < len; i++) {
			cluster.fork();
		}
		for (const id in cluster.workers) {
			var o = cluster.workers[id];
			// 监听子进程推送来的消息
			o.on('message', (data) => {
				$.master.handle(data);
			});
		}

		$.master.cluster = cluster;
		bin.init(this, 'master');

		this.listen(m.port, m.host);
	} else if (cluster.isWorker) {
		// 监听主进程推送来的消息
		process.on('message', (data) => {
			$.worker.handle(data);
		});

		bin.init(this, 'worker');
		this.listen(port, host);
	}
	bin.init(this, 'common_after', true);
	return this;
};



module.exports = Soa;
