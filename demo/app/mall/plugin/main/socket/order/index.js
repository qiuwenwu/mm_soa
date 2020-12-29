var test_msg = {
	"from_user": "小明",
	"to_user": "小白",
	"create_time": new Date().stamp(),
	"content": "你好"
};

/**
 * 主函数, 用于处理未定义函数的消息
 * @param {Object} body 消息主体内容
 * @param {Object} ws websocket通讯器
 */
exports.main = async function(body, ws) {
	$.log.info('收到客户端推送数据', body);
	test_msg["create_time"] = new Date().stamp();
	
	ws.send(JSON.stringify([body.params, test_msg]));
	// ws.req('get_method', 1, function(res){
	// 	$.log.debug("从客户端获取数据:", res);
	// 	$.log.debug("查看消息队列数:", ws.list_msg.length);
	// });
};

/**
 * 同步消息, 用于定时给前端推送数据
 * @param {Object} ws websocket通讯器
 */
exports.sync = async function(ws) {
	ws.send([]);
};

/**
 * 初始化函数, 用于定义开放给前端的函数
 */
exports.init = async function() {
	var m = this.methods;
	/**
	 * @param {Object} params 参数
	 * @param {Object} ws Websocket服务
	 */
	m.test = function(params, ws) {
		return "你好"
	};
};