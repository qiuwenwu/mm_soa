const {
	proxy,
	proxyTo,
	isMatch
} = require('mm_koa_proxy');

/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	var config = server.config;
	var options = config.proxy;
	if (options.targets) {
		server.use(proxy(options, function(op, ctx, next) {
			if (ctx.session && ctx.session.user) {
				ctx.request.header['user_id'] = ctx.session.user.user_id;
			}
		}));
	}
	return server;
};
