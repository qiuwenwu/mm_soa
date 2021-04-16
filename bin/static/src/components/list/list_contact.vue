<template>
	<div class="list_contact">
		<div class="item" :class="css" v-for="(o, k) in list" :key="k">
			<item_contact :viewmodel="vm" :obj="o"></item_contact>
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
							contact_id: 1,
							name: "姓名",
							avatar: "/img/avatar.png",
							phone: "15817188XXX"
						},
						{
							contact_id: 2,
							name: "姓名",
							avatar: "/img/avatar.png",
							phone: "15817188XXX"
						},
						{
							contact_id: 3,
							name: "姓名",
							avatar: "/img/avatar.png",
							phone: "15817188XXX"
						},
						{
							contact_id: 4,
							name: "姓名",
							avatar: "/img/avatar.png",
							phone: "15817188XXX"
						}
					]
				}
			}
		}
	}
</script>

<style>
</style>
