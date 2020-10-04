const Item = require('mm_machine').Item;
const Excel = require('mm_excel');

/**
 * Sql操作驱动类
 * @extends {Item}
 * @class
 */
class Drive extends Item {
	/**
	 * 构造函数
	 * @param {String} dir 当前路径
	 * @constructor
	 */
	constructor(dir) {
		super(dir, __dirname);
		this.default_file = "./sql.json";

		/* 通用项 */
		// 配置参数
		this.config = {
			// 名称
			"name": "",
			// 表名 {0} 代表可前端传参自定义查询的表
			"table": "{0}",
			// 主键 用于水平连表查询时 例如：id
			"key": "",
			// 排序 {0} 代表可前台传参自定义排序规则 格式: `name` asc, `id` desc
			"orderby": "{0}",
			// 默认排序 `id` desc
			"orderby_default": "",
			// 显示的字段 {0} 代表可前台传参自定义查询的字段, 例如: `id`,`username`,`name`,`email`
			"field": "{0}",
			// 默认显示字段 例如： `id`,`username`,`name`
			"field_default": "*",
			// 隐藏字段 有些字段即使前端请求也不能返回，这是通过隐藏字段将其过滤掉, 例如：password *表示包含匹配
			"field_hide": ["*password*", "*token*", "salt"],
			// 分页大小，默认一页显示条数
			"page_size": 30,
			/* 过滤参数 */
			"filter": {
				/**
				 * 表名
				 */
				"table": "table",
				/**
				 * 查询的页码
				 */
				"page": "page",
				/**
				 * 查询每页条数
				 */
				"size": "size",
				/**
				 * 操作方式: 传入参数method=add, 支持参数 add增、del删、set改、get查，为空则为get
				 */
				"method": "method",
				/**
				 * 排序
				 */
				"orderby": "orderby",
				/**
				 * 查询显示的字段
				 */
				"field": "field",
				/**
				 * 统计结果: 统计符合条件的结果数，只有当page等于1或0时才会统计
				 */
				"count_ret": "count_ret"
			},
			// 分隔符 用于查询时的多条件处理
			"separator": "|",
			// 支持的方法 add增、del删、set改、get查, 只填get表示只支持查询 // import export del_repeat",
			"method": "add del set get get_obj import export del_repeat",
			// sql查询语句
			"query": {},
			// 默认查询, 当查询条件中不包含该项时，默认添加该项。 例如: { "age": "`age` < 20" } , 当查询参含有age，不调用该项，不存在时，sql会增加该项
			"query_default": {},
			// sql更改语句
			"update": {},
			// 文件路径, 当调用函数不存在时，会先从文件中加载
			"func_file": "",
			// 回调函数名 用于决定调用脚本的哪个函数
			"func_name": "",
			// 参数 []
			"params": null,
			// 格式
			"format": [
				/* {
					// 表名，当选择转换方式 表转换时需填写
					"table": "mm_web_region",
					// 查询条件，用于加速转换
					"query": {
						"group": "市"
					},
					// 表标题名
					"title": "所属省份",
					// 转换ID
					"id": "province_id",
					// 转换主键
					"key": "province",
					// 取名
					"name": "name",
					// 列表
					"list": [{
							"province_id": 1,
							"name": "广东省"
						},
						{
							"province_id": 2,
							"name": "广西省"
						},
						{
							"province_id": 3,
							"name": "湖南省"
						}
					]
				},
				{
					"title": "是否可见",
					"key": "show",
					"list": ["否", "是"]
				} */
			],
			/* 去重 */
			"del_repeat": {
				// 判断重复的字段，例如字段名 number
				"groupBy": "",
				// 排序方式 例如： `diJia` ASC
				"orderBy": ""
			},
			/* 逻辑符 */
			"logic": {},
			// 输出sql语句 
			"log": false
		};
	}
}

/**
 * 执行前, 可用于过滤参数
 * @param {Object} params 参数对象 (object) 包含query和body 如{ query, body }
 * @param {Object} db 数据库管理器
 * @return {Object} 过滤后的参数
 */
