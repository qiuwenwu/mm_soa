/**
 * 拓展类
 * @class
 */
class Expand {
	/**
	 * 构造函数
	 * @constructor
	 * @param {Object} config 配置参数
	 */
	constructor(server) {
		var web = server.config.web;
		/**
		 * 事件集合
		 */
		this.events = {
			/**
			 * 请求前
			 */
			before: [],
			/**
			 * 验证
			 */
			check: [],
			/**
			 * 主要
			 */
			main: [],
			/**
			 * 渲染
			 */
			render: [],
			/**
			 * 请求后
			 */
			after: []
		};

		/**
		 * 路由集合
		 */
		this.routes = {
			post: [],
			get: []
		};

		$.push(server, this, true);

		if (web.event && $.event_admin) {
			// 创建一个API事件
			var apis = $.event_admin('api', 'API事件');
			apis.update();
			for (var k in this.events) {
				this.events[k] = apis["list_" + k];
			}
		};

		/**
		 * 路由前后事件
		 */
		server.use(async (ctx, next) => {
			ctx.db = {};
			var db = ctx.db;
			db.ret = null;
			var ret = await this.run_event(ctx, this.events.before, db);
			if (!ret) {
				await next();
				ret = await this.run_event(ctx, this.events.after, db) || db.ret;
			}
			if (ret) {
				ctx.body = ret;
				ctx.status = ctx.status == 404 ? 200 : ctx.status;
			}
		});

		// 追加主程序
		this.main("/*", async (ctx, db) => {
			var md = ctx.method.toLocaleLowerCase();
			var list = this.routes[md];
			return await this.run_route(ctx, db, list);
		});

		// 使用路由(主要)
		server.use(async (ctx, next) => {
			var db = ctx.db;
			var path = ctx.path;
			if (path !== "/favicon.ico") {
				db.ret = await this.run_event(ctx, this.events.check, db);
				if (!db.ret) {
					db.ret = await this.run_event(ctx, this.events.main, db);
				}
				db.ret = await this.run_event(ctx, this.events.render, db) || db.ret;
			}
			if (db.ret) {
				ctx.body = db.ret;
			} else {
				next();
			}
		});
		return server;
	}
}

/**
 * 执行
 * @param {Object} ctx 请求上下文
 * @param {Function} next 跳过当前
 * @param {Array} list 路由列表
 * @param {Object} db 数据管理器
 */
Expand.prototype.run_event = async function(ctx, list, db) {
	try {
		var path = ctx.path;
		var method = ctx.method;
		for (var i = 0; i < list.length; i++) {
			var o = list[i];
			var cg = o.config;
			if (cg.method == "ALL" || cg.method == method) {
				if (o.onOff && path.has(cg.target)) {
					var ret = await o.run(ctx, db);
					if (ret) {
						db.ret = ret;
						if (cg.end) {
							break;
						}
					}
				}
			}
		}
	} catch (e) {
		console.log(e);
	}
	return db.ret;
};

/**
 * 执行
 * @param {Object} ctx 请求上下文
 * @param {Object} db 数据库管理器
 * @param {Array} list 路由列表
 */
Expand.prototype.run_route = async function(ctx, db, list) {
	try {
		if (list) {
			var path = ctx.path;
			for (var i = 0; i < list.length; i++) {
				var o = list[i];
				var cg = o.config;
				if (o.onOff && path.has(cg.path)) {
					var ret = await o.run(ctx, db);
					if (ret) {
						db.ret = ret;
					}
					if (cg.end) {
						break;
					}
				}
			}
		}
	} catch (e) {
		console.log(e);
	}
	return db.ret;
};

/**
 * 新建事件模型
 * @param {Object} obj 附加值
 * @return {Object} 返回模型
 */
Expand.prototype.event_model = function(obj, run) {
	return {
		// 开关
		onOff: true,
		// 配置参数
		config: Object.assign({
			// 接受的请求方式
			method: "ALL",
			// 目标
			target: "",
			// 排序
			sort: 100,
			// 结束
			end: true,
		}, obj),
		// 回调函数
		run: run || function(ctx, db) {
			return null;
		}
	};
};

/**
 * 新建路由模型
 * @param {Object} obj 附加值
 * @return {Object} 返回模型
 */
Expand.prototype.route_model = function(obj, run) {
	return {
		// 开关
		onOff: true,
		// 配置参数
		config: Object.assign({
			// 接受的请求方式
			method: "GET",
			// 请求路径
			path: "",
			// 排序
			sort: 100,
			// 结束
			end: true,
			// 缓存时长, 单位:分钟
			cache: 0,
			// 缓存方式 client客户端缓存, server服务端缓存
			cache_method: "client server"
		}, obj),
		// 回调函数
		run: run || function(ctx, db) {
			return null;
		}
	};
};

