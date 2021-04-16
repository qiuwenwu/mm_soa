<template>
	<div class="list_media">
		<div class="item" :class="css" v-for="(o, k) in list" :key="k">
			<item_media :viewmodel="vm" :obj="o"></item_media>
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
						media_id: 1,
						title: "测试1",
						image: "/img/default.png",
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