Drive.prototype.before = async function(params, db) {
	return params;
};

/**
 * 验证, 用于判断是否执行
 * @param {Object} params 参数对象 (object) 包含query和body
 * @param {Object} db 数据管理器
 * @return {Boolean} 验证通过返回true, 失败返回false
 */
Drive.prototype.check = async function(params, db) {
	return true;
};
/**
 * @return {type} 执行后 可用于附加执行
 * @param {Object} params 参数对象 (object) 包含query和body
 * @param {Object} db 数据管理器
 * @return {Object} 最终执行结果
 */
Drive.prototype.after = async function(params, db) {
	return db.ret;
};

/**
 * 更新缓存
 * @param {Object} sql
 */
Drive.prototype.update_cache = async function(table, sql) {

};

/**
 * @ 执行修改
 * @param {Object} query 查询url参数
 * @param {Object} body 修改时置入body的参数
 * @param {Object} db 数据库管理器
 */
Drive.prototype.run = async function(query, body, db) {
	var params = {
		query,
		body
	};
	params = await this.before(params, db);
	if (this.check(params, db)) {
		var ret = await this.main(params, db);
		if (!ret.error) {
			db.ret = ret;
			return await this.after(params, db);
		} else {
			return ret;
		}
	}
	return null;
};


/**
 * SQL操作准备
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回准备参数
 */
Drive.prototype.ready = async function(db, query, body) {
	var cg = this.config;
	var qy = Object.assign({}, query);
	$.push(db.config.filter, cg.filter, true);
	db.filter(qy);
	return {
		cg,
		qy
	};
};

/**
 * 查询(主要)
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} method 方法
 * @return {Object} 返回查询结果
 */
Drive.prototype.get_main = async function(db, query, method) {
	var ret;
	var {
		cg,
		qy
	} = await this.ready(db, query, {});
	db.config.separator = cg.separator;
	if (!query.size && cg.page_size) {
		db.size = cg.page_size + 0;
	}
	if (db.size > 0 && db.page === 0) {
		db.page = 1;
	}
	var f = db.config.filter;
	// 设置查询字段
	var field = query[f.field];
	if (cg.field.has("*{0}*")) {
		if (field) {
			if (cg.field_hide.getMatch(field)) {
				return $.ret.error(70003, '不合法的查询参数');
			}
			db.field = cg.field.replace("{0}", field);
		} else if (method === 'get_obj' && cg.field_obj) {
			db.field = cg.field_obj + '';
		} else if (cg.field_default) {
			db.field = cg.field_default + '';
		}
	} else {
		db.field = cg.field + '';
		if (field) {
			qy[f.field] = field;
		}
	}

	// 设置排序方式
	var orderby = query[f.orderby];
	if (cg.orderby.has("*{0}*")) {
		if (orderby) {
			db.orderby = cg.orderby.replace("{0}", orderby);
		} else if (cg.orderby_default) {
			db.orderby = cg.orderby_default + '';
		}
	} else {
		db.orderby = cg.orderby + '';
		if (orderby) {
			qy[f.orderby] = orderby;
		}
	}
	var query_str = db.tpl_query(qy, cg.query);
	var qt = cg.query_default;
	if (Object.keys(qt).length > 0) {
		var id = $.dict.user_id;
		var word = "{" + id + "}";
		var user_id = "0";
		if (db.user && db.user[id]) {
			user_id = db.user[id];
		}
		for (var k in qt) {
			if (!qy[k]) {
				query_str += " && " + qt[k].replace(word, user_id);
			}
		}
		if (query_str.startsWith(" && ")) {
			query_str = query_str.replace(" && ", "");
		}
	}

	// 查询
	if (db.count_ret === "true") {
		ret = $.ret.body(await db.getCountSql(query_str, db.orderby, db.field));
	} else {
		ret = $.ret.list(await db.getSql(query_str, db.orderby, db.field));
	}
	if (cg.log) {
		$.log.debug('查询SQL语句', db.sql)
	}
	if (db.error) {
		$.log.error('查询SQL', db.sql, db.error);
	}
	return ret;
};

