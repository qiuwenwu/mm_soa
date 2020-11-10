const Item = require('mm_machine').Item;

/**
 * 延迟
 * @param {Number} 毫秒
 */
function sleep(milliSeconds) {
	var endTime = new Date().getTime() + milliSeconds;
	while (new Date().getTime() < endTime) {}
}

/**
 * 计算时间差
 * @param {String} startTime 开始时间
 * @param {String} endTime 结束时间
 * @return {Number} 返回间隔时长
 */
function span(startTime, endTime) {
	var stime = Date.parse(startTime);
	var etime = Date.parse(endTime);
	return etime - stime;
};

/**
 * 转为时间
 * @param {String} timeStr 时间字符串
 * @return {Date} 时间类型
 */
function toTime(timeStr) {
	var str = timeStr.replace('T', ' ').replace('Z', '').replaceAll('.', '/').replaceAll('-', '/');
	return new Date(str);
};

/**
 * 定时器类函数
 */
class Drive extends Item {
	/**
	 * 构造函数
	 * @param {String} dir 当前目录
	 */
	constructor(dir) {
		super(dir, __dirname);
		this.default_file = "./task.json";
		
		/// 配置参数
		this.config = {
			// 标题, 介绍事件作用
			"title": "示例事件",
			// 描述, 用于描述该事件有什么用的
			"description": "描述事件使用方法",
			// 名称, 由中英文和下“_”组成, 用于卸载事件
			"name": "demo",
			// 文件路径, 当调用函数不存在时，会先从文件中加载
			"func_file": "./index.js",
			// 执行次数
			"num": 10,
			// 时间间隔（毫秒ms）
			"interval": 1000,
			// 等待时长（毫秒ms）
			"wait": 0,
			// 执行时间
			"time": "",
			// 执行开始日期
			"date_start": "",
			// 执行结束日期
			"date_end": "",
			// 执行顺序
			"sort": 100
		};
		
		/// 状态
		this.state = "start";
		/// 等候器
		this.timeout;
		/// 定时执行器
		this.interval;
		/// 当前执行次数
		this.num = 1;
	}
}

/**
 * @description 设置等待执行
 * @param {Function} func 回调函数
 */
Drive.prototype.setTimeout = function(func) {
	if (!func) {
		func = function() {};
	}
	this.timeout = setTimeout(func, this.config.wait);
};

/**
 * @description 设置间隔执行
 * @param {Function} func 回调函数
 */
Drive.prototype.setInterval = async function(func) {
	if (!func) {
		func = function() {};
	}
	sleep(this.config.wait);
	this.interval = setInterval(func, this.config.interval);
};

/**
 * @description 设置时期执行
 * @param {Function} func 回调函数
 */
Drive.prototype.setPeriod = function(func) {
	var _this = this;
	var cg = this.config;
	var fn;
	var time = cg.time;
	if (time) {
		if (time.indexOf(' ') !== -1) {
			if (time.indexOf('-') !== -1) {
				var arr = time.split('-');
				if (arr.length > 2) {
					fn = function() {
						if (new Date().toStr('yyyy-MM-dd hh:mm:ss') === time) {
							func();
						}
					};
				} else {
					fn = function() {
						if (new Date().toStr('MM-dd hh:mm:ss') === time) {
							func();
						}
					};
				}
			} else {
				fn = function() {
					if (new Date().toStr('dd hh:mm:ss') === time) {
						func();
					}
				};
			}
		} else {
			var arr = time.split(':');
			if (arr.length == 3) {
				fn = function() {
					if (new Date().toStr('hh:mm:ss') === time) {
						func();
					}
				};
			} else if (arr.length == 2) {
				fn = function() {
					if (new Date().toStr('hh:mm') === time) {
						func();
					}
				};
			} else {
				fn = function() {
					if (new Date().toStr('mm') === time) {
						func();
					}
				};
			}
		}
	} else {
		fn = func;
	}
	if (cg.date_start) {
		var start = toTime(cg.date_start);
		if (cg.date_end) {
			var end = toTime(cg.date_end);
			return function() {
				var now = new Date();
				if (span(now, end) >= 0) {
					if (span(now, start) <= 0) {
						fn();
					}
				} else {
					_this.clear_sub();
					_this.notify(_this.config.name, 'time_end');
				}
			};
		} else {
			return function() {
				var now = new Date();
				if (span(now, start) <= 0) {
					fn();
				}
			};
		}
	} else if (cg.date_end) {
		var end = toTime(cg.date_end);
		return function() {
			var now = new Date();
			if (span(now, end) >= 0) {
				fn();
			} else {
				_this.clear_sub();
				_this.notify(_this.config.name, 'time_end');
			}
		};
	} else {
		return fn;
	}
};

