const Item = require('mm_machine').Item;

const fs = require("fs");

if (!$.dict.user_id) {
	$.dict.user_id = "user_id";
}

/**
 * db数据库开发驱动类
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
		this.default_file = "./db.json";

		this.query_string = ["name", "title", "keywords", "tag", "description", "content"];

		// 是否设置数值类型为可查询
		this.query_number = ["state", "uin"];

		// 是否设置数值类型为关键词可查
		this.query_keyword = ["name", "title", "keywords", "tag", "description"];

		// 是否设置以下字段为get查列表SQL时不可见
		this.get_not = ['password', 'salt', 'content'];

		// 是否设置以下字段为getObj查对象SQL时不可见
		this.getObj_not = ['password', 'salt', 'display'];
		
		// 是否设置默认该表仅用户可访问
		this.query_default_table = ['user'];
		
		/**
		 * 配置参数
		 */
		this.config = {
			// 标题
			"title": "",
			// 描述
			"description": "",
			// 名称
			"name": "",
			// 表名
			"table": "",
			// 主键，用于实体模型
			"key": "",
			// 字段
			"fields": [
				/* */
			]
		};
	}
}

/**
 * 创建字段模型
 * @param {Object} obj
 * @property {String} obj.name 字段名称
 * @param {Object} dflt_value 默认值
 * @param {Object} notnull 是否非空
 * @param {Object} type 字段类型
 * @param {Object} pk 是否主键
 * @param {Object} note 字段备注
 */
Drive.prototype.model = function(fields) {
	var {
		name,
		dflt_value,
		notnull,
		type,
		pk,
		note,
		auto
	} = fields;

	var tp = type.left("(", true);
	var len = type.between("(", ")");
	var min_length = 0;
	var max_length = 0;
	var decimal = 0;
	if (len) {
		max_length = Number(len.left(",", true));
		var d = len.right(",");
		if (d) {
			decimal = Number(d);
		}
	}
	var min = 0;
	var max = 0;

	var note = note.replace("：", ":").replace('（', '(').replace('）',')');
	var title = note.left(":", true).trim();
	var desc = note.right(":");
	var description = "";
	var map = "";
	if (desc) {
		// 获取主要注释
		description = desc.right(']', true).left('(', true).trim();
		var range = desc.between("[", "]");
		if (range) {
			// 取最小值
			var min_str = range.left(',', true);
			if (min_str) {
				if (tp === 'varchar') {
					min_length = Number(min_str);
				} else {
					min = Number(min_str);
				}
			}
			// 取最大值
			var max_str = range.right(',');
			if (max_str) {
				var n = Number(max_str);
				if (tp === 'varchar') {
					if (n < max_length) {
						max_length = n;
					}
				} else {
					max = n;
				}
			}
		}
		map = desc.between("(", ")");
	}
	if (min === 0 && name.indexOf('_id') !== -1) {
		min = 1;
	}
	if (max === 0) {
		switch (tp) {
			case "tinyint":
				max = 1;
				break;
			case "smallint":
				max = 32767;
				break;
			case "mediumint":
				max = 8388607;
				break;
			case "int":
				max = 2147483647;
				break;
			case "bigint":
				max = 0;
				break;
			default:
				break;
		}
		if (max_length) {
			var num = Math.pow(10, max_length) - 1;
			if (max > num) {
				max = num;
			}
		}
	}

	var not_null = notnull | pk | (tp !== 'varchar' && tp !== 'text')
	if (not_null && !dflt_value) {
		if (tp === 'varchar' || tp === 'text') {
			dflt_value = "";
		} else {
			dflt_value = "0";
		}
	}
	var config = this.config;
	if (pk && !config.key) {
		config.key = name;
	}

	return {
		// 字段名
		"name": name,
		// 字段标题
		"title": title,
		// 字段描述
		"description": description,
		// 字段类型 smallint短整数、mediumint中长整数、int整数、float浮点数、double双精度、tinyint二进制(0和1的布尔)、text文本、varchar字符串、datetime日期时间、date日期、time时间、timestamp时间戳
		"type": tp,
		// 是否主键
		"key": pk,
		// 自动
		"auto": auto,
		// 是否含符号
		"symbol": tp === "float" || tp === "decimal",
		// 是否填充零，用于数字类型
		"fill_zero": false,
		// 非空
		"not_null": not_null,
		// 最小长度
		"min_length": min_length,
		// 最大长度
		"max_length": max_length,
		// 最小值
		"min": min,
		// 最大值
		"max": max,
		// 小数位
		"decimal": decimal,
		// 默认值
		"default": dflt_value,
		// 转换编排
		"map": map,
		// 联表入，唯一主键在其他表中，然后关联到该表
		"join_in": [],
		// 联表出，唯一主键在该表中，然后关联其他表
		"join_out": [],
		// 展现位置
		"position": []
	};
};

