/**
 * 视图模型
 * @class
 */
class ViewModel {
	/**
	 * 配置参数
	 * @param {Object} config
	 */
	constructor(config) {

	}
}

/**
 * 获取显示类型 
 * @param {String} key
 * @param {Boolean} f 是否带格式
 * @return {String} 返回显示类型
 */
ViewModel.prototype.get_type = function(key, f) {
	var show = '';
	switch (key) {
		case "search":
			show = f ? "select" : "";
			break;
		case "view":
			show = "text";
			break;
		case "table":
			show = f ? "select" : "text";
			break;
		case "edit":
			show = f ? "select" : "input";
			break;
		case "list":
			show = "text";
			break;
		case "details":
			show = "text";
			break;
		case "batch":
			show = f ? "select" : "";
			break;
		case "filter":
			show = f ? "select" : "";
			break;
		default:
			show = f ? "select" : "";
			break;
	}
	return show;
};

/**
 * 查询显示方式
 * @param {Array} arr
 * @param {String} key
 * @param {Boolean} f 是否带格式
 * @return {String}
 */
ViewModel.prototype.get_show = function(arr, key, f) {
	var bl = false;
	var show = '';
	for (var i = 0; i < arr.length; i++) {
		var str = arr[i];
		if (str.indexOf(key + "_no") !== -1) {
			bl = true;
			break;
		} else if (str.indexOf(key + "_input") !== -1) {
			show = 'input';
			break;
		} else if (str.indexOf(key + "_select") !== -1) {
			show = 'select';
			break;
		} else if (str.indexOf(key + "_text") !== -1) {
			show = 'text';
			break;
		}
	}
	if (!show && !bl) {
		show = this.get_type(key, f);
	}
	return show;
};

/**
 * 获取表格所需键值对
 * @param {Object} model 模型
 * @return {Object} 返回视图所用模型
 */
ViewModel.prototype.field = async function(model) {
	var list = model.param.list;
	if (!list) {
		model.param.list = [];
		return [];
	}
	var field;
	if (model.file.indexOf('_form') !== -1 || model.file.indexOf('_view') !== -1) {
		field = model.sql.field_obj || '';
	} else {
		field = model.sql.field_default || '';
	}
	var requireds = [];
	var add = model.param.add;
	if (add) {
		requireds = add.body_required;
	}
	var arr = field.replace(/`/g, '').split(',');
	var pm = [];
	for (var i = 0; i < list.length; i++) {
		var o = list[i];
		var name = o.name;
		if (arr.indexOf(name) !== -1) {
			var obj = Object.assign({}, o);
			var format = model.sql.format.getObj({
				key: name
			});
			var f = false;
			if (format) {
				obj.title = format.title;
				obj.format = format;
				f = true;
			}
			if (requireds.indexOf(name) !== -1) {
				obj.required = true;
			}
			var desc = obj.description;
			var show = {};
			
			if (desc.indexOf("##") === -1) {
				show.form = f ? "select" : "input";
				show.view = "text";
				show.search = f ? "select" : "";
				show.table = f ? "select" : "text";
				show.list = "text";
				show.edit = f ? "select" : "input";
				show.details = "text";
				show.batch = f ? "select" : "";
				show.filter = f ? "select" : "";
			} else {
				desc = desc.between("##", "##");
				obj.description = obj.description.replace("##" + desc + "##", "");
				var ar = desc.trim().split(" ");
				if (desc.indexOf("none") !== -1) {
					show.form = '';
					show.view = '';
					show.search = '';
					show.table = '';
					show.list = '';
					show.edit = '';
					show.details = '';
					show.batch = '';
					show.filter = '';
				} else {
					// 后端 - 搜索栏
					show.search = this.get_show(ar, "search", f);
					// 后端 - 表格
					show.table = this.get_show(ar, "table", f);
					// 后端 - 表单页
					show.form = this.get_show(ar, "form", f);
					// 后端 - 详情页
					show.view = this.get_show(ar, "view", f);
					// 后端 - 批量操作
					show.batch = this.get_show(ar, "batch", f);

					// 前端 - 列表
					show.list = this.get_show(ar, "list", f);
					// 前端 - 详情页
					show.details = this.get_show(ar, "details", f);
					// 前端 - 筛选栏
					show.filter = this.get_show(ar, "filter", f);
					// 前端 - 编辑页
					show.edit = this.get_show(ar, "edit", f);
				}
			}
			obj.show = show;
			pm.push(obj);
		}
	}
	return pm;
};

/**
 * 运算视图模型（css）
 * @param {Object} model 模型
 * @return {Object} 返回视图所用模型
 */
ViewModel.prototype.css = async function(model) {
	var css = {};
	return css;
};

/**
 * 运算视图模型（html）
 * @param {Object} model 模型
 * @return {Object} 返回视图所用模型
 */
ViewModel.prototype.html = async function(model) {
	var html = {};
	if (!model.sql) {
		return html;
	}
	return html;
};

/**
 * 运算视图模型（js）
 * @param {Object} model 模型
 * @return {Object} 返回视图所用模型
 */
ViewModel.prototype.js = async function(model) {
	var js = {
		data: [],
		query: []
	};
	var field = model.field;
	var path_start = model.file.indexOf('admin') !== -1 ? '/apis/' : '/api/';

	for (var i = 0; i < field.length; i++) {
		var o = field[i];
		var format = o.format;
		if (format) {
			var obj;
			if (format.table) {
				var basename = format.table.split('_').splice(1).join('_');
				var name = "list_" + basename;
				var id = format.id || format.key;
				o.label = name;
				var path = path_start + format.table.replace('_', '/') + "?size=0";
				obj = {
					basename,
					title: format.title,
					id,
					name,
					field: format.name,
					value: [],
					path
				};

				// 存在BUG（start）
				if (o.name === 'father_id' || o.name === 'fid') {
					obj.father_id = o.name;
				}
				if (o.name === 'title') {
					obj.title_name = 'title';
				}
				// 存在BUG（end）
			} else {
				var basename = format.key;
				var name = "arr_" + basename;
				o.label = name;
				obj = {
					title: format.title,
					name,
					value: format.list
				}
			}
			js.data.push(obj);
		}
	}
	var param = model.param;
	if (param && param.get) {
		var arr = param.get.query_required.concat(param.get.query);
		var lt = param.list;
		for (var i = 0; i < arr.length; i++) {
			var o = lt.getObj({
				name: arr[i]
			});
			if (o) {
				js.query.push({
					title: o.title,
					name: o.name,
					type: o.type,
					select: o.description ? (o.description.indexOf('(') !== -1) : false
				});
			}
		}
	}
	return js;
};

/**
 * 运算视图模型
 * @param {Object} model 模型
 * @return {Object} 返回视图所用模型
 */
ViewModel.prototype.run = async function(model) {
	model.field = await this.field(model);
	model.js = await this.js(model);
	model.html = await this.html(model);
	model.css = await this.css(model);
	return model;
};

module.exports = ViewModel;
