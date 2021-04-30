define(function() {
	"use strict";
	return {
		model: {
			event: 'change',
			prop: 'obj'
		},
		props: {
			css: {
				type: String,
				default: ""
			},
			icon_key:{
				type: String,
				default: "image"
			},
			src_default: {
				type: String,
				default: "/img/default.png"
			},
			// 回调函数
			func: {
				type: Function,
				default: null
			},
			// 主题
			theme: {
				type: String,
				default: "primary"
			},
			// 显示方式
			display: {
				type: String,
				default: "1"
			},
			// 显示隐藏
			show: {
				type: Boolean,
				default: false
			},
			// 加载进度, 小于100表示加载中，大于100表示加载完成
			loading: {
				type: Number,
				default: 0
			},
			// 当前索引
			index: {
				type: Number,
				default: 0
			},
			// 列数
			col: {
				type: Number,
				default: 4
			},
			// 对象
			obj: {
				type: Object,
				default: function() {
					return {
						url: ""
					};
				}
			},
			// 视图模型
			viewmodel: {
				type: Object,
				default: function() {
					return {};
				}
			},
			// 当前页
			page: {
				type: Number,
				default: 1
			},
			// 大小
			size: {
				type: Number,
				default: 10
			},
			// 总计
			count: {
				type: Number,
				default: 0
			},
			// 主键
			field: {
				type: String,
				default: "id"
			},
			// 活跃项
			active: {
				type: String,
				default: ""
			},
			// 选中项
			selected: {
				type: Array,
				default: function _default() {
					return [];
				}
			},
			// 允许访问的用户组
			user_group: {
				type: Array,
				default: function _default() {
					return [];
				}
			},
			// 允许访问的管理组
			user_admin: {
				type: Array,
				default: function _default() {
					return [];
				}
			},
			// 允许访问的用户级别需多少以上
			vip: {
				type: Number,
				default: 0
			},
			// 允许访问的管理级别需多少以上
			gm: {
				type: Number,
				default: 0
			},
			// 允许访问的角色
			roles: {
				type: Array,
				default: function _default() {
					return [];
				}
			},
			// 身份验证
			oauth: {
				type: Boolean,
				default: false
			}
		},
		data: function data() {
			return {
				// 显示方式
				dy: this.display,
				// 加载中
				load: this.loading,
				// 大小
				se: this.size,
				// 数量
				nm: this.num,
				// 选中
				sd: this.selected,
				// 显示隐藏
				sw: this.show,
				// 视图模型
				vm: Object.assign({
					// 当前ID
					id: 'id',
					// 上级ID
					fid: 'fid',
					// 用户id
					user_id: 'user_id',
					// 图片
					img: 'img',
					// 图片集合
					imgs: 'imgs',
					// 图标
					icon: 'icon',
					// 标题
					title: 'title',
					// 描述
					description: 'description',
					// 关键词
					keywords: 'keywords',
					// 图片
					image: 'image',
					// 头像
					avatar:'avatar',
					// 等级
					level: 'level',
					// 状态
					state: 'state',
					// 内容
					content: 'content',
					// 时间
					time: 'time',
					// 日期
					date: 'date',
					// 类型
					type: 'type',
					// 链接
					url: 'url',
					// 方式
					mode: 'mode',
					// 来源
					source: 'source',
					// 来源地址
					source_url: 'source_url',
					// 分数
					score: 'score',
					// 标签
					label: 'label',
					// 名称
					name: 'name',
					// 值
					value: 'value',
					// 提示
					tip: 'tip',
					// 热度
					hot: 'hot',
					// 电话号码
					phone: 'phone',
					// 原价
					price_ago: 'price_ago',
					// 价格
					price: 'price',
					// 播放
					play: 'play',
					// 总价
					total: 'total',
					// 运费
					freight: 'freight',
					// 商家
					business: 'business',
					// 评论
					num_comment: 'num_comment',
					// 点赞数
					num_praise: 'num_praise',
					// 访问数
					num_see: 'num_see',
					// 消息数量
					num_message:'num_message',
					// 总量
					count: 'count',
					// 数量
					num: 'num',
					// 作者
					author: 'author',
					// 地址
					address: 'address',
					// 收藏量
					collect: 'collect',
					// 标签
					tag: 'tag',
					// 静音图标
					mute: 'mute',
					// 二维码图标
					qrcode: 'qrcode',
					// 省略号图标
					ellipsis:"ellipsis",
				}, this.viewmodel)
			};
		},
		methods: {
			/**
			 * 回调函数
			 * @param {String} name 函数名
			 * @param {String} method 方法
			 * @param {Object} param1
			 * @param {Object} param2
			 * @param {Object} param3
			 */
			run: function run(fun, method, param2, param3) {
				if (this.func) {
					return this.func(method, param2, param3);
				}

				return null;
			},
			// 添加
			/// obj: 添加的对象
			add: function add(obj) {
				this.run('add', obj);
			},
			// 删除
			/// query: 查询条件
			del: function del(query) {
				this.run('del', query);
			},
			// 修改
			/// query: 查询条件
			/// obj: 修改的对象
			set: function set(query, obj) {
				this.run('set', query, obj);
			},
			// 查询
			/// query: 查询条件
			get: function get(query) {
				this.run('get', query);
			},
			// 上下翻页
			/// n: 加减数
			go: function go(n) {
				this.run('go', n);
			},
			// 上下翻页
			/// page: 加减数
			goTo: function goTo(page) {
				this.run('goTo', page);
			}
		}
	};
});
