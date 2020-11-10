/**
 * 定时任务函数
 */
exports.main = async function main() {
	$.log.debug('定时任务, 执行中...');
};

/**
 * 执行结果通知
 * @param {String} name 任务名称
 * @param {String} message 提示内容
 */
exports.notify = async function(name, message) {
	switch (state) {
		case "init":
			$.log.debug('初始化');
			break;
		case "start":
			$.log.debug('开始执行');
			break;
		case "stop":
			$.log.debug('已暂停');
			break;
		case "suspend":
			// 主动中断
			$.log.debug('已中断');
			break;
		case "time_end":
			$.log.debug('已到期');
			// 删除任务
			this.del(name)
			break;
		case "completed":
			$.log.debug('已完成');
			// 删除任务
			this.del(name)
			break;
		default:
			break;
	}
};
