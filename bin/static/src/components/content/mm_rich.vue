<template>
	<div class="rich">
		
	</div>
</template>

<script>
	import quill from "/js/vue-quill.js";
	import '/css/quill.core.css'
	import '/css/quill.snow.css'
	import '/css/quill.bubble.css'
	
	export default {
		components: {
			quillEditor
		},
		model: {
			event: "input",
			prop: "value"
		},
		props: {
			value: {
				type: String,
				default: ""
			}
		},
		mounted() {

		}
	}
</script>

<style>
</style>
