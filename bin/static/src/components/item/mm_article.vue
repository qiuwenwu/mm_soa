<template>
	<!-- 文章 -->
	<mm_item :url="obj[vm.url]">
		<div class="mm_article">
			<div class="media" v-if="obj[vm.image] || obj[vm.icon]">
				<mm_icon :src="obj[vm.image] || obj[vm.icon]" :desc="obj[vm.tip]"></mm_icon>
			</div>
			<div class="doc">
				<div class="title" v-if="obj[vm.title]">
					<span class="h5">{{ obj[vm.title] }}</span>
					<span class="tag" v-if="obj[vm.tag]"></span>
				</div>
				<div class="content">
					<div class="desc">{{ obj[vm.description] }}</div>
					<div class="time">{{ obj[vm.time] }}</div>
					<div class="collect" v-if="obj[vm.collect] && show" @click="run('collect', obj)">
						<span class="fa fa-heart" v-bind:class="{ 'font-default': obj[vm.collect] }"></span>
						<span>{{ obj[vm.collect] }}</span>
					</div>
				</div>
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
			},
			show: {
				type: Boolean,
				default: true
			},
			field: {
				type: String,
				default: "id"
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
	.mm_article .tag {
		display: inline-block;
		position: absolute;
		bottom: 0.15rem;
		right: 1rem;
		font-size: 0.625rem;
		border: 1px solid #ff5a6a;
		padding: 0.1rem 0.25rem 0 0.25rem;
		border-radius: 0.25rem;
		color: #ff5a6a;
	}

	.mm_article .mm_side {
		float: right;
	}

	.mm_article .mm_main {
		width: calc(100% - 6.75rem);
		height: 6.25rem;
		padding-top: 0.625rem;
		padding-right: 1.5rem;
		border: none;
	}

	.mm_article .div {
		max-height: 3rem;
		line-height: 1.5rem;
		overflow-y: hidden;
	}

	.mm_article .mm_icon {
		width: 5rem;
		height: 5rem;
		border-radius: 0.25rem;
	}

	.mm_article .mm_item {
		background: #fff;
		margin-left: 2rem;
		margin-right: 2rem;
		border-radius: 0.25rem;
		margin-bottom: 1rem;
	}

	.mm_article .mm_desc {
		width: 100%;
		line-height: 1.5;
		position: absolute;
		bottom: 0.625rem;
		left: 0rem;
	}

	.mm_article .time {
		float: left;
		margin-right: 1.25rem;
	}
</style>
