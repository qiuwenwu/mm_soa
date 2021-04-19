<template>
	<!-- 常见问题 -->
	<mm_item :url="obj[vm.url]">
		<div class="item_question" :class="css">
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
		mixins: [mixin]
	}
</script>

<style>
	.item_question .mm_item {
		border-bottom: none;
		margin-bottom: 2rem;
	}

	.item_question .mm_view~.mm_view {
		margin-top: 0.5rem;
	}

	.item_question .div {
		color: #333;
	}

	.item_question .mm_desc {
		float: left;
		margin-top: 1rem;
	}
</style>
