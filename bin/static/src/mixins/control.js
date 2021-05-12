export default {
	model: {
		prop: 'value',
		event: 'input'
	},
	props: {
		// 宽度
		width: {
			type: String,
			default: ''
		},
		height: {
			type: String,
			default: ''
		},
		// 类型
		type: {
			type: String,
			default: 'text'
		},
		// 选项
		options: {
			type: Array,
			default: function _default() {
				return [];
			}
		},
		// 赋值
		value: {
			type: [String, Number, Boolean]
		},
		// 回调函数
		func: {
			type: Function,
			default: function _default(fun, param1, param2) {
				return null;
			}
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
		// 标题
		title: {
			type: String,
			default: ""
		},
		// 图标
		icon: {
			type: String,
			default: ''
		},
		// 单位
		unit: {
			type: String,
			default: ''
		},
		// 描述
		desc: {
			type: String,
			default: ""
		},
		// 错误提示
		tip: {
			type: String,
			default: ""
		},
		// 最小值
		min: {
			type: Number,
			default: 0
		},
		// 最大值
		max: {
			type: Number,
			default: 0
		},
		// 最小长度
		min_length: {
			type: Number,
			default: 0
		},
		// 最大长度
		max_length: {
			type: Number,
			default: 65535
		},
		// 主键
		field: {
			type: String,
			default: "value"
		},
    disabled: {
			type: Boolean,
			default: false
		},
    num: {
      type: Number,
      default: 5
    }
	},
	data: function data() {
		return {
			// 显示方式
			dy: this.display,
			// 显示隐藏
			sw: this.show,
			// 加载中
			load: this.loading,
			// 列表
			oj: this.obj,
			// 数量
			nm: this.num,
			// 文本
			txt: this.text,
			// 值
			val: this.value,
			// 禁用
			dd: this.disabled
		};
	},
	methods: {
		/// 可更改其他属性，默认绑定回调函数
		/// fun: 函数名
		/// param1: 参数1
		/// param2: 参数2
		/// param3: 参数3
		run: function run(fun, param1, param2, param3) {
			if (this.func) {
				return this.func(param1, param2, param3);
			}

			return null;
		},
		// 删除
		/// query: 查询条件
		del: function del() {
			var query = {};
			query[this.field] = this.id;
			this.run('del', query);
		},
		// 修改
		/// query: 查询条件
		/// obj: 修改的对象
		set: function set(obj) {
			var query = {};
			query[this.field] = this.id;
			this.run('set', query, obj);
		}
	}
};
