<template>
	<main id="${id}">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}${api.title}</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
										<!--{loop field v idx}-->
										<!--{if(v.show.form)}-->
										<!--{if(v.name !== sql.key)}-->
										<!--{if(v.required)}-->
										<dt class="required">${v.title}</dt>
										<!--{else}-->
										<dt>${v.title}</dt>
										<!--{/if}-->
										<!--{if(v.dataType === 'tinyint')}-->
										<dd>
											<control_switch v-model="form.${v.name}" />
										</dd>
										<!--{else if(v.format)}-->
										<!--{if(v.format.table)}-->
										<dd>
											<!--{if(v.format.key.endWith('_id') !== -1)}-->
											<control_select type="list" v-model="form.${v.name}"
												:options="$to_kv(${v.label}, '${v.format.id || v.format.key}', '${v.format.name}')" />
											<!--{else}-->
											<control_select v-model="form.${v.name}"
												:options="$to_kv(${v.label}, '${v.format.id || v.format.key}', '${v.format.name}')" />
											<!--{/if}-->
										</dd>
										<!--{else}-->
										<dd>
											<control_select v-model="form.${v.name}"
												:options="$to_kv(${v.label})" />
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
										<!--{else if(v.name.indexOf('img') !== -1 || v.name.indexOf('icon') !== -1 || v.name === 'avatar')}-->
										<dd>
											<mm_upload_img width="10rem" height="10rem" name="${v.name}" type="text"
												v-model="form.${v.name}" />
										</dd>
										<!--{else if(v.name.indexOf('content') !== -1 || v.dataType.indexOf('longtext') !== -1)}-->
										<dd>
											<control_rich v-model="form.${v.name}"></control_rich>
										</dd>
										<!--{else if(v.dataType.indexOf('text') !== -1)}-->
										<dd>
											<control_textarea v-model="form.${v.name}" type="text"
												placeholder="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}">
											</control_textarea>
										</dd>
										<!--{else if(v.type === 'number' && v.name.indexOf('id') === -1)}-->
										<dd>
											<!--{if(v.number.range && v.number.range.length)}-->
											<control_number v-model="form.${v.name}" :min="${v.number.range[0]}" :max="${v.number.range[1]}" />
											<!--{else}-->
											<control_number v-model="form.${v.name}" :min="${v.number ? v.number.min : -99999999}" :max="${v.number ? v.number.max : 99999999}" />
											<!--{/if}-->
										</dd>
										<!--{else}-->
										<dd>
											<!--{if(v.required)}-->
											<control_input v-model="form.${v.name}" :minlength="0"
												:maxlength="${v.string ? v.string.max : 0}"
												placeholder="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}"
												:required="true" />
											<!--{else}-->
											<control_input v-model="form.${v.name}" :minlength="0"
												:maxlength="${v.string ? v.string.max : 0}"
												placeholder="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}" />
											<!--{/if}-->
										</dd>
										<!--{/if}-->
										<!--{/if}-->
										<!--{/if}-->
										<!--{/loop}-->
									</dl>
								</mm_form>
							</div>
							<div class="card_foot">
								<div class="mm_group">
									<button class="btn_default" type="button" @click="cancel">返回</button>
									<button class="btn_primary" type="button" @click="submit()">提交</button>
								</div>
							</div>
						</mm_card>
					</mm_col>
				</mm_row>
			</mm_container>
		</mm_warp>
	</main>
</template>


<script>
	import mixin from '/src/mixins/page.js';

	export default {
		mixins: [mixin],
		components: {},
		data() {
			return {
				url_add: "${api.path}?method=add",
				url_set: "${api.path}?method=set",
				url_get_obj: "${api.path}?method=get_obj",
				field: "${sql.key}",
				query: {
					"${sql.key}": 0
				},
				form: {
					/*[loop field v idx]*/
					// ${v.title}
					/*[if v.type === 'number']*/
					"${v.name}": ${v.default ? v.default : 0},
					/*[else]*/
					"${v.name}": '${v.default !== "0" ? v.default : ""}',
					/*[/if]*/
					/*[/loop]*/
				},
				/*[loop js.data v idx]*/
				// ${' ' + v.title}
				'${v.name}': ${@JSON.stringify(v.value)},
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
			get_/*[v.basename]*/(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "${v.id},${v.field}${v.father_id ? ',' + v.father_id : '' }${v.title_name ? ',title' : '' }"
					};
				}
				this.$get('~${v.path}', query, function(json) {
					if (json.result) {
						_this/*['.' + v.name]*/.clear();
						_this/*['.' + v.name]*/.addList(json.result.list)
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
			this.get_/*[v.basename]*/();
			/*[/if]*/
			/*[/loop]*/
		}
	}
</script>

<style>
</style>
