<template>
	<main id="pay_account_discount_form">
		<mm_grid>
			<mm_col width="33">
				<mm_form class="card">
					<div class="head arrow">
						<h5>{{ form[field] ? '修改' : '创建' }}账户提现</h5>
					</div>
					<div class="body">
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
							<dt>提现金额</dt>
							<dd>
								<mm_number v-model="form.amount" :min="0" :max="0" />
							</dd>
							<dt>手续费</dt>
							<dd>
								<mm_number v-model="form.fee" :min="0" :max="0" />
							</dd>
							<dt>转账支付时间</dt>
							<dd>
								<mm_time v-model="form.pay_time" type="datetime-local" />
							</dd>
							<dt>资金到账时间</dt>
							<dd>
								<mm_time v-model="form.time_end" type="datetime-local" />
							</dd>
							<dt>应用平台</dt>
							<dd>
								<mm_input v-model="form.platform" :minlength="0" :maxlength="0" placeholder="pc电脑版网站 / moblie移动版网站 / wechat微信公众号 / app手机应用" />
							</dd>
							<dt>收款方式</dt>
							<dd>
								<mm_input v-model="form.way" :minlength="0" :maxlength="0" placeholder="third第三方支付 / bank网银 / digiccy数字货币" />
							</dd>
							<dt>转账机构</dt>
							<dd>
								<mm_input v-model="form.institution" :minlength="0" :maxlength="0" placeholder="第三方填支付宝 / 微信，银行填银行名称例如建设银行，数字货币填数字货币名称，例如比特币" />
							</dd>
							<dt>发起提现时的IP</dt>
							<dd>
								<mm_input v-model="form.ip" :minlength="0" :maxlength="0" placeholder="" />
							</dd>
							<dt>付款账户</dt>
							<dd>
								<mm_input v-model="form.from_user" :minlength="0" :maxlength="0" placeholder="" />
							</dd>
							<dt>收款账户</dt>
							<dd>
								<mm_input v-model="form.to_user" :minlength="0" :maxlength="0" placeholder="" />
							</dd>
							<dt>拒绝原因</dt>
							<dd>
								<mm_input v-model="form.cause" :minlength="0" :maxlength="0" placeholder="告知商户为什么拒绝本次提现" />
							</dd>
							<dt>商户备注</dt>
							<dd>
								<mm_input v-model="form.note" :minlength="0" :maxlength="0" placeholder="提现完成后的商户备注信息，便于商户查询" />
							</dd>
						</dl>
					</div>
					<div class="foot">
						<div class="mm_group">
							<button class="btn_default" type="button" @click="cancel">取消</button>
							<button class="btn_primary" type="button" @click="submit()">提交</button>
						</div>
					</div>
				</mm_form>
			</mm_col>
		</mm_grid>
	</main>
</template>


<script>
	import mixin from '/src/mixins/page.js';

	export default {
		mixins: [mixin],
		components: {},
		data() {
			return {
				url_submit: "/apis/pay/account_discount?",
				url_get_obj: "/apis/pay/account_discount?method=get_obj",
				field: "discount_id",
				query: {
					"discount_id": 0
				},
				form: {
					"discount_id": 0,
					"state": 0,
					"to_user_id": 0,
					"seller_id": 0,
					"user_id": 0,
					"amount": 0,
					"fee": 0,
					"pay_time": '',
					"time_end": '',
					"platform": '',
					"way": '',
					"institution": '',
					"ip": '',
					"from_user": '',
					"to_user": '',
					"cause": '',
					"note": '',
				},
				// 提现状态
				'arr_state': [ '' , '申请中' , '转帐中' , '已完成' , '已拒绝' ],
				// 收款人
				'list_account': [ ],
				// 商户
				'list_seller': [ ],
				// 审批人
				'list_account': [ ],
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
