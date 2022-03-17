const path = require('path');
const fs = require('fs');
const Item = require('mm_machine').Item;
const Param = require('../param/drive.js'); // 是MM自带的参数机制，可以不使用
const Sql = require('../sql/drive.js'); // 是MM自带的参数机制，可以不使用
const Oauth = require('./oauth.js'); // 是MM自带的身份验证机制，基于Oauth2.0，可以不使用
const Ret = require('mm_ret').Ret;

if (!$.dict) {
	if (!$.dict.session_id) {
		$.dict.session_id = "mm:uuid";
	}
}

var dir = '/app/sys/static/doc/';
var url_path = "/sys/doc/";

/**
 * Api接口驱动类
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
		this.default_file = "./api.json";

		// 开关，开启可使用接口
		this.onOff = true;

		// oauth身份验证配置 + 函数
		this.oauth;
		// param参数配置 + 函数
		this.param;
		// sql模板配置 + 函数
		this.sql;
		/* 通用项 */
		// 配置参数
		this.config = {
			// 名称, 由中英文和下“_”组成, 用于卸载接口 例如: demo
			"name": "",
			// 标题, 介绍接口作用
			"title": "示例接口",
			// 描述, 用于描述该接口有什么用的
			"description": "暂无描述",
			// 路径 例如：/demo
			"path": "",
			// 接口类型，api表示服务端数据类型，web表示网页类型，app表示第三方应用类型
			"type": "api",
			// 返回的数据类型
			"contentType": "json",
			// 文件路径, 当调用函数不存在时，会先从文件中加载
			"func_file": "",
			// 回调函数名 用于决定调用脚本的哪个函数
			"func_name": "",
			// Rpc接口文件路径
			"rpc_file": "",
			// 请求方式, POST或GET, 为空或ALL表示都可以
			"method": "GET",
			// 缓存时长 (单位：秒) 默认：60秒，建议600秒
			"cache": 0,
			// 是否用客户端缓存，即 http 304 状态
			"client_cache": false,
			// param参数验证路径 例如: ./param.json
			"param_path": "",
			// sql模板路径 例如: ./sql.json
			"sql_path": "",
			// 是否验证参数
			"check_param": true,
			// 执行顺序, 数字越小，越优先执行
			"sort": 100,
			// oauth身份验证模型, 参考oauth文件
			"oauth": {
				"scope": true,
				"signIn": false,
				"vip": 0,
				"gm": 0,
				"mc": 0,
				"user_admin": [],
				"user_group": []
			}
		};

		/**
		 * 定义rpc 方法
		 */
		this.methods = {};

		/**
		 * 定义当前RPC文件路径
		 */
		this.rpc_file_now = "";
	}
}


/**
 * 新建配置
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
			var name = arr[arr.length - 2];
			var api_name = arr[arr.length - 3];
			var scope = api_name.replace('_manage', '').replace('_client', '').replace('api_', '');
			if (api_name === "api_client") {
				text = text.replaceAll('{path}', `/api/${name}`);
				text = text.replaceAll('{name}', `${scope}_${name}`);
			} else if (api_name === "api_manage") {
				text = text.replaceAll('{path}', `/apis/${name}`);
				text = text.replaceAll('{name}', `${scope}_${name}_manage`);
			} else if (api_name.indexOf('_manage') !== -1) {
				text = text.replaceAll('{path}', `/apis/${scope}/${name}`);
				text = text.replaceAll('{name}', `${scope}_${name}_manage`);
			} else if (api_name.indexOf('_client') !== -1) {
				text = text.replaceAll('{path}', `/api/${scope}/${name}`);
				text = text.replaceAll('{name}', `${scope}_${name}`);
			} else {
				text = text.replaceAll('{path}', `/api/${scope}/${name}`);
				text = text.replaceAll('{name}', `${scope}_${name}`);
			}
			text = text.replaceAll('{0}', name);
			file.saveText(text);
		}
	}
};


/**
 * 加载完成后执行
 */
Drive.prototype.load_after = function() {
	var cg = this.config;
	this.loadParam(cg.param_path);
	this.loadSql(cg.sql_path);
	this.loadRPC(cg.rpc_file);
	this.loadOauth();
};

/**
 * 设置参数对象
 * @param {Object} param 参数对象
 */
Drive.prototype.setParam = function(param) {
	if ($.param) {
		var lt = $.param.list;
		if (lt) {
			var has = false;
			var len = lt.length;
			for (var i = 0; i < len; i++) {
				var o = lt[i];
				if (param.filename === o.filename) {
					$.param.list[i] = param;
					has = true;
					break;
				}
			}
			if (!has) {
				$.param.list.push(param);
			}
		}
	}
};

/**
 * 获取现有参数
 * @param {String} file 文件名
 * @return {Object} 获取的对象
 */
Drive.prototype.getParam = function(file) {
	if ($.param) {
		var obj = $.param.list.getObj({
			filename: file
		});
		if (obj) {
			return obj;
		}
	}
	return null;
};

/**
 * 加载参数
 * @param {String} file_path 文件路径
 */
