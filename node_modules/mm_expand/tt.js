const {
	join,
	dirname,
	basename,
	extname
} = require('path');

/**
 * @type {String}
 */
const slash = join('/');
global.$ = {};
$.runPath = process.cwd() + slash;

/**
 * @description 验证开头字符串
 * @param {String} startStr 开头字符串
 * @return {Boolean} 验证成功返回true，失败返回false
 */
String.prototype.startWith = function(startStr) {
	var d = this.length - startStr.length;
	if (d >= 0 && this.indexOf(startStr) === 0) {
		return true;
	}
	return false;
};

/**
 * @description 补全路径
 * @param {String} dir 
 * @return {String} 全路径
 */
String.prototype.fullname = function(dir) {
	var file = this + '';
	file = file.replace(/\//g, slash);
	if (file.startWith('.' + slash)) {
		if (dir) {
			file = file.replace('.' + slash, dir.fullname());
		} else {
			file = file.replace('.' + slash, $.runPath);
		}
	} else if (file.startWith('..' + slash)) {
		if (dir) {
			file = dir.fullname() + file;
		} else {
			file = $.runPath + file;
		}
	} else if (file.startWith(slash) && !file.startWith($.runPath)) {
		file = $.runPath + file.substring(0);
	}
	file = join(file, '');
	if (file.indexOf('.') === -1 && !file.endsWith(slash)) {
		file += slash;
	}
	return file;
};

console.log('/user'.fullname().fullname().fullname());
console.log('/user.json'.fullname().fullname().fullname());
console.log('./user.json'.fullname(__dirname + '/../').fullname().fullname());
console.log('../user.json'.fullname().fullname().fullname());