/**
 * 从数据库更新配置
 * @param {Object} db 数据库管理器
 * @param {Boolean} cover 是否覆盖文件
 */
Drive.prototype.update_config = async function(db, cover) {
	var cg = this.config;
	var list = [];

	// 查询表注释并修改
	var sql = "SELECT TABLE_NAME, TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + db.database +
		"' && TABLE_NAME = '" + cg.table + "';";

	var lt = await db.run(sql);
	if (lt && lt.length > 0) {
		var commit = lt[0].TABLE_COMMENT;
		var arr = commit.replace('：', ':').split(':');
		cg.title = arr[0];
		if (arr.length > 1) {
			cg.description = arr[1];
		}
	}

	// 设置表名
	db.table = cg.table + "";

	// 获取所有字段
	var fields = await db.fields();
	for (var i = 0; i < fields.length; i++) {
		var field = this.model(fields[i]);
		list.push(field);
	}
	cg.fields = list;
	if (!cg.name) {
		cg.name = cg.table;
	}
	await this.update_app(cover);
};

/**
 * 通过配置更新数据库
 * @param {Object} db 数据库管理器
 * @return {String} 更新成功返回空，否则返回错误提示
 */
Drive.prototype.update_db = async function(db) {
	var cg = this.config;
	db.table = cg.table + "";
	var fields = await db.fields();
	var list = cg.fields;

	if (fields.length === 0) {
		var k = cg.key;
		var len = list.length;
		for (var i = 0; i < len; i++) {
			var o = list[i];
			if (k === o.name) {
				await db.addTable(cg.table, o.name, o.type, o.auto, cg.title + "：" + cg.description);
				fields.push({
					name: o.name
				});
				break;
			}
		}
	} else {
		var commit = cg.title + "：" + cg.description;
		var sql = "alter table `{0}` comment '{1}';".replace('{0}', cg.table).replace('{1}', commit);
		db.exec(sql);
	}
	if (fields.length > 0) {
		// 删除配置中没有的字段
		for (var i = 0; i < fields.length; i++) {
			var o = fields[i];
			var obj = list.getObj({
				name: o.name
			});

			if (!obj) {
				await db.field_del(o.name)
			}
		}

		// 添加或修改配置
		var len = list.length;
		for (var i = 0; i < len; i++) {
			var o = list[i];
			var arr = fields.get({
				name: o.name
			});

			var notnull = "";
			var type = '';
			var value = "";
			switch (o.type) {
				case "varchar":
				case "text":
					if (o.decimal) {
						type = o.type + '(' + o.max_length + ',' + o.decimal + ')';
					} else {
						type = o.type + '(' + o.max_length + ')';
					}
					if (o.not_null) {
						notnull = "NOT NULL";
					}
					if (o.default) {
						value = "DEFAULT '" + o.default+"'";
					} else if (o.default === null) {
						value = "DEFAULT NULL";
					} else {
						value = "DEFAULT ''";
					}
					break;
				case "date":
				case "time":
				case "datetime":
				case "timestamp":
					type = o.type;
					notnull = "NOT NULL";
					if (o.default) {
						if (o.default.indexOf('CURR') !== -1) {
							value = "DEFAULT " + o.default;
						} else {
							value = "DEFAULT '" + o.default+"'";
						}
					}
					if (o.auto) {
						notnull += '';
						value = "DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP";
					}
					break;
				default:
					// 数字类型
					if (o.decimal) {
						type = o.type + '(' + o.max_length + ',' + o.decimal + ')';
					} else {
						type = o.type + '(' + o.max_length + ')';
					}
					if (!o.symbol) {
						type += " UNSIGNED";
					}
					notnull = "NOT NULL";
					if (o.default) {
						value = "DEFAULT " + o.default;
					} else {
						value = "DEFAULT 0";
					}
					if (o.auto) {
						notnull += ' AUTO_INCREMENT';
						value = "";
					}
					break;
			}

			var note = o.title + "：";
			if (o.type === 'varchar' || o.type === 'text') {
				if (o.max_length) {
					note += "[" + o.min_length + "," + o.max_length + "]"
				} else if (o.min_length) {
					note += "[" + o.min_length + "]"
				}
			} else {
				if (o.max) {
					note += "[" + o.min + "," + o.max + "]"
				} else if (o.min) {
					note += "[" + o.min + "]"
				}
			}
			note += o.description;
			if(o.map){
				note += '(' + o.map + ')'
			}
			var sql = "`{1}` {2} {3} {4} COMMENT '{5}'";
			sql = sql.replace('{1}', o.name).replace('{2}', type).replace('{3}', notnull).replace('{4}', value).replace('{5}',
				note);

			if (arr.length === 0) {
				// 如果没有则添加
				await db.exec("alter table `{0}` add ".replace('{0}', cg.table) + sql);
			} else {
				// 如果有则修改
				await db.exec("alter table `{0}` change `{1}` ".replace('{0}', cg.table).replace('{1}', o.name) + sql);
			}
		}
	} else {
		return "数据表更新失败！";
	}
};

