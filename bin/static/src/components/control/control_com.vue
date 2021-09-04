<template>
	<control_input class="control_com" v-if="tag === 'input'" v-model="ve"></control_input>
	<control_number class="control_com" v-else-if="tag === 'number'" v-model="ve">
	</control_number>
	<control_select class="control_com" v-else-if="tag === 'select'" v-model="ve" :options="m">
	</control_select>
	<control_checkbox class="control_com" v-else-if="tag === 'checkbox'" :options="m" v-model="ve"></control_checkbox>
	<control_switch class="control_com" v-else-if="tag === 'switch'" v-model="ve">
	</control_switch>
	<control_textarea class="control_com" v-else-if="tag === 'textarea'" v-model="ve">
	</control_textarea>
	<control_radio class="control_com" v-else-if="tag === 'radio'" :options="m" v-model="ve">
	</control_radio>
	<input :type="type" v-else v-model="ve" />
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
