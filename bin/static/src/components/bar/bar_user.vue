<template>
	<a class="bar_user" :href="obj.url">
		<div class="media">
			<div class="figure">
				<img :src="obj.image">
			</div>
		</div>
		<div class="doc">
			<div class="name"><span>{{obj.name}}</span></div>
			<span class="chevron"></span>
			<span class="qrcode"></span>
			<div class="user_id"><span>{{obj.user_id}}</span></div>
		</div>
	</a>
</template>

<script>
	import mixin from '/src/mixins/component.js'
	export default {
		mixins: [mixin],
		props: {
			obj: {
				type: Object,
				default: function() {
					return {
						image: "/img/default.png",
						name: "Tao",
						user_id: "123456",
						url:"#",
					}
				}
			}
		},
		data() {
			return {};
		},
	}
</script>

<style>
</style>
