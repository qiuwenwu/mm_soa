<template>
	<!-- 标题栏 -->
	<a :href="obj.url" class="bar_title">
		<div class="title"><span>{{obj.title}}</span></div>
		<div class="desc"><span>{{obj.desc}}</span></div>
	</a>

</template>

<script>
	import mixin from '/src/mixins/component.js'
	export default {
		mixins: [mixin],
		props: {
			obj: {
				type: Object,
				default () {
					return {
						title: "标题",
						desc:"描述",
						url:"#"
					}
				}
			},
		},
		data() {
			return {};
		},
		methods:{
		}
	}
</script>

<style>
</style>
