<template>
	<div class="mm_list">
		<div :class="'item ' + cs + (col ? ' col-' + col : '')" v-for="(o, i) in list" :key="i">
			<solt><mm_item :obj="o" :display="" :viewmodel="viewmodel"></mm_item></solt>
		</div>
	</div>
</template>

<script>
	export default {
		props: {
			cs: {
				type: String,
				default: ""
			},
			col: {
				type: String,
				default: ""
			},
			viewmodel: {
				type: String,
				default: function() {
					return {}
				}
			}
		}
	}
</script>

<style>
</style>
