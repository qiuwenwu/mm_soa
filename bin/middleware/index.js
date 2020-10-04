class Middleware {
	/**
	 * 构造函数
	 * @param {Object} config 配置参数
	 */
	constructor(config) {
		// 中间件列表
		this.list = [];

		this.config = {
			dir: __dirname + "/",
			file: "middleware.json"
		};

		if (config) {
			this.config = Object.assign(this.config, config)
		}
	}
}

/**
 * 加载配置
 * @param {String} file 配置文件路径
 */
Middleware.prototype.load = function(file) {
	var f = this.config.file;
	var config = file.loadJson();
	if (config) {
		var cg = this.list.getObj({
			name: config.name
		});
		if (cg) {
			$.push(cg, config, true);
		} else {
			cg = {
				func_file: file.replace(f, 'index.js')
			}
			$.push(cg, config, true);
			this.list.push(cg);
		}
	}
};

/**
 * 遍历加载配置
 * @param {Object} path
 */
Middleware.prototype.each_load = function(path) {
	if (path.hasDir()) {
		var dirs = $.dir.getAll(path);
		// 遍历目录路径
		var file = this.config.file;
		dirs.map((d) => {
			this.load(d + file);
		});
	}
};

/**
 * 排序
 */
Middleware.prototype.sort = function() {
	return this.list.sortBy('asc', 'sort');
};

/**
 * 遍历加载配置
 */
Middleware.prototype.init = function() {
	this.each_load(__dirname.fullname());
	this.each_load($.path.middleware);
	this.sort();
};

module.exports = Middleware;