/**
 * 更新应用，根据表生成目录结构和文件
 * @param {Boolean} cover 是否覆盖文件
 */
Drive.prototype.update_app = async function(cover) {
	var cg = this.config;
	var f;
	var dir_api;
	if (!this.filename) {
		var p = "./app/".fullname();
		var dir_arr = cg.table.split('_');
		var scope = dir_arr[0];
		var dir = p + scope;
		if (!fs.existsSync(dir)) {
			fs.mkdirSync(dir);
		}

		dir += "/plugin";
		if (!fs.existsSync(dir)) {
			fs.mkdirSync(dir);
		}

		dir += "/server";
		if (!fs.existsSync(dir)) {
			fs.mkdirSync(dir);
		}
		dir_api = dir;
		var db_dir = dir + "/db";
		if (!fs.existsSync(db_dir)) {
			fs.mkdirSync(db_dir);
		}
		this.dir = db_dir.fullname();

		f = this.dir + cg.table.replace(scope + '_', '') + '.db.json';
		this.filename = f;
	} else {
		f = this.filename;
	}
	if (f) {
		if (!this.dir) {
			this.dir = f.dirname();
			if (!fs.existsSync(dir)) {
				fs.mkdirSync(dir);
			}
		}
		if (!dir_api) {
			dir_api = this.dir.dirname()
		}

		if (!f.hasFile()) {
			this.save();
		} else if (cover) {
			var jobj = f.loadJson();
			var o = Object.assign({}, this.config);
			if (!o.title) {
				delete o.title;
			}
			if (!o.description) {
				delete o.description;
			}
			$.push(jobj, o, true);
			f.saveText(JSON.stringify(jobj, null, 4));
		}
		this.update_api(dir_api, cover);
	}
};

/**
 * 更新API及相关配置文件
 * @param {String} dir API存放目录
 * @param {Boolean} cover 是否覆盖文件
 */
