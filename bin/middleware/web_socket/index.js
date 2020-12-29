const websocket = require('koa-websocket');

/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	// 引入web socket通讯
	server = websocket(server);

	if (server.config.web.websocket && $.Socket) {
		// console.log("已启动websocket服务！");
		//使用 websocket 服务
		$.socket = new $.Socket();
		$.socket.update();
		server.ws.use((ctx, next) => {
			$.socket.run(ctx, next);
		});
	}

	return server;
};
