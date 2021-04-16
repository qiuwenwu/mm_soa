<template>
	<div class="control_rich_quill quill-editor">
		<slot name="toolbar"></slot>
		<div class="control_rich_quill_content" ref="editor"></div>
	</div>
</template>

<script>
	// require sources
	import Quill from '/js/quill.min.js';
	import '/css/quill.snow.css';
	import '/css/quill.core.css';
	import '/css/quill.bubble.css';

	const defaultOptions = {
		theme: 'snow',
		boundary: document.body,
		modules: {
			toolbar: {
				container: [
					['bold', 'italic', 'underline', 'strike'],
					['blockquote', 'code-block'],
					[{
						'header': 1
					}, {
						'header': 2
					}],
					[{
						'list': 'ordered'
					}, {
						'list': 'bullet'
					}],
					[{
						'script': 'sub'
					}, {
						'script': 'super'
					}],
					[{
						'indent': '-1'
					}, {
						'indent': '+1'
					}],
					[{
						'direction': 'rtl'
					}],
					[{
						'size': ['small', false, 'large', 'huge']
					}],
					[{
						'header': [1, 2, 3, 4, 5, 6, false]
					}],
					[{
						'color': []
					}, {
						'background': []
					}],
					[{
						'font': []
					}],
					[{
						'align': []
					}],
					['clean'],
					['link', 'image', 'video']
				],
				handlers: {
					'image': function(value) {
						if (value) {
						  // var fd = new ActiveXObject("MSComDlg.CommonDialog");
						  //  fd.Filter = "*.png|*.gif|*.jfif|*.pjpeg|*.jpeg|*.pjp|*.jpg|*.bmp|*.dib|*.ico";
						  //  fd.FilterIndex = 2;
						  //  fd.MaxFileSize = 128;
						  //  fd.ShowSave();
							// var href = prompt('Enter the URL');
						} else {
							this.quill.format('image', false);
						}
					}
				}
			}
		},
		placeholder: 'Insert text here ...',
		readOnly: false
	}
	// pollfill
	if (typeof Object.assign != 'function') {
		Object.defineProperty(Object, 'assign', {
			value(target, varArgs) {
				if (target == null) {
					throw new TypeError('Cannot convert undefined or null to object')
				}
				const to = Object(target)
				for (let index = 1; index < arguments.length; index++) {
					const nextSource = arguments[index]
					if (nextSource != null) {
						for (const nextKey in nextSource) {
							if (Object.prototype.hasOwnProperty.call(nextSource, nextKey)) {
								to[nextKey] = nextSource[nextKey]
							}
						}
					}
				}
				return to
			},
			writable: true,
			configurable: true
		})
	}
	// export
	export default {
		model: {
			event: "input",
			prop: "value"
		},
		data() {
			return {
				op: {},
				ct: '',
				defaultOptions
			}
		},
		props: {
			content: String,
			value: String,
			disabled: {
				type: Boolean,
				default: false
			},
			options: {
				type: Object,
				required: false,
				default: () => ({})
			},
			globalOptions: {
				type: Object,
				required: false,
				default: () => ({})
			}
		},
		mounted() {
			this.initialize()
		},
		beforeDestroy() {
			this.quill = null
			delete this.quill
		},
		methods: {
			// Init Quill instance
			initialize() {
				if (this.$el) {
					// Options
					this.op = Object.assign({}, this.defaultOptions, this.globalOptions, this.options)
					// Instance
					this.quill = new Quill(this.$refs.editor, this.op)

					this.quill.enable(false)
					// Set editor content
					if (this.value || this.content) {
						this.quill.pasteHTML(this.value || this.content)
					}
					// Disabled editor
					if (!this.disabled) {
						this.quill.enable(true)
					}
					// Mark model as touched if editor lost focus
					this.quill.on('selection-change', range => {
						if (!range) {
							this.$emit('blur', this.quill)
						} else {
							this.$emit('focus', this.quill)
						}
					})
					// Update model if text changes
					this.quill.on('text-change', (delta, oldDelta, source) => {
						let html = this.$refs.editor.children[0].innerHTML
						const quill = this.quill
						const text = this.quill.getText()
						if (html === '<p><br></p>') html = ''
						this.ct = html
						this.$emit('input', this.ct);
						this.$emit('change', {
							html,
							text,
							quill
						})
					});
					// Emit ready event
					this.$emit('ready', this.quill)
				}
			}
		},
		watch: {
			// Watch content change
			content(newVal, oldVal) {
				if (this.quill) {
					if (newVal && newVal !== this.ct) {
						this.ct = newVal
						this.quill.pasteHTML(newVal)
					} else if (!newVal) {
						this.quill.setText('')
					}
				}
			},
			// Watch content change
			value(newVal, oldVal) {
				if (this.quill) {
					if (newVal && newVal !== this.ct) {
						this.ct = newVal
						this.quill.pasteHTML(newVal)
					} else if (!newVal) {
						this.quill.setText('')
					}
				}
			},
			// Watch disabled change
			disabled(newVal, oldVal) {
				if (this.quill) {
					this.quill.enable(!newVal)
				}
			}
		}
	}
</script>
