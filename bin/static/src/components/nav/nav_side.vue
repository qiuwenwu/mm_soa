<template>
	<!-- 侧边导航 -->
	<div class="nav_side">
		<div id="btn_open_nav" @click="open_nav"><slot><span>点击此处</span></slot></div>

		<!-- 模态 -->
		<div class="modal_nav" :class="{ in: is_in ,out: is_out}">
			<div class="modal_backdrop" @click="close_nav"></div>
			<div class="modal_body">
				<!-- 一级 -->
				<div class="nav_item" v-for="(o,i) in list" :key="i">
					<a class="btn_nav" :href="o.url" @click="open_sub(o,i)">
						<i :class="o.icon" v-if="o.icon"></i>
						<span>{{o.title}}</span>
						<i class="arrow_nav" :class="{rotate:key_rotate === i,rotate_back:key_rotate !== i}" v-if="has_sub(o)"></i>
					</a>
					<!-- 二级 -->
					<div class="sub_list" v-if="has_sub(o)" :style="get_height(o,i)">
						<div class="sub_item" v-for="(obj,idx) in o.sub">
							<a @click="close_nav" class="btn_nav" :href="obj.url">
								<i :class="obj.icon" v-if="obj.icon"></i>
								<span>{{obj.title}}</span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import mixin from '/src/mixins/component.js'
	export default {
		mixins: [mixin],
		props: {
			list: {
				type: Array,
				default () {
					return [{
							title: "item1",
							url: "#",
							icon: "fa-map-marker"
						},
						{
							title: "item2",
							url: "#",
							icon: "fa-th-large",
							sub: [{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								}
							]
						},
						{
							title: "item3",
							url: "#",
							icon: "fa-file-text-o",
							sub: [{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								},
								{
									title: "sub_item1",
									url: "#",
								}
							]
						},
						{
							title: "item4",
							url: "#",
							icon: "fa-cog",
						},
						{
							title: "跳转自动关闭导航",
							url: "#",
							icon: "fa-close"
						},
					]
				},
			},
		},
		data() {
			return {
				is_in: false,
				is_out: false,
				key_drop: -1,
				key_rotate: -1
			};
		},
		methods: {
			// 打开导航
			open_nav() {
				this.is_in = true;
			},
			// 关闭导航
			close_nav() {
				this.is_out = true;
				setTimeout(() => {
					this.is_in = false;
					this.is_out = false;
				}, 300)
			},
			// 打开折叠
			open_sub(o, i) {
				var key_drop = this.key_drop
				var key_rotate = this.key_rotate
				if (o.sub && o.sub.length) {
					if (key_drop !== i) {
						key_drop = i
						key_rotate = i
					} else {
						key_drop = -1
						key_rotate = -1
					}
				} else {
					// 跳转
					this.$nav(o.url)
					this.close_nav()
				}
				this.key_drop = key_drop
				this.key_rotate = key_rotate
			},
			// 获取折叠高度
			get_height(o, i) {
				if (this.key_drop === i) {
					if (this.has_sub(o)) {
						var height = 2.75 * o.sub.length;
						return 'height:' + height + 'rem;'
					}
				}

			},
			// 判断是否有子导航
			has_sub(o) {
				return o.sub && o.sub.length
			},
		},
	};
</script>

<style scoped>
</style>
