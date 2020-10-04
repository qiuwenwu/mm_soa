<template>
	<main id="${id}">
		<mm_grid>
			<mm_col>
				<mm_view>
					<header class="arrow">
						<h5>${api.title}</h5>
					</header>
					<mm_body>
						<mm_form class="mm_filter">
							<h5><span>筛选条件</span></h5>
							<mm_list col="3">
								<!--{if(param.list)}-->
								<!--{loop param.list v idx}-->
									<!--{if(v.name == 'keyword')}-->
								<mm_col>
									<mm_input v-model="query.keyword" title="${v.title}" desc="${v.description.replace(/\([0-9A-Za-z_]+\)/g, '').replace('用于搜索', '').replace(/、/g, ' / ')}" @blur="search()" />
								</mm_col>
									<!--{/if}-->
								<!--{/loop}-->
								<!--{/if}-->
								<!--{loop field v idx}-->
									<!--{if(v.format)}-->
										<!--{if(v.format.table)}-->
								<mm_col>
									<mm_select v-model="query.${v.format.key}" title="${v.title}" :options="$to_kv(${v.label}, '${v.format.id || v.format.key}', '${v.format.name}')" @change="search()" />
								</mm_col>
										<!--{else}-->
								<mm_col>
									<mm_select v-model="query.${v.format.key}" title="${v.title}" :options="$to_kv(${v.label})" @change="search()" />
								</mm_col>
										<!--{/if}-->
									<!--{/if}-->
								<!--{/loop}-->
								<mm_col>
									<mm_btn class="btn_primary-x" type="reset" @click.native="reset();search()">重置</mm_btn>
								</mm_col>
							</mm_list>
						</mm_form>
						<div class="mm_action">
							<h5><span>操作</span></h5>
							<div class="">
								<mm_btn class="btn_primary-x" url="./${name}_form">添加</mm_btn>
								<mm_btn @click.native="show = true" class="btn_primary-x" v-bind:class="{ 'disabled': !selects }">批量修改</mm_btn>
							</div>
						</div>
						<mm_table type="2">
							<thead>
								<tr>
									<th scope="col" class="th_selected"><input type="checkbox" :checked="select_state" @click="select_all()" /></th>
									<th scope="col" class="th_id"><span>#</span></th>
									<!--{loop field v idx}-->
										<!--{if(idx > 0)}-->
									<th scope="col">
										<mm_reverse title="${v.title}" v-model="query.orderby" field="${v.name}" :func="search"></mm_reverse>
									</th>
										<!--{/if}-->
									<!--{/loop}-->
									<th scope="col" class="th_handle"><span>操作</span></th>
								</tr>
							</thead>
							<tbody>
								<tr v-for="(o, idx) in list" :key="idx">
									<th scope="row"><input type="checkbox" :checked="select_has(o[field])" @click="select_change(o[field])" /></th>
									<th scope="row"><span>{{ o[field] }}</span></th>
									<!--{loop field v idx}-->
										<!--{if(v.format)}-->
											<!--{if(v.format.table)}-->
									<td><span>{{ get_name(${v.label}, o.${v.format.key}, '${v.format.id || v.format.key}', '${v.format.name}') }}</span></td>
											<!--{else}-->
									<td><span>{{ ${v.label}[o.${v.name}] }}</span></td>
											<!--{/if}-->
										<!--{else if(v.name.indexOf('time') !== -1 || v.name.indexOf('Time') !== -1)}-->
									<td><span>{{ $to_time(o.${v.name}, 'yyyy-MM-dd hh:mm') }}</span></td>
										<!--{else if(idx > 0)}-->
									<td><span>{{ o.${v.name} }}</span></td>
										<!--{/if}-->
									<!--{/loop}-->
									<td>
										<mm_btn class="btn_primary" :url="'./${name}_form?${sql.key}=' + o[field]">修改</mm_btn>
										<mm_btn class="btn_warning" @click.native="del_show(o, field)">删除</mm_btn>
									</td>
								</tr>
							</tbody>
						</mm_table>
					</mm_body>
					<footer>
						<mm_grid class="mm_data_count">
							<mm_col>
								<mm_select v-model="query.size" :options="$to_size()" @change="search()" />
							</mm_col>
							<mm_col width="50" style="min-width: 22.5rem;">
								<mm_pager display="2" v-model="query.page" :count="count / query.size" :func="goTo" :icons="['首页', '上一页', '下一页', '尾页']"></mm_pager>
							</mm_col>
							<mm_col>
								<div class="right plr">
									<span class="mr">共 {{ count }} 条</span>
									<span>当前</span>
									<input class="pager_now" v-model.number="page_now" @blur="goTo(page_now)" @change="page_change" />
									<span>/{{ page_count }}页</span>
								</div>
							</mm_col>
						</mm_grid>
					</footer>
				</mm_view>
			</mm_col>
		</mm_grid>
		<mm_modal v-model="show" mask="true">
			<mm_view class="card bg_no">
				<header class="bg_white">
					<h5>批量修改</h5>
				</header>
				<mm_body>
					<dl>
						<!--{loop field v idx}-->
							<!--{if(v.format)}-->
						<dt>${v.title}</dt>
								<!--{if(v.format.table)}-->
						<dd>
							<mm_select v-model="form.${v.format.key}" :options="$to_kv(${v.label}, '${v.format.id || v.format.key}', '${v.format.name}')" />
						</dd>
								<!--{else}-->
						<dd>
							<mm_select v-model="form.${v.format.key}" :options="$to_kv(${v.label})" />
						</dd>
								<!--{/if}-->
							<!--{/if}-->
						<!--{/loop}-->
					</dl>
				</mm_body>
				<footer>
					<div class="mm_group">
						<button class="btn_default" type="reset" @click="show = false">取消</button>
						<button class="btn_primary" type="button" @click="batchSet()">提交</button>
					</div>
				</footer>
			</mm_view>
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
				field: "${sql.key}",
				query_set: {
					"${sql.key}": ""
				},
				// 查询条件
				query: {
					//页码
					page: 1,
					//页面大小
					size: 10,
					/*[loop js.query v idx]*/
					// ${' ' + v.title}
						/*[if v.type == 'string']*/
					'${v.name}': '',
						/*[else]*/
					'${v.name}': 0,
						/*[/if]*/
					/*[/loop]*/
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', 'font_success', 'font_warning', 'font_yellow', 'font_default'],
				/*[loop js.data v idx]*/
				// ${' ' + v.title}
				'${v.name}': [/*[loop v.value a idx]*//*[if idx == 0]*/'${a}'/*[else]*/,'${a}'/*[/if]*//*[/loop]*/],
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
			get_/*[v.basename]*/(query){
				var _this = this;
				if(!query){
					query = {
						field: "${v.id},${v.field}"
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
