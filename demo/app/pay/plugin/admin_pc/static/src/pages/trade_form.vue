<template>
	<main id="pay_trade_form">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}交易信息</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
										<dt>付款状态</dt>
										<dd>
											<mm_select v-model="form.state" :options="$to_kv(arr_state)" />
										</dd>
										<dt>付款人</dt>
										<dd>
											<mm_select v-model="form.from_user_id" :options="$to_kv(list_account, 'user_id', 'nickname', 0)" />
										</dd>
										<dt>收款人</dt>
										<dd>
											<mm_select v-model="form.to_user_id" :options="$to_kv(list_account, 'user_id', 'nickname', 0)" />
										</dd>
										<dt>商户</dt>
										<dd>
											<mm_select v-model="form.seller_id" :options="$to_kv(list_seller, 'seller_id', 'name', 0)" />
										</dd>
										<dt>付款总计金额</dt>
										<dd>
											<mm_number v-model="form.total" :min="0" :max="0" />
										</dd>
										<dt>实际付款金额</dt>
										<dd>
											<mm_number v-model="form.amount" :min="0" :max="0" />
										</dd>
										<dt>手续费</dt>
										<dd>
											<mm_number v-model="form.fee" :min="0" :max="0" />
										</dd>
										<dt>转账支付时间</dt>
										<dd>
											<mm_time v-model="form.time_pay" type="datetime-local" />
										</dd>
										<dt>付款到账时间</dt>
										<dd>
											<mm_time v-model="form.time_end" type="datetime-local" />
										</dd>
										<dt>应用平台</dt>
										<dd>
											<mm_input v-model="form.platform" :minlength="0" :maxlength="12" placeholder="pc电脑版网站 / moblie移动版网站 / wechat微信公众号 / app手机应用" />
										</dd>
										<dt>付款方式</dt>
										<dd>
											<mm_input v-model="form.way" :minlength="0" :maxlength="12" placeholder="third第三方支付 / bank网银 / digiccy数字货币" />
										</dd>
										<dt>付款应用</dt>
										<dd>
											<mm_input v-model="form.app" :minlength="0" :maxlength="16" placeholder="cms内容管理系统 / mall商城 / bbs论坛，可自定义" />
										</dd>
										<dt>转账机构</dt>
										<dd>
											<mm_input v-model="form.institution" :minlength="0" :maxlength="16" placeholder="第三方填支付宝 / 微信，银行填银行名称例如建设银行，数字货币填数字货币名称，例如比特币" />
										</dd>
										<dt>付款标题</dt>
										<dd>
											<mm_input v-model="form.title" :minlength="0" :maxlength="16" placeholder="" />
										</dd>
										<dt class="required">交易ID</dt>
										<dd>
											<mm_input v-model="form.transaction_id" :minlength="0" :maxlength="32" placeholder="类似合同编号，可用来查询该笔交易明细"
											 :required="true" />
										</dd>
										<dt>转账时的用户IP</dt>
										<dd>
											<mm_input v-model="form.ip" :minlength="0" :maxlength="67" placeholder="" />
										</dd>
										<dt>付款账户</dt>
										<dd>
											<mm_input v-model="form.from_user" :minlength="0" :maxlength="128" placeholder="" />
										</dd>
										<dt>收款账户</dt>
										<dd>
											<mm_input v-model="form.to_user" :minlength="0" :maxlength="128" placeholder="" />
										</dd>
										<dt>付款描述</dt>
										<dd>
											<mm_input v-model="form.description" :minlength="0" :maxlength="255" placeholder="告知用户付款的原因" />
										</dd>
										<dt>付款人备注</dt>
										<dd>
											<mm_rich v-model="form.note"></mm_rich>
										</dd>
										<dt>付款内容</dt>
										<dd>
											<mm_rich v-model="form.content"></mm_rich>
										</dd>
									</dl>
								</mm_form>
							</div>
							<div class="card_foot">
								<div class="mm_group">
									<button class="btn_default" type="button" @click="cancel">取消</button>
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
				url: "/apis/pay/trade?",
				url_get_obj: "/apis/pay/trade?method=get_obj",
				field: "trade_id",
				query: {
					"trade_id": 0
				},
				form: {
					"trade_id": 0,
					"state": 0,
					"from_user_id": 0,
					"to_user_id": 0,
					"seller_id": 0,
					"total": 0,
					"amount": 0,
					"fee": 0,
					"time_pay": '',
					"time_end": '',
					"platform": '',
					"way": '',
					"app": '',
					"institution": '',
					"title": '',
					"transaction_id": '',
					"ip": '',
					"from_user": '',
					"to_user": '',
					"description": '',
					"note": '',
					"content": '',
				},
				// 付款状态
				'arr_state':["","待付款","待确认","已完成","已取消"],
				// 付款人
				'list_account':[],
				// 收款人
				'list_account':[],
				// 商户
				'list_seller':[],
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