Drive.prototype.update_api = async function(dir, cover) {
	var cg = this.config;
	var arr = cg.table.split('_');

	var name = "root";
	if (arr.length > 1) {
		name = cg.table.replace(arr[0], '').trim('_');
	}
	var l = $.slash;
	var app = arr[0];
	var o = $.pool.api[app + '_client'];
	var client = "";
	if (o) {
		client = dir + l + "api_" + app + "_client";
	} else {
		client = dir + l + "api_client"
	}
	if (!fs.existsSync(client)) {
		fs.mkdirSync(client);
	}
	client += "/" + name;
	if (!fs.existsSync(client)) {
		fs.mkdirSync(client);
	}

	o = $.pool.api[app + '_manage'];
	var manage = "";
	if (o) {
		manage = dir + l + "api_" + app + "_manage";
	} else {
		manage = dir + l + "api_manage"
	}
	if (!fs.existsSync(manage)) {
		fs.mkdirSync(manage);
	}
	manage += "/" + name;
	if (!fs.existsSync(manage)) {
		fs.mkdirSync(manage);
	}

	this.new_sql(client, manage, cover);
	await this.new_param(client, manage, cover);
	this.new_api(client, manage, cover);
};

/**
 * 新建event配置文件和文件
 * @param {String} dir 保存的路径
 * @param {String} path 检索路径
 * @param {String} scope 接口域
 */
Drive.prototype.new_event = async function(dir, path, scope) {
	// // 添加事件
	// 				var event_dir = dir + "/event_api";
	// 				if (!fs.existsSync(event_dir)) {
	// 					fs.mkdirSync(event_dir);
	// 				}
	// 
	// 				if (dir_arr.length > 1) {
	// 					event_dir += "/" + dir_arr[1];
	// 					if (!fs.existsSync(event_dir)) {
	// 						fs.mkdirSync(event_dir);
	// 					}
	// 					this.new_event(event_dir, dir_arr[0], dir_arr[1]);
	// 				}

	var f = dir + "/main.js";
	if (!f.hasFile()) {
		var code = (__dirname + '/event_script.js').loadText();
		code = code.replaceAll('{0}', path).replaceAll('{1}', scope);
		f.saveText(code);
	}
};

/**
 * 获取格式
 * @param {Object} obj
 * @return {Object} 返回格式
 */
Drive.prototype.get_format = async function(obj){
	var map = obj.map;
	var format = {
		key: obj.name,
		title: obj.title.replace('ID', '').replace('id', '')
	};
	if(map.indexOf('|') !== -1){
		var list = map.split('|');
		if(map.indexOf('0') !== 0){
			list.unshift('');
		}
		format.list = list.map((value) => {
			return value.replace(/[0-9]+/, '')
		})
	}
	else {
		if(map.indexOf('.') !== -1){
			var arr = obj.map.split('.');
			format.table = arr[0];
			format.name = arr[1];
			if(arr.length > 2){
				format.id = arr[2];
			}
		}
		else {
			format.table = obj.map;
			format.name = 'name';
		}
	}
	return format;
};

/**
 * 新建sql配置文件
 * @param {String} client 客户端配置保存路径
 * @param {String} manage 管理端配置保存路径
 * @param {Boolean} cover 是否覆盖文件
 */
