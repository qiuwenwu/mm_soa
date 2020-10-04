<template>
	<div class="mm_drag" draggable="true" @dragstart="dragstart" @dragover="dragover" @dragend="dragend">
		<slot></slot>
	</div>
</template>

<script>
	export default {
		data() {
			return {}
		},
		methods: {
			/**
			 * 推拽开始
			 * @param {Object} e
			 */
			dragstart(e) {
				console.log('拖拽开始', e);
			},
			/**
			 * 拖拽结束
			 * @param {Object} e
			 */
			dragend(e) {
				console.log('拖拽结束', e);
			},
			/**
			 * 拖拽经过
			 * @param {Object} e
			 */
			dragover(e) {
				console.log('拖拽经过', e);
			}
		}
	}
</script>

<style>
</style>
