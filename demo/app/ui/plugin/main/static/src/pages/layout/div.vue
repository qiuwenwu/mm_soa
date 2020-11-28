<template>
	<mm_page id="page_div">
		<header>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">
					<mm_card url="/">
						<h3>
							<span>块</span>
							<span class="fr">&lt; 返回</span></router-link>
						</h3>
					</mm_card>
				</mm_col>
			</mm_row></mm_container></mm_warp>
		</header>
		<main>
			<mm_warp><mm_container><mm_row>
				<mm_col width="100">
					<mm_row class="center">
						<mm_col width="100">
							<h5>默认块</h5>
							<mm_card class="ba">
								<div class="head">块头</div>
								<div class="body">
									<p>&nbsp;</p>内容主体<p>&nbsp;</p>
								</div>
								<div class="foot">块脚</div>
							</mm_card>

							<mm_card class="card b-n">
								<div class="head">块头</div>
								<div class="body">
									<p>&nbsp;</p>内容主体<p>&nbsp;</p>
								</div>
								<div class="foot">块脚</div>
							</mm_card>
						</mm_col>
						<mm_col width="100">
							<h5>带圆角块</h5>
							<mm_card class="ba b-a">
								<div class="head">块头</div>
								<div class="body">
									<p>&nbsp;</p>内容主体<p>&nbsp;</p>
								</div>
								<div class="foot">块脚</div>
							</mm_card>
							<mm_card class="card">
								<div class="head">块头</div>
								<div class="body">
									<p>&nbsp;</p>内容主体<p>&nbsp;</p>
								</div>
								<div class="foot">块脚</div>
							</mm_card>
						</mm_col>
					</mm_row></mm_container></mm_warp>
				</mm_col>
			</mm_row></mm_container></mm_warp>
		</main>
	</mm_page>
</template>

<script>
</script>

<style>
	#page_div header,
	#page_div footer {
		background: #FDFDFD;
	}
</style>
