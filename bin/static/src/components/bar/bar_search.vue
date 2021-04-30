<template>
	<div class="bar_search">
		<div class="btn_search">
			<span class="icon_search" @click="even_click(obj_search)"></span>
			<input type="text" placeholder="搜索" :value="value" v-on:input="$emit('input', $event.target.value)">
		</div>
		<div class="cancle" @click="even_click(cancle)"><span>{{ cancle.title }}</span></div>
	</div>
</template>

<script>
	import mixin from '/src/mixins/component.js'
	export default {
		mixins: [mixin],
		model: {
			prop: 'value',
			event: 'input'
		},
		props: {
			value: {
				type: String,
				default () {
					return ""
				}
			},
			obj_search: {
				type: Object,
				default: function() {
					return {
						title: '搜索',
						command: 'search'
					}
				}
			},
			cancle: {
				type: Object,
				default: function() {
					return {

						title: '取消',
						command: 'cancle'
					}
				}
			},
		},
		data() {
			return {};
		},
		methods: {
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
