<template>
	<div class="list_question" :class="cols">
		<item_question v-for="(o, i) in list" :key="i" :viewmodel="vm" :obj="o"
			:class="css + (select === i ? ' active' : '')" @click.native="selected(i, o)"><slot></slot></item_question>
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
							description: "这是一个图片的描述，为了方便演示排版而写",
							url: "/"
						}
					]
				}
			}
		}
	}
</script>

<style>
</style>
