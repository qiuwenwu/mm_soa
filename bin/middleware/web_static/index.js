const statics = require('mm_statics');

/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	var config = server.config;
	// 处理静态文件
	if (config.web.static) {
		var path = config.path.static.fullname();
		server.use(statics(path, {
				maxAge: config.web.maxAge,
				gzip: true,
				brotli: true
			}));
		// 使用多路径静态文件处理器
		if ($.Static) {
			const Static = $.Static;
			$.static = new Static();
			$.static.update();
			server.use($.static.run);
		}
	}
	return server;
};
