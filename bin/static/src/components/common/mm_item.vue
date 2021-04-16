<template>
	<div class="mm_item">
		<div class="media" v-if="obj[vm.icon] || obj[vm.image]">
			<mm_icon class="img" v-if="obj[vm.image]" :src="obj[vm.image]"></mm_icon>
			<mm_icon class="icon" v-if="obj[vm.icon]" :src="obj[vm.icon]"></mm_icon>
		</div>
		<div class="doc">
			<div class="avatar" v-html="obj[vm.avatar]"></div>
			<div class="title" v-html="obj[vm.title]"></div>
			<div class="content" v-html="obj[vm.content]" v-if="obj[vm.content]"></div>
		</div>
		<slot></slot>
	</div>
</template>

<script>
	export default {
		props: {
			col: {
				type: String,
				default: ""
			},
			viewmodel: {
				type: String,
				default: function(){
					return {}
				}
			}
		},
		data(){
			return {
				// 视图模型
				vm: Object.assign({
					// 当前ID
					id: 'id',
					// 上级ID
					father_id: 'father_id',
					// 图片
					image: 'image',
					// 图标
					icon: 'icon',
					// 标题
					title: 'title',
					// 描述
					description: 'description',
					// 头像
					avatar: 'avatar',
					// 关键词
					keywords: 'keywords',
					// 内容
					content: 'content',
					// 时间
					time: 'time',
					// 链接
					url: 'url',
					// 方式
					mode: 'mode',
					// 来源
					source: 'source',
					// 来源地址
					source_url: 'source_url',
					// 作者
					author: 'author',
					// 名称
					name: 'name',
					// 值
					value: 'value',
					// 错误提示
					tip: 'tip',
					// 热度
					hot: 'hot',
					// 原价
					price_ago: 'price_ago',
					// 价格
					price: 'price',
					// 总价
					total: 'total',
					// 点赞数
					praise_num: 'praise_num',
					// 总量
					count: 'count',
					// 数量
					num: 'num',
					// 标签
					tag: 'tag',
					// 文本框的声明
					placeholder: ""
				}, this.viewmodel)
			}
		}
	}
</script>

<style>
</style>
