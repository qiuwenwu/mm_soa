<template>
	<mm_page id="page_grid">
		<header>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">
					<mm_card url="/">
						<h3>
							<span>栅格</span>
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
						<h5>常见栅格布局</h5>
						<mm_row class="center grid-x">
							<!-- 100% -->
							<mm_col width="100"><mm_card>100</mm_card></mm_col>

							<!-- 1:3 -->
							<mm_col width="25"><mm_card>25</mm_card></mm_col>
							<mm_col width="75"><mm_card>75</mm_card></mm_col>

							<!-- 1:1 -->
							<mm_col width="50"><mm_card>50</mm_card></mm_col>
							<mm_col width="50"><mm_card>50</mm_card></mm_col>

							<!-- 1:1:1:1 -->
							<mm_col width="25"><mm_card>25</mm_card></mm_col>
							<mm_col width="25"><mm_card>25</mm_card></mm_col>
							<mm_col width="25"><mm_card>25</mm_card></mm_col>
							<mm_col width="25"><mm_card>25</mm_card></mm_col>

							<!-- 1:4 -->
							<mm_col width="20"><mm_card>20</mm_card></mm_col>
							<mm_col width="80"><mm_card>80</mm_card></mm_col>

							<!-- 1:2:1 -->
							<mm_col width="25"><mm_card>25</mm_card></mm_col>
							<mm_col width="50"><mm_card>25</mm_card></mm_col>
							<mm_col width="25"><mm_card>25</mm_card></mm_col>

							<!-- 1:1:1 -->
							<mm_col width="33"><mm_card>33</mm_card></mm_col>
							<mm_col width="33"><mm_card>33</mm_card></mm_col>
							<mm_col width="33"><mm_card>33</mm_card></mm_col>

							<!-- 1:2 -->
							<mm_col width="33"><mm_card>33</mm_card></mm_col>
							<mm_col width="66"><mm_card>66</mm_card></mm_col>

							<!-- 1:1:1:1:1 -->
							<mm_col width="20"><mm_card>20</mm_card></mm_col>
							<mm_col width="20"><mm_card>20</mm_card></mm_col>
							<mm_col width="20"><mm_card>20</mm_card></mm_col>
							<mm_col width="20"><mm_card>20</mm_card></mm_col>
							<mm_col width="20"><mm_card>20</mm_card></mm_col>
						</mm_row></mm_container></mm_warp>
					</mm_card>
					<mm_card>
						<h5>通过父级改变列数 <mm_btn class="btn_info" @click.native="add()">{{ col }}列</mm_btn>
						</h5>
						<mm_row :col="col" class="center grid-x">
							<mm_col>
								<mm_card>1</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>2</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>3</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>4</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>5</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>6</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>7</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>8</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>9</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>10</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>11</mm_card>
							</mm_col>
							<mm_col>
								<mm_card>12</mm_card>
							</mm_col>
						</mm_row></mm_container></mm_warp>
					</mm_card>
					<mm_card>
						<h5>自适应列数 <mm_btn class="btn_info" @click.native="add_num()">{{ num }}列</mm_btn>
						</h5>
						<mm_row class="center grid-x mm_row-sm">
							<mm_col v-for="(o, idx) in num" :key="idx">
								<mm_card>{{ o }}</mm_card>
							</mm_col>
						</mm_row></mm_container></mm_warp>
					</mm_card>
					<mm_card>
						<h5>常见响应式列</h5>
						<mm_row col="1" class="center grid-x">
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>1</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>2</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>3</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>4</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>5</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>6</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>7</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>8</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>9</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>10</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>11</mm_card>
							</mm_col>
							<mm_col class="col-lg-2 col-md-3 col-sm-6">
								<mm_card>12</mm_card>
							</mm_col>
						</mm_row></mm_container></mm_warp>
					</mm_card>
				</mm_col>
			</mm_row></mm_container></mm_warp>
		</main>
	</mm_page>
</template>

<script>
	export default {
		data() {
			return {
				idx: 3,
				num: 1
			}
		},
		methods: {
			add() {
				var idx = this.idx + 1;
				if (idx > 8) {
					idx = 0;
				}
				this.idx = idx;
			},
			add_num() {
				this.num += 1;
				if (this.num > 12) {
					this.num = 1;
				}
			}
		},
		computed: {
			col() {
				var arr = [1, 2, 3, 4, 5, 6, 8, 10, 12];
				var n = this.idx;
				if (n >= arr.length) {
					n = arr.length;
				}
				return arr[n].toString();
			}
		}
	}
</script>

<style>
</style>
