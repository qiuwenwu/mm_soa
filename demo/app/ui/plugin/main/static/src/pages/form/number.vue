<template>
	<mm_page id="page_btn">
		<header>
			<mm_warp>
				<mm_container>
					<mm_row>
						<mm_col width="100">
							<mm_view url="/">
								<h3>
									<span>计数器</span>
									<span class="fr">&lt; 返回</span></router-link>
								</h3>
							</mm_view>
						</mm_col>
					</mm_row>
				</mm_container>
			</mm_warp>
		</header>
		<main>
			<mm_warp>
				<mm_container>
					<mm_row>
						<mm_col width="100">
							<mm_card class="pc">
								<h5 @click="$copy(code_1)">样式一</h5>
								<mm_number v-model="value" :min="min" :max="max" :num="num"></mm_number>
							</mm_card>

							<mm_card class="mobile">
								<h5 @click="$copy(code_2)">样式二</h5>
								<mm_number v-model="value" :min="min" :max="max" :num="num"></mm_number>
							</mm_card>

							<mm_card>
								{{ value }}
							</mm_card>
						</mm_col>
					</mm_row>
				</mm_container>
			</mm_warp>
		</main>
	</mm_page>
</template>

<script>
	export default {
		data() {
			return {
				value: 5,
				min: 5,
				max: 150,
				// 每次增减数
				num: 5,
				code_1: `
<mm_card class="pc">
<mm_number v-model="value" :min="min" :max="max" :num="num"></mm_number>
</mm_card>
`,
				code_2: `
<mm_card class="mobile">
<mm_number v-model="value" :min="min" :max="max" :num="num"></mm_number>
</mm_card>
`
			}
		}
	}
</script>

<style>
</style>
