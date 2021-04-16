<template>
	<!-- 轮播图 -->
	<div class="swiper_image swiper-container" indicator-dots autoplay circular :interval="5000">
		<div class="swiper-slide" v-for="(o, idx) in list" :key="idx">
			<slot :item="o" :index="idx">
				<item_image :obj="o"></item_image>
			</slot>
		</div>
	</div>
</template>

<script>
	import mixin from '/src/mixins/component.js';
	import Swiper from "swiper";

	export default {
		mixins: [
			mixin
		],
		props: {
			autoplay: {
				type: "",
				default: true
			},
			id: {
				type: String,
				default: "swiper_card"
			}
		},
		methods: {
			doing() {
				var swiper = new Swiper(this.id, {
					pagination: {
						el: '.swiper-pagination',
						autoplay: this.autoplay
					}
				});
			}
		},
		mounted() {
			setTimeout(this.doing, 1000)
		}
	}
</script>

<style>
	.swiper_image {
		height: 8.75rem;
	}
</style>
