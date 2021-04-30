<template>
	<div class="bar_menu">
		<div class="list">
			<a :href="o.url" class="item" v-for="(o, i) in list" :key="i">
					<div class="media">
						<mm_icon :src="o[vm.img]"></mm_icon>
					</div>
					<div class="title">
						{{ o[vm.title] }}
					</div>
			</a>
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
				default () {
					return [{
							title: "手机充值",
							img: "/img/default.png",
							url:"#"
						},
						{
							title: "生活",
							img: "/img/default.png",
							url:"#"
						},
						{
							title: "Q币充值",
							img: "/img/default.png",
							url:"#"
						},
						{
							title: "城市服务",
							img: "/img/default.png",
							url:"#"
						},
						{
							title: "腾讯公益",
							img: "/img/default.png",
							url:"#"
						},
					];
				},
			},
		},
		methods: {
		},
		components: {},
	};
</script>

<style scoped>

</style>
