/**
 * 定时任务函数
 */
exports.main = async function main() {
	$.log.debug('定时任务, 执行中...');
};

/**
 * 执行结果通知
 * @param {String} name 任务名称
 * @param {String} state 状态
 */
exports.notify = async function(name, state) {
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
			break;
		case "completed":
			$.log.debug('已完成');
			break;
		default:
			break;
	}
};