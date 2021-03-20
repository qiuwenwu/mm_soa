<template>
	<main id="service_achievement_form">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}业绩</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
										<dt>评分</dt>
										<dd>
											<mm_number v-model="form.score" :min="0" :max="9" />
										</dd>
										<dt>收入</dt>
										<dd>
											<mm_number v-model="form.income" :min="0" :max="0" />
										</dd>
										<dt>用户ID</dt>
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
				url: "/apis/service/achievement?",
				url_get_obj: "/apis/service/achievement?method=get_obj",
				field: "achievement_id",
				query: {
					"achievement_id": 0
				},
				form: {
					"achievement_id": 0,
					"score": 0,
					"income": 0,
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
