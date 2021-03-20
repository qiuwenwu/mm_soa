<template>
	<main id="service_balance_form">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}结算</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
										<dt>账户余额</dt>
										<dd>
											<mm_number v-model="form.remain_cash" :min="0" :max="0" />
										</dd>
										<dt>结款金额</dt>
										<dd>
											<mm_number v-model="form.settlement" :min="0" :max="0" />
										</dd>
										<dt>状态</dt>
										<dd>
											<mm_number v-model="form.state" :min="0" :max="9" />
										</dd>
										<dt>结款人</dt>
										<dd>
											<mm_input v-model="form.user_id" :minlength="0" :maxlength="0" placeholder="" />
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
				url: "/apis/service/balance?",
				url_get_obj: "/apis/service/balance?method=get_obj",
				field: "account_id",
				query: {
					"account_id": 0
				},
				form: {
					"account_id": 0,
					"remain_cash": 0,
					"settlement": 0,
					"state": 0,
					"user_id": 0,
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
