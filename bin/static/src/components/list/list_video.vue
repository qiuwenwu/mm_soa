<template>
	<div class="list_video" :class="cols">
		<item_video v-for="(o, i) in list" :key="i" :viewmodel="vm" :obj="o"
			:class="css + (select === i ? ' active' : '')" @click.native="selected(i, o)"><slot></slot></item_video>
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
						video_id: 1,
						title: "测试1",
						image: "/img/default.png",
						src: "/media/video.mp4",
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
