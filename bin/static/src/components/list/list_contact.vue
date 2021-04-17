<template>
	<div class="list_contact" :class="cols">
		<item_contact v-for="(o, i) in list" :key="i" :viewmodel="vm" :obj="o"
			:class="css + (select === i ? ' active' : '')" @click.native="selected(i, o)"><slot></slot></item_contact>
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
