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
 * 获取表格所需键值对
 * @param {Object} model 模型
 * @return {Object} 返回视图所用模型
 */
ViewModel.prototype.field = async function(model) {
	var list = model.param.list;
	if (!list) {
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
			if (format) {
				obj.title = format.title;
				obj.format = format;
			}
			if (requireds.indexOf(name) !== -1) {
				obj.required = true;
			}
			var desc = obj.description;
			obj.show = {};
			if (desc.indexOf("##") === -1) {
				obj.show.form = true;
				obj.show.view = true;
				obj.show.search = true;
				obj.show.table = true;
				obj.show.list = true;
				obj.show.edit = true;
				obj.show.details = true;
				obj.show.batch = true;
			} else {
				desc = desc.between("##", "##");
				if (desc.indexOf("none") !== -1) {
					obj.show.form = false;
					obj.show.view = false;
					obj.show.search = false;
					obj.show.table = false;
					obj.show.list = false;
					obj.show.edit = false;
					obj.show.details = false;
					obj.show.batch = false;
				} else {
					obj.show.form = desc.indexOf("form") !== -1;
					obj.show.view = desc.indexOf("view") !== -1;
					obj.show.search = desc.indexOf("search") !== -1;
					obj.show.table = desc.indexOf("table") !== -1;
					obj.show.list = desc.indexOf("list") !== -1;
					obj.show.edit = desc.indexOf("edit") !== -1;
					obj.show.details = desc.indexOf("details") !== -1;
					obj.show.batch = desc.indexOf("batch") !== -1;

					obj.show.form = !(desc.indexOf("form_no") !== -1);
					obj.show.view = !(desc.indexOf("view_no") !== -1);
					obj.show.search = !(desc.indexOf("search_no") !== -1);
					obj.show.table = !(desc.indexOf("table_no") !== -1);
					obj.show.list = !(desc.indexOf("list_no") !== -1);
					obj.show.edit = !(desc.indexOf("edit_no") !== -1);
					obj.show.details = !(desc.indexOf("details_no") !== -1);
					obj.show.batch = !(desc.indexOf("batch_no") !== -1);
				}
			}
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
