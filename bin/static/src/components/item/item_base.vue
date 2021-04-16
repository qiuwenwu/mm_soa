<template>
	<!-- 基础 -->
	<mm_item :url="obj[vm.url]">
		<div class="item_base">
			<div class="media" v-if="obj[vm.icon] || obj[vm.image]">
				<mm_icon class="icon" v-if="obj[vm.icon]" :src="obj[vm.icon]"></mm_icon>
				<mm_icon class="img" v-if="obj[vm.image]" :src="obj[vm.image]"></mm_icon>
			</div>
			<div class="doc">
				<div class="title" v-html="obj[vm.title]"></div>
				<div class="content" v-html="obj[vm.content]" v-if="obj[vm.content]"></div>
			</div>
			<slot></slot>
		</div>
	</mm_item>
</template>

<script>
	import mixin from '/src/mixins/item.js'

	export default {
		mixins: [mixin],
		data() {
			return {};
		}
	}
</script>

<style>
</style>
