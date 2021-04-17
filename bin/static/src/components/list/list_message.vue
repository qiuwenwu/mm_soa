<template>
	<div class="list_message" :class="cols">
		<item_message v-for="(o, i) in list" :key="i" :viewmodel="vm" :obj="o"
			:class="css + (select === i ? ' active' : '')" @click.native="selected(i, o)"><slot></slot></item_message>
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
						message_id: 1,
						title: "标题",
						content: "内容",
						image: "/img/default.png",
					}]
				}
			}
		}
	}
</script>

<style>
</style>
