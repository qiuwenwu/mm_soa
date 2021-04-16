<template>
	<div class="list_base">
		<div class="item" :class="css" v-for="(o, k) in list" :key="k">
			<item_base :viewmodel="vm" :obj="o"></item_base>
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
							title: "标题",
							description: "描述",
							content: "正文"
						},
						{
							title: "标题",
							description: "描述",
							content: "正文"
						},
						{
							title: "标题",
							description: "描述",
							content: "正文"
						},
						{
							title: "标题",
							description: "描述",
							content: "正文"
						}
					]
				}
			}
		}
	}
</script>

<style>
</style>
