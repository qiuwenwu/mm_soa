<template>
	<main id="mall_config_form">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
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
				url: "?",
				url_get_obj: "?method=get_obj",
				field: "",
				query: {
					"": 0
				},
				form: {
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
