/**
 * @param {String} html 网页内容
 */
class Dom {
	/**
	 * 构造函数
	 * @param {Object} config 配置参数
	 */
	constructor(config) {
		this.config = {
			tags_text: ["i", "strong", "span", "small", "em", "sup", "sub"],
			tags_col: ["li", "dd", "td"],
			tags_hp: ["h1", "h2", "h3", "h4", "h5", "h6", "p", "button", "canvas", "video"],
			tags_left:  ["img", "link", "input", "br", "meta", "hr"],
			tags_no: ["img", "audio", "input", "meta", "col", "colgroup", "datalist", "ul", "ol", "dl", "dl", "table",
				"thead", "tbody", "tfoot", "tr", "select"
			],
			tags_only: ["img", "i", "strong", "span", "small", "em", "sup"]
		}
	}
}

/**
 * 转为JQ操作对象
 * @param {String} html 网页内容
 * @return {Object} JQ操作对象
 */
Dom.prototype.toJQ = function(html) {
	return $(html);
};

/**
 * 递归补充列表
 * @param {Object} node 节点
 * @return {Object} 返回整个json节点
 */
Dom.prototype.recursively = function(node) {
	// console.log(node, Object.keys(node));
	if (!node || Object.keys(node).length === 0) {
		return;
	}
	var tag = node.prop('tagName').toLowerCase();
	var dict = {
		tag
	};
	try {
		var attr = this.getAttrs(node);
		if (Object.keys(attr).length) {
			dict.attr = attr;
		}
	} catch {

	}
	if(tag === "script" || tag === "style" || tag === "title"){
		dict.text = node.text();
	}
	else {
		var sub = [];
		var child = node.contents();
		for (var i = 0; i < child.length; i++) {
			var o = child.eq(i);
			if (o.prop('tagName')) {
				var obj = this.recursively(o);
				if (obj) {
					sub.push(obj);
				}
			} else {
				var text = o.text().trim();
				if (text) {
					sub.push({
						tag: "span",
						attr: {
							class: "text"
						},
						text
					});
				}
			}
		}
		if (sub.length) {
			dict.sub = sub;
		}
	}
	
	return dict;
};

/**
 * 获取所有属性
 * @param {Object} node 节点
 * @return {Object} 返回对象所有属性键值
 */
Dom.prototype.getAttrs = function(node) {
	var dict = {};
	var html = node.prop("outerHTML");
	var tag = node.prop('tagName');
	var mh = (html + "").match(eval(`/<${tag}.*?\>/gi`));
	var mstr = mh[0];

	var text = mstr.substring(tag.length + 1).endTrim('>').endTrim('/');
	var arr = text.split('" ');
	for (var i = 0; i < arr.length; i++) {
		var str = arr[i];
		if (str) {
			var key = str.left('=', true).trim();
			var value = str.right('=').trim('"');
			dict[key] = value || key;
		}
	}
	return dict;
};

/**
 * html代码转为json对象
 * @param {String} html html字符串
 * @return {Object} JSON对象
 */
Dom.prototype.toJson = function(html) {
	var list = [];
	var node = this.toJQ(html);
	var list = this.recursively(node.eq(0));
	return list;
};


/**
 * json对象转为html
 * @param {Object} json JSON对象
 * @return {String} 返回html字符串
 * @return {Object}
 */
Dom.prototype.toHtml = function(json, tab = "\t") {
	var tag = json.tag;
	var attr_str = "";
	var attr = json.attr;
	if (attr) {
		for (var k in attr) {
			var value = attr[k];
			attr_str += " " + k + '="' + value + '"';
		}
	}
	if(this.config.tags_left.indexOf(tag) !== -1){
		return `<${tag}${attr_str} />`
	}
	else {
		var sub_str = "";
		var sub = json.sub;
		if (sub) {
			for (var i = 0; i < sub.length; i++) {
				var o = sub[i];
				sub_str += "\n" + tab + this.toHtml(o, tab + "\t")
			}
		}
		if(sub_str){
			sub_str += '\n' + tab.substring(1);
		}
		var text = "";
		if(json.text){
			text = json.text;
		}
		return `<${tag}${attr_str}>${sub_str}${text}</${tag}>`;
	}
};

/**
 * 导出
 */
module.exports = Dom;

// // /**
// //  * 使用jsdom将html跟jquery组装成dom
// //  * @param  {String}   html     需要处理的html
// //  * @param  {Function} callback 组装成功后将html页面的$对象返回
// //  * @return {[type]}            [description]
// //  */
// function makeDom(html, callback) {
//   jsdom.env({
//     html: html,
//     src: [jquery],
//     done: function (errors, window) {
//       var $ = window.$;
//       callback(errors, $);
// 	  // 释放window相关资源，否则将会占用很高的内存
//       window.close();
//     }
//   });
// }
