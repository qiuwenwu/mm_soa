<template>
	<main id="pay_trade">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>交易信息</h5>
							</div>
							<div class="card_body">
								<mm_form class="mm_filter">
									<div class="title">
										<h5><span>筛选条件</span></h5>
									</div>
									<mm_list col="3">
										<mm_item>
											<mm_input v-model="query.keyword" title="关键词" desc="付款标题 / 付款描述 / 付款内容"
											 @blur="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.state" title="付款状态" :options="$to_kv(arr_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.from_user_id" title="付款人" :options="$to_kv(list_account, 'user_id', 'nickname')"
											 @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.to_user_id" title="收款人" :options="$to_kv(list_account, 'user_id', 'nickname')"
											 @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.seller_id" title="商户" :options="$to_kv(list_seller, 'seller_id', 'name')"
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
										<mm_btn class="btn_primary-x" url="./trade_form?">添加</mm_btn>
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
												<mm_reverse title="付款状态" v-model="query.orderby" field="state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款人" v-model="query.orderby" field="from_user_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="收款人" v-model="query.orderby" field="to_user_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="商户" v-model="query.orderby" field="seller_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款总计金额" v-model="query.orderby" field="total" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="实际付款金额" v-model="query.orderby" field="amount" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="手续费" v-model="query.orderby" field="fee" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="订单创建时间" v-model="query.orderby" field="time_create" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="转账支付时间" v-model="query.orderby" field="time_pay" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款到账时间" v-model="query.orderby" field="time_end" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="最后编辑时间" v-model="query.orderby" field="time_update" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="应用平台" v-model="query.orderby" field="platform" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款方式" v-model="query.orderby" field="way" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款应用" v-model="query.orderby" field="app" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="转账机构" v-model="query.orderby" field="institution" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款标题" v-model="query.orderby" field="title" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="交易ID" v-model="query.orderby" field="transaction_id" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="转账时的用户IP" v-model="query.orderby" field="ip" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款账户" v-model="query.orderby" field="from_user" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="收款账户" v-model="query.orderby" field="to_user" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款描述" v-model="query.orderby" field="description" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="付款人备注" v-model="query.orderby" field="note" :func="search"></mm_reverse>
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
												<span v-bind:class="arr_color[o.state]">{{arr_state[o.state] }}</span>
											</td>
											<td>
												<span>{{ get_name(list_account, o.from_user_id, 'user_id', 'nickname') }}</span>
											</td>
											<td>
												<span>{{ get_name(list_account, o.to_user_id, 'user_id', 'nickname') }}</span>
											</td>
											<td>
												<span>{{ get_name(list_seller, o.seller_id, 'seller_id', 'name') }}</span>
											</td>
											<td>
												<span>{{ o.total }}</span>
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
												<span>{{ $to_time(o.time_pay, 'yyyy-MM-dd hh:mm') }}</span>
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
												<span>{{ o.app }}</span>
											</td>
											<td>
												<span>{{ o.institution }}</span>
											</td>
											<td>
												<span>{{ o.title }}</span>
											</td>
											<td>
												<span>{{ o.transaction_id }}</span>
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
												<span>{{ o.description }}</span>
											</td>
											<td>
												<span>{{ o.note }}</span>
											</td>
											<td>
												<mm_btn class="btn_primary" :url="'./trade_form?trade_id=' + o[field]">修改</mm_btn>
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
						<dt>付款状态</dt>
						<dd>
							<mm_select v-model="form.state" :options="$to_kv(arr_state)" />
						</dd>
						<dt>付款人</dt>
						<dd>
							<mm_select v-model="form.from_user_id" :options="$to_kv(list_account, 'user_id', 'nickname')" />
						</dd>
						<dt>收款人</dt>
						<dd>
							<mm_select v-model="form.to_user_id" :options="$to_kv(list_account, 'user_id', 'nickname')" />
						</dd>
						<dt>商户</dt>
						<dd>
							<mm_select v-model="form.seller_id" :options="$to_kv(list_seller, 'seller_id', 'name')" />
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
				url_get_list: "/apis/pay/trade",
				url_del: "/apis/pay/trade?method=del&",
				url_set: "/apis/pay/trade?method=set&",
				url_import: "/apis/pay/trade?method=import&",
				url_export: "/apis/pay/trade?method=export&",
				field: "trade_id",
				query_set: {
					"trade_id": ""
				},
				// 查询条件
				query: {
					//页码
					page: 1,
					//页面大小
					size: 10,
					// 交易序号
					'trade_id': 0,
					// 付款状态——最小值
					'state_min': '',
					// 付款状态——最大值
					'state_max': '',
					// 付款总计金额——最小值
					'total_min': 0,
					// 付款总计金额——最大值
					'total_max': 0,
					// 实际付款金额——最小值
					'amount_min': 0,
					// 实际付款金额——最大值
					'amount_max': 0,
					// 手续费——最小值
					'fee_min': 0,
					// 手续费——最大值
					'fee_max': 0,
					// 订单创建时间——开始时间
					'time_create_min': '',
					// 订单创建时间——结束时间
					'time_create_max': '',
					// 转账支付时间——开始时间
					'time_pay_min': '',
					// 转账支付时间——结束时间
					'time_pay_max': '',
					// 付款到账时间——开始时间
					'time_end_min': '',
					// 付款到账时间——结束时间
					'time_end_max': '',
					// 最后编辑时间——开始时间
					'time_update_min': '',
					// 最后编辑时间——结束时间
					'time_update_max': '',
					// 付款标题
					'title': '',
					// 付款描述
					'description': '',
					// 付款内容
					'content': '',
					// 关键词
					'keyword': '',
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', '', 'font_yellow', 'font_success', 'font_warning', 'font_primary', 'font_info', 'font_default'],
				// 付款状态
				'arr_state':["","待付款","待确认","已完成","已取消"],
				// 付款人
				'list_account':[],
				// 收款人
				'list_account':[],
				// 商户
				'list_seller':[],
				// 视图模型
				vm: {}
			}
		},
		methods: {
			/**
			 * 获取付款人
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
						_this.list_account.clear();
						_this.list_account.addList(json.result.list)
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
						_this.list_seller.clear();
						_this.list_seller.addList(json.result.list)
					}
				});
			},
		},
		created() {
			// 获取付款人
			this.get_account();
			// 获取收款人
			this.get_account();
			// 获取商户
			this.get_seller();
		}
	}
</script>

<style>
</style>
