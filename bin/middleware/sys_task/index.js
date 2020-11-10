/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	if (server.config.sys.task && $.event_admin) {
		// 创建一个任务管理器
		$.task = $.task_admin('sys');
		$.task.update();
		$.task.run();
		// 启动计时器
		$.timer.run();
		console.log('已启动定时任务！');
	};
	
	return server;
};
