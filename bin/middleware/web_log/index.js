// 格式化请求日志
function formatReq(ctx, resTime = new Date()) {
	var req = ctx.request;
	var logText = '\n======= request =======\n';

	var method = req.method;
	
	// 访问方法
	logText += '\n' + 'method: ' + method + '\n';

	// 请求原始地址
	logText += 'originalUrl:  ' + req.originalUrl + '\n';

	// 客户端ip
	logText += 'client ip:  ' + req.ip + '\n';

	// 开始时间
	//   var startTime;
	// 请求参数
	if (method === 'GET') {
		logText += 'query:  ' + JSON.stringify(req.query) + '\n';
		// startTime = req.query.requestStartTime;
	} else {
		logText += 'query:  ' + JSON.stringify(req.query) + '\n';
		logText += 'body: ' + '\n' + JSON.stringify(req.body) + '\n';
	}
	// 服务器请求时间
	logText += 'req time: ' + resTime + '\n';
	
	// 响应日志结束
	logText += '\n======= request end =======\n';
	return logText;
}

// 格式化响应日志
var formatRes = function(ctx, resTime = new Date()) {
	var logText = '\n======= response start =======\n';

	// 响应状态码
	logText += 'status: ' + ctx.status + '\n';

	// 响应内容
	logText += 'body: ' + '\n' + JSON.stringify(ctx.body) + '\n';
	
	// 服务器响应时间
	logText += 'res time: ' + resTime + '\n';
	
	// 响应日志结束
	logText += '\n======= response end =======\n';

	return logText;
}

/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	if (server.config.web.log) {
		server.use(async (ctx, next) => {
			$.log.httpLogger.info(formatReq(ctx));
			await next();
			$.log.httpLogger.info(formatRes(ctx));
		});
	}
}
