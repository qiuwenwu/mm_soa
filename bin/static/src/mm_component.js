// 栏目
import bar_action from '/src/components/bar/bar_action.vue';
import bar_buy from '/src/components/bar/bar_buy.vue';
import bar_chat from '/src/components/bar/bar_chat.vue';
import bar_count from '/src/components/bar/bar_count.vue';
import bar_filter from '/src/components/bar/bar_filter.vue';
import bar_search from '/src/components/bar/bar_search.vue';
import bar_sort from '/src/components/bar/bar_sort.vue';
import bar_tab from '/src/components/bar/bar_tab.vue';
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


// 列表
import list_article from '/src/components/list/list_article.vue';
import list_base from '/src/components/list/list_base.vue';
import list_contact from '/src/components/list/list_contact.vue';
import list_goods from '/src/components/list/list_goods.vue';
import list_image from '/src/components/list/list_image.vue';
import list_media from '/src/components/list/list_media.vue';
import list_message from '/src/components/list/list_message.vue';
import list_music from '/src/components/list/list_music.vue';
import list_news from '/src/components/list/list_news.vue';
import list_question from '/src/components/list/list_question.vue';
import list_user from '/src/components/list/list_user.vue';
import list_video from '/src/components/list/list_video.vue';


// 轮播
import swiper_card from '/src/components/swiper/swiper_card.vue';
import swiper_image from '/src/components/swiper/swiper_image.vue';
import swiper_page from '/src/components/swiper/swiper_page.vue';
import swiper_text from '/src/components/swiper/swiper_text.vue';
import swiper_menu from '/src/components/swiper/swiper_menu.vue';

// 拓展
import expand_drag from '/src/components/expand/expand_drag.vue';
import expand_sptite from '/src/components/expand/expand_sptite.vue';

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
		Vue.component('bar_tab', bar_tab);

		// 列表项
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
		
		// 列表
		Vue.component('list_article', list_article);
		Vue.component('list_base', list_base);
		Vue.component('list_contact', list_contact);
		Vue.component('list_goods', list_goods);
		Vue.component('list_image', list_image);
		Vue.component('list_media', list_media);
		Vue.component('list_message', list_message);
		Vue.component('list_number', list_message);
		Vue.component('list_music', list_music);
		Vue.component('list_news', list_news);
		Vue.component('list_question', list_question);
		Vue.component('list_user', list_user);
		Vue.component('list_video', list_video);
		
		// 轮播
		Vue.component('swiper_card', swiper_card);
		Vue.component('swiper_image', swiper_image);
		Vue.component('swiper_page', swiper_page);
		Vue.component('swiper_text', swiper_text);
		Vue.component('swiper_menu', swiper_menu);
		
		// 拖拽
		Vue.component('expand_drag', expand_drag);
		Vue.component('expand_sptite', expand_sptite);
	}
}
