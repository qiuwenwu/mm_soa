<template>
	<!-- 媒体 -->
	<div class="item_media">
		<slot></slot>
	</div>
</template>

<script>
	import mixin from '/src/mixins/item.js'

	export default {
		mixins: [mixin],
		data() { return {};}
	}
</script>

<style>
</style>
