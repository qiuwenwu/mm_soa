<template>
	<mm_page id="page_pre">
		<header>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">
					<mm_card url="/">
						<h3>
							<span>富文本编辑器</span>
							<span class="fr">&lt; 返回</span></router-link>
						</h3>
					</mm_card>
				</mm_col>
			</mm_row></mm_container></mm_warp>
		</header>
		<main>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">
					<mm_card>
						<mm_rich id="test" v-model="content"></mm_rich>
					</mm_card>
				</mm_col>

				<mm_col width="100">
					<h5>查看结果</h5>
					<mm_card v-html="content">
					</mm_card>
				</mm_col>
			</mm_row></mm_container></mm_warp>
		</main>
	</mm_page>
</template>

<script>
	import mm_rich from '/src/components/form/mm_rich.vue';

	export default {
		template: __template__,
		components: {
			mm_rich
		},
		data() {
			return {
				content: ""
			}
		}
	}
</script>

<style>
</style>
