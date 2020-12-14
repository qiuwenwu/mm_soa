var mixin_page = {
	data() {
		return {
			message: "hello world！",
			nav_top_show: false
		}
	},
	methods: {
		set_lang(lang) {
			$.http.get("/api/lang?type=" + lang, function(res) {
				window.location.href = window.location.href;
			})
		},
		set_color(color) {
			$.http.get("/api/theme?color=" + color, function(res) {
				window.location.href = window.location.href;
			})
		}
	}
};
