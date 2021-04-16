// 栏目
import bar_action from '/src/components/bar/bar_action.vue';
import bar_buy from '/src/components/bar/bar_buy.vue';
import bar_chat from '/src/components/bar/bar_chat.vue';
import bar_count from '/src/components/bar/bar_count.vue';
import bar_filter from '/src/components/bar/bar_filter.vue';
import bar_search from '/src/components/bar/bar_search.vue';
import bar_sort from '/src/components/bar/bar_sort.vue';
import bar_tag from '/src/components/bar/bar_tag.vue';
import bar_title from '/src/components/bar/bar_title.vue';

// 列表项
import item_article from '/src/components/item/item_article.vue';
import item_base from '/src/components/item/item_base.vue';
import item_contact from '/src/components/item/item_contact.vue';
import item_goods from '/src/components/item/item_goods.vue';
import item_image from '/src/components/item/item_image.vue';
import item_media from '/src/components/item/item_media.vue';
import item_message from '/src/components/item/item_message.vue';
import item_music from '/src/components/item/item_music.vue';
import item_news from '/src/components/item/item_news.vue';
import item_question from '/src/components/item/item_question.vue';
import item_user from '/src/components/item/item_user.vue';
import item_video from '/src/components/item/item_video.vue';

// 轮播
import swiper_card from '/src/components/swiper/swiper_card.vue';
import swiper_image from '/src/components/swiper/swiper_image.vue';
import swiper_page from '/src/components/swiper/swiper_page.vue';
import swiper_text from '/src/components/swiper/swiper_text.vue';
import swiper_menu from '/src/components/swiper/swiper_menu.vue';

// 拓展
import mm_drag from '/src/components/expand/mm_drag.vue';
import mm_sptite from '/src/components/expand/mm_sptite.vue';

/* === 创建全局组件 === */
export default {
	install(Vue, options) {

		// 栏目组件
		Vue.component('bar_action', bar_action);
		Vue.component('bar_buy', bar_buy);
		Vue.component('bar_chat', bar_chat);
		Vue.component('bar_count', bar_count);
		Vue.component('bar_filter', bar_filter);
		Vue.component('bar_search', bar_search);
		Vue.component('bar_sort', bar_sort);
		Vue.component('bar_title', bar_title);
		Vue.component('bar_tag', bar_tag);

		// 项目
		Vue.component('item_article', item_article);
		Vue.component('item_base', item_base);
		Vue.component('item_contact', item_contact);
		Vue.component('item_goods', item_goods);
		Vue.component('item_image', item_image);
		Vue.component('item_media', item_media);
		Vue.component('item_message', item_message);
		Vue.component('item_number', item_message);
		Vue.component('item_music', item_music);
		Vue.component('item_news', item_news);
		Vue.component('item_question', item_question);
		Vue.component('item_user', item_user);
		Vue.component('item_video', item_video);

		// 轮播
		Vue.component('swiper_card', swiper_card);
		Vue.component('swiper_image', swiper_image);
		Vue.component('swiper_page', swiper_page);
		Vue.component('swiper_text', swiper_text);
		Vue.component('swiper_menu', swiper_menu);
		
		// 拖拽
		Vue.component('mm_drag', mm_drag);
		Vue.component('mm_sptite', mm_sptite);
	}
}
