var api = $.api_admin('mall_manage', '商城管理端');
// 首次启动更新api接口;
api.update('mall/');

var sql = $.mysql_admin('sys', __dirname);

/**
 * @description 接口主函数
 * @param {Object} ctx HTTP上下文
 * @param {Object} db 数据管理器,如: { next: async function{}, ret: {} }
 * @return {Object} 执行结果
 */
async function main(ctx, db) {
	// 在这定义要访问的数据库 (分布式开发时设置不同的数据库名)
	$.push(db, sql.db(), true);
	return api.run(ctx, db);
};

exports.main = main;