/**
 * @description 设置按次数执行
 * @param {Function} func 回调函数
 */
Drive.prototype.setNum = function(func) {
	var _this = this;
	return function() {
		if (_this.state === 'start') {
			if (_this.config.num < 1) {
				func();
			} else if (_this.num < _this.config.num) {
				func();
				_this.num += 1;
			} else {
				func();
				_this.clear();
				_this.notify(_this.config.name, 'completed');
			}
		}
	};
};

/**
 * @description 结束定时器
 */
Drive.prototype.end = function() {
	// 当前状态为结束
	this.state = "end";
	this.notify(this.config.name, 'suspend');
	this.clear();
};

/**
 * @description 清除定时器(子函数)
 */
Drive.prototype.clear_sub = function() {
	if (this.interval) {
		clearInterval(this.interval);
	}
	if (this.timeout) {
		clearTimeout(this.timeout);
	}
};

/**
 * @description 清除定时器
 * @param {Number} millisecond 时间间隔, 单位: 毫秒
 */
Drive.prototype.clear = function(millisecond) {
	if (millisecond) {
		var _this = this;
		setTimeout(function() {
			_this.clear_sub();
		}, millisecond);
	} else {
		this.clear_sub();
	}
};

/**
 * @description 执行线程
 * @param {Function} func 回调函数
 * @return {Object} 当前类
 */
Drive.prototype.main = async function() {
	$.log.debug('定时任务, 执行中...');
};

/**
 * @description 执行线程
 * @param {Function} func 回调函数
 * @return {Object} 当前类
 */
Drive.prototype.run = async function(func) {
	this.init();
	if (func) {
		await this.setInterval(this.setPeriod(this.setNum(func)));
	} else {
		await this.setInterval(this.setPeriod(this.setNum(this.main)));
	}
	return this;
};

/**
 * @description 初始化定时器
 */
Drive.prototype.init = function() {
	// 当前执行次数
	this.num = 1;
	// 当前状态为开启
	this.state = "start";
	this.notify(this.config.name, 'init');
};

/**
 * @description 启动定时器
 */
Drive.prototype.start = function() {
	// 当前状态为开启
	this.state = "start";
	this.notify(this.config.name, 'start');
};

/**
 * @description 暂停定时器
 */
Drive.prototype.stop = function() {
	// 当前状态为开启
	this.state = "stop";
	this.notify(this.config.name, 'stop');
};

/**
 * @description 通知函数, 当定时器执行完最后一次时, 会调用通知函数
 * @param {String} name 名称
 * @param {String} state 状态
 */
Drive.prototype.notify = function(name, state) {
	// switch (state) {
	// 	case "init":
	// 		$.log.debug('初始化');
	// 		break;
	// 	case "start":
	// 		$.log.debug('开始执行');
	// 		break;
	// 	case "stop":
	// 		$.log.debug('已暂停');
	// 		break;
	// 	case "suspend":
	// 		// 主动中断
	// 		$.log.debug('已中断');
	// 		break;
	// 	case "time_end":
	// 		$.log.debug('已到期');
	// 		// 删除任务
	// 		break;
	// 	case "completed":
	// 		$.log.debug('已完成');
	// 		// 删除任务
	// 		break;
	// 	default:
	// 		break;
	// }
};

/**
 * @description 销毁资源
 */
Drive.prototype.dispose = function() {
	this.clear_sub();
	this.interval = undefined;
	this.timeout = undefined;
};

module.exports = Drive;
