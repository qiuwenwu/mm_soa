<template>
	<main id="pay_account_form">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}支付账户</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
										<dt>状态</dt>
										<dd>
											<mm_select v-model="form.state" :options="$to_kv(arr_state)" />
										</dd>
										<dt>网银账户</dt>
										<dd>
											<mm_input v-model="form.bank" :minlength="0" :maxlength="32" placeholder="" />
										</dd>
										<dt>网银名称</dt>
										<dd>
											<mm_input v-model="form.bank_name" :minlength="0" :maxlength="255" placeholder="含支行" />
										</dd>
										<dt>网银认证</dt>
										<dd>
											<mm_switch v-model="form.bank_state" />
										</dd>
										<dt>收款微信账户</dt>
										<dd>
											<mm_input v-model="form.wechat" :minlength="0" :maxlength="32" placeholder="" />
										</dd>
										<dt>微信认证</dt>
										<dd>
											<mm_switch v-model="form.wechat_state" />
										</dd>
										<dt>收款支付宝账户</dt>
										<dd>
											<mm_input v-model="form.alipay" :minlength="0" :maxlength="32" placeholder="" />
										</dd>
										<dt>支付宝认证</dt>
										<dd>
											<mm_switch v-model="form.alipay_state" />
										</dd>
										<dt>比特币地址</dt>
										<dd>
											<mm_input v-model="form.btc" :minlength="0" :maxlength="255" placeholder="" />
										</dd>
										<dt>比特币地址认证</dt>
										<dd>
											<mm_switch v-model="form.btc_state" />
										</dd>
										<dt>以太币地址</dt>
										<dd>
											<mm_input v-model="form.eth" :minlength="0" :maxlength="255" placeholder="" />
										</dd>
										<dt>以太币地址认证</dt>
										<dd>
											<mm_switch v-model="form.eth_state" />
										</dd>
										<dt>柚子币地址</dt>
										<dd>
											<mm_input v-model="form.eos" :minlength="0" :maxlength="255" placeholder="" />
										</dd>
										<dt>柚子币地址认证</dt>
										<dd>
											<mm_switch v-model="form.eos_state" />
										</dd>
										<dt>美眉币地址</dt>
										<dd>
											<mm_input v-model="form.mm" :minlength="0" :maxlength="255" placeholder="" />
										</dd>
										<dt>美眉币地址认证</dt>
										<dd>
											<mm_switch v-model="form.mm_state" />
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
				url: "/apis/pay/account?",
				url_get_obj: "/apis/pay/account?method=get_obj",
				field: "user_id",
				query: {
					"user_id": 0
				},
				form: {
					"user_id": 0,
					"state": 0,
					"bank": '',
					"bank_name": '',
					"bank_state": 0,
					"wechat": '',
					"wechat_state": 0,
					"alipay": '',
					"alipay_state": 0,
					"btc": '',
					"btc_state": 0,
					"eth": '',
					"eth_state": 0,
					"eos": '',
					"eos_state": 0,
					"mm": '',
					"mm_state": 0,
				},
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
