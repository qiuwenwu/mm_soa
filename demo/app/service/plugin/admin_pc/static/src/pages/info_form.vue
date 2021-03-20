<template>
	<main id="service_info_form">
		<mm_warp>
			<mm_container>
				<mm_row>
					<mm_col class="col-mm-12">
						<mm_card>
							<div class="card_head arrow">
								<h5>{{ form[field] ? '修改' : '创建' }}服务信息</h5>
							</div>
							<div class="card_body">
								<mm_form>
									<dl>
										<dt>是否启用</dt>
										<dd>
											<mm_switch v-model="form.available" />
										</dd>
										<dt>状态</dt>
										<dd>
											<mm_select v-model="form.state" :options="$to_kv(arr_state)" />
										</dd>
										<dt>服务分类</dt>
										<dd>
											<mm_select v-model="form.type_id" :options="$to_kv(list_type, 'type_id', 'name', 0)" />
										</dd>
										<dt>收费方式</dt>
										<dd>
											<mm_select v-model="form.way" :options="$to_kv(arr_way)" />
										</dd>
										<dt>所属城市</dt>
										<dd>
											<mm_select v-model="form.city_id" :options="$to_kv(list_address_city, 'city_id', 'name', 0)" />
										</dd>
										<dt>所属市区</dt>
										<dd>
											<mm_select v-model="form.area_id" :options="$to_kv(list_address_area, 'area_id', 'name', 0)" />
										</dd>
										<dt>用户</dt>
										<dd>
											<mm_select v-model="form.user_id" :options="$to_kv(list_account, 'user_id', 'nickname', 0)" />
										</dd>
										<dt>热度</dt>
										<dd>
											<mm_number v-model="form.hot" :min="0" :max="1000000000" />
										</dd>
										<dt>点赞次数</dt>
										<dd>
											<mm_number v-model="form.praise" :min="0" :max="1000000000" />
										</dd>
										<dt>销量</dt>
										<dd>
											<mm_number v-model="form.sales" :min="0" :max="1000000000" />
										</dd>
										<dt>坐标位置X</dt>
										<dd>
											<mm_number v-model="form.position_x" :min="0" :max="0" />
										</dd>
										<dt>坐标位置Y</dt>
										<dd>
											<mm_number v-model="form.position_y" :min="0" :max="0" />
										</dd>
										<dt>服务定价</dt>
										<dd>
											<mm_number v-model="form.price" :min="1" :max="1000000" />
										</dd>
										<dt>服务者电话</dt>
										<dd>
											<mm_input v-model="form.service_phone" :minlength="0" :maxlength="11" placeholder="" />
										</dd>
										<dt>服务者姓名</dt>
										<dd>
											<mm_input v-model="form.servicer_name" :minlength="0" :maxlength="16" placeholder="" />
										</dd>
										<dt>服务项</dt>
										<dd>
											<mm_input v-model="form.items" :minlength="0" :maxlength="255" placeholder="用于说明提供的服务项，多个标签用空格隔开" />
										</dd>
										<dt class="required">具体地址</dt>
										<dd>
											<mm_input v-model="form.address" :minlength="0" :maxlength="255" placeholder=""
											 :required="true" />
										</dd>
										<dt>正文</dt>
										<dd>
											<mm_rich v-model="form.content"></mm_rich>
										</dd>
										<dt>封面图</dt>
										<dd>
											<mm_upload_img width="10rem" height="10rem" name="img" type="text" v-model="form.img" />
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
				url: "/apis/service/info?",
				url_get_obj: "/apis/service/info?method=get_obj",
				field: "info_id",
				query: {
					"info_id": 0
				},
				form: {
					"info_id": 0,
					"available": 0,
					"state": 0,
					"type_id": 0,
					"way": 0,
					"city_id": 0,
					"area_id": 0,
					"user_id": 0,
					"hot": 0,
					"praise": 0,
					"sales": 0,
					"position_x": 0,
					"position_y": 0,
					"price": 0,
					"service_phone": '',
					"servicer_name": '',
					"items": '',
					"address": '',
					"content": '',
					"img": '',
				},
				// 是否启用
				'arr_available':["否","是"],
				// 状态
				'arr_state':["","空闲中","工作中","休假中","已退出","已违规"],
				// 服务分类
				'list_type':[],
				// 收费方式
				'arr_way':["","次","时","日","周","月","季","年"],
				// 所属城市
				'list_address_city':[],
				// 所属市区
				'list_address_area':[],
				// 用户
				'list_account':[],
			}
		},
		methods: {
			/**
			 * 获取服务分类
			 * @param {query} 查询条件
			 */
			get_type(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "type_id,name"
					};
				}
				this.$get('~/apis/service/type?size=0', query, function(json) {
					if (json.result) {
						_this.list_type.clear();
						_this.list_type.addList(json.result.list)
					}
				});
			},
			/**
			 * 获取所属城市
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
						_this.list_address_city.clear();
						_this.list_address_city.addList(json.result.list)
					}
				});
			},
			/**
			 * 获取所属市区
			 * @param {query} 查询条件
			 */
			get_address_area(query) {
				var _this = this;
				if (!query) {
					query = {
						field: "area_id,name"
					};
				}
				this.$get('~/apis/sys/address_area?size=0', query, function(json) {
					if (json.result) {
						_this.list_address_area.clear();
						_this.list_address_area.addList(json.result.list)
					}
				});
			},
			/**
			 * 获取用户
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
		},
		created() {
			// 获取服务分类
			this.get_type();
			// 获取所属城市
			this.get_address_city();
			// 获取所属市区
			this.get_address_area();
			// 获取用户
			this.get_account();
		}
	}
</script>

<style>
</style>
