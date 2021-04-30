<template>
	<div class="bar_count">
		<div class="more">
			<div class="btns_more" v-show="!active">
				<div class="btn_more" v-for="(o,i) in more" :key="i" @click="even_click(o)">
					<span>{{ o.title }}</span>
				</div>
			</div>
			<div class="lable_more" :class="{active:active}" @click="show_menu">
				<span>更多</span>
				<span class="icon_arrow"></span>
			</div>
		</div>
		<div class="btns_count">
			<div class="btn_count" v-for="(o,i) in list" :key="i" @click="even_click(o)">
				<span>{{ o.title }}</span>
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
				default: function() {
					return [{
							title: '再次拼单',
							command: 'buy_again'
						},
						{
							title: '查看物流',
							command: 'check_express'
						},
						{
							title: '确认收货',
							command: 'comfirm_receive'
						},
					]
				}
			},
			more: {
				type: Array,
				default: function() {
					return [{
							title: '延长收货',
							command: 'delay_receive'
						},
						{
							title: '申请退货',
							command: 'refound'
						},
					]
				}
			}
		},
		data() {
			return {
				active: "false",
			}
		},
		methods: {
			show_menu() {
				this.active = !this.active
			},
			even_click(o) {
				if (this.func) {
					this.func(o);
				}
			}
		}
	}
</script>

<style>

</style>