/**
 * 查询
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回查询结果
 */
Drive.prototype.get = async function(db, query, body) {
	return await this.get_main(db, query);
};

/**
 * 查询单条数据
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回查询结果
 */
Drive.prototype.get_obj = async function(db, query, body) {
	query.page = 1;
	query.size = 1;
	var ret = await this.get_main(db, query, 'get_obj');
	if (ret.result) {
		var list = ret.result.list;
		if (list.length > 0) {
			return $.ret.obj(list[0]);
		} else {
			return $.ret.obj(null);
		}
	}
	return ret;
};

/**
 * 修改(主要)
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回修改结果
 */
Drive.prototype.set_main = async function(db, query, body) {
	var ret;
	var {
		cg,
		qy
	} = await this.ready(db, query, body);
	var key = cg.key;
	if (body[key]) {
		qy[key] = body[key];
	}
	var query_str = db.tpl_query(qy, cg.query);
	var set_str = db.tpl_body(body, cg.update);

	var n = await db.setSql(query_str, set_str);

	if (n < 1) {
		ret = $.ret.error(500, '修改失败！\n' + db.error.message);
		$.log.error('修改SQL', db.sql, db.error);
	} else {
		ret = $.ret.bl(true, '修改成功！');
	}
	return ret;
};


/**
 * 修改
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回查询结果
 */
Drive.prototype.set = async function(db, query, body) {
	return await this.set_main(db, query, body);
};

/**
 * 添加(主要)
 * @param {Object} db 数据库操作类
 * @param {Object} body 添加项
 * @return {Object} 返回查询结果
 */
Drive.prototype.add_main = async function(db, body) {
	var ret;
	var {
		cg
	} = await this.ready(db, {}, body);
	if (Object.keys(body).length > 0) {
		var n = await db.add(body);
		if (n < 1) {
			ret = $.ret.error(500, '添加失败！\n' + db.error.message);
			$.log.error('添加SQL', db.sql, db.error);
		} else {
			ret = $.ret.bl(true, '添加成功！');
		}
	} else {
		ret = $.ret.error(70000, '参数不能为空');
	}
	if (cg.log) {
		$.log.debug('添加SQL语句', db.sql)
	}
	return ret;
};

/**
 * 添加
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回添加结果
 */
Drive.prototype.add = async function(db, query, body) {
	return await this.add_main(db, body);
};

/**
 * 删除(主要)
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @return {Object} 返回查询结果
 */
Drive.prototype.del_main = async function(db, query) {
	var ret;
	var {
		cg,
		qy
	} = await this.ready(db, query, {});
	var query_str = db.tpl_query(qy, cg.query);
	var bl = await db.delSql(query_str);
	if (bl < 1) {
		ret = $.ret.error(500, '删除失败！\n' + db.error.message);
		$.log.error('删除SQL', db.sql, db.error);
	} else {
		ret = $.ret.bl(true, '删除成功！');
	}
	if (cg.log) {
		$.log.debug('删除SQL语句', db.sql)
	}
	return ret;
};

/**
 * 删除
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回删除结果
 */
Drive.prototype.del = async function(db, query, body) {
	return await this.del_main(db, query);
};


/**
 * 添加或修改(主要)
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回修改结果
 */
Drive.prototype.addOrSet_main = async function(db, query, body) {
	var ret;
	var {
		cg,
		qy
	} = await this.ready(db, query, body);
	if (Object.keys(body).length > 0 && Object.keys(qy).length > 0) {
		var n = await db.addOrSet(qy, body);
		if (n < 1) {
			ret = $.ret.error(500, '操作失败！\n' + db.error.message);
			$.log.error('添加或修改SQL', db.sql, db.error);
		} else {
			ret = $.ret.bl(true, '操作成功！');
		}
	} else {
		ret = $.ret.error(70000, '参数不能为空');
	}
	if (cg.log) {
		$.log.debug('添加或修改SQL语句', db.sql)
	}
	return ret;
};


