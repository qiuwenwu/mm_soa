const cluster = require('cluster');
const Koa = require('koa');
$.binPath = __dirname.fullname();
const { Base } = require('mm_expand');
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
			 * web服务配置
			 * @type {Object}
			 */
			web: {
				/**
				 * 监听地址
				 * @type {String}
				 */
				host: "0.0.0.0",
				/**
				 * 监听端口
				 * @type {Number}
				 */
				port: 5000,
				/**
				 * 是否输出操作日志
				 * @type {Boolean}
				 */
				log: false,
				/**
				 * 进程数, 0为根据CPU核心数创建线程数
				 * @type {Number}
				 */
				process_num: 0,
				/**
				 * 是否启用静态文件处理器
				 * @type {Boolean}
				 */
				static: true,
				/**
				 * 使用外事件
				 * @type {Boolean}
				 */
				event: true,
				/**
				 * 是否启用压缩
				 * @type {Boolean}
				 */
				compress: false
			},
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
			/**
			 * 系统项
			 * @type {Object}
			 */
			sys: {
				/**
				 * 服务端名称
				 * @type {String}
				 */
				name: "mm",
				/**
				 * 服务端中文名
				 * @type {String}
				 */
				title: "超级美眉",
				/**
				 * 系统使用的语言
				 * @type {String}
				 */
				lang: "zh",
				/**
				 * 缓存方式, 选填 redis, cache, memory
				 * @type {String}
				 */
				cache: "redis",
				/**
				 * 数据存储方式
				 * @type {String}
				 */
				db: "mysql",
				/**
				 * 是否启用定时任务服务
				 * @type {Boolean}
				 */
				task: false
			},
			/**
			 * 外缓存配置
			 */
			redis: {
				/**
				 * 服务器地址
				 * @type {String}
				 */
				host: "127.0.0.1",
				/**
				 * 端口号
				 * @type {Number}
				 */
				port: 6379,
				/**
				 * 密码
				 * @type {String}
				 */
				password: "asd123",
				/**
				 * 选用的数据库0-9
				 * @type {Number}
				 */
				database: 0,
				/**
				 * 键前缀
				 * @type {String}
				 */
				prefix: "mm_"
			},
			/**
			 * Mysql数据库存储配置
			 */
			mysql: {
				/**
				 * 服务器地址
				 * @type {String}
				 */
				host: "127.0.0.1",
				/**
				 * 端口号
				 * @type {Number}
				 */
				port: 3306,
				/**
				 * 用户名
				 * @type {String}
				 */
				user: "root",
				/**
				 * 密码
				 * @type {String}
				 */
				password: "asd123",
				/**
				 * 数据库名称
				 * @type {String}
				 */
				database: "mm"
			},
			/**
			 * mongo数据库存储配置
			 */
			mongodb: {
				/**
				 * 服务器地址
				 * @type {String}
				 */
				host: "localhost",
				/**
				 * 端口号
				 * @type {Number}
				 */
				port: 27017,
				/**
				 * 数据库名
				 * @type {String}
				 */
				database: "mm",
				/**
				 * 用户名
				 * @type {String}
				 */
				user: "admin",
				/**
				 * 密码
				 * @type {String}
				 */
				password: "asd123"
			},
			/**
			 * 重定向
			 */
			redirect: {
				// 将m.开头的域名指向到/phone/路由路径
				"m.*": "/phone/",
				"pad.*": "/pad/",
				"tv.*": "/tv/"
			},
			/**
			 * 代理
			 */
			proxy: {
				// 转发到web socket服务器
				webscoket: {
					path: ["/ws/*"],
					com: ["*"]
				},
				// 转发到开发者服务器
				dev: {
					path: ["/dev/*", "/api/dev/*"],
					com: ["task", "app"]
				}
			}
		});
		this.set_config(config, {});
		
		$.push(server, this, true);
		$.path = this.config.path;
		bin.new(server);
		return server;
	}
}

/**
 * 主执行(主要)
 * @param {Object} ctx 请求上下文
 * @param {Function} next 跳过函数
 * @return {Object} 返回执行结果
 */
Soa.prototype.run_main = async function(ctx, next) {
	var body = await $.worker.req('config', {
		req: ctx.request
	});

	if (body) {
		ctx.status = 200;
		ctx.body = JSON.stringify(body);
	}
	else {
		next();
	}
};

/**
 * 初始化(主要)
 */
Soa.prototype.init_main = function() {
	// 工作进程可以共享任何 TCP 连接。在这种情况下，它是一个 HTTP 服务器。
	var {
		port,
		host,
		process_num,
	} = this.config.web;
	bin.init(this, 'common');
	if (cluster.isMaster) {
		// 获取要开展的进程数
		var len = process_num || require('os').cpus().length;
		$.log.info('欢迎使用' + this.config.sys.title, `访问地址 http://${host}:${port}`);
		// console.log(`主进程${process.pid}: 正在运行...`);

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

		cluster.on('fork', (worker) => {
			// console.log(`工作进程${worker.process.pid}: 启动完毕！`);
			// console.log('工作进程已关闭:', worker.isDead());
		});

		// cluster.on('exit', (worker, code, signal) => {
		// 	console.log('工作进程已关闭:', worker.isDead());
		// });

		$.master.cluster = cluster;
		bin.init(this, 'master');
	} else if (cluster.isWorker) {
		// 监听主进程推送来的消息
		process.on('message', (data) => {
			$.worker.handle(data);
		});
		
		bin.init(this, 'worker');
		// this.use(async (ctx, next) => {
		// 	console.log('监听了');
		// 	await this.run(ctx, next);
		// });
		
		this.listen(port, host);
	}
	return this;
};



module.exports = Soa;
