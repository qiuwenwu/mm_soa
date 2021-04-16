<template>
	<div class="list_article">
		<div class="item" :class="css" v-for="(o, k) in list" :key="k">
			<item_article :viewmodel="vm" :obj="o"></item_article>
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
							article_id: 1,
							title: "标题",
							description: "描述",
							content: "正文",
							create_time: "2020-04-01 11:11:11"
						},
						{
							article_id: 2,
							title: "标题",
							description: "描述",
							content: "正文",
							create_time: "2020-04-01 11:11:11"
						},
						{
							article_id: 3,
							title: "标题",
							description: "描述",
							content: "正文",
							create_time: "2020-04-01 11:11:11"
						},
						{
							article_id: 4,
							title: "标题",
							description: "描述",
							content: "正文",
							create_time: "2020-04-01 11:11:11"
						}
					]
				}
			}
		}
	}
</script>

<style>
</style>
