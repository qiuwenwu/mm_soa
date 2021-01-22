/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	"./app".fullname().addDir();
	
	// 追加主程序
	server.main("/*", async (ctx, db) => {
		var md = ctx.method.toLocaleLowerCase();
		var list = server.routes[md];
		return await server.run_route(ctx, db, list);
	});
	
	// 使用路由(主要)
	server.use(async (ctx, next) => {
		var db = ctx.db;
		var path = ctx.path;
		if (path !== "/favicon.ico") {
			db.ret = await server.run_event(ctx, server.events.check, db);
			if (!db.ret) {
				db.ret = await server.run_event(ctx, server.events.main, db);
			}
			db.ret = await server.run_event(ctx, server.events.render, db) || db.ret;
		}
		if (db.ret) {
			ctx.body = db.ret;
		}
		await next();
	});
	
	return server;
};
