/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	// 创建一个任务管理器
	$.app = $.app_admin('app', '系统应用');
	$.app.update();
	$.app.init();
	return server;
};
