<template>
	<mm_page id="page_icon">
		<header>
			<mm_warp>
				<mm_container>
					<mm_row>
						<mm_col width="100">
							<mm_view url="/">
								<h3>
									<span>图标</span>
									<span class="fr">&lt; 返回</span>
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
							<mm_card>
								<div class="card_head">字体图标</div>
								<div class="card_body">
									<mm_icon src="<i class='fa fa-user'></i>"></mm_icon>
								</div>
							</mm_card>

							<mm_card>
								<div class="card_head">字体图标（镂空）</div>
								<div class="card_body">
									<mm_icon src="<i class='fa fa-user stroke'></i>"></mm_icon>
								</div>
							</mm_card>

							<mm_card>
								<div class="card_head">图片图标</div>
								<div class="card_body">
									<mm_icon src="/img/logo.png"></mm_icon>
								</div>
							</mm_card>
						</mm_col>
					</mm_row>
				</mm_container>
			</mm_warp>
		</main>
	</mm_page>
</template>

<script>
</script>

<style>
	#page_icon .mm_icon {
		font-size: 4rem;
	}
</style>
