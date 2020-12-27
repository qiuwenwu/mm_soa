<template>
	<main id="pay_seller">
		<mm_grid>
			<mm_col>
				<mm_view>
					<header class="arrow">
						<h5>商户信息</h5>
					</header>
					<mm_body>
						<mm_form class="mm_filter">
							<h5><span>筛选条件</span></h5>
							<mm_list col="3">
								<mm_col>
									<mm_input v-model="query.keyword" title="关键词" desc="商户名称"
									 @blur="search()" />
								</mm_col>
								<mm_col>
									<mm_select v-model="query.institution_state" title="认证状态" :options="$to_kv(arr_institution_state)" @change="search()" />
								</mm_col>
								<mm_col>
									<mm_select v-model="query.user_id" title="商户持有人" :options="$to_kv(list_account, 'user_id', 'nickname')"
									 @change="search()" />
								</mm_col>
								<mm_col>
									<mm_select v-model="query.province_id" title="省份" :options="$to_kv(list_address_province, 'province_id', 'name')"
									 @change="search()" />
								</mm_col>
								<mm_col>
									<mm_select v-model="query.city_id" title="所在城市" :options="$to_kv(list_address_city, 'city_id', 'name')"
									 @change="search()" />
								</mm_col>
								<mm_col>
									<mm_btn class="btn_primary-x" type="reset" @click.native="reset();search()">重置</mm_btn>
								</mm_col>
							</mm_list>
						</mm_form>
						<div class="mm_action">
							<h5><span>操作</span></h5>
							<div class="">
								<mm_btn class="btn_primary-x" url="./seller_form">添加</mm_btn>
								<mm_btn @click.native="show = true" class="btn_primary-x" v-bind:class="{ 'disabled': !selects }">批量修改</mm_btn>
							</div>
						</div>
						<mm_table type="2">
							<thead>
								<tr>
									<th scope="col" class="th_selected"><input type="checkbox" :checked="select_state" @click="select_all()" /></th>
									<th scope="col" class="th_id"><span>#</span></th>
									<th scope="col">
										<mm_reverse title="认证状态" v-model="query.orderby" field="institution_state" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="商户持有人" v-model="query.orderby" field="user_id" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="省份" v-model="query.orderby" field="province_id" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="所在城市" v-model="query.orderby" field="city_id" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="商户名称" v-model="query.orderby" field="name" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="注册企业名" v-model="query.orderby" field="institution" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="组织机构码" v-model="query.orderby" field="institution_code" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="详细地址" v-model="query.orderby" field="address" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="经营范围" v-model="query.orderby" field="business" :func="search"></mm_reverse>
									</th>
									<th scope="col" class="th_handle"><span>操作</span></th>
								</tr>
							</thead>
							<draggable v-model="list" tag="tbody" @change="sort_change">
								<tr v-for="(o, idx) in list" :key="idx" :class="{'active': select == idx}" @click="selected(idx)">
									<th scope="row"><input type="checkbox" :checked="select_has(o[field])" @click="select_change(o[field])" /></th>
									<td>
										<span>{{ o.seller_id }}</span>
									</td>
									<td>
										<span>{{arr_institution_state[o.institution_state] }}</span>
									</td>
									<td>
										<span>{{ get_name(list_account, o.user_id, 'user_id', 'nickname') }}</span>
									</td>
									<td>
										<span>{{ get_name(list_address_province, o.province_id, 'province_id', 'name') }}</span>
									</td>
									<td>
										<span>{{ get_name(list_address_city, o.city_id, 'city_id', 'name') }}</span>
									</td>
									<td>
										<span>{{ o.name }}</span>
									</td>
									<td>
										<span>{{ o.institution }}</span>
									</td>
									<td>
										<span>{{ o.institution_code }}</span>
									</td>
									<td>
										<span>{{ o.address }}</span>
									</td>
									<td>
										<span>{{ o.business }}</span>
									</td>
									<td>
										<mm_btn class="btn_primary" :url="'./seller_form?seller_id=' + o[field]">修改</mm_btn>
										<mm_btn class="btn_warning" @click.native="del_show(o, field)">删除</mm_btn>
									</td>
								</tr>
							</draggable>
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
						<dt>认证状态</dt>
						<dd>
							<mm_select v-model="form.institution_state" :options="$to_kv(arr_institution_state)" />
						</dd>
						<dt>商户持有人</dt>
						<dd>
							<mm_select v-model="form.user_id" :options="$to_kv(list_account, 'user_id', 'nickname')" />
						</dd>
						<dt>省份</dt>
						<dd>
							<mm_select v-model="form.province_id" :options="$to_kv(list_address_province, 'province_id', 'name')" />
						</dd>
						<dt>所在城市</dt>
						<dd>
							<mm_select v-model="form.city_id" :options="$to_kv(list_address_city, 'city_id', 'name')" />
						</dd>
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
				url_get_list: "/apis/pay/seller",
				url_del: "/apis/pay/seller?method=del&",
				url_set: "/apis/pay/seller?method=set&",
				field: "seller_id",
				query_set: {
					"seller_id": ""
				},
				// 查询条件
				query: {
					//页码
					page: 1,
					//页面大小
					size: 10,
					// 商户ID
					'seller_id': 0,
					// 认证状态——最小值
					'institution_state_min': '',
					// 认证状态——最大值
					'institution_state_max': '',
					// 商户名称
					'name': '',
					// 关键词
					'keyword': '',
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', '', 'font_yellow', 'font_success', 'font_warning', 'font_primary', 'font_info', 'font_default'],
				// 认证状态
				'arr_institution_state': [ '' , '未认证' , '认证中' , '已认证' , '认证失败' ],
				// 商户持有人
				'list_account': [ ],
				// 省份
				'list_address_province': [ ],
				// 所在城市
				'list_address_city': [ ],
				// 视图模型
				vm: {}
			}
		},
		methods: {
			/**
			 * 获取商户持有人
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
						_this.list_account .clear();
						_this.list_account .addList(json.result.list)
					}
				});
			},
			/**
			 * 获取省份
			 * @param {query} 查询条件
			 */
			get_address_province(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "province_id,name"
					};
				}
				this.$get('~/apis/sys/address_province?size=0', query, function(json) {
					if (json.result) {
						_this.list_address_province .clear();
						_this.list_address_province .addList(json.result.list)
					}
				});
			},
			/**
			 * 获取所在城市
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
						_this.list_address_city .clear();
						_this.list_address_city .addList(json.result.list)
					}
				});
			},
		},
		created() {
			// 获取商户持有人
			this.get_account();
			// 获取省份
			this.get_address_province();
			// 获取所在城市
			this.get_address_city();
		}
	}
</script>

<style>
</style>
