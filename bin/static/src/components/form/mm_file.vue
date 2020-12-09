<template>
	<div class="mm_file">
		<label>
			<input :type="file" :accept="accept" hidden="hidden" @change="$emit('change', event)">
		</label>
	</div>
</template>

<script>
	export default {
		props: {
			accept: {
				type: String,
				default: ".xls,.xlsx,.csv"
			},
			type: {
				type: "String",
				default: "file"
			}
		}
	}
</script>

<style>
</style>
