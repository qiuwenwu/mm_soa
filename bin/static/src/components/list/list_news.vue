<template>
	<div class="list_news">
		<div class="item" :class="css" v-for="(o, k) in list" :key="k">
			<item_news :viewmodel="vm" :obj="o"></item_news>
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
						image_id: 1,
						title: "测试1",
						image: "/img/default.png",
						author: "作者",
						srouce: "来源",
						srouce_url: "http://mm.elins.cn",
						description: "这是一个图片的描述，为了方便演示排版而写",
						url: "/"
					}]
				}
			}
		}
	}
</script>

<style>
</style>
