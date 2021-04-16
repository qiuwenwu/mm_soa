<template>
	<!-- 轮播图 -->
	<div class="swiper_card swiper-container" :id="id" indicatorDots autoplay>
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
	.swiper_card {
		height: 11.5rem;
	}

	.swiper_card .swiper-slide {
		width: calc(100% - 4rem);
	}

	.swiper_card .mm_icon {
		width: 100%;
		border-radius: 0.25rem;
		height: 10rem;
		margin: auto;
	}
</style>
