<template>
	<!-- 轮播图 -->
	<div class="swiper_menu swiper-container" :id="id">
		<div class="swiper-wrapper">
			<div class="swiper-slide" v-for="(o, idx) in list" :key="idx">
				<slot :item="o" :index="idx"></slot>
			</div>
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
				type: Boolean,
				default: false
			},
			id: {
				type: String,
				default: "swiper_menu"
			}
		},
		methods: {
			doing() {
				var swiper = new Swiper(this.id, {
					autoplay: this.autoplay,
					centeredSlides: true,
					slidesPerView: 1.2,
					spaceBetween: 30,
					pagination: {
						el: '.swiper-pagination',
						clickable: true
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
	
</style>
