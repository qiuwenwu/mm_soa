<template>
	<div id="app">
		<mm_page v-if="is_sign">
			<router-view></router-view>
		</mm_page>
		<mm_page id="page_root">
			<mm_side :class="{hide: hide, fold: fold}" :func="set_width">
				<mm_warp>
					<div class="mm_bar_logo"><img src="/img/logo.png"><span>超级美眉</span></div>
					<nav_side></nav_side>
				</mm_warp>
			</mm_side>
			<header :style="'width: calc(100% -' + width + 'px)'">
				<mm_warp>
					<mm_container>
						<mm_row>
							<mm_col class="col-6">
								<div class="mm_nav_fast">
									<button class="btn_link btn_primary hide_phone" @click="fold = !fold"><i class="fa-bars"></i></button>
									<button class="btn_link btn_primary show_phone" @click="hide = !hide"><i class="fa-bars"></i></button>
								</div>
							</mm_col>
							<mm_col class="col-6">
								<nav_top></nav_top>
							</mm_col>
							<!-- <mm_col class="col-12">
								<nav_quick></nav_quick>
							</mm_col> -->
						</mm_row>
					</mm_container>
				</mm_warp>
				<mm_warp>
					<mm_container>
						<mm_row>
							<mm_col width="100">
								<!-- 页签组件 -->
								<div class="mm_tab_head" id="tabs">
									<div v-for="(o, idx) in nav_cache" :key="idx" :class="{ 'active': o.url === url_now }">
										<i class="fa-times-circle" v-if="o.name !== 'index'" @click="del_tab(o)"></i>
										<router-link :to="o.url">
											{{ o.title }}
										</router-link>
									</div>
								</div>
							</mm_col>
						</mm_row>
					</mm_container>
				</mm_warp>
			</header>

			<router-view id="main" :style="'width: calc(100% -' + width + 'px)'"></router-view>
			<!-- <mm_main>
				<mm_warp>
					<mm_container>
						<mm_row>
							<mm_col class="col-6">
								<div class="mm_card"></div>
							</mm_col>
						</mm_row>
					</mm_container>
				</mm_warp>
			</mm_main> -->
			<footer :style="'width: calc(100% -' + width + 'px)'">
				<div class="mm_warp">
					<div class="mm_container">
						<div class="mm_row">
							<div class="mm_col">
								页脚
							</div>
						</div>
					</div>
				</div>
			</footer>
			<div class="mm_modal hide">
				<div class="popup"></div>
				<div class="mask"></div>
			</div>
		</mm_page>
	</div>
</template>

<script>
	import Vue from 'Vue';
	// import mm_side from './components/mm_side.vue'
	import nav_top from './components/nav_top.vue'
	import nav_side from './components/nav_side.vue'
	import nav_quick from './components/nav_quick.vue'
	import nav_float from './components/nav_float.vue'

	export default {
		components: {
			// mm_side,
			nav_top,
			nav_side,
			nav_quick,
			nav_float
		},
		data: function() {
			return {
				nav_cache: this.$store.state.web.nav_cache,
				nav: this.$store.state.web.nav,
				web: this.$store.state.web,
				user: this.$store.state.user,
				hide: true,
				fold: false,
				width: 0,
				msg_count: 19,
				option: "",
				options: [{
						name: "基本资料",
						value: "/info"
					},
					{
						name: "修改密码",
						value: "/password"
					},
					{
						name: "退出",
						value: "/logout"
					}
				]
			}
		},
		methods: {
			select_item(o) {
				if (o.url === this.url_now) {
					return true;
				} else {
					return o.sub.has({
						url: this.url_now
					})
				}
			},
			set_width(width) {
				this.width = width;
			},
			del_tab(o) {
				this.$store.commit('del_nav_cache', o);
				var tabs = this.nav_cache;
				var keys = Object.keys(tabs);
				if (keys.length > 0) {
					this.$router.push(tabs[keys[keys.length - 1]].url);
				} else {
					this.$router.push('/');
				}
			}
		},
		computed: {
			url_now() {
				var query = this.$route.query
				if (query.length > 0) {
					return this.$route.path + "?" + $.toUrl(query);
				}
				return this.$route.path;
			},
			is_sign() {
				var p = this.$route.path;
				if (p.indexOf('/sign') !== -1 || p.indexOf('/forgot') !== -1) {
					return true;
				} else {
					return false;
				};
			}
		},
		created() {
			if (window.history && window.history.pushState) {
				history.pushState(null, null, document.URL);
			}
		},
		destroyed() {
			window.removeEventListener('popstate', this.goBack, flase)
		}
	};
</script>

<style>

</style>
