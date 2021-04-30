<template>
	<div class="bar_tool">
		<div class="list">
			<div class="item" v-for="(o, i) in list" :key="i">
				<div v-if="o.sub.length" class="dropdown" :class="{show:index===i}">
					<div @click="show_dropdown(i)">
						<span class="icon"></span>
						<span class="title">{{ o.title }}</span>
					</div>
					<div class="box">
						<div class="dropdown_menu">
							<div class="btn_dropdown_item" v-for="(obj, idx) in o.sub" :key="idx" @click="event_click(obj)">
								{{ obj.title }}
							</div>
						</div>
					</div>
				</div>
				<!-- 无子数组 -->
				<div v-else @click="event_click(o)" class="btn_title">{{ o.title }}</div>
			</div>
		</div>
	</div>
</template>

<script>
	import mixin from '/src/mixins/component.js'
	export default {
		mixins:[mixin],
		props: {
			list: {
				type: Array,
				default () {
					return [{
							title: "百日誓师",
							command: "#",
							sub: [{
									title: "高考真题",
									command: "#",
								},
								{
									title: "模拟试题",
									command: "#",
								},
								{
									title: "最新讲座",
									command: "#",
								},
							],
						},
						{
							title: "四六级",
							command: "#",
							sub: [{
									title: "四六级真题",
									command: "#",
								},
								{
									title: "四六级真题",
									command: "#",
								},
							],
						},
						{
							title: "首页",
							command: "#",
							sub: [],
						},
					];
				},
			},
			vm: {
				type: Object,
				default () {
					return {
						title: "title",
						url: "url",
					};
				},
			},
		},
		data() {
			return {
				index: -1
			}
		},
		methods: {
			show_dropdown(i) {
				let index = this.index
				if (index === i) {
					this.index = -1
				} else {
					this.index = i
				}
			},
			event_click(o) {
				if (this.func) {
					this.func(o);
				}
			}
		}
	};
</script>

<style scoped>

</style>