Drive.prototype.loadParam = async function(file_path) {
	if (file_path) {
		var p = file_path.fullname(this.dir);
		var param = this.getParam(p);
		if (param) {
			this.param = param;
		} else {
			this.param = new Param(this.dir);
			this.param.load(p);
			this.setParam(this.param);
		}
	}
};

/**
 * 设置Sql
 * @param {Object} param sql对象
 */
Drive.prototype.setSql = function(sql) {
	if ($.sql) {
		var lt = $.sql.list;
		if (lt) {
			var has = false;
			var len = lt.length;
			for (var i = 0; i < len; i++) {
				var o = lt[i];
				if (sql.filename === o.filename) {
					$.sql.list[i] = sql;
					has = true;
					break;
				}
			}
			if (!has) {
				$.sql.list.push(sql);
			}
		}
	}
};

/**
 * 获取现有sql模板
 * @param {String} file 文件名
 * @return {Object} 获取的对象
 */
Drive.prototype.getSql = function(file) {
	if ($.sql) {
		var lt = $.sql.list;
		if (lt) {
			var obj = lt.getObj({
				filename: file
			});
			if (obj) {
				return obj;
			}
		}
	}
	return null;
};

/**
 * 加载sql模板
 * @param {String} file_path 文件路径
 */
Drive.prototype.loadSql = async function(file_path) {
	if (file_path) {
		var p = file_path.fullname(this.dir);
		var sql = this.getSql(p);
		if (sql) {
			this.sql = sql;
		} else {
			this.sql = new Sql(this.dir);
			this.sql.load(p);
			this.setSql(this.sql);
		}
	}
};

/**
 * 加载RPC方法
 * @param {String} file_path 文件路径
 */
Drive.prototype.loadRPC = async function(file_path) {
	if (file_path) {
		var p = file_path.fullname(this.dir);
		this.rpc_file_now = file_path;
		if (p.hasFile()) {
			await this.unloadRPC(this.rpc_file_now);
			var f = require(p);
			this.methods = f(this);
		} else {
			var fl = this.dir_base + "/rpc.js";
			fl.copyFile(p);
			var f = require(p);
			this.methods = f(this);
		}
	}
};

/**
 * 卸载RPC方法
 * @param {String} file_path 文件路径
 */
Drive.prototype.unloadRPC = async function(file_path) {
	if (file_path) {
		var p = file_path.fullname(this.dir);
		if (p.hasFile()) {
			delete require.cache[require.resolve(p)];
			this.methods = {};
		}
	}
};

/**
 * 加载身份验证配置
 * @param {Object} cg 配置对象
 */
Drive.prototype.loadOauth = function() {
	var cg = this.config.oauth;
	if (cg) {
		this.oauth = new Oauth(this.dir);
		this.oauth.loadObj(cg);
	}
};

/**
 * 保存文件
 * @param {Object} files 上传的文件
 */
Drive.prototype.save_file = function(files) {
	var file;
	var url;
	if (files.file) {
		var f = files.file;
		// 创建可读流
		const readStream = fs.createReadStream(f.path);
		var stamp = Date.now();
		var name = f.name;
		file = path.join($.runPath, dir, name);
		const fileDir = path.join($.runPath, dir);
		if (!fs.existsSync(fileDir)) {
			fs.mkdirSync(fileDir, err => {
				$.log.error('创建失败', err);
			});
		}
		// 创建写入流
		try {
			const writeStream = fs.createWriteStream(file);
			readStream.pipe(writeStream);
			// writeStream.close();
			url = url_path + name;
		} catch (err) {
			$.log.error('保存文件失败', err);
		}
	}
	return {
		file,
		url
	}
};

/* 回调函数集 */
/**
 * 主要函数
 * @param {Object} ctx 请求上下文
 * @param {Object} db 数据管理器
 * @return {Object} 执行结果
 */
Drive.prototype.main = async function(ctx, db) {
	if (this.sql) {
		var req = ctx.request;
		// 获取文件
		if (req.files) {
			var fobj = this.save_file(req.files);
			req.body.file = fobj.file;
			req.body.url = fobj.url;
		}
		db.user = ctx.session.user;
		var ret = await this.sql.run(req.query, req.body, db);
		return ret;
	} else {
		return $.ret.error(10000, "接口函数未定义");
	}
};

/**
 * 调用函数
 * @param {Object} ctx  请求上下文
 * @param {Object} db 数据管理器
 * @return {Object} 执行结果
 */
Drive.prototype.run = async function(ctx, db) {
	var body = await this.getCache(ctx);
	if (!body) {
		var req = ctx.request;

		var md = this.config["method"].toLocaleUpperCase();
		if (md !== req.method && md !== "ALL") {
			return null;
		}
		var ret = await this.check(ctx, db);
		if (!ret) {
			try {
				ret = await this.main(ctx, db);
			} catch (err) {
				$.log.error("脚本文件错误", req.path, err);
				ret = $.ret.error(10000, "脚本文件错误：" + err.toString());
			}
		}
		var res = ctx.response;
		body = this.body(ret, res, req.type);
		this.setCache(ctx, body, res.type);
	}
	return body;
};

/**
 * 获取缓存
 * @param {Object} ctx 请求上下文
 * @return {String} 响应内容
 */
