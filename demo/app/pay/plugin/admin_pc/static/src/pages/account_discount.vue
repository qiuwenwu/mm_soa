<template>
	<main id="pay_account_discount">
		<mm_grid>
			<mm_col>
				<mm_view>
					<header class="arrow">
						<h5>账户提现</h5>
					</header>
					<mm_body>
						<mm_form class="mm_filter">
							<h5><span>筛选条件</span></h5>
							<mm_list col="3">
								<mm_col>
									<mm_select v-model="query.state" title="提现状态" :options="$to_kv(arr_state)" @change="search()" />
								</mm_col>
								<mm_col>
									<mm_select v-model="query.to_user_id" title="收款人" :options="$to_kv(list_account, 'user_id', 'nickname')"
									 @change="search()" />
								</mm_col>
								<mm_col>
									<mm_select v-model="query.seller_id" title="商户" :options="$to_kv(list_seller, 'seller_id', 'name')"
									 @change="search()" />
								</mm_col>
								<mm_col>
									<mm_select v-model="query.user_id" title="审批人" :options="$to_kv(list_account, 'user_id', 'nickname')"
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
								<mm_btn class="btn_primary-x" url="./account_discount_form">添加</mm_btn>
								<mm_btn @click.native="show = true" class="btn_primary-x" v-bind:class="{ 'disabled': !selects }">批量修改</mm_btn>
							</div>
						</div>
						<mm_table type="2">
							<thead>
								<tr>
									<th scope="col" class="th_selected"><input type="checkbox" :checked="select_state" @click="select_all()" /></th>
									<th scope="col" class="th_id"><span>#</span></th>
									<th scope="col">
										<mm_reverse title="提现状态" v-model="query.orderby" field="state" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="收款人" v-model="query.orderby" field="to_user_id" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="商户" v-model="query.orderby" field="seller_id" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="审批人" v-model="query.orderby" field="user_id" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="提现金额" v-model="query.orderby" field="amount" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="手续费" v-model="query.orderby" field="fee" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="创建时间" v-model="query.orderby" field="time_create" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="转账支付时间" v-model="query.orderby" field="pay_time" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="资金到账时间" v-model="query.orderby" field="time_end" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="最后编辑时间" v-model="query.orderby" field="time_update" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="应用平台" v-model="query.orderby" field="platform" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="收款方式" v-model="query.orderby" field="way" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="转账机构" v-model="query.orderby" field="institution" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="发起提现时的IP" v-model="query.orderby" field="ip" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="付款账户" v-model="query.orderby" field="from_user" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="收款账户" v-model="query.orderby" field="to_user" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="拒绝原因" v-model="query.orderby" field="cause" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="商户备注" v-model="query.orderby" field="note" :func="search"></mm_reverse>
									</th>
									<th scope="col" class="th_handle"><span>操作</span></th>
								</tr>
							</thead>
							<draggable v-model="list" tag="tbody" @change="sort_change">
								<tr v-for="(o, idx) in list" :key="idx" :class="{'active': select == idx}" @click="selected(idx)">
									<th scope="row"><input type="checkbox" :checked="select_has(o[field])" @click="select_change(o[field])" /></th>
									<td>
										<span>{{ o.discount_id }}</span>
									</td>
									<td>
										<span v-bind:class="arr_color[o.state]">{{arr_state[o.state] }}</span>
									</td>
									<td>
										<span>{{ get_name(list_account, o.to_user_id, 'user_id', 'nickname') }}</span>
									</td>
									<td>
										<span>{{ get_name(list_seller, o.seller_id, 'seller_id', 'name') }}</span>
									</td>
									<td>
										<span>{{ get_name(list_account, o.user_id, 'user_id', 'nickname') }}</span>
									</td>
									<td>
										<span>{{ o.amount }}</span>
									</td>
									<td>
										<span>{{ o.fee }}</span>
									</td>
									<td>
										<span>{{ $to_time(o.time_create, 'yyyy-MM-dd hh:mm') }}</span>
									</td>
									<td>
										<span>{{ $to_time(o.pay_time, 'yyyy-MM-dd hh:mm') }}</span>
									</td>
									<td>
										<span>{{ $to_time(o.time_end, 'yyyy-MM-dd hh:mm') }}</span>
									</td>
									<td>
										<span>{{ $to_time(o.time_update, 'yyyy-MM-dd hh:mm') }}</span>
									</td>
									<td>
										<span>{{ o.platform }}</span>
									</td>
									<td>
										<span>{{ o.way }}</span>
									</td>
									<td>
										<span>{{ o.institution }}</span>
									</td>
									<td>
										<span>{{ o.ip }}</span>
									</td>
									<td>
										<span>{{ o.from_user }}</span>
									</td>
									<td>
										<span>{{ o.to_user }}</span>
									</td>
									<td>
										<span>{{ o.cause }}</span>
									</td>
									<td>
										<span>{{ o.note }}</span>
									</td>
									<td>
										<mm_btn class="btn_primary" :url="'./account_discount_form?discount_id=' + o[field]">修改</mm_btn>
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
						<dt>提现状态</dt>
						<dd>
							<mm_select v-model="form.state" :options="$to_kv(arr_state)" />
						</dd>
						<dt>收款人</dt>
						<dd>
							<mm_select v-model="form.to_user_id" :options="$to_kv(list_account, 'user_id', 'nickname')" />
						</dd>
						<dt>商户</dt>
						<dd>
							<mm_select v-model="form.seller_id" :options="$to_kv(list_seller, 'seller_id', 'name')" />
						</dd>
						<dt>审批人</dt>
						<dd>
							<mm_select v-model="form.user_id" :options="$to_kv(list_account, 'user_id', 'nickname')" />
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
				url_get_list: "/apis/pay/account_discount",
				url_del: "/apis/pay/account_discount?method=del&",
				url_set: "/apis/pay/account_discount?method=set&",
				field: "discount_id",
				query_set: {
					"discount_id": ""
				},
				// 查询条件
				query: {
					//页码
					page: 1,
					//页面大小
					size: 10,
					// 提现申请ID
					'discount_id': 0,
					// 提现状态——最小值
					'state_min': '',
					// 提现状态——最大值
					'state_max': '',
					// 提现金额——最小值
					'amount_min': 0,
					// 提现金额——最大值
					'amount_max': 0,
					// 手续费——最小值
					'fee_min': 0,
					// 手续费——最大值
					'fee_max': 0,
					// 创建时间——开始时间
					'time_create_min': '',
					// 创建时间——结束时间
					'time_create_max': '',
					// 转账支付时间——开始时间
					'pay_time_min': '',
					// 转账支付时间——结束时间
					'pay_time_max': '',
					// 资金到账时间——开始时间
					'time_end_min': '',
					// 资金到账时间——结束时间
					'time_end_max': '',
					// 最后编辑时间——开始时间
					'time_update_min': '',
					// 最后编辑时间——结束时间
					'time_update_max': '',
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', '', 'font_yellow', 'font_success', 'font_warning', 'font_primary', 'font_info', 'font_default'],
				// 提现状态
				'arr_state': [ '' , '申请中' , '转帐中' , '已完成' , '已拒绝' ],
				// 收款人
				'list_account': [ ],
				// 商户
				'list_seller': [ ],
				// 审批人
				'list_account': [ ],
				// 视图模型
				vm: {}
			}
		},
		methods: {
			/**
			 * 获取收款人
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
			 * 获取商户
			 * @param {query} 查询条件
			 */
			get_seller(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "seller_id,name"
					};
				}
				this.$get('~/apis/pay/seller?size=0', query, function(json) {
					if (json.result) {
						_this.list_seller .clear();
						_this.list_seller .addList(json.result.list)
					}
				});
			},
			/**
			 * 获取审批人
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
		},
		created() {
			// 获取收款人
			this.get_account();
			// 获取商户
			this.get_seller();
			// 获取审批人
			this.get_account();
		}
	}
</script>

<style>
</style>