Drive.prototype.new_sql = async function(client, manage, cover) {
	var cg = this.config;

	var lt = cg.fields;
	var query = {};
	var update = {};
	var field = "";
	var field_obj = "";
	var query_default = {};
	var format = [];
	var orderby = "";
	var uid = $.dict.user_id;
	// 设置sql模板
	var len = lt.length;
	var keyword = "";
	var query_default_user = this.isSet(cg.table, this.query_default_table);
	for (var i = 0; i < len; i++) {
		var o = lt[i];
		var p = o.type;
		var n = o.name;
		if (this.isCan(n, this.get_not, p)) {
			field += ",`" + n + "`";
		}
		if (this.isCan(n, this.getObj_not)) {
			field_obj += ",`" + n + "`";
		}

		if (p === 'varchar' || p === 'text') {
			query[n] = "`" + n + "` like '%{0}%'";
			if (this.isSet(n, this.query_keyword)) {
				keyword += " || `" + n + "` like '%{0}%'";
			}
		} else if (p === 'date' || p === 'time' || p === 'datetime' || p === 'datetime' || p === 'timestamp') {
			query[n + "_min"] = "`" + n + "` >= '{0}'";
			query[n + "_max"] = "`" + n + "` <= '{0}'";
		} else if (p !== 'tinyint') {
			if (!n.endWith('id')) {
				query[n + "_min"] = "`" + n + "` >= {0}";
				query[n + "_max"] = "`" + n + "` <= {0}";
				update[n + "_add"] = "`" + n + "` = `" + n + "` + {0}";

				if (n === "sort" || n === "display" || n === "orderby") {
					orderby = '`' + n + '` asc';
				}
			} else if (n === uid && query_default_user) {
				query_default[n] = "`" + n + "` = {" + uid + "}";
			}
		}
		if(o.map){
			var fmt = await this.get_format(o);
			if(fmt){
				format.push(fmt);
			}
		}
	}

	if (keyword) {
		query["keyword"] = "(" + keyword.replace(' || ', '') + ")";
	}

	// 创建模型
	var m = {
		name: cg.table,
		title: cg.title,
		table: cg.table,
		key: cg.key,
		orderby_default: '`' + cg.key + '` desc',
		field_obj: field_obj.replace(',', ''),
		field_default: field.replace(',', ''),
		method: 'get get_obj',
		query,
		query_default,
		update,
		format
	};
	if (client) {
		var oj = Object.assign({}, m);
		if (orderby) {
			oj.orderby_default = orderby;
		}
		if (oj.query_default[uid]) {
			oj.filter = {
				"table": "table",
				"page": "page",
				"size": "size",
				"method": "method",
				"orderby": "orderby",
				"field": "field",
				"count_ret": "count_ret"
			};
			oj.filter[uid] = uid;
		}
		this.save_file(client + '/sql.json', oj, cover);
	}
	if (manage) {
		delete m.method;
		m.field_hide = [];
		m.name += 2;
		m.field_obj = m.field_obj.replace(",`time_create`", "").replace(",`time_update`", "").replace(",`create_time`", "").replace(",`update_time`", "");
		delete m.query_default;
		this.save_file(manage + '/sql.json', m, cover);
	}
};

/**
 * 保存sql配置
 * @param {String} file 文件名
 * @param {Object} model 配置模型
 * @param {Boolean} cover 是否覆盖文件
 */
Drive.prototype.save_file = function(file, model, cover) {
	if (!file.hasFile()) {
		file.saveText(JSON.stringify(model, null, 4));
	} else if (cover) {
		var jobj = file.loadJson();
		for (var k in model) {
			var val = model[k];
			if (!val) {
				model[k] = jobj[k];
			}
		}
		$.push(jobj, model, true);
		file.saveText(JSON.stringify(jobj, null, 4));
	}
};

/**
 * 新建param配置文件
 * @param {String} client 客户端配置保存路径
 * @param {String} manage 管理端配置保存路径
 * @param {Boolean} cover 是否覆盖文件
 */
