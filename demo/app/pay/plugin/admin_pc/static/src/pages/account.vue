<template>
	<main id="pay_account">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>支付账户</h5>
							</div>
							<div class="card_body">
								<mm_form class="mm_filter">
									<div class="title">
										<h5><span>筛选条件</span></h5>
									</div>
									<mm_list col="3">
										<mm_item>
											<mm_input v-model="query.keyword" title="关键词" desc="网银名称"
											 @blur="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.state" title="状态" :options="$to_kv(arr_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.bank_state" title="网银认证" :options="$to_kv(arr_bank_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.wechat_state" title="微信认证" :options="$to_kv(arr_wechat_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.alipay_state" title="支付宝认证" :options="$to_kv(arr_alipay_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.btc_state" title="比特币地址认证" :options="$to_kv(arr_btc_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.eth_state" title="以太币地址认证" :options="$to_kv(arr_eth_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.eos_state" title="柚子币地址认证" :options="$to_kv(arr_eos_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_select v-model="query.mm_state" title="美眉币地址认证" :options="$to_kv(arr_mm_state)" @change="search()" />
										</mm_item>
										<mm_item>
											<mm_btn class="btn_primary-x" type="reset" @click.native="reset();search()">重置</mm_btn>
										</mm_item>
									</mm_list>
								</mm_form>
								<div class="mm_action">
									<h5><span>操作</span></h5>
									<div class="btns">
										<mm_btn class="btn_primary-x" url="./account_form?">添加</mm_btn>
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
												<mm_reverse title="状态" v-model="query.orderby" field="state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="网银账户" v-model="query.orderby" field="bank" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="网银名称" v-model="query.orderby" field="bank_name" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="网银认证" v-model="query.orderby" field="bank_state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="收款微信账户" v-model="query.orderby" field="wechat" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="微信认证" v-model="query.orderby" field="wechat_state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="收款支付宝账户" v-model="query.orderby" field="alipay" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="支付宝认证" v-model="query.orderby" field="alipay_state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="比特币地址" v-model="query.orderby" field="btc" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="比特币地址认证" v-model="query.orderby" field="btc_state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="以太币地址" v-model="query.orderby" field="eth" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="以太币地址认证" v-model="query.orderby" field="eth_state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="柚子币地址" v-model="query.orderby" field="eos" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="柚子币地址认证" v-model="query.orderby" field="eos_state" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="美眉币地址" v-model="query.orderby" field="mm" :func="search"></mm_reverse>
											</th>
											<th>
												<mm_reverse title="美眉币地址认证" v-model="query.orderby" field="mm_state" :func="search"></mm_reverse>
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
												<span>{{ o.bank }}</span>
											</td>
											<td>
												<span>{{ o.bank_name }}</span>
											</td>
											<td>
												<mm_switch v-model="o.bank_state" @click.native="set(o)" />
											</td>
											<td>
												<span>{{ o.wechat }}</span>
											</td>
											<td>
												<mm_switch v-model="o.wechat_state" @click.native="set(o)" />
											</td>
											<td>
												<span>{{ o.alipay }}</span>
											</td>
											<td>
												<mm_switch v-model="o.alipay_state" @click.native="set(o)" />
											</td>
											<td>
												<span>{{ o.btc }}</span>
											</td>
											<td>
												<mm_switch v-model="o.btc_state" @click.native="set(o)" />
											</td>
											<td>
												<span>{{ o.eth }}</span>
											</td>
											<td>
												<mm_switch v-model="o.eth_state" @click.native="set(o)" />
											</td>
											<td>
												<span>{{ o.eos }}</span>
											</td>
											<td>
												<mm_switch v-model="o.eos_state" @click.native="set(o)" />
											</td>
											<td>
												<span>{{ o.mm }}</span>
											</td>
											<td>
												<mm_switch v-model="o.mm_state" @click.native="set(o)" />
											</td>
											<td>
												<mm_btn class="btn_primary" :url="'./account_form?user_id=' + o[field]">修改</mm_btn>
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
						<dt>状态</dt>
						<dd>
							<mm_select v-model="form.state" :options="$to_kv(arr_state)" />
						</dd>
						<dt>网银认证</dt>
						<dd>
							<mm_select v-model="form.bank_state" :options="$to_kv(arr_bank_state)" />
						</dd>
						<dt>微信认证</dt>
						<dd>
							<mm_select v-model="form.wechat_state" :options="$to_kv(arr_wechat_state)" />
						</dd>
						<dt>支付宝认证</dt>
						<dd>
							<mm_select v-model="form.alipay_state" :options="$to_kv(arr_alipay_state)" />
						</dd>
						<dt>比特币地址认证</dt>
						<dd>
							<mm_select v-model="form.btc_state" :options="$to_kv(arr_btc_state)" />
						</dd>
						<dt>以太币地址认证</dt>
						<dd>
							<mm_select v-model="form.eth_state" :options="$to_kv(arr_eth_state)" />
						</dd>
						<dt>柚子币地址认证</dt>
						<dd>
							<mm_select v-model="form.eos_state" :options="$to_kv(arr_eos_state)" />
						</dd>
						<dt>美眉币地址认证</dt>
						<dd>
							<mm_select v-model="form.mm_state" :options="$to_kv(arr_mm_state)" />
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
				url_get_list: "/apis/pay/account",
				url_del: "/apis/pay/account?method=del&",
				url_set: "/apis/pay/account?method=set&",
				url_import: "/apis/pay/account?method=import&",
				url_export: "/apis/pay/account?method=export&",
				field: "user_id",
				query_set: {
					"user_id": ""
				},
				// 查询条件
				query: {
					//页码
					page: 1,
					//页面大小
					size: 10,
					// 用户ID
					'user_id': 0,
					// 状态——最小值
					'state_min': '',
					// 状态——最大值
					'state_max': '',
					// 网银名称
					'bank_name': '',
					// 网银认证
					'bank_state': '',
					// 微信认证
					'wechat_state': '',
					// 支付宝认证
					'alipay_state': '',
					// 比特币地址认证
					'btc_state': '',
					// 以太币地址认证
					'eth_state': '',
					// 柚子币地址认证
					'eos_state': '',
					// 美眉币地址认证
					'mm_state': '',
					// 关键词
					'keyword': '',
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', '', 'font_yellow', 'font_success', 'font_warning', 'font_primary', 'font_info', 'font_default'],
				// 状态
				'arr_state':["","正常","异常","冻结","注销"],
				// 网银认证
				'arr_bank_state':["未认证","已认证"],
				// 微信认证
				'arr_wechat_state':["未认证","已认证"],
				// 支付宝认证
				'arr_alipay_state':["未认证","已认证"],
				// 比特币地址认证
				'arr_btc_state':["未认证","已认证"],
				// 以太币地址认证
				'arr_eth_state':["未认证","已认证"],
				// 柚子币地址认证
				'arr_eos_state':["未认证","已认证"],
				// 美眉币地址认证
				'arr_mm_state':["未认证","已认证"],
				// 视图模型
				vm: {}
			}
		},
		methods: {
		},
		created() {
		}
	}
</script>

<style>
</style>
