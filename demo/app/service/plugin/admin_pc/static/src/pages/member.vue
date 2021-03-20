<template>
	<main id="service_member">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>服务成员</h5>
							</div>
							<div class="card_body">
								<mm_form class="mm_filter">
									<div class="title">
										<h5><span>筛选条件</span></h5>
									</div>
									<mm_list col="3">
										<mm_item>
											<mm_input v-model="query.keyword" title="关键词" desc="服务者姓名"
											 @blur="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.user_id" title="用户" :options="$to_kv(list_account, 'user_id', 'nickname')"
											 @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.way" title="收费方式" :options="$to_kv(arr_way)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.type_id" title="默认分类" :options="$to_kv(list_type, 'type_id', 'name')"
											 @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.city_id" title="所属城市" :options="$to_kv(list_address_city, 'city_id', 'name')"
											 @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.area_id" title="所属市区" :options="$to_kv(list_address_area, 'area_id', 'name')"
											 @change="search()" />
										</mm_item>
										<mm_item>
											<mm_btn class="btn_primary-x" type="reset" @click.native="reset();search()">重置</mm_btn>
										</mm_item>
									</mm_list>
								</mm_form>
								<div class="mm_action">
									<h5><span>操作</span></h5>
									<div class="btns">
										<mm_btn class="btn_primary-x" url="./member_form?">添加</mm_btn>
										<mm_btn @click.native="show = true" class="btn_primary-x" v-bind:class="{ 'disabled': !selects }">批量修改</mm_btn>
									</div>
									<div class="btn_small">
										<mm_file class="btn_default-x" type="excel" :func="import_db" v-if="url_import"></mm_file>
										<mm_btn class="btn_default-x" @click.native="export_db()" v-if="url_export">导出</mm_btn>
									</div>
								</div>
								<mm_table type="2">
									<thead class="table-sm">
										<tr>
											<th class="th_selected"><input type="checkbox" :checked="select_state" @click="select_all()" /></th>
											<th class="th_id"><span>#</span></th>
											<th>
												<mm_reverse title="用户" v-model="query.orderby" field="user_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="收费方式" v-model="query.orderby" field="way" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="默认分类" v-model="query.orderby" field="type_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="所属城市" v-model="query.orderby" field="city_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="所属市区" v-model="query.orderby" field="area_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="坐标位置X" v-model="query.orderby" field="position_x" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="坐标位置Y" v-model="query.orderby" field="position_y" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="默认定价" v-model="query.orderby" field="price" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="创建时间" v-model="query.orderby" field="time_create" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="更新时间" v-model="query.orderby" field="time_update" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="服务者电话" v-model="query.orderby" field="service_phone" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="服务者姓名" v-model="query.orderby" field="servicer_name" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="具体地址" v-model="query.orderby" field="address" :func="search"></mm_reverse>
											</th>
											<th class="th_handle"><span>操作</span></th>
										</tr>
									</thead>
									<tbody>
										<!-- <draggable v-model="list" tag="tbody" @change="sort_change"> -->
										<tr v-for="(o, idx) in list" :key="idx" :class="{'active': select == idx}" @click="selected(idx)">
											<th class="th_selected"><input type="checkbox" :checked="select_has(o[field])" @click="select_change(o[field])" /></th>
											<td>{{ o[field] }}</td>
											<td>
												<span>{{ get_name(list_account, o.user_id, 'user_id', 'nickname') }}</span>
											</td>
											<td>
												<span>{{arr_way[o.way] }}</span>
											</td>
											<td>
												<span>{{ get_name(list_type, o.type_id, 'type_id', 'name') }}</span>
											</td>
											<td>
												<span>{{ get_name(list_address_city, o.city_id, 'city_id', 'name') }}</span>
											</td>
											<td>
												<span>{{ get_name(list_address_area, o.area_id, 'area_id', 'name') }}</span>
											</td>
											<td>
												<span>{{ o.position_x }}</span>
											</td>
											<td>
												<span>{{ o.position_y }}</span>
											</td>
											<td>
												<span>{{ o.price }}</span>
											</td>
											<td>
												<span>{{ $to_time(o.time_create, 'yyyy-MM-dd hh:mm') }}</span>
											</td>
											<td>
												<span>{{ $to_time(o.time_update, 'yyyy-MM-dd hh:mm') }}</span>
											</td>
											<td>
												<span>{{ o.service_phone }}</span>
											</td>
											<td>
												<span>{{ o.servicer_name }}</span>
											</td>
											<td>
												<span>{{ o.address }}</span>
											</td>
											<td>
												<mm_btn class="btn_primary" :url="'./member_form?member_id=' + o[field]">修改</mm_btn>
												<mm_btn class="btn_warning" @click.native="del_show(o, field)">删除</mm_btn>
											</td>
										</tr>
									</tbody>
									<!-- </draggable> -->
								</mm_table>
							</div>
							<div class="card_foot">
								<div class="fl">
									<mm_select v-model="query.size" :options="$to_size()" @change="search()" />
								</div>
								<div class="fr">
									<span class="mr">共 {{ count }} 条</span>
									<span>当前</span>
									<input type="number" class="pager_now" v-model.number="page_now" @blur="goTo(page_now)" @change="page_change" />
									<span>/{{ page_count }}页</span>
								</div>
								<mm_pager display="2" v-model="query.page" :count="count / query.size" :func="goTo" :icons="['首页', '上一页', '下一页', '尾页']"></mm_pager>
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
						<dt>用户</dt>
						<dd>
							<mm_select v-model="form.user_id" :options="$to_kv(list_account, 'user_id', 'nickname')" />
						</dd>
						<dt>收费方式</dt>
						<dd>
							<mm_select v-model="form.way" :options="$to_kv(arr_way)" />
						</dd>
						<dt>默认分类</dt>
						<dd>
							<mm_select v-model="form.type_id" :options="$to_kv(list_type, 'type_id', 'name')" />
						</dd>
						<dt>所属城市</dt>
						<dd>
							<mm_select v-model="form.city_id" :options="$to_kv(list_address_city, 'city_id', 'name')" />
						</dd>
						<dt>所属市区</dt>
						<dd>
							<mm_select v-model="form.area_id" :options="$to_kv(list_address_area, 'area_id', 'name')" />
						</dd>
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
				url_get_list: "/apis/service/member",
				url_del: "/apis/service/member?method=del&",
				url_set: "/apis/service/member?method=set&",
				url_import: "/apis/service/member?method=import&",
				url_export: "/apis/service/member?method=export&",
				field: "member_id",
				query_set: {
					"member_id": ""
				},
				// 查询条件
				query: {
					//页码
					page: 1,
					//页面大小
					size: 10,
					// 成员ID
					'member_id': 0,
					// 收费方式——最小值
					'way_min': '',
					// 收费方式——最大值
					'way_max': '',
					// 坐标位置X——最小值
					'position_x_min': 0,
					// 坐标位置X——最大值
					'position_x_max': 0,
					// 坐标位置Y——最小值
					'position_y_min': 0,
					// 坐标位置Y——最大值
					'position_y_max': 0,
					// 默认定价——最小值
					'price_min': 0,
					// 默认定价——最大值
					'price_max': 0,
					// 创建时间——开始时间
					'time_create_min': '',
					// 创建时间——结束时间
					'time_create_max': '',
					// 更新时间——开始时间
					'time_update_min': '',
					// 更新时间——结束时间
					'time_update_max': '',
					// 服务者姓名
					'servicer_name': '',
					// 关键词
					'keyword': '',
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', '', 'font_yellow', 'font_success', 'font_warning', 'font_primary', 'font_info', 'font_default'],
				// 用户
				'list_account':[],
				// 收费方式
				'arr_way':["","次","时","日","周","月","季","年"],
				// 默认分类
				'list_type':[],
				// 所属城市
				'list_address_city':[],
				// 所属市区
				'list_address_area':[],
				// 视图模型
				vm: {}
			}
		},
		methods: {
			/**
			 * 获取用户
			 * @param {query} 查询条件
			 */
			get_account(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "user_id,nickname"
					};
				}
				this.$get('~/apis/user/account?size=0', query, function(json) {
					if (json.result) {
						_this.list_account.clear();
						_this.list_account.addList(json.result.list)
					}
				});
			},
			/**
			 * 获取默认分类
			 * @param {query} 查询条件
			 */
			get_type(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "type_id,name"
					};
				}
				this.$get('~/apis/service/type?size=0', query, function(json) {
					if (json.result) {
						_this.list_type.clear();
						_this.list_type.addList(json.result.list)
					}
				});
			},
			/**
			 * 获取所属城市
			 * @param {query} 查询条件
			 */
			get_address_city(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "city_id,name"
					};
				}
				this.$get('~/apis/sys/address_city?size=0', query, function(json) {
					if (json.result) {
						_this.list_address_city.clear();
						_this.list_address_city.addList(json.result.list)
					}
				});
			},
			/**
			 * 获取所属市区
			 * @param {query} 查询条件
			 */
			get_address_area(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "area_id,name"
					};
				}
				this.$get('~/apis/sys/address_area?size=0', query, function(json) {
					if (json.result) {
						_this.list_address_area.clear();
						_this.list_address_area.addList(json.result.list)
					}
				});
			},
		},
		created() {
			// 获取用户
			this.get_account();
			// 获取默认分类
			this.get_type();
			// 获取所属城市
			this.get_address_city();
			// 获取所属市区
			this.get_address_area();
		}
	}
</script>

<style>
</style>
