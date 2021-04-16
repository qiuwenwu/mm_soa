<template>
	<div class="list_goods">
		<div class="item" :class="css" v-for="(o, k) in list" :key="k">
			<item_goods :viewmodel="vm" :obj="o"></item_goods>
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
