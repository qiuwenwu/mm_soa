const xmlParser = require("mm_xml");
const session = require('mm_session');
const compress = require('koa-compress');
const koaBody = require('koa-body');
const compose = require('koa-compose');
const send = require('koa-send');

/**
 * 应用
 * @param {Object} server 服务
 */
module.exports = function(server) {
	var web = server.config.web;
	
	/**
	 * 发送文件
	 */
	server.use(async(ctx, next) => {
		ctx.send = async function(src){
			await send(ctx, src);
		}
		await next();
	});
	
	// 设置session 保存时长2小时
	server.use(session({
		maxAge: 7200
	}));

	// 使用压缩
	if (web.compress) {
		server.use(
			compress({
				filter: function(content_type) {
					// 只有在请求的content-type中有gzip类型，我们才会考虑压缩，因为zlib是压缩成gzip类型的
					return /text/i.test(content_type);
				},
				// 阀值，当数据超过1kb的时候，可以压缩
				threshold: 1024,
				// zlib是node的压缩模块
				flush: require('zlib').Z_SYNC_FLUSH
			})
		);
	}

	// 解析 text/xml
	server.use(xmlParser());

	// 解析 application/json、application/x-www-form-urlencoded、text/plain
	// 接收主体
	server.use(koaBody({
		multipart: true,
		formidable: {
			// 设置上传文件大小最大限制，默认20M
			maxFileSize: 2000 * 1024 * 1024
		}
	}));

	return server;
};