Drive.prototype.new_param = async function(client, manage, cover) {
	var cg = this.config;

	var lt = cg.fields;

	var cm = {
		name: cg.table,
		title: cg.title,
		add: {
			body: [],
			body_required: []
		},
		del: {
			query: [],
			query_required: []
		},
		set: {
			query: [],
			query_required: [],
			body: [],
			body_required: [],
			body_not: []
		},
		get: {
			query: [],
			query_required: []
		},
		list: []
	};
	var len = lt.length;
	var keyword = "";
	for (var i = 0; i < len; i++) {
		var o = lt[i];
		var p = o.type;
		var n = o.name;

		var m = {
			// 参数名
			"name": n,
			// 参数介绍名
			"title": o.title,
			// 参数做用描述
			"description": o.description + (o.map ? '(' + o.map + ')' : ''),
			// 是否主键
			"key": o.pk,
			// 参数类型 string字符串、number数字、bool布尔、dateTime时间、object对象类型、array数组类型
			"type": "",
			// 数据存储类型
			"dataType": p,
		};

		if (p === 'varchar' || p === 'text') {
			m.type = "string";
			// 字符串相关验证
			m.string = {
				// // 非空
				// "notEmpty": o.not_null,
				// // 最小长度
				// "min": o.min_length,
				// // 最大长度
				// "max": o.max_length,
				// // 验证字符串范围, 传入两个成员, 最小长度和最大长度。例如：[0, 0]
				// "range": ,
				// // 格式验证 email、url、date、dateISO、number、digits、phone
				// "format": ""
			};

			var range = (o.min_length && o.max_length) ? [o.min_length, o.max_length] : [];
			if (range.length > 0) {
				m.string.range = range;
			} else if (o.min) {
				m.string.min = o.min_length;
			} else if (o.max) {
				m.string.max = o.max_length;
			}

			if (n.has("phone") || n === "tel") {
				m.string.format = "phone"
			} else if (n.has("url") || n === "src" || n === "source") {
				m.string.format = "url"
			} else if (n.has("date")) {
				m.string.format = "date"
			} else if (n === "num" || n === "number" || n === "count") {
				m.string.format = "digits"
			} else if (n === "money" || n === "coin") {
				m.string.format = "number"
			} else if (n.has("email")) {
				m.string.format = "email"
			}
			if (o.not_null) {
				m.string.notEmpty = o.not_null;
				cm.add.body_required.push(n);
			} else {
				cm.add.body.push(n);
			}
			if (this.isSet(n, this.query_string)) {
				cm.get.query.push(n);
				cm.set.query.push(n);
				keyword += "、" + o.title + "(" + n + ")";
			}
			cm.set.body.push(n);

			// 添加验证模型
			cm.list.push(m);
		} else if (p === 'date' || p === 'time' || p === 'datetime' || p === 'timestamp') {
			var format = "";
			if (p === 'timestamp') {
				format = "datetime"
			} else {
				format = p;
			}
			m.type = "string";
			// 时间相关验证
			m.string = {
				// 非空
				"notEmpty": true,
				"format": format
			};
			// 添加验证模型
			cm.list.push(m);
			var m_min = Object.assign({}, m);
			m_min.name = n + "_min";
			m_min.title += "——开始时间";
			cm.list.push(m_min);
			var m_max = Object.assign({}, m);
			m_max.name = n + "_max";
			m_max.title += "——结束时间";
			cm.list.push(m_max);
			
			if (n.indexOf('create') !== -1 && n.indexOf('update') !== -1) {
				cm.add.body.push(n);
				cm.set.body.push(n);
			}

			cm.get.query.push(n + "_min");
			cm.get.query.push(n + "_max");
		} else {
			m.type = "number";
			// 数值相关验证

			m.number = {
				// // 最小值
				// "min": o.min,
				// // 最大值
				// "max": o.max,
				// // 验证字符串范围
				// "range": []
			};
			var range = (o.min && o.max) ? [o.min, o.max] : [];
			if (range.length > 0) {
				m.number.range = range;
			} else if (o.min) {
				m.number.min = o.min;
			} else if (o.max) {
				m.number.max = o.max;
			}
			if (o.name === cg.key) {
				cm.del.query_required.push(n);
				cm.set.query.push(n);
				cm.get.query.push(n);
				// 添加验证模型
				cm.list.push(m);
			} else {
				cm.add.body.push(n);
				cm.set.body.push(n);
				cm.list.push(m);
				if (m.dataType !== "tinyint") {
					var ne = n;
					if (!ne.endWith('id')) {
						cm.get.query.push(n + "_min");
						cm.get.query.push(n + "_max");
						cm.set.query.push(n + "_min");
						cm.set.query.push(n + "_max");
						cm.set.body.push(n + "_add");
						var m_min = Object.assign({}, m);
						m_min.name = n + "_min";
						m_min.title += "——最小值";
						cm.list.push(m_min);
						var m_max = Object.assign({}, m);
						m_max.name = n + "_max";
						m_max.title += "——最大值";
						cm.list.push(m_max);
					} else {
						if (this.isSet(n, this.query_number)) {
							cm.set.query.push(n);
							cm.get.query.push(n);
						}
					}
				} else {
					cm.set.query.push(n);
					cm.get.query.push(n);
				}
			}
		}
	}

	if (keyword) {
		cm.get.query.push('keyword');
		cm.set.query.push('keyword');
		var m_k = {
			"name": "keyword",
			"title": "关键词",
			"description": "用于搜索" + keyword.replace('、', ''),
			"type": "string",
			"dataType": "varchar",
			"string": {}
		};
		cm.list.push(m_k);
	}

	// 保存配置文件
	if (client) {
		this.save_file(client + '/param.json', cm, cover);
	}
	if (manage) {
		delete cm.method;
		cm.name += 2;
		this.save_file(manage + '/param.json', cm, cover);
	}
};

