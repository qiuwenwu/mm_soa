<template>
	<main id="pay_account_amount">
		<mm_grid>
			<mm_col>
				<mm_view>
					<header class="arrow">
						<h5>账户余额</h5>
					</header>
					<mm_body>
						<mm_form class="mm_filter">
							<h5><span>筛选条件</span></h5>
							<mm_list col="3">
								<mm_col>
									<mm_btn class="btn_primary-x" type="reset" @click.native="reset();search()">重置</mm_btn>
								</mm_col>
							</mm_list>
						</mm_form>
						<div class="mm_action">
							<h5><span>操作</span></h5>
							<div class="">
								<mm_btn class="btn_primary-x" url="./account_amount_form">添加</mm_btn>
								<mm_btn @click.native="show = true" class="btn_primary-x" v-bind:class="{ 'disabled': !selects }">批量修改</mm_btn>
							</div>
						</div>
						<mm_table type="2">
							<thead>
								<tr>
									<th scope="col" class="th_selected"><input type="checkbox" :checked="select_state" @click="select_all()" /></th>
									<th scope="col" class="th_id"><span>#</span></th>
									<th scope="col">
										<mm_reverse title="美元余额" v-model="query.orderby" field="usd" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="人民币余额" v-model="query.orderby" field="cny" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="美眉币余额" v-model="query.orderby" field="mm" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="比特币余额" v-model="query.orderby" field="btc" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="以太币余额" v-model="query.orderby" field="eth" :func="search"></mm_reverse>
									</th>
									<th scope="col">
										<mm_reverse title="柚子币余额" v-model="query.orderby" field="eos" :func="search"></mm_reverse>
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
										<span>{{ o.usd }}</span>
									</td>
									<td>
										<span>{{ o.cny }}</span>
									</td>
									<td>
										<span>{{ o.mm }}</span>
									</td>
									<td>
										<span>{{ o.btc }}</span>
									</td>
									<td>
										<span>{{ o.eth }}</span>
									</td>
									<td>
										<span>{{ o.eos }}</span>
									</td>
									<td>
										<mm_btn class="btn_primary" :url="'./account_amount_form?seller_id=' + o[field]">修改</mm_btn>
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
				url_get_list: "/apis/pay/account_amount",
				url_del: "/apis/pay/account_amount?method=del&",
				url_set: "/apis/pay/account_amount?method=set&",
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
					// 美元余额——最小值
					'usd_min': 0,
					// 美元余额——最大值
					'usd_max': 0,
					// 人民币余额——最小值
					'cny_min': 0,
					// 人民币余额——最大值
					'cny_max': 0,
					// 美眉币余额——最小值
					'mm_min': 0,
					// 美眉币余额——最大值
					'mm_max': 0,
					// 比特币余额——最小值
					'btc_min': 0,
					// 比特币余额——最大值
					'btc_max': 0,
					// 以太币余额——最小值
					'eth_min': 0,
					// 以太币余额——最大值
					'eth_max': 0,
					// 柚子币余额——最小值
					'eos_min': 0,
					// 柚子币余额——最大值
					'eos_max': 0,
					//排序
					orderby: ""
				},
				form: {},
				//颜色
				arr_color: ['', '', 'font_yellow', 'font_success', 'font_warning', 'font_primary', 'font_info', 'font_default'],
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
