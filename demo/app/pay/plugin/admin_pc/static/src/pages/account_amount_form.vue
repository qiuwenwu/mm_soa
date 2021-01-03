<template>
	<main id="pay_account_amount_form">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}账户余额</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
										<dt>美元余额</dt>
										<dd>
											<mm_number v-model="form.usd" :min="0" :max="0" />
										</dd>
										<dt>人民币余额</dt>
										<dd>
											<mm_number v-model="form.cny" :min="0" :max="0" />
										</dd>
										<dt>美眉币余额</dt>
										<dd>
											<mm_number v-model="form.mm" :min="0" :max="0" />
										</dd>
										<dt>比特币余额</dt>
										<dd>
											<mm_number v-model="form.btc" :min="0" :max="0" />
										</dd>
										<dt>以太币余额</dt>
										<dd>
											<mm_number v-model="form.eth" :min="0" :max="0" />
										</dd>
										<dt>柚子币余额</dt>
										<dd>
											<mm_number v-model="form.eos" :min="0" :max="0" />
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
				url: "/apis/pay/account_amount?",
				url_get_obj: "/apis/pay/account_amount?method=get_obj",
				field: "seller_id",
				query: {
					"seller_id": 0
				},
				form: {
					"seller_id": 0,
					"usd": 0,
					"cny": 0,
					"mm": 0,
					"btc": 0,
					"eth": 0,
					"eos": 0,
				},
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
