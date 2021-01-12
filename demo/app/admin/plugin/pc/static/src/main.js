"use strict";

require({
	// 基础路径, 会将 ./ 替换成该路径
	baseUrl: '/admin/pc/src/',
	// 是否保留注释
	preserveLicenseComments: true,
	waitSeconds: 0,
	paths: {
		css: '/js/css.min',
		text: '/js/text.min',
		vue: '/js/requirejs-vue',

		// 生产版||调试版
		Vue: '/js/vue',
		vuex: '/js/vuex.min',
		VueRouter: '/js/vue-router.min',
		jquery: '/js/jquery.min',
		swiper: "/js/swiper.min",
		clipboard: '/js/clipboard.min',
		mm_sdk: '/js/mm_sdk',
		mm_vue: '/js/mm_vue',
		sortablejs: '/js/sortable.min',
		vuedraggable: '/js/vuedraggable.min',
		ui: '/js/mm_vue_ui',
		nav: '/api/sys_nav.js?scope=admin_pc',
		store: './store',
		router: './router',
		echarts: '/js/echarts',
		kindeditor: '/kindeditor/kindeditor-all-min',
		page: '/src/mixins/page.js'
	},
	shim: {
		clipboard: {
			deps: ['jquery']
		},
		kindeditor: {
			exports: 'Kindeditor',
			deps: ['jquery']
		},
		vuex: {
			deps: ['Vue']
		},
		VueRouter: {
			deps: ['Vue']
		},
		swiper: {
			deps: ['jquery']
		},
		mm_sdk: {
			deps: ['jquery']
		},
		mm_vue: {
			deps: ['mm_sdk']
		},
		// sortable: {
		// 	exports: 'sortable'
		// },
		// vuedraggable {
		// 	exports: 'vuedraggable',
		// 	deps: ['sortable']
		// }
	},
	config: {
		// vue加载配置
		'vue': {
			'css': 'inject',
			'templateVar': '__template__'
		}
	}
}, ['Vue', 'mm_sdk', 'mm_vue', 'store', 'router', 'ui', 'clipboard', 'vuedraggable', 'vue!/src/components/form/mm_rich.vue','vue!./App.vue'], function(Vue, mm_sdk, mm_vue, store, router,
	ui, clipboard, vuedraggable, mm_rich, app) {
	// 开启调试模式
	Vue.config.debug = true;
	// 使用UI组件
	Vue.config.devtools = true;
	
	Vue.component('mm_rich', mm_rich);
	Vue.component('draggable', vuedraggable);
	Vue.use(mm_vue);
	Vue.use(ui);

	/**
	 * @description 初始化整个Vue应用程序
	 * 由于组件预先注册的标记名而自动放置的组件头将在应用程序模板中找到
	 */
	var vue = new Vue({
		el: '#app',
		// 引用缓存管理器
		store: store,
		// 引用路由管理器
		router: router,
		// 渲染页面
		render: function render(h) {
			return h(app);
		}
	});
});
