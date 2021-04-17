<template>
	<div class="list_goods" :class="cols">
		<item_goods v-for="(o, i) in list" :key="i" :viewmodel="vm" :obj="o"
			:class="css + (select === i ? ' active' : '')" @click.native="selected(i, o)"><slot></slot></item_goods>
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
							goods_id: 1,
							img: "/img/goods.png",
							title: "商品名称",
							price: "13.50",
							price_ago: "15.99",
						},
						{
							goods_id: 2,
							img: "/img/goods.png",
							title: "商品名称",
							price: "13.50",
							price_ago: "15.99",
						},
						{
							goods_id: 3,
							img: "/img/goods.png",
							title: "商品名称",
							price: "13.50",
							price_ago: "15.99",
						},
						{
							goods_id: 4,
							img: "/img/goods.png",
							title: "商品名称",
							price: "13.50",
							price_ago: "15.99",
						}
					]
				}
			}
		}
	}
</script>

<style>
</style>
