<template>
	<!-- 操作栏 -->
	<div class="bar_action">
		<div id="btn_open_modal" @click="open_modal"><slot>点击此处</slot></div>
		<div class="modal_action" :class="{ in: is_in ,out: is_out}" id="modal_action">
			<div class="modal_action_backdrop" @click="close_modal()"></div>
			<div class="modal_action_body">
				<div class="btn_action" v-for="(o,i) in list" :key="i" @click="event_click(o)">{{o.title}}</div>
				<div class="btn_close" @click="close_modal">取消</div>
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
							title: "拍照",
							command: "take_picture"
						},
						{
							title: "选取",
							command: "select"
						}
					]
				},
			},
		},
		data() {
			return {
				is_in: false,
				is_out: false
			};
		},
		methods: {
			open_modal() {
				this.is_in = true;
			},
			close_modal() {
				this.is_out = true;
				setTimeout(() => {
					this.is_in = false;
					this.is_out = false;
				}, 300)
			},
			event_click(o) {
				this.close_modal()
				if (this.func) {
					this.func(o);
				}
			}
		},
	};
</script>

<style scoped>
</style>