/**
 * 添加post路由
 * @param {String} path 路由路径
 * @param {Function} func 回调函数
 * @param {Number} sort 排列顺序
 */
Expand.prototype.post = function(path, run, sort = 100) {
	this.routes["post"].push(this.route_model({
		method: "POST",
		path,
		sort
	}, run));
	this.route_sort('post');
};

/**
 * 添加get路由
 * @param {String} path 路由路径
 * @param {Function} func 回调函数
 * @param {Number} sort 排列顺序
 */
Expand.prototype.get = function(path, run, sort = 100) {
	this.routes["get"].push(this.route_model({
		method: "GET",
		path,
		sort
	}, run));
	this.route_sort('get');
};

/**
 * 请求前
 * @param {String} target 目标
 * @param {Function} func 回调函数
 * @param {Number} sort 排列顺序
 */
Expand.prototype.before = function(target, run, sort = 100) {
	this.events["before"].push(this.event_model({
		end: false,
		target,
		sort
	}, run));
	this.event_sort('before');
};

/**
 * 请求后
 * @param {String} target 目标
 * @param {Function} func 回调函数
 * @param {Number} sort 排列顺序
 */
Expand.prototype.check = function(target, run, sort = 100) {
	this.events["check"].push(this.event_model({
		target,
		sort
	}, run));
	this.event_sort('check');
};

/**
 * 主要
 * @param {String} target 目标
 * @param {Function} func 回调函数
 * @param {Number} sort 排列顺序
 */
Expand.prototype.main = function(target, run, sort = 100) {
	this.events["main"].push(this.event_model({
		end: false,
		target,
		sort
	}, run));
	this.event_sort('main');
};

/**
 * 渲染
 * @param {String} target 目标
 * @param {Function} func 回调函数
 * @param {Number} sort 排列顺序
 */
Expand.prototype.render = function(target, run, sort = 100) {
	this.events["render"].push(this.event_model({
		target,
		sort
	}, run));
	this.event_sort('render');
};

/**
 * 请求后
 * @param {String} target 目标
 * @param {Function} func 回调函数
 * @param {Number} sort 排列顺序
 */
Expand.prototype.after = function(target, run, sort = 100) {
	this.events["after"].push(this.event_model({
		end: false,
		target,
		sort
	}, run));
	this.event_sort('after');
};


/**
 * 路由排序方式
 * @param {Object} obj_a 对象A
 * @param {Object} obj_b 对象B
 */
Expand.prototype.route_sort_way = function(obj_a, obj_b) {
	var a = obj_a.config;
	var b = obj_b.config;
	var n = a.sort - b.sort;
	if (n == 0) {
		return b.path.length - a.path.length;
	} else {
		return n;
	}
};

/**
 * 路由排序
 * @param {String} key 排序类型
 */
Expand.prototype.route_sort = function(key) {
	if (key) {
		if (this.routes[key]) {
			this.routes[key].sort(this.route_sort_way);
		}
	} else {
		this.routes["post"].sort(this.route_sort_way);
		this.routes["get"].sort(this.route_sort_way);
	}
};

/**
 * 事件排序方式
 * @param {Object} obj_a 对象A
 * @param {Object} obj_b 对象B
 */
Expand.prototype.event_sort_way = function(obj_a, obj_b) {
	var a = obj_a.config;
	var b = obj_b.config;
	var n = a.sort - b.sort;
	if (n == 0) {
		return b.target.length - a.target.length;
	} else {
		return n;
	}
};

/**
 * 事件排序
 * @param {String} key 排序类型
 */
Expand.prototype.event_sort = function(key) {
	if (key) {
		if (this.events[key]) {
			this.events[key].sort(this.event_sort_way);
		}
	} else {
		this.events["before"].sort(this.event_sort_way);
		this.events["check"].sort(this.event_sort_way);
		this.events["main"].sort(this.event_sort_way);
		this.events["render"].sort(this.event_sort_way);
		this.events["after"].sort(this.event_sort_way);
	}
};

/**
 * 对象转移
 * @param {Array} lt 排序类型
 * @param {Array} list 排序类型
 * @param {String} paths 路径集合
 * @param {String} key 主键
 */
Expand.prototype.shift = function(lt, list, paths, key = "target") {
	for (var i = list.length - 1; i >= 0; i--) {
		var o = list[i];
		var p = o.config[key];
		for (var n = 0; n < paths.length; n++) {
			if (p.has(paths[n])) {
				lt.push(o);
				list.splice(i, 1);
			};
		}
	}
};

/**
 * 排序
 * @param {String} key 排序类型
 */
Expand.prototype.sort = function() {
	this.event_sort();
	this.route_sort();
};

/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	"./app".fullname().addDir();
	
	server = new Expand(server);
	return server;
};