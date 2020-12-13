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

		// 获取系统配置
		db.table = "sys_config";
		db.size = 0;
		var arr_config = await db.get({}, "", "`name`,`value`");
		var config = {};
		if (arr_config.length) {
			for (var i = 0; i < arr_config.length; i++) {
				var o = arr_config[i];
				config[o.name] = o.value;
			}
		}

		var theme_style = ctx.cookies.get("theme_style") || config.theme_style || 'default';
		var theme_color = ctx.cookies.get("theme_color") || config.theme_color || 'blue';

		// 获取当前的语言包
		var sys_lang = ctx.cookies.get("sys_lang") || config.sys_lang || 'zh_cn';
		db.table = "sys_lang";
		var arr_lang = await db.get({}, "", "`key`" + ",`" + sys_lang + "`");
		var lang = {};
		if (arr_lang.length) {
			for (var i = 0; i < arr_lang.length; i++) {
				var o = arr_lang[i];
				lang[o.key] = o[sys_lang];
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
			config: Object.assign(config, $.config),
			seo: Object.assign({
				title: $.config.sys.title + "门户",
				keywords: "mm home pc",
				description: "",
				content: "",
			}, seo),
			theme_style,
			theme_color,
			sys_lang,
			list,
			obj,
			lang,
			view: function(file, m) {
				return db.tpl.view(file.fullname(tpl_dir), Object.assign({}, model, m));
			},
			nav: {
				top: [{
						name: "home",
						title: "首页",
						url: "/",
						target: ""
					},
					{
						name: "about",
						title: "关于我们",
						url: "/about",
						target: ""
					},
					{
						name: "service",
						title: "开发服务",
						url: "/service",
						target: ""
					},
					{
						name: "contact",
						title: "联系方式",
						url: "/contact",
						target: ""
					}
				]
			}
		};

		// return model;
		// art模板引擎
		return db.tpl.view(file, model);
	}
	return null;
}

exports.main = main;
