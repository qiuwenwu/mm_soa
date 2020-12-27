<template>
	<main id="pay_seller_form">
		<mm_grid>
			<mm_col width="33">
				<mm_form class="card">
					<div class="head arrow">
						<h5>{{ form[field] ? '修改' : '创建' }}商户信息</h5>
					</div>
					<div class="body">
						<dl>
							<dt>认证状态</dt>
							<dd>
								<mm_select v-model="form.institution_state" :options="$to_kv(arr_institution_state)" />
							</dd>
							<dt>商户持有人</dt>
							<dd>
								<mm_select v-model="form.user_id" :options="$to_kv(list_account, 'user_id', 'nickname')" />
							</dd>
							<dt>省份</dt>
							<dd>
								<mm_select v-model="form.province_id" :options="$to_kv(list_address_province, 'province_id', 'name')" />
							</dd>
							<dt>所在城市</dt>
							<dd>
								<mm_select v-model="form.city_id" :options="$to_kv(list_address_city, 'city_id', 'name')" />
							</dd>
							<dt class="required">商户名称</dt>
							<dd>
								<mm_input v-model="form.name" :minlength="0" :maxlength="0" placeholder=""
								 :required="true" />
							</dd>
							<dt>注册企业名</dt>
							<dd>
								<mm_input v-model="form.institution" :minlength="0" :maxlength="0" placeholder="" />
							</dd>
							<dt>组织机构码</dt>
							<dd>
								<mm_input v-model="form.institution_code" :minlength="0" :maxlength="0" placeholder="" />
							</dd>
							<dt>详细地址</dt>
							<dd>
								<mm_input v-model="form.address" :minlength="0" :maxlength="0" placeholder="商户办公地的详细地址" />
							</dd>
							<dt>经营范围</dt>
							<dd>
								<mm_input v-model="form.business" :minlength="0" :maxlength="0" placeholder="" />
							</dd>
							<dt>营业执照图片</dt>
							<dd>
								<mm_upload_img width="10rem" height="10rem" name="institution_img" type="text" v-model="form.institution_img" />
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
				url_submit: "/apis/pay/seller?",
				url_get_obj: "/apis/pay/seller?method=get_obj",
				field: "seller_id",
				query: {
					"seller_id": 0
				},
				form: {
					"seller_id": 0,
					"institution_state": 0,
					"user_id": 0,
					"province_id": 0,
					"city_id": 0,
					"name": '',
					"institution": '',
					"institution_code": '',
					"address": '',
					"business": '',
					"institution_img": '',
				},
				// 认证状态
				'arr_institution_state': [ '' , '未认证' , '认证中' , '已认证' , '认证失败' ],
				// 商户持有人
				'list_account': [ ],
				// 省份
				'list_address_province': [ ],
				// 所在城市
				'list_address_city': [ ],
			}
		},
		methods: {
			/**
			 * 获取商户持有人
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
			 * 获取省份
			 * @param {query} 查询条件
			 */
			get_address_province(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "province_id,name"
					};
				}
				this.$get('~/apis/sys/address_province?size=0', query, function(json) {
					if (json.result) {
						_this.list_address_province .clear();
						_this.list_address_province .addList(json.result.list)
					}
				});
			},
			/**
			 * 获取所在城市
			 * @param {query} 查询条件
			 */
			get_address_city(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "city_id,name"
					};
				}
				this.$get('~/apis/sys/address_city?size=0', query, function(json) {
					if (json.result) {
						_this.list_address_city .clear();
						_this.list_address_city .addList(json.result.list)
					}
				});
			},
		},
		created() {
			// 获取商户持有人
			this.get_account();
			// 获取省份
			this.get_address_province();
			// 获取所在城市
			this.get_address_city();
		}
	}
</script>

<style>
</style>
