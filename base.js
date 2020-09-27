/**
 * 基础类
 */
class Base {
	/**
	 * 构造函数
	 * @param {Object} config 配置参数
	 * @param {Object} options 附加选项
	 */
	constructor(config, options) {
		/**
		 * 配置参数
		 */
		this.config = {};

		/**
		 * 附加选项
		 */
		this.options = {};

		this.set_config(config, options);
	}
}

/**
 * 事件
 * @param {String} name 名称
 * @param {Object} paramA 参数1
 * @param {Object} paramB 参数2
 * @param {Object} paramC 参数3
 * @return {Object} 返回执行结果
 */
Base.prototype.event = async function(name, paramA, paramB, paramC) {
	if (this[name]) {
		return await this[name](paramA, paramB, paramC);
	} else {
		return undefined;
	}
};

/**
 * 执行事件
 * @param {String} name 名称
 * @param {Object} paramA 参数1
 * @param {Object} paramB 参数2
 * @return {Object} 返回执行结果
 */
Base.prototype.do = async function(name, paramA, paramB, paramC) {
	var res = await this.event(name + '_before', paramA, paramB, paramC);
	if (!res) {
		res = await this.event(name + '_main', paramA, paramB, paramC);
	}
	var ret = await this.event(name + '_after', paramA, paramB, res);
	return ret || res;
};

/**
 * 设置配置参数(主要)
 * @param {Object} config 主要配置
 * @param {Object} options 其他配置
 * @return {Object} 返回执行结果
 */
Base.prototype.set_config_main = async function(config, options) {
	if (config) {
		this.config = Object.assign(this.config, config);
	}
	if (options) {
		this.options = Object.assign(this.options, options);
	}
	return this.config;
};


/**
 * 设置配置参数
 * @param {String} name 名称
 * @param {Object} config 主要配置
 * @param {Object} options 其他配置
 * @return {Object} 返回执行结果
 */
Base.prototype.set_config = async function(config, options) {
	return await this.do('set_config', config, options);
};


/**
 * 初始化
 * @param {Object} paramA 参数1
 * @param {Object} paramB 参数2
 * @return {Object} 返回执行结果
 */
Base.prototype.init = async function(paramA, paramB) {
	return await this.do('init', paramA, paramB);
};

/**
 * 执行
 * @param {Object} paramA 参数1
 * @param {Object} paramB 参数2
 * @return {Object} 返回执行结果
 */
Base.prototype.run = async function(paramA, paramB) {
	return await this.do('run', paramA, paramB);
};

/**
 * 执行指令(主要)
 * @param {Object} method 方法
 * @param {Object} paramA 参数1
 * @param {Object} paramB 参数2
 * @return {Object} 返回执行结果
 */
Base.prototype.cmd_main = async function(method, paramA, paramB) {
	var mds = method.split('.');
	var obj = this;
	var str = '';
	for (var i = 0; i < mds.length; i++) {
		var name = mds[i];
		str += '["' + name + '"]';
		if (obj[name]) {
			obj = obj[name];
			var type = typeof(obj);
			if (type === 'function') {
				var func_str = 'this' + str + '(paramA, paramB);';
				obj = await eval(func_str);
				break;
			} else if (Array.isArray(obj) && paramA) {
				var oj = obj[paramA];
				if (paramB) {
					obj = oj[paramB];
				} else {
					obj = oj;
				}
			} else if (type !== 'object') {
				break;
			}
		} else {
			obj = undefined;
		}
	}
	return obj;
};


/**
 * 执行指令
 * @param {Object} method 方法
 * @param {Object} paramA 参数1
 * @param {Object} paramB 参数2
 * @return {Object} 返回执行结果
 */
Base.prototype.cmd = async function(method, paramA, paramB) {
	return await this.do('cmd', method, paramA, paramB);
};


/**
 * 帮助
 * @param {Object} param 参数
 * @return {Object} 返回执行结果
 */
Base.prototype.help_main = async function(param) {
	var ret = '';
	if (this.helper) {
		var hp = '';
		if (param) {
			hp = this.helper[param];
		} else {
			hp = this.helper;
		}

		if (Array.isArray(hp)) {
			for (var i = 0; i < hp.length; i++) {
				ret += "[" + i + "] " + typeof(hp[i]) + "\r\n";
			}
		} else if (typeof(hp) === 'object') {
			for (var k in hp) {
				ret += "." + k + " " + typeof(hp[k]) + "\r\n";
			}
		} else {
			ret = hp;
		}
	} else {
		if (param) {
			var obj = this;
			var mds = param.split('.');
			for (var i = 0; i < mds.length; i++) {
				var name = mds[i];
				if (obj[name]) {
					obj = obj[name];
					var type = typeof(obj);
					if (type === 'function') {
						ret = obj.toString();
						break;
					} else if (Array.isArray(obj)) {
						ret = JSON.stringify(obj);
					} else if (type !== 'object') {
						ret = obj;
						break;
					} else {
						ret = obj;
					}
				} else {
					ret = obj;
					break;
				}
			}
			if (typeof(ret) === 'object') {
				var hp = ret;
				ret = "";
				for (var k in hp) {
					if (Array.isArray(hp[k])) {
						ret += "." + k + " array\r\n";
					} else {
						ret += "." + k + " " + typeof(hp[k]) + "\r\n";
					}
				}
			}
		} else {
			ret = "";
			for (var k in this) {
				if (Array.isArray(hp[k])) {
					ret += "." + k + " array\r\n";
				} else {
					ret += "." + k + " " + typeof(hp[k]) + "\r\n";
				}
			}
		}
	}
	return ret;
};

Base.prototype.help = async function(param) {
	return await this.do('help', param);
};

module.exports = Base;
