<template>
	<main id="${id}">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>${api.title}</h5>
							</div>
							<div class="card_body">
								<mm_form class="bar_filter">
									<div class="title">
										<h5><span>筛选条件</span></h5>
									</div>
									<mm_list :col="3">
										<!--{if(param.list)}-->
										<!--{loop param.list v idx}-->
										<!--{if(v.name == 'keyword')}-->
										<mm_item>
											<control_input v-model="query.keyword" title="${v.title}" desc="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}"
											 @blur="search()" />
										</mm_item>
										<!--{/if}-->
										<!--{/loop}-->
										<!--{/if}-->
										<!--{loop field v idx}-->
										<!--{if(v.format)}-->
										<!--{if(v.format.table)}-->
										<mm_item>
											<control_select v-model="query.${v.format.key}" title="${v.title}" :options="$to_kv(${v.label}, '${v.format.id || v.format.key}', '${v.format.name}')"
											 @change="search()" />
										</mm_item>
										<!--{else}-->
										<mm_item>
											<control_select v-model="query.${v.format.key}" title="${v.title}" :options="$to_kv(${v.label})" @change="search()" />
										</mm_item>
										<!--{/if}-->
										<!--{/if}-->
										<!--{/loop}-->
										<mm_item>
											<mm_btn class="btn_primary-x" type="reset" @click.native="reset();search()">重置</mm_btn>
										</mm_item>
									</mm_list>
								</mm_form>
								<div class="bar_action">
									<h5><span>操作</span></h5>
									<div class="btns">
										<mm_btn class="btn_primary-x" url="./${name}_form?">添加</mm_btn>
										<mm_btn @click.native="show = true" class="btn_primary-x" v-bind:class="{ 'disabled': !selects }">批量修改</mm_btn>
									</div>
									<div class="btn_small">
										<control_file class="btn_default-x" type="excel" :func="import_db" v-if="url_import"></control_file>
										<mm_btn class="btn_default-x" @click.native="export_db()" v-if="url_export">导出</mm_btn>
									</div>
								</div>
								<mm_table type="3">
									<thead class="table-sm">
										<tr>
											<th class="th_open"></th>
											<th class="th_selected"><input type="checkbox" :checked="select_state" @click="select_all()" /></th>
											<th class="th_id"><span>#</span></th>
											<!--{loop field v idx}-->
											<!--{if(v.name !== sql.key)}-->
											<th>
												<control_reverse title="${v.title}" v-model="query.orderby" field="${v.name}" :func="search"></control_reverse>
											</th>
											<!--{/if}-->
											<!--{/loop}-->
											<th class="th_handle"><span>操作</span></th>
										</tr>
									</thead>
									<tbody>
										<!-- <draggable v-model="list" tag="tbody" @change="sort_change"> -->
										<tr v-for="(o, idx) in list_new" :key="idx" :class="{'active': select == idx, sub: o[father_id], open: opens_has(o[field]), no_sub: !opens_has_sub(o[field]) }"
										 @click="selected(idx)">
											<th class="th_open"><button class="btn_open" :style="'margin-left:' + (1.5 * opens_lv(o[father_id])) + 'rem;'"
												 @click="opens_change(o[field])"><i class="fa-caret-right"></i></button></th>
											<th class="th_selected"><input type="checkbox" :checked="select_has(o[field])" @click="select_change(o[field])" /></th>
											<td>{{ o[field] }}</td>
											<!--{loop field v idx}-->
											<!--{if(v.name !== sql.key)}-->
											<td>
												<!--{if(v.dataType === 'tinyint')}-->
												<control_switch v-model="o.${v.name}" @click.native="set(o)" />
												<!--{else if(v.format)}-->
												<!--{if(v.format.table)}-->
												<span>{{ get_name(${v.label}, o.${v.format.key}, '${v.format.id || v.format.key}', '${v.format.name}') }}</span>
												<!--{else if(v.name == 'state' || v.name == 'status')}-->
												<span v-bind:class="arr_color[o.${v.name}]">{{ ${v.label}[o.${v.name}] }}</span>
												<!--{else}-->
												<span>{{ ${v.label}[o.${v.name}] }}</span>
												<!--{/if}-->
												<!--{else if(v.name.indexOf('img') !== -1 || v.name.indexOf('icon') !== -1 || v.name === 'avatar')}-->
												<img class="${v.name}" :src="o.${v.name}" alt="${v.title}" />
												<!--{else if(v.dataType === 'date')}-->
												<span>{{ $to_time(o.${v.name}, 'yyyy-MM-dd') }}</span>
												<!--{else if(v.dataType === 'time')}-->
												<span>{{ o.${v.name} }}</span>
												<!--{else if(v.dataType === 'timestamp' || v.dataType === 'datetime')}-->
												<span>{{ $to_time(o.${v.name}, 'yyyy-MM-dd hh:mm') }}</span>
												<!--{else if(v.name === 'display' || v.name === 'orderby')}-->
												<input class="input_display" v-model.number="o.${v.name}" @blur="set(o)" min="0" max="1000" />
												<!--{else}-->
												<control_input :auto="true" v-model="o.${v.name}" @blur="set(o)" />
												<!--{/if}-->
											</td>
											<!--{/if}-->
											<!--{/loop}-->
											<td>
												<mm_btn class="btn_primary" :url="'./${name}_form?${sql.key}=' + o[field]">修改</mm_btn>
												<mm_btn class="btn_warning" @click.native="del_show(o, field)">删除</mm_btn>
											</td>
										</tr>
									</tbody>
									<!-- </draggable> -->
								</mm_table>
							</div>
						</mm_card>
					</mm_col>
				</mm_row>
			</mm_container>
		</mm_warp>
		<mm_modal v-model="show" mask="true">
			<mm_card class="card">
				<div class="card_head">
					<h5>批量修改</h5>
				</div>
				<div class="card_body">
					<dl>
						<!--{loop field v idx}-->
						<!--{if(v.format)}-->
						<dt>${v.title}</dt>
						<!--{if(v.format.table)}-->
						<dd>
							<control_select v-model="form.${v.format.key}" :options="$to_kv(${v.label}, '${v.format.id || v.format.key}', '${v.format.name}')" />
						</dd>
						<!--{else}-->
						<dd>
							<control_select v-model="form.${v.format.key}" :options="$to_kv(${v.label})" />
						</dd>
						<!--{/if}-->
						<!--{/if}-->
						<!--{/loop}-->
					</dl>
				</div>
				<div class="card_foot">
					<div class="mm_group">
						<button class="btn_default" type="reset" @click="show = false">取消</button>
						<button class="btn_primary" type="button" @click="batchSet()">提交</button>
					</div>
				</div>
			</mm_card>
		</mm_modal>
	</main>
