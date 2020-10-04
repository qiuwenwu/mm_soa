/**
 * 公共类
 */
class Com {
	/**
	 * 构造函数
	 * @param {Object} config
	 * @param {Object} src 载入源
	 */
	constructor(config, src) {
		/**
		 * 配置参数
		 */
		this.config = {
			/**
			 * 检索的起始目录
			 */
			path: __dirname,
			/**
			 * 检索的目录名
			 */
			dir: "com",
			/**
			 * 检索的文件名
			 */
			file: "index.js"
		};

		$.push(this.config, config, true);
	}
}


/**
 * 加载模块
 * @param {String} file 文件全名
 */
Com.prototype.load = function(file) {
	var com = require(file);
	$.push($, com, true);
};

/**
 * 运行com加载
 * @param {String} path 路径
 */
Com.prototype.each_load = function(path) {
	if (path.hasDir()) {
		var dirs = $.dir.get(path);
		var file = this.config.file;
		dirs.map((d) => {
			this.load(d + file);
		});
	}
};

/**
 * 卸载模块
 * @param {String} file 文件全名
 */
Com.prototype.unload = function(file) {
	delete require.cache[require.resolve(file)];
};

/**
 * 初始化
 */
Com.prototype.init = function() {
	this.each_load(__dirname.fullname());
	this.each_load($.config.path.com);
};

module.exports = Com;
