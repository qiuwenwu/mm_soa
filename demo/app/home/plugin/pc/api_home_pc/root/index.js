const file = '../../static/index.html'.fullname(__dirname);

/**
 * @description 接口主函数
 * @param {Object} ctx HTTP上下文
 * @param {Object} db 数据管理器,如: { next: async function{}, ret: {} }
 * @return {Object} 执行结果
 */
async function main(ctx, db) {
	var path = ctx.path;
	if (path.indexOf('.') === -1) {
		$.globalBag.congfig = $.config;
		var model = {
			os: "mm",
			app: "home",
			plugin: "pc",
			site_name: "elins.cn",
			title: $.config.sys.title + "门户",
			keywords: "mm home pc",
			description: "",
			content: "",
			list: [
				{ 
					name: "张三",
					age: 21,
					sex: 1
				},
				{
					name: "李四",
					age: 31,
					sex: 0
				}
			]
		};
		// return model;
		// art模板引擎
		return db.tpl.view(file, model);
	}
	return null;
}

exports.main = main;