</template>

<script>
	import mixin from '/src/mixins/page.js';

	export default {
		mixins: [mixin],
		data() {
			return {
				// 列表请求地址
				url_get_list: "${api.path}",
				url_del: "${api.path}?method=del&",
				url_set: "${api.path}?method=set&",
				url_import: "${api.path}?method=import&",
				url_export: "${api.path}?method=export&",
				field: "${sql.key}",
				query_set: {
					"${sql.key}": ""
				},
				// 查询条件
				query: {
					//页码
					page: 0,
					//页面大小
					size: '0',
					/*[loop js.query v idx]*/
					// ${' ' + v.title}
					/*[if v.type === 'number' && !v.select]*/
					'${v.name}': 0,
					/*[else]*/
					'${v.name}': '',
					/*[/if]*/
					/*[/loop]*/
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', '', 'font_yellow', 'font_success', 'font_warning', 'font_primary', 'font_info', 'font_default'],
				/*[loop js.data v idx]*/
				// ${' ' + v.title}
				'${v.name}': $ {
					@JSON.stringify(v.value)
				},
				/*[/loop]*/
				// 视图模型
				vm: {}
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
						field: "${v.id},${v.field}${v.father_id ? ',' + v.father_id : '' }${v.title_name ? ',title' : '' }"
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
			/**
			 * 获取列表之前
			 * @param {Object} param 参数
			 */
			get_list_before(param) {
				delete param.page;
				param.size = "0";
				return param;
			}
		},
		created() {
			/*[loop js.data v idx]*/
			/*[if(v.path)]*/
			// 获取 ${v.title}
			this.get_ /*[v.basename]*/();
			/*[/if]*/
			/*[/loop]*/
		},
		computed: {
			list_new() {
				var lt = this.list.toTree(this.field).toList();
				var list = [];
				var arr = this.opens;
				for (var i = 0; i < lt.length; i++) {
					var o = lt[i];
					if (this.opens.indexOf(o[this.father_id]) !== -1) {
						list.push(o);
					}
				}
				return list;
			}
		}
	}
</script>

<style>
</style>
