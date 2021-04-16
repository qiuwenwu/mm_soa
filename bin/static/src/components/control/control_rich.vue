<template>
	<textarea class="control_rich" :id="id_sub"></textarea>
</template>

<script>
	import Vue from 'Vue';
	// require sources
	import Tinymce from '/tinymce/tinymce.min.js';

	export default {
		name: "tinymce",
		props: {
			id: {
				type: String,
				required: false
			},
			options: {
				type: Object,
				default: function() {
					return {
						plugins: 'print preview searchreplace autolink directionality visualblocks visualchars fullscreen image link media template code codesample table charmap hr pagebreak nonbreaking anchor insertdatetime advlist lists wordcount imagetools textpattern help emoticons autosave bdmap autoresize',
						toolbar: `formatselect fontselect fontsizeselect | bold italic underline strikethrough link anchor forecolor backcolor | alignleft aligncenter alignright alignjustify outdent indent | table image axupimgs media charmap emoticons blockquote
						| code undo redo restoredraft | bullist numlist | subscript superscript removeformat |
						cut copy paste pastetext | hr pagebreak insertdatetime print preview | bdmap axupimgs indent2em lineheight formatpainter | fullscreen`,
						// height: 650, //编辑器高度
						min_height: 400,
						fontsize_formats: '12px 14px 16px 18px 24px 36px 48px 56px 72px',
						font_formats: '微软雅黑=Microsoft YaHei,Helvetica Neue,PingFang SC,sans-serif;苹果苹方=PingFang SC,Microsoft YaHei,sans-serif;宋体=simsun,serif;仿宋体=FangSong,serif;黑体=SimHei,sans-serif;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats;知乎配置=BlinkMacSystemFont, Helvetica Neue, PingFang SC, Microsoft YaHei, Source Han Sans SC, Noto Sans CJK SC, WenQuanYi Micro Hei, sans-serif;小米配置=Helvetica Neue,Helvetica,Arial,Microsoft Yahei,Hiragino Sans GB,Heiti SC,WenQuanYi Micro Hei,sans-serif',
						images_upload_base_path: '/sys/img'
					}
				}
			},
			value: {
				type: String,
				default: ''
			},
			lang: {
				type: String,
				default: 'zh_CN'
			},
			url: {
				type: String,
				default: '/upload/image'
			},
			// 上传方式
			base64: {
				type: String,
				default: ''
			}
		},
		watch: {
			content() {
				tinymce.get(this.id_sub).setContent(this.value)
			}
		},
		data: function(){
			return {
				id_sub: this.id || this.new_id()
			}
		},
		methods: {
			upload_image_base64(blobInfo, succFun, failFun) {
				$.post(this.url, {
					filename: blobInfo.filename(),
					image: blobInfo.base64()
				}, function(json, status) {
					if (json.result && json.result.obj) {
						succFun(json.result.obj.url);
					} else {
						if (json.error) {
							failFun(json.error.message);
						} else {
							failFun('失败！');
						}
					}
				});
			},
			upload_image(blobInfo, succFun, failFun) {
				var formData = new FormData();
				formData.append('name', blobInfo.name());
				formData.append('filename', blobInfo.filename());
				formData.append('file', blobInfo.blob());

				var hp = {
					type: 'POST',
					url: this.url,
					data: formData,
					processData: false,
					contentType: false,
					xhrFields: {
						withCredentials: true
					},
					success: function success(json, status) {
						if (json.result && json.result.obj) {
							console.log(json.result.obj.url);
							succFun(json.result.obj.url);
						} else {
							if (json.error) {
								failFun(json.error.message);
							} else {
								failFun('失败！');
							}
						}
					},
					complete: function complete(XHR, TS) {
						XHR = null;
					},
					error: function(status) {
						failFun(status);
					}
				};
				hp.headers = {};
				$.ajax(hp);
			},
			new_id: function new_id(){
				var num = Math.ceil(Math.random() * 100000);
				return "rich_" + num;
			}
		},
		mounted() {
			//Initial configuration
			let options = {}
			let s1 = new Function()
			let config = (editor) => {
				editor.on('NodeChange Change KeyUp', (e) => {
					this.$emit('input', tinymce.get(this.id_sub).getContent())
					this.$emit('change', tinymce.get(this.id_sub), tinymce.get(this.id_sub).getContent())
				})
				editor.on('init', (e) => {
					if (this.value != undefined) tinymce.get(this.id_sub).setContent(this.value)
					this.$emit('input', this.value)
				})
			}

			//Default configuration
			s1 = (e) => config(e)
			if (typeof this.options == 'object') {

				options = Object.assign({}, this.options)
				if (!this.options.hasOwnProperty('selector')) options.selector = '#' + this.id_sub
				if (typeof this.options.setup == 'function') {
					s1 = (editor) => {
						config(editor)
						this.options.setup(editor)
					}
				}

			} else options.selector = '#' + this.id_sub

			options.setup = (editor) => s1(editor);
			options.language = this.lang;
			options.images_upload_handler = (blobInfo, succFun, failFun) => {
				if (this.base64) {
					this.upload_image_base64(blobInfo, succFun, failFun);
				} else {
					this.upload_image(blobInfo, succFun, failFun);
				}
			};
			Vue.nextTick(() => tinymce.init(options))
		},
		beforeDestroy() {
			tinymce.execCommand('mceRemoveEditor', false, this.id_sub)
		}
	}
</script>