Drive.prototype.getCache = async function(ctx) {
	var cg = this.config;
	if (cg.cache) {
		var req = ctx.request;
		if (cg.client_cache) {
			var etag = req.headers['if-none-match'];
			if (etag) {
				var stamp = Number(etag.replace('"', '').replace('"', ''));
				var cha = stamp * 1000 - Date.parse(new Date());
				if (cha > 0) {
					ctx.response.status = 304;
					return ' ';
				}
			}
		} else {
			var data = await $.cache.get("api_" + req.url);
			if (data) {
				var obj = JSON.parse(data);
				ctx.response.type = obj.type;
				return obj.body;
			}
		}
	}
	return null;
};

/**
 * 设置缓存
 * @param {Object} ctx 请求上下文
 * @param {Object} body 正文参数
 */
Drive.prototype.setCache = async function(ctx, body) {
	var cg = this.config;
	if (cg.cache && ctx.method === 'GET') {
		if (cg.client_cache) {
			var age = cg.cache * 60;
			ctx.set('Cache-Control', 'max-age=' + age);
			ctx.etag = Date.parse(new Date()) / 1000 + age;
			return " ";
		} else {
			var req = ctx.request;
			var o = {};
			o.body = body;
			o.type = ctx.response.type;
			$.cache.set("api_" + req.url, JSON.stringify(o), cg.cache * 60);
		}
	}
};

/**
 * 调用函数
 * @param {Object} ret 设置响应结果
 * @param {Object} res 响应器
 * @param {String} t 请求类型
 * @return {String} 处理后的响应结果
 */
Drive.prototype.body = function(ret, res, t) {
	var type;
	if (res.type) {
		type = res.type;
	}
	if (ret) {
		var tp = typeof(ret);
		if (tp === "object") {
			if (!type) {
				/// 设置响应头
				if (t.indexOf('xml') !== -1) {
					type = t;
				} else {
					type = "application/json; charset=utf-8";
				}
				res.type = type;
			} else {
				if (type.indexOf('json') !== -1) {
					type = "application/json; charset=utf-8";
				} else if (type.indexOf('html') !== -1) {
					type = "text/html";
				} else if (type.indexOf('xml') !== -1) {
					type = "text/xml; charset=utf-8";
				} else {
					type = "text/plain; charset=utf-8";
				}
				res.type = type;
			}

			if (type.indexOf('/xml') !== -1) {
				return $.toXml(ret);
			} else {
				return JSON.stringify(ret);
			}
		} else if (tp === "string") {
			ret = ret.trim();
			if (!type) {
				if (ret.startWith('{') && ret.endWith('}')) {
					res.type = "application/json; charset=utf-8";
				} else if (ret.startWith('[') && ret.endWith(']')) {
					res.type = "application/json; charset=utf-8";
				} else if (ret.endWith("</html>")) {
					res.type = "text/html";
				} else {
					res.type = "text/plain; charset=utf-8";
				}
			}
		}
	}
	return ret;
};

/**
 * 验证参数
 * @param {Object} query url参数
 * @param {Object} body 内容参数
 * @param {String} method 方法
 * @return {Object} 验证结果
 */
Drive.prototype.checkParam = function(query, body, method) {
	if (this.param) {
		var msg = this.param.check(query, body, method);
		if (msg) {
			var code;
			if (msg.indexOf("必须") !== -1 || msg.indexOf("为空") !== -1) {
				code = 30001;
			} else {
				code = 30002;
			}
			return $.ret.error(code, msg);
		}
	}
	return null;
};

/**
 * 验证参数
 * @param {Object} ctx 内容上下文
 * @return {Object} 验证结果
 */
Drive.prototype.check = async function(ctx) {
	var error;
	if (this.config.check_param) {
		var req = ctx.request;
		error = this.checkParam(req.query, req.body, req.method);
	}
	if (!error) {
		error = await this.checkOauth(ctx);
		if (error) {
			error = {
				error
			}
		}
	}
	return error;
};

/**
 * 验证身份
 * @param {Object} ctx 内容上下文
 * @return {Object} 验证结果
 */
Drive.prototype.checkOauth = async function(ctx) {
	var aouth = this.oauth;
	if (aouth) {
		return await aouth.check(ctx);
	} else {
		return null;
	}
};

/**
 * 运行GRPC方法
 * @param {Object} db 数据库管理器
 * @param {String} method 方法名称
 * @param {Object} query 查询条件
 * @param {Object} body 增改项
 * @return {Object} 返回执行结果
 */
Drive.prototype.runRPC = async function(db, method, query, body) {
	var func = this.methods[method];
	var ret = {};
	try {
		if (func) {
			ret = this.checkParam(query, body, method);
			if (!ret) {
				ret = await func(db, query, body);
			}
		} else {
			ret = {
				error: {
					code: 60000,
					message: "方法名称不存在",
					data: Object.keys(this.methods)
				}
			}
		}
	} catch (err) {
		$.log.error(err);
		ret = {
			error: {
				code: 500,
				message: "服务端业务逻辑错误"
			}
		}
	}
	return ret;
};

module.exports = Drive;
