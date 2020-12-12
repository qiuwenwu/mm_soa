const tpl_dir = "../../static/".fullname(__dirname);
const tpl_file = tpl_dir + '{0}.html';

/**
 * @description 接口主函数
 * @param {Object} ctx HTTP上下文
 * @param {Object} db 数据管理器,如: { next: async function{}, ret: {} }
 * @return {Object} 执行结果
 */
async function main(ctx, db) {
	var path = ctx.path;
	if (path.indexOf('.') === -1) {

		// 抽取文件名
		var name = path.replace("/", "");
		if (!name) {
			name = "index";
		}
		var file = tpl_file.replace("{0}", name);
		if (!file.hasFile()) {
			return;
		}

		// 获取当前的语言包
		var type = ctx.cookies.get("lang_type") || 'en';
		db.table = "sys_lang";
		db.size = 0;
		var arr = await db.get({}, "", "`key`" + ",`" + type + "`");
		var lang = {};
		if (arr.length) {
			for (var i = 0; i < arr.length; i++) {
				var o = arr[i];
				lang[o.key] = o[type];
			}
		}

		// 获取seo配置
		db.table = "sys_seo";
		var seo = await db.getObj({
			path
		});
		if (!seo) {
			seo = {};
		}

		// 获取系统配置
		db.table = "sys_config";
		var config = await db.get();
		if (!config) {
			config = {};
		}


		var query = Object.assign({}, ctx.request.query);
		var list = [];
		var obj = {};
		if (name.indexOf("/list") !== -1 || name.indexOf("/channel") !== -1 || name.indexOf("/type") !== -1) {
			// 获取系统配置
			db.table = ("cms_" + name).replace("/list", "").replaceAll("/", "_");
			db.page = query.page || 1;
			db.size = query.size || 10;
			delete query.page;
			delete query.size;
			list = await db.get(query);
		} else if (name.indexOf("/view") !== -1 || name.indexOf("/form") !== -1) {
			// 获取系统配置
			db.table = ("cms_" + name).replace("/view", "").replace("/form", "").replaceAll("/", "_");
			obj = await db.getObj(query);
		}

		// 创建与view视图通讯的模型
		var model = {
			os: "mm",
			app: "home",
			plugin: "pc",
			site_name: "elins.cn",
			congfig: Object.assign(config, $.config),
			seo: Object.assign({
				title: $.config.sys.title + "门户",
				keywords: "mm home pc",
				description: "",
				content: "",
			}, seo),
			list,
			obj,
			lang,
			view: function(file, m){
				return db.tpl.view(file.fullname(tpl_dir), Object.assign({}, model, m));
			}
		};

		// return model;
		// art模板引擎
		return db.tpl.view(file, model);
	}
	return null;
}

exports.main = main;
