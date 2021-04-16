<template>
	<!-- 轮播图 -->
	<div class="swiper_text swiper-container" autoplay circular vertical>
		<div class="swiper-wrapper">
			<div class="swiper-slide" v-for="(o, idx) in list" :key="idx">
				<slot :item="o" :index="idx">
					<router-link :to="o[vm.url]">
						{{ o[vm.title] }}
					</router-link>
				</slot>
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
					autoplay: this.autoplay,
					direction: 'vertical'
				});
			}
		},
		mounted() {
			setTimeout(this.doing, 1000)
		}
	}
</script>

<style>
	.swiper_text {
		line-height: 2.5rem;
		height: 2.5rem;
	}

	.swiper_text .mm_view {
		color: #666;
		padding: 0 1rem;
		font-size: 85%;
	}
</style>