/**
 * 添加或修改
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回查询结果
 */
Drive.prototype.addOrSet = async function(db, query, body) {
	return await this.addOrSet_main(db, query, body);
};


/**
 * 获取数据
 * @param {Array} fields 要获取的字段数组
 * @return {Array} 返回参数信息列表
 */
Drive.prototype.get_params = async function(fields) {
	var cg = this.config;
	if (cg.params) {
		return cg.params;
	}
	var params;
	var name = cg.table;
	var db = $.pool.db['sys'];
	if (db) {
		var dt = db.get(name);
		if (dt && dt.config) {
			var list = dt.config.fields;
			if (fields) {
				var lt = [];
				var arr = fields.split(',');
				arr.map((name) => {
					for (var i = 0; i < list.length; i++) {
						var o = list[i];
						if (name == o.name) {
							lt.push(o);
						}
					}
				});
				params = lt;
			} else {
				params = list;
			}
		}
	}
	if (!params) {
		var field = cg.field_default;
		var lt = [];
		var arr = field.split(',');
		for (var i = 0; i < arr.length; i++) {
			var name = arr[i].replace(/`/g, '');
			params.push({
				name,
				title: name
			});
		}
		params = lt;
	}
	return params;
};

/**
 * 获取导入导出格式
 * @param {Object} db 数据库操作类
 * @return {Array} 格式列表
 */
Drive.prototype.get_format = async function(db) {
	var dbs = Object.assign({}, db);
	dbs.size = 0;
	var fmt = this.config.format;
	for (var i = 0; i < fmt.length; i++) {
		var o = fmt[i];
		if (o.table) {
			if (!o.list || o.list.length == 0) {
				dbs.table = o.table;
				o.list = await dbs.getSql(o.where, null, o.id + "," + o.name);
			}
		}
	}
	return fmt;
};

/**
 * 导入数据(主要)
 * @param {Object} db 数据库操作类
 * @param {String} file 文件名
 * @return {Object} 返回导入结果
 */
Drive.prototype.import_main = async function(db, file) {
	var params = await this.get_params();
	var format = await this.get_format(db);
	file = file.fullname($.config.path.user || $.config.path.static);
	if (!file.hasFile()) {
		return $.ret.error(30000, file + "文件不存在！");
	}
	var excel = new Excel({
		file,
		params,
		format
	});
	var jarr = await excel.load();
	var list = [];
	var errors = [];
	db.table = db.table || this.config.table;
	for (var i = 0; i < jarr.length; i++) {
		var o = jarr[i];
		var n = await db.add(o);
		if (n < 1) {
			list.push(o);
			errors.push(db.error);
		}
	}
	var bl = list.length !== jarr.length;
	var body = $.ret.bl(bl, bl ? '导入成功!' : '导入失败!');
	body.result.list = list;
	if (errors.length) {
		body.errors = errors;
	}
	return body;
};


/**
 * 导入数据
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 导出设置
 * @return {Object} 返回执行结果
 */
Drive.prototype.import = async function(db, query, body) {
	var params = Object.assign({}, query, body);
	if (!params.file) {
		return $.ret.error(70000, '文件名（file）参数不能为空');
	}
	return await this.import_main(db, params.file);
};

/**
 * 导出数据(主要)
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询参数
 * @param {Object} body 正文参数（导出设置）
 * @property {String} body.fields 需要导出的字段 例如: `username`,`gm`,`vip`
 * @property {String} body.file 文件名 例如: 用户名.xlsx 、用户信息.csv 、用户账户.xls
 * @property {String} body.path 文件路径 例如: /static/download, 可不填写
 * @return {Object} 返回执行结果
 */
Drive.prototype.export_main = async function(db, query, body) {
	var by = await this.get_main(db, query);
	var message = "";
	if (db.error) {
		message = db.error.message;
		return $.ret.error(10000, message);
	}
	var {
		path,
		file,
		fields
	} = body;
	var table = db.table || this.config.table;
	if (!file) {
		var uid = 0;
		if (db.user) {
			uid = db.user.user_id;
		}
		file = './user/' + uid + '/' + table + '.xlsx';
		file.addDir($.config.path.user || $.config.path.static);
	}
	if (!fields && query.field) {
		fields = query.field;
	}
	var params = await this.get_params(fields);
	var format = await this.get_format(db);

	if (!path) {
		path = $.config.path.user;
	}
	file = file.fullname(path || $.config.path.static);
	var excel = new Excel({
		file,
		params,
		format
	});
	var list = by.result.list;
	file = await excel.save(list);
	var body = $.ret.bl(file == true, file ? '导出成功!' : '导出失败!');
	body.result.file = file;
	if (message) {
		body.result.message = message;
	}
	return body;
};

/**
 * 导出数据
 * @param {Object} db 数据库操作类
 * @param {Object} query 查询条件
 * @param {Object} body 修改项
 * @return {Object} 返回执行结果
 */
Drive.prototype.export = async function(db, query, body) {
	return await this.export_main(db, query, body);
};

/**
 * 删除重复项（主要）
 * @param {Object} db 数据库管理器
 * @param {Object} params 查询参数
 * @return {Object} 返回执行结果
 */
Drive.prototype.del_repeat_main = async function(db, params) {
	var msg = '';
	var cg = this.config.del_repeat;
	var orderBy = params.orderby || cg.orderBy;
	delete params.orderby;
	var groupBy = params.groupby || cg.groupBy;
	delete params.groupby;
	var f = db.config.filter;
	// 设置查询字段
	var field = params[f.field] || groupBy;
	delete params[f.field];
	db.field = field;
	var sql = db.toGetSql(params).replace(' * ', ' `' + field + '`, count(*) as len ');
	sql += ` GROUP BY ${groupBy}`;
	sql = 'SELECT * FROM (' + sql + ') a WHERE len > 1';
	var list = await db.run(sql);
	if (list.length) {
		db.page = 1;
		db.size = 1;
		var key = this.config.key;
		for (var i = 0; i < list.length; i++) {
			var o = list[i];
			var len = o.len - 1;
			delete o.len;
			for (var n = 0; n < len; n++) {
				var obj = await db.getObj(o, orderBy, key);
				if (obj) {
					await db.del(obj);
				}
			}
		}
	} else {
		msg = '没有重复号码。';
	}
	// console.log(list);
	return $.ret.bl(!msg, msg ? '去重失败!原因：' + msg : '去重成功!');
};

/**
 * 删除重复项
 * @param {Object} db 数据库管理器
 * @param {Object} query 查询条件
 * @return {Object} 返回执行结果
 */
Drive.prototype.del_repeat = async function(db, query, body) {
	var pm = Object.assign({}, query, body);
	return await this.del_repeat_main(db, pm);
};

/**
 * 执行模板操作
 * @param {Object} params 参数对象 (object) 包含query和body
 * @param {Object} db 数据管理器
 * @return {Object} 返回执行结果
 */
Drive.prototype.main = async function(params, db) {
	var {
		query,
		body
	} = params;

	var cg = this.config;
	var method = query.method;

	if (!method) {
		method = "get";
	}
	if (!cg.method.has("*" + method + "*")) {
		return $.ret.error(50001, '不支持的操作方式')
	}
	delete query.method;
	if (this[method]) {
		db.method = method;

		// 过滤查询参数
		var f = cg.filter;
		var table = query[f.table];

		// 设置操作的数据表
		if (cg.table.has("*{0}*")) {
			if (table) {
				db.table = cg.table.replace("{0}", table);
			} else {
				return $.ret.error(70000, '表名不能为空');
			}
		} else {
			db.table = cg.table + '';
		}

		return await this[method](db, query, body);
	} else {
		return $.ret.error(50001, '不支持的操作方式');
	}
};

module.exports = Drive;
