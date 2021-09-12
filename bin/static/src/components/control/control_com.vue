<template>
	<div class="control_com">
		<control_input v-if="tag === 'input'" v-model="ve" @blur.native="$emit('change', ve)"></control_input>
		<control_number v-else-if="tag === 'number'" v-model="ve" @input.native="$emit('change', ve)">
		</control_number>
		<control_select v-else-if="tag === 'select'" v-model="ve" :options="m" @input.native="$emit('change', ve)">
		</control_select>
		<control_checkbox v-else-if="tag === 'checkbox'" :options="m" v-model="ve" @input.native="$emit('change', ve)">
		</control_checkbox>
		<control_switch v-else-if="tag === 'switch'" v-model="ve" @input.native="$emit('change', ve)">
		</control_switch>
		<control_textarea v-else-if="tag === 'textarea'" v-model="ve" @input.native="$emit('change', ve)">
		</control_textarea>
		<control_radio v-else-if="tag === 'radio'" :options="m" @input.native="$emit('change', ve)" v-model="ve">
		</control_radio>
		<input :type="type" v-else v-model="ve" @blur.native="$emit('change', ve)" />
	</div>
</template>

<script>
	export default {
		model: {
			event: "change",
			prop: "value"
		},
		props: {
			tag: {
				type: String,
				default: "input"
			},
			mod: {
				type: String,
				default: "{}"
			},
			value: {
				type: [String, Boolean, Number],
				default: ""
			}
		},
		data: function() {
			return {
				ve: this.value
			}
		},
		computed: {
			m: function() {
				var mod = this.mod;
				if (mod && (mod.indexOf('{') === 0 || mod.indexOf('[') === 0)) {
					return JSON.parse(mod.replace(/\n/g, ""));
				} else {
					return {};
				}
			}
		},
		watch: {
			ve: function() {
				if (this.ve !== this.value) {
					this.$emit('change', this.ve + "");
				}
			},
			value: function() {
				if (this.tag === "number") {
					this.ve = Number(this.value);
				} else {
					this.ve = this.value;
				}
			}
		}
	}
</script>

<style>
</style>
