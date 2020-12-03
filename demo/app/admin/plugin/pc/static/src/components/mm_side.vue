<template>
	<div class="mm_side">
		<slot></slot>
		<div class="mask"></div>
	</div>
</template>

<script>
	export default {
		props: {
			func: Function,
			default: function(e) {
				console.log(e);
			}
		}
	}
</script>

<style>
</style>
