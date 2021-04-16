<template>
	<div class="list_message">
		<div class="item" :class="css" v-for="(o, k) in list" :key="k">
			<item_message :viewmodel="vm" :obj="o"></item_message>
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
