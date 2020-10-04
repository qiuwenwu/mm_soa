<template>
	<main id="${id}">
		<mm_grid>
			<mm_col width="33">
				<mm_form class="card">
					<div class="head arrow">
						<h5>{{ form[field] ? '修改' : '创建' }}${api.title}</h5>
					</div>
					<div class="body">
						<dl>
							<!--{loop field v idx}-->
							<!--{if idx > 0}-->
							<!--{if(v.required)}-->
							<dt class="required">${v.title}</dt>
							<!--{else}-->
							<dt>${v.title}</dt>
							<!--{/if}-->
							<!--{if(v.dataType === 'tinyint')}-->
							<dd>
								<mm_switch v-model="form.${v.name}" />
							</dd>
							<!--{else if(v.format)}-->
							<!--{if(v.format.table)}-->
							<dd>
								<mm_select v-model="form.${v.format.key}" :options="$to_kv(${v.label}, '${v.format.id || v.format.key}', '${v.format.name}')" />
							</dd>
							<!--{else}-->
							<dd>
								<mm_select v-model="form.${v.format.key}" :options="$to_kv(${v.label})" />
							</dd>
							<!--{/if}-->
							<!--{else if(v.dataType === 'date')}-->
							<dd>
								<mm_time v-model="form.${v.name}" type="date" />
							</dd>
							<!--{else if(v.dataType === 'time')}-->
							<dd>
								<mm_time v-model="form.${v.name}" type="time" />
							</dd>
							<!--{else if(v.dataType.indexOf('time') !== -1)}-->
							<dd>
								<mm_time v-model="form.${v.name}" type="datetime-local" />
							</dd>
							<!--{else if(v.name.indexOf('img') !== -1 || v.name.indexOf('icon') !== -1)}-->
							<dd>
								<mm_upload_img width="10rem" height="10rem" name="${v.name}" type="text" v-model="form.${v.name}" />
							</dd>
							<!--{else if(v.dataType.indexOf('text') !== -1)}-->
							<dd>
								<mm_textarea v-model="form.${v.name}" type="text" placeholder="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}" />
							</dd>
							<!--{else if(v.type === 'number' && v.name.indexOf('id') === -1)}-->
							<dd>
								<!--{if(v.number.range && v.number.range.length)}-->
								<mm_number v-model="form.${v.name}" :min="${v.number.range[0]}" :max="${v.number.range[1]}" />
								<!--{else}-->
								<mm_number v-model="form.${v.name}" :min="${v.number ? v.number.min : 0}" :max="${v.number ? v.number.max : 0}" />
								<!--{/if}-->
							</dd>
							<!--{else}-->
							<dd>
								<!--{if(v.required)}-->
								<mm_input v-model="form.${v.name}" :minlength="0" :maxlength="${v.string ? v.string.max : 0}" placeholder="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}"
								 :required="true" />
								<!--{else}-->
								<mm_input v-model="form.${v.name}" :minlength="0" :maxlength="${v.string ? v.string.max : 0}" placeholder="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}" />
								<!--{/if}-->
							</dd>
							<!--{/if}-->
							<!--{/if}-->
							<!--{/loop}-->
						</dl>
					</div>
					<div class="foot">
						<div class="mm_group">
							<button class="btn_default" type="button" @click="cancel">取消</button>
							<button class="btn_primary" type="button" @click="submit()">提交</button>
						</div>
					</div>
				</mm_form>
			</mm_col>
		</mm_grid>
	</main>
</template>


<script>
	import mixin from '/src/mixins/page.js';

	export default {
		mixins: [mixin],
		components: {},
		data() {
			return {
				url_submit: "${api.path}?",
				url_get_obj: "${api.path}?method=get_obj",
				field: "${sql.key}",
				query: {
					"${sql.key}": 0
				},
				form: {
					/*[loop field v idx]*/
					/*[if v.type === 'number']*/
					"${v.name}": 0,
					/*[else]*/
					"${v.name}": '',
					/*[/if]*/
					/*[/loop]*/
				},
				/*[loop js.data v idx]*/
				// ${' ' + v.title}
				'${v.name}': [ /*[loop v.value a idx]*/ /*[if idx == 0]*/ '${a}' /*[else]*/ , '${a}' /*[/if]*/ /*[/loop]*/ ],
				/*[/loop]*/
			}
		},
		methods: {
			/*[loop js.data v idx]*/
			/*[if(v.path)]*/
			/**
			 * 获取 ${v.title}
			 * @param {query} 查询条件
			 */
			get_ /*[v.basename]*/(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "${v.id},${v.field}"
					};
				}
				this.$get('~${v.path}', query, function(json) {
					if (json.result) {
						_this /*['.' + v.name]*/ .clear();
						_this /*['.' + v.name]*/ .addList(json.result.list)
					}
				});
			},
			/*[/if]*/
			/*[/loop]*/
		},
		created() {
			/*[loop js.data v idx]*/
			/*[if(v.path)]*/
			// 获取 ${v.title}
			this.get_ /*[v.basename]*/();
			/*[/if]*/
			/*[/loop]*/
		}
	}
</script>

<style>
</style>
