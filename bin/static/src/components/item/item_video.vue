<template>
	<!-- 文章 -->
	<mm_item :url="obj[vm.url]">
		<div class="item_video" :class="css">
			<div class="media">
				<mm_icon :src="obj[vm.image]" :desc="obj[vm.tip]"></mm_icon>
			</div>
			<div class="doc">
				<div class="title" v-html="obj[vm.title]"></div>
				<div class="content" v-html="obj[vm.description]" v-if="obj[vm.description]"></div>
			</div>
		</div>
	</mm_item>
</template>

<script>
	import mixin from '/src/mixins/item.js'

	export default {
		mixins: [mixin],
		props: {
			uid: {
				type: Number,
				default: 0
			}
		},
		methods: {
			click_fun(o) {
				var u = obj[this.vm.url];
				if (this.func) {
					if (!this.func(o)) {
						return;
					}
				}
				if (u) {
					this.$nav(u);
				}
			},
			has_collect(arr) {
				if (arr) {
					if (this.uid && arr) {
						return arr.has(this.field, this.uid);
					}
				}
				return false;
			}
		}
	}
</script>

<style>
	.item_video .mm_main {
		padding: 0.625rem 0;
	}

	.item_video .mm_side {
		width: 100%;
		padding: 0;
	}

	.item_video .mm_main {
		width: calc(100% - 0.875rem);
		overflow: hidden;
		border: none;
	}

	.item_video .div {
		max-height: 3rem;
		line-height: 1.5rem;
		overflow: hidden;
		width: calc(100% - 4rem);
		text-overflow: ellipsis;
	}

	.item_video .mm_icon {
		width: 100%;
		height: 10rem;
	}

	.item_video .mm_item {
		background: #fff;
		margin-left: 2rem;
		margin-right: 2rem;
		border-radius: 0.25rem;
		margin-bottom: 1rem;
		overflow: hidden;
	}

	.item_video .mm_desc {
		line-height: 1.5;
	}

	.item_video .collect {
		position: absolute;
		right: 0.875rem;
		bottom: 0.625rem;
		text-align: right;
	}
</style>