/**
 * 是否设置
 * @param {String} name 名称
 * @param {Array} arr 匹配的对象
 */
Drive.prototype.isSet = function(name, arr) {
	var bl = false;
	for (var i = 0; i < arr.length; i++) {
		if (name.indexOf(arr[i]) !== -1) {
			bl = true;
			break;
		}
	}
	return bl;
};

/**
 * 是否排除
 * @param {String} name 名称
 * @param {Array} arr 匹配的对象
 * @param {String} type 数据类型
 * @return {Boolean} 是否可以
 */
Drive.prototype.isCan = function(name, arr, type) {
	if(type === 'text'){
		return false;
	}
	var bl = false;
	for (var i = 0; i < arr.length; i++) {
		if (name.indexOf(arr[i]) !== -1) {
			bl = true;
			break;
		}
	}
	return !bl;
};


/**
 * 新建api配置文件
 * @param {String} client 客户端配置保存路径
 * @param {String} manage 管理端配置保存路径
 * @param {Boolean} cover 是否覆盖文件
 */
Drive.prototype.new_api = async function(client, manage, cover) {
	var cg = this.config;
	var arr = cg.table.split('_');
	var p = "/api/";
	if (arr.length > 1) {
		p += cg.table.replace('_', '/');
	} else {
		p += arr[0];
	}
	var m = {
		"name": cg.table,
		"title": cg.title,
		"description": cg.description,
		"path": p,
		"method": "ALL",
		"cache": 0,
		"client_cache": false,
		"param_path": "./param.json",
		"sql_path": "./sql.json",
		"check_param": true
	};

	// 保存配置文件
	if (client) {
		var o = Object.assign({}, m);

		var lt = cg.fields;
		if (cg.title.indexOf('user') !== -1) {
			// 判断该表是否含用户ID，如果含有则需要验证才能访问
			var has = false;
			for (var i = 0, item; item = lt[i++];) {
				var name = item.name;
				if (name == $.dict.user_id || name === 'uid' || name === 'user_id' || name === 'userid') {
					has = true;
					break;
				}
			}
			if (has) {
				o.oauth = {
					"scope": true,
					"signIn": true,
					"vip": 0,
					"user_group": []
				};
			}
		}
		o.method = "GET";
		this.save_file(client + '/api.json', o, cover);
	}
	if (manage) {
		var o = Object.assign({}, m);
		o.oauth = {
			"scope": true,
			"signIn": true,
			"gm": 2,
			"user_admin": []
		};
		o.path = o.path.replace("/api/", "/apis/");
		o.name += "_manage";
		this.save_file(manage + '/api.json', o, cover);
	}
};

module.exports = Drive;
