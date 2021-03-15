// 百度翻译API
// APPID
var appid = '20201209000642613';
// 密钥
var key = 'EFNYG2FPSuYHcNKrfH6V';

/**
 * 翻译
 * @param {String} word 需要翻译的单词
 * @param {String} from 来源语言
 * @param {String} to 翻译后的语言
 * @return {String} 返回翻译结果
 */
async function translate(word, from = "zh", to = "en") {
	var salt = (new Date).getTime();
	var sign = (appid + word + salt + key).md5();
	var http = new $.Http();
	
	var query = {
		q: word,
		appid,
		salt,
		from,
		to,
		sign
	};
	var queryStr = $.toUrl(query);
	var res = await http.get('http://api.fanyi.baidu.com/api/trans/vip/translate?' + queryStr);

	if (res.body) {
		var json = res.body.toJson();
		if (json) {
			if(json.error_code){
				return $.ret.error(Number(json.error_code), json.error_msg);
			}
			else {
				var arr = json.trans_result;
				if (arr.length) {
					return $.ret.body(arr[0]);
				}
			}
		}
	}
	return $.ret.error(10000, "翻译失败！");
}

$.translate = translate;

/**
 * 接口主函数
 * @param {Object} ctx HTTP上下文
 * @param {Object} db 数据管理器,如: { next: async function{}, ret: {} }
 * @return {Object} 执行结果
 */
async function main(ctx, db) {
	// 获取请求参数
	var req = ctx.request;
	var {
		word,
		from,
		to
	} = req.query;
	return await translate(word, from, to);
};

exports.main = main;
