<template>
	<div class="nav_user">
		<div class="login" v-if="!obj[vm.username]">
			<a href=""><span>请登陆</span></a>
			<a href=""><span>注册</span></a>
		</div>
		<div class="user" v-else :class="{active:is_active}">
			<div class="username">
				<span>{{obj[vm.username]}}</span>
				<span class="icon" @click="active"></span>
			</div>
			<div class="dropdown">
				<a :href="o.url" v-for="(o,i) in list" :key="i">
					<div class="title"><span>{{o[vm.title]}}</span></div>
				</a>
			</div>
		</div>
	</div>
</template>

<script>
	import mixin from '/src/mixins/component.js'
	export default {
		mixins: [mixin],
		props: {
			list: {
				type: Array,
				default: function() {
					return [{
						title: "个人信息",
						url: ""
					}, {
						title: "账号管理",
						url: ""
					}, {
						title: "修改密码",
						url: ""
					}, {
						title: "退出",
						url: ""
					}]
				}
			},
			obj: {
				type: Object,
				default: function() {
					return {
						username: "姓名xxx",
						url: ""
					}
				}
			}
		},
		data() {
			return {
				key_drop: -1,
				is_active: false
			};
		},
		methods: {
			active() {
				this.is_active = !this.is_active
			}
		}
	}
</script>

<style>
</style>
