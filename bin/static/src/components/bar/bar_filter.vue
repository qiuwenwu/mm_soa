<template>
	<div class="bar_filter">
		<div class="list" :class="cols">
			<div class="item" v-for="(o,i) in list" :key="i">
				<div class="title">{{o.title}}</div>
				<div class="select_box" :class="{active:is_active}">
					<div class="select_group">
						<div class="select" v-for="(obj,idx) in o[vm.sub]" :key="idx">
							<span class="icon" :class="{show:is_show,selected:is_selected(obj)}" @click="select_item(obj)"></span>
							<span class="name">{{obj[vm.name]}}</span>
						</div>
					</div>
					<div class="btn_submit">
						<div class="submit" @click="event_click"><span>提交</span></div>
						<div class="remove" @click="reset"><span>取消</span></div>
					</div>
				</div>
				<div class="btns">
					<div class="btn_select_multi" :class="{show:is_show}" @click="show_select">多选</div>
					<div class="btn_more" :class="{active:is_active}" @click="show_more"></div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	import mixin from '/src/mixins/component.js'
	export default {
		mixins: [mixin],
		props: {
			col: {
				type: String,
				default: ""
			},
			icon_key: {
				type: String,
				default: "image",
			},
			list: {
				type: Array,
				default: function() {
					return [{
						title: "手机类型:",
						sub: [{
								name: "智能手机",
								command: "intelligence phone",
							},
							{
								name: "时尚手机",
								command: "fashion phone",
							},
							{
								name: "拍照手机",
								command: "photograph phone",
							},
							{
								name: "4G手机",
								command: "4G phone",
							},
							{
								name: "音乐手机",
								command: "music phone",
							}, {
								name: "商务手机",
								command: "business phone",
							}, {
								name: "老人手机",
								command: "older phone",
							}, {
								name: "女性手机",
								command: "female phone",
							}, {
								name: "备用手机 phone",
								command: "spare",
							},
							{
								name: "时尚手机",
								command: "fashion phone",
							},
							{
								name: "拍照手机",
								command: "photograph phone",
							},
							{
								name: "4G手机",
								command: "4G phone",
							},
							{
								name: "音乐手机",
								command: "music phone",
							}, {
								name: "商务手机",
								command: "business phone",
							}, {
								name: "老人手机",
								command: "older phone",
							}, {
								name: "女性手机",
								command: "female phone",
							}, {
								name: "备用手机 phone",
								command: "spare",
							},
							{
								name: "时尚手机",
								command: "fashion phone",
							},
							{
								name: "拍照手机",
								command: "photograph phone",
							},
							{
								name: "4G手机",
								command: "4G phone",
							},
							{
								name: "音乐手机",
								command: "music phone",
							}, {
								name: "商务手机",
								command: "business phone",
							}, {
								name: "老人手机",
								command: "older phone",
							}, {
								name: "女性手机",
								command: "female phone",
							}, {
								name: "备用手机 phone",
								command: "spare",
							},
							{
								name: "时尚手机",
								command: "fashion phone",
							},
							{
								name: "拍照手机",
								command: "photograph phone",
							},
							{
								name: "4G手机",
								command: "4G phone",
							},
							{
								name: "音乐手机",
								command: "music phone",
							}, {
								name: "商务手机",
								command: "business phone",
							}, {
								name: "老人手机",
								command: "older phone",
							}, {
								name: "女性手机",
								command: "female phone",
							}, {
								name: "备用手机 phone",
								command: "spare",
							},
							{
								name: "时尚手机",
								command: "fashion phone",
							},
							{
								name: "拍照手机",
								command: "photograph phone",
							},
							{
								name: "4G手机",
								command: "4G phone",
							},
							{
								name: "音乐手机",
								command: "music phone",
							}, {
								name: "商务手机",
								command: "business phone",
							}, {
								name: "老人手机",
								command: "older phone",
							}, {
								name: "女性手机",
								command: "female phone",
							}, {
								name: "备用手机 phone",
								command: "spare",
							}
						],
						command: "default"
					}]
				}
			}
		},
		data() {
			return {
				is_active: false,
				is_show: false,
				list_select: []
			};
		},
		methods: {
			// 显示选择框，并展开更多内容
			show_select() {
				this.is_show = true;
				this.is_active = true;
			},
			// 更多展开
			show_more() {
				this.is_active = !this.is_active;
				if (this.is_show && !this.is_active) {
					this.is_show = false
				}
			},
			// 判断是否选择
			is_selected(obj) {
				return this.list_select.indexOf(obj) !== -1
			},
			// 选择某项
			select_item(o) {
				var bool = this.list_select.indexOf(o) !== -1
				if (bool) {
					this.list_select.del(o)
				} else {
					this.list_select.push(o)
				}
			},
			// 发射事件
			event_click() {
				if (this.func) {
					this.func(this.list_select);
				}
				this.reset()
			},
			// 取消
			reset() {
				this.is_active = false
				this.is_show = false
				this.list_select = []
			}
		},
	}
</script>

<style>
</style>
