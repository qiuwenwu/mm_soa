<template>
	<div class="list_base" :class="cols">
		<item_base v-for="(o, i) in list" :key="i" :viewmodel="vm" :obj="o"
			:class="css + (select === i ? ' active' : '')" @click.native="selected(i, o)">
			<slot></slot>
		</item_base>
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
