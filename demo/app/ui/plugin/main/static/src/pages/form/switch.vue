<template>
	<mm_page id="page_btn">
		<header>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">
					<mm_card url="/">
						<h3>
							<span>开关</span>
							<span class="fr">&lt; 返回</span></router-link>
						</h3>
					</mm_card>
				</mm_col>
			</mm_row></mm_container></mm_warp>
		</header>
		<main>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">
					<mm_card class="pc">
						<h5 @click="$copy(code_1)">样式一（PC）</h5>
						<mm_switch title="开关" v-model="value"></mm_switch>
					</mm_card>

					<mm_card class="pc">
						<h5 @click="$copy(code_2)">样式二（PC）</h5>
						<mm_switch title="开关" v-model="value" display="2"></mm_switch>
					</mm_card>

					<mm_card class="mobile">
						<h5 @click="$copy(code_3)">样式三（mobile）</h5>
						<mm_switch title="开关" v-model="value"></mm_switch>
					</mm_card>

					<mm_card class="mobile">
						<h5 @click="$copy(code_4)">样式四（mobile）</h5>
						<mm_switch title="开关" v-model="value" display="2"></mm_switch>
					</mm_card>
				</mm_col>
			</mm_row></mm_container></mm_warp>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">{{ value }}</mm_col>
			</mm_row></mm_container></mm_warp>
		</main>
	</mm_page>
</template>

<script>
	export default {
		data() {
			return {
				value: 1,
				code_1: `
<mm_card class="pc">
	<mm_switch title="开关" v-model="value"></mm_switch>
</mm_card>
`,
				code_2: `
<mm_card class="pc">
	<mm_switch title="开关" v-model="value" display="2"></mm_switch>
</mm_card>
`,
				code_3: `
<mm_card class="mobile">
	<mm_switch title="开关" v-model="value" display="2"></mm_switch>
</mm_card>
`,
				code_4: `
<mm_card class="mobile">
	<mm_switch title="开关" v-model="value" display="2"></mm_switch>
</mm_card>
`
			}
		}
	}
</script>

<style>
</style>
