require('mm_expand');
// 修改程序运行目录
$.runPath = __dirname  + $.slash;
const Soa = require('../index.js');

var NODE_ENV = process.env.NODE_ENV || 'local';
var config = `./config/${NODE_ENV}.json`.loadJson();
var soa = new Soa(config);

async function startup(test){
	var app = await soa.init();
	
	// 临时缓存结果
	var ret_cache;
	
	// 添加请求前事件
	app.before('/te*', async (ctx, db) => {
		if (ret_cache) {
			body = ret_cache;
			ret_cache = null;
			return body;
		}
	});
	
	// 添加请求后事件
	app.after('/te*', async (ctx, db) => {
		if (db.ret) {
			ret_cache = db.ret;
		}
	});
	
	// 添加Get请求
	app.get('/te*', async (ctx, db) => {
		var qy = ctx.request.query;
		console.log(qy);
		return "te";
	});
	
	// 添加Post请求
	app.post('/te*', async (ctx, db) => {
		var qy = ctx.request.query;
		var by = ctx.request.body;
		console.log(qy, by);
		return "te";
	});
	
	var i = 0;
	
	// 添加Get请求
	app.get('/test', async (ctx, db) => {
		i++;
		ctx.body = "test" + i;
		// ctx.redirect("https://www.baidu.com");
	});
	
	app.get('/ws/tt', async (ctx, db) => {
		ctx.body = "子函数";
	});
	
	// app.after('/src/*', async (ctx, db) => {
	// 	console.log('进入了', ctx.response);
	// });
}

startup();