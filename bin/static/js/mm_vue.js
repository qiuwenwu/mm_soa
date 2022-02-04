function load_mm_vue(Vue) {
	"use strict";

	var getHost = function() {
		var tag = $.html.tag('script', 'src', '*require.js');

		if (tag) {
			var server = tag.dataset.server;
			if (server) {
				return server;
			}
		}
		return "/";
	};

	var mm = {
		/**
		 * @description 安装
		 * @param {Object} Vue 框架
		 * @param {Object} options 配置参数
		 */
		install: function install(Vue, options) {
			var host;

			if (options) {
				if (options.host) {
					host = options.host;
				} else {
					host = getHost();
				}
			} else {
				host = getHost();
			}

			/**
			 * @description 
			 */
			Vue.prototype.$ = $;

			/**
			 * 提示信息
			 * @param {String} message 提示信息
			 */
			Vue.prototype.$toast = function(message) {
					$.toast(message);
				},
				/**
				 * 获取名称
				 * @param {Array} list 用来取名的列表
				 * @param {String} arr_str id集合
				 * @param {String} key 键
				 * @param {String} name 名
				 * @param {String} span 分隔符
				 */
				Vue.prototype.$get_name = function(list, arr_str, key, name, span) {
					if (!name) {
						name = "name";
					}
					var value = "";
					if (list.length) {
						if (arr_str) {
							var item = list[0];
							if (typeof(arr_str) == 'string') {
								if (!span) {
									span = ',';
								}
								var arr = arr_str.split(span);

								if (typeof(item) === "object") {
									arr.map((id) => {
										for (var i = 0; i < list.length; i++) {
											var o = list[i];
											if (o[key] == id) {
												value += '|' + o[name];
											}
										}
									});
									value = value.replace('|', '');
								} else {
									value = list[arr_str];
								}
							} else {
								var id = arr_str;
								if (typeof(item) == 'object') {
									for (var i = 0; i < list.length; i++) {
										var o = list[i];
										if (o[key] == id) {
											value = o[name];
											break
										}
									}
								} else {
									value = list[arr_str];
								}
							}
						}
					}
					return value;
				};

			/**
			 * 路由跳转
			 * @param {String} url
			 */
			Vue.prototype.$redirect = function(url) {
				if (url) {
					$.route.redirect_url = url;
				} else {
					return $.route.redirect_url;
				}
			};

			/**
			 * @description 路由跳转
			 */
			Vue.prototype.$back = function() {
				this.$router.back();
			};

			/**
			 * 转页面大小
			 * @param {Object} arr
			 */
			Vue.prototype.$to_size = function(arr) {
				if (!arr || arr.length == 0) {
					arr = [10, 30, 50, 100, 200];
				}
				var list = [];
				for (var i = 0; i < arr.length; i++) {
					var n = arr[i];
					list.push({
						name: n + "条/页",
						value: n
					});
				}
				return list;
			};

			/**
			 * @description 取host地址
			 * @param {String} pathAndQuery 路径和参数 例如：'/app/test?name=123'
			 */
			Vue.prototype.$host = function(pathAndQuery) {
				return host + pathAndQuery;
			};

			/**
			 * @description 跳转连接
			 * @param {String} url 路径
			 */
			Vue.prototype.$url = function(url) {
				return window.location.protocol + "//" + window.location.host + url;
			};

			/**
			 * @description 复制
			 */
			Vue.prototype.$copy = function(text) {
				$.copyText(text);
				_this.$toast("复制成功");
			};

			/**
			 * @description 引入get请求函数
			 * @param {String} url 请求地址
			 * @param {Object} query 请求参数
			 * @param {Function} func 回调函数
			 */
			Vue.prototype.$get = function(url, query, func) {
				var token = $.db.get("token");
				var u = url.replace("~/", host);
				u = query ? $.toUrl(query, u) : u;
				var _this = this;
				$.http.get(u, function(json, status) {
					if (json.error) {
						var msg = json.error.message;
						if (msg.indexOf('未登录') !== -1 || msg.indexOf('非法') !== -1) {
							$.db.set("token", "", 120);
							_this.$router.push('/sign_in');
						} else if (msg.indexOf('没有') !== -1) {
							_this.$router.push('/not_power');
						}
					}
					if (func) {
						func(json, status);
					}
				}, {
					"x-auth-token": token
				});
			};

			/**
			 * @description 引入post请求
			 * @param {String} url 请求地址
			 * @param {Object} param 请求参数
			 * @param {Function} func 回调函数
			 * @param {String} type 发送的数据类型 xml类型、json类型、form类型
			 */
			Vue.prototype.$post = function(url, param, func, type) {
				var token = $.db.get("token");
				$.http.post(url.replace("~/", host), param, func, {
					"x-auth-token": token
				}, type);
			};

			/**
			 * @description 跳转到指定页面
			 * @param {String} url 跳转网址
			 * @param {Boolean} bl 是否返回到标签页
			 */
			Vue.prototype.$nav = function(url, bl) {
				if (url.indexOf("http") === 0) {
					location.href = url;
				} else {
					this.$router.push(url);
				}
			};

			/**
			 * @description 引入上传请求
			 * @param {String} url 上传地址
			 * @param {Object} form 表单数据
			 * @param {Object} fileObj 上传文件对象
			 * @param {Function} func 回调函数
			 */
			Vue.prototype.$upload = function(url, form, fileObj, func) {
				var token = $.db.get("token");
				var headers = {
					"x-auth-token": token
				};
				$.file.upload(url.replace("~/", host), form, fileObj, func, headers);
			};

			/**
			 * @description 被转换的数值
			 * @param {Object} num 引入浮点数
			 * @return {String} 浮点数数值
			 */
			Vue.prototype.$float = function(num) {
				var str = num.toFloor(8).toStr(8);
				for (var i = 0; i < 9; i++) {
					if (!str.endWith("0") && !str.endWith(".")) {
						break;
					}
					str = str.substring(0, str.length - 1);
				}
				return str;
			};

			/**
			 * @description 转双精度
			 * @param {Number} num 被转换的数值
			 * @return {String} 返回双精度字符串
			 */
			Vue.prototype.$double = function(num) {
				return num.toFloor(2).toStr(2);
			};

			/**
			 * @description 搁一法
			 * @param {Number} num 被转换的数值
			 * @param {Number} len 保留小数位
			 * @return {Number} 浮点数数值
			 */
			Vue.prototype.$floor = function(num, len) {
				return num.toFloor(len);
			};

			/**
			 * @description 科学计数转浮点数
			 * @param {String} num 被转换的数值
			 * @return {Number} 数值
			 */
			Vue.prototype.$num = function(num) {
				return new Number(num);
			};

			/**
			 * @description 引入截取字符串函数
			 * @param {String} str 被截取的字符串
			 * @param {String} start 起始字符串
			 * @param {String} end 结束字符串
			 * @return {String} 截取后的字符串
			 */
			Vue.prototype.$substr = function(str, start, end) {
				return str.substring(start, end);
			};

			/**
			 * @description 转字符串并截取长度
			 * @param {Object} value 被转换的数值
			 * @param {Number} num 保留长度
			 * @return {String} 截取后字符串
			 */
			Vue.prototype.$toStr = function(value, num) {
				return value.toStr(num);
			};

			/* 新加函数 */
			/**
			 * 签名地址
			 * @param {String} content 正文
			 * @return {Object} 返回签名后的对象
			 */
			Vue.prototype.$sign_address = function(content) {
				var date = new Date();
				var timestamp = date.stamp();
				var salt = (Math.random(0, 18) + '').md5().substring(0, 6);
				var signature = (timestamp + content + salt + "wr").md5();
				return {
					timestamp,
					content,
					signature,
					salt
				};
			};

			Vue.prototype.$sign = function(content) {
				var date = new Date();
				var timestamp = date.stamp();
				var {
					salt,
					user_id
				} = this.user;
				var signature = (timestamp + content + user_id + salt + "wr").md5();
				return {
					timestamp,
					content,
					salt,
					signature
				}
			};

			/**
			 * 改变地址
			 * @param {Object} address
			 * @return {String}
			 */
			Vue.prototype.$change_address = function(address) {
				if (address) {
					var len = address.length;
					return address.substring(0, 6) + "******" + address.substring(len - 4, len);
				}
				return address;
			};

			/**
			 * 转为键值
			 * @param {Object} arr 数组
			 * @param {String} key 键
			 * @param {String} name 名称
			 * @param {String} value 默认值
			 */
			Vue.prototype.$to_kv = function(arr, key, name, value) {
				if (value === undefined) {
					value = '';
				}
				var list = [];
				if (arr.length > 0) {
					if (key) {
						var n = name ? name : 'name';
						for (var i = 0; i < arr.length; i++) {
							var o = arr[i];
							list.push({
								name: o[n],
								value: o[key]
							});
						}
						if (arr[0].name !== '') {
							list.unshift({
								name: '',
								value: value
							});
						} else {
							list[0].value = value;
						}
					} else if (arr.length && typeof(arr[0]) === "object") {
						list = arr;
						if (arr[0].name !== '') {
							list.unshift({
								name: '',
								value: value
							});
						}
					} else {
						for (var i = 0; i < arr.length; i++) {
							var o = arr[i];
							list.push({
								name: o,
								value: i
							})
						}
						if (arr[0] !== '') {
							list.unshift({
								name: '',
								value: value
							});
						} else {
							list[0].value = value;
						}
					}
				}
				return list;
			};

			/**
			 * 转换时间
			 * @param {String} timeStr 时间字符串
			 * @param {String} format 转换格式
			 * @return {String} 返回转换后的结果
			 */
			Vue.prototype.$to_time = function(timeStr, format) {
				var time = timeStr.toTime();
				if (format) {
					return time.toStr(format);
				} else {
					var date = time.toStr("yyyy-MM-dd");
					var now = new Date();
					if (date == now.toStr("yyyy-MM-dd")) {
						return time.toStr("hh:mm")
					} else if (date == now.addDays(-1).toStr("yyyy-MM-dd")) {
						return "昨天" + time.toStr("hh:mm")
					} else if (time.toStr("yyyy") == now.toStr("yyyy")) {
						return time.toStr("MM-dd");
					} else {
						return date;
					}
				}
			};

			/**
			 * @description 过滤数组
			 * @param {Array} arr 被过滤的数组
			 * @param {String} key 判断的键
			 * @param {Object} value 判断的值
			 * @return {Array} 返回过滤后的数组
			 */
			Vue.prototype.$filter = function(arr, key, value) {
				var ar = [];
				for (var i = 0; i < arr.length; i++) {
					var o = arr[i];
					if (o[key] === value) {
						ar.push(o);
					}
				}
				return ar;
			};

			/**
			 *  改变对象属性时间
			 * @param {Object} o 被改变的对象
			 */
			Vue.prototype.$changeTime = function(o) {
				for (var k in o) {
					if (k.indexOf('time') !== -1) {
						if (typeof(k) == 'string') {
							var val = o[k];
							if (val || val.indexOf('T') !== -1) {
								var v = new Date(o[k]);
								o[k] = v.toStr('yyyy-MM-dd hh:mm:ss');
							} else if (/\d+/.test(val)) {
								if (o[k].length == 10) {
									var v = new Date(o[k] * 1000);
									o[k] = v.toStr('yyyy-MM-dd hh:mm:ss');
								} else if (o[k].length == 13) {
									var v = new Date(o[k] * 1000);
									o[k] = v.toStr('yyyy-MM-dd hh:mm:ss');
								}
							} else if (typeof(k) == 'number') {
								var v = new Date(o[k]);
								o[k] = v.toStr('yyyy-MM-dd hh:mm:ss');
							}
						}
					}
				}
			};

			/**
			 * 转为大写
			 * @param {String} word 单词
			 */
			Vue.prototype.$to_up = function(word) {
				return word.toUpperCase()
			};

			/**
			 * 显示小数位
			 * @param {Number} num 数值
			 * @param {Number} len 小数位
			 */
			Vue.prototype.$to_fixed = function(num, len = 4) {
				if (typeof(num) === 'number') {
					return num.toFixed(len);
				} else if (num) {
					var n = Number(num);
					return n.toFixed(len);
				} else {
					num = 0;
					return num.toFixed(len);
				}
			};

			/**
			 * @description 转url字符串
			 * @param {Object} obj 被转换的对象
			 * @param {String} url 请求地址
			 * @return {String} url参数格式字符串
			 */
			Vue.prototype.$toUrl = function(obj, url) {
				var queryStr = "";
				for (var key in obj) {
					var value = obj[key];
					if (typeof(value) === 'number') {
						if (value > 0) {
							queryStr += "&" + key + "=" + obj[key];
						}
					} else if (value) {
						queryStr += "&" + key + "=" + encodeURI(value);
					}
				}
				if (url) {
					if (url.endWith('?') || url.endWith('&')) {
						return url + queryStr.replace('&', '');
					} else if (url.indexOf('?') === -1) {
						return url + queryStr.replace('&', '?');
					} else {
						return url + queryStr;
					}
				} else {
					return queryStr.replace('&', '');
				}
			};

			/**
			 * 转换名称
			 * @param {Array} list 数组
			 */
			Vue.prototype.$to_name = function(list, value, value_key = 'name', key = 'value') {
				var ret = "";
				for (var i = 0; i < list.length; i++) {
					var o = list[i];
					if (o[key] === value) {
						ret = o[value_key];
						break
					}
				}
				return ret;
			};

			/**
			 * 补全请求url
			 * @param {String} url 现地址
			 * @return {String} 新地址
			 */
			Vue.prototype.$fullUrl = function(url) {
				var url_new = "";
				if (url) {
					if (url.indexOf("~/") === 0) {
						url_new = url.replace('~/', host);
					} else if (url.indexOf("/") === 0) {
						url_new = url.replace('/', host);
					} else {
						url_new = url;
					}
				}
				return url_new;
			};

			/**
			 * 补全请求url
			 * @param {String} url 现地址
			 * @return {String} 新地址
			 */
			Vue.prototype.$fullImgUrl = function(url) {
				if (url) {
					return this.$fullUrl(url);
				} else {
					return "/static/img/logo.png"
				}
			};

			/**
			 * 设置文件
			 * @param {Object} o 被设置的对象
			 * @param {Object} e 事件
			 * @param {String} key 设置的值 
			 */
			Vue.prototype.$setFile = function(o, e, key = "value", set = true) {
				var file = e;
				var _this = this;
				var form = {
					name: file.name,
					filename: file.name,
					file
				};
				this.$upload("~/upload/file", form, function(json) {
					if (json.result && json.result.obj) {
						o[key] = json.result.obj.url;
						if (set) {
							_this.set(o);
						}
					}
				});
			};

			/**
			 * 设置图片
			 * @param {Object} o 被设置的对象
			 * @param {Object} e 事件
			 * @param {String} key 设置的值 
			 */
			Vue.prototype.$setImg = function(o, e, key = "value", set = true) {
				var file = e;
				var _this = this;
				var form = {
					name: file.name,
					filename: file.name,
					file
				};
				this.$upload("~/upload/image", form, function(json) {
					if (json.result && json.result.obj) {
						o[key] = json.result.obj.url;
						if (set) {
							_this.set(o);
						}
					}
				});
			};

			/* /新加函数 */

			/* === 注册过滤器, 备注：过滤器在$-app中无法使用 === */
			/**
			 * @description 转双精度小数字符串
			 * @param {Object} value 被转换的数值
			 * @return {String} 返回双精度数字符串
			 */
			Vue.filter("double", function(value) {
				return parseFloat(value).toFloor(2).toStr(2);
			});

			/**
			 * @description 转浮点数字符串
			 * @param {Object} value 被转换的数值
			 * @return {String} 返回浮点数字符串
			 */
			Vue.filter("float", function(value) {
				return parseFloat(value).toFloor(8).toStr(8);
			});
		}
	};

	/**
	 * @description 全局混入
	 */
	Vue.mixin({
		methods: {
			/**
			 * @description 读取语言库
			 * @param {String} name 名称
			 * @return {String} 返回语言值
			 */
			$lang: function $lang(name) {
				var lang = this.$store.state.web.lang;
				var title = "";
				for (var i = 0; i < lang.length; i++) {
					if (name = o.name) {
						title = o.title;
						break;
					};
				}
				return title;
			},

			/**
			 * @description 数字货币转法币
			 * @param {Object} coin 货币数值
			 * @return {Number} 法币数值
			 */
			$money: function $money(coin) {
				return parseFloat(coin * this.$store.state.web.rate).toFloor(2);
			},

			/**
			 * @description 法币转数字货币
			 * @param {Object} money 法币数值
			 * @return {Number} 货币数值
			 */
			$coin: function $coin(money) {
				return parseFloat(money / this.$store.state.web.rate).toFloor(8);
			},
			/**
			 * @description 获取用户信息
			 * @param {Function} func
			 */
			$get_user: function $get_user(func) {
				var _this = this;
				this.$get('~/api/user/state', null, function(json, status) {
					if (json.result) {
						_this.$sotre.commit('set_user', json.result);
					} else if (json.error) {
						// 非法访问或未登录
						$.db.set("token", "");
						// _this.$router.push('/signin')
					} else {
						_this.$toast('服务器连接失败！');
						return;
					}
					if (func) {
						func();
					}
				});
			}
		}
	});
	return mm;
}
if (window.define) {
	define(['Vue'], load_mm_vue);
} else {
	window.mm_vue = load_mm_vue(Vue);
}
