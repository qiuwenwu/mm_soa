// 栏目
import bar_action from '/src/components/bar/bar_action.vue';
import bar_ad from '/src/components/bar/bar_ad.vue';
import bar_buy from '/src/components/bar/bar_buy.vue';
import bar_chat from '/src/components/bar/bar_chat.vue';
import bar_count from '/src/components/bar/bar_count.vue';
import bar_filter from '/src/components/bar/bar_filter.vue';
import bar_menu from '/src/components/bar/bar_menu.vue';
import bar_search from '/src/components/bar/bar_search.vue';
import bar_sort from '/src/components/bar/bar_sort.vue';
import bar_tab from '/src/components/bar/bar_tab.vue';
import bar_title from '/src/components/bar/bar_title.vue';
import bar_tool from '/src/components/bar/bar_tool.vue';
import bar_user from '/src/components/bar/bar_user.vue';


// 列表项
import item_address from '/src/components/item/item_address.vue';
import item_analyse from '/src/components/item/item_analyse.vue';
import item_article from '/src/components/item/item_article.vue';
import item_audio from '/src/components/item/item_audio.vue';
import item_base from '/src/components/item/item_base.vue';
import item_chat from '/src/components/item/item_chat.vue';
import item_comment from '/src/components/item/item_comment.vue';
import item_contact from '/src/components/item/item_contact.vue';
import item_count from '/src/components/item/item_count.vue';
import item_date from '/src/components/item/item_date.vue';
import item_forum from '/src/components/item/item_forum.vue';
import item_goods from '/src/components/item/item_goods.vue';
import item_image from '/src/components/item/item_image.vue';
import item_media from '/src/components/item/item_media.vue';
import item_message from '/src/components/item/item_message.vue';
import item_music from '/src/components/item/item_music.vue';
import item_news from '/src/components/item/item_news.vue';
import item_number from '/src/components/item/item_number.vue';
import item_order from '/src/components/item/item_order.vue';
import item_question from '/src/components/item/item_question.vue';
import item_recommend from '/src/components/item/item_recommend.vue';
import item_reply from '/src/components/item/item_reply.vue';
import item_tag from '/src/components/item/item_tag.vue';
import item_text from '/src/components/item/item_text.vue';
import item_thread from '/src/components/item/item_thread.vue';
import item_trend from '/src/components/item/item_trend.vue';
import item_type from '/src/components/item/item_type.vue';
import item_user from '/src/components/item/item_user.vue';
import item_video from '/src/components/item/item_video.vue';

// 列表
import list_address from '/src/components/list/list_address.vue';
import list_analyse from '/src/components/list/list_analyse.vue';
import list_article from '/src/components/list/list_article.vue';
import list_audio from '/src/components/list/list_audio.vue';
import list_base from '/src/components/list/list_base.vue';
import list_chat from '/src/components/list/list_chat.vue';
import list_comment from '/src/components/list/list_comment.vue';
import list_contact from '/src/components/list/list_contact.vue';
import list_count from '/src/components/list/list_count.vue';
import list_date from '/src/components/list/list_date.vue';
import list_forum from '/src/components/list/list_forum.vue';
import list_goods from '/src/components/list/list_goods.vue';
import list_image from '/src/components/list/list_image.vue';
import list_media from '/src/components/list/list_media.vue';
import list_message from '/src/components/list/list_message.vue';
import list_music from '/src/components/list/list_music.vue';
import list_news from '/src/components/list/list_news.vue';
import list_number from '/src/components/list/list_number.vue';
import list_order from '/src/components/list/list_order.vue';
import list_question from '/src/components/list/list_question.vue';
import list_recommend from '/src/components/list/list_recommend.vue';
import list_reply from '/src/components/list/list_reply.vue';
import list_tag from '/src/components/list/list_tag.vue';
import list_text from '/src/components/list/list_text.vue';
import list_thread from '/src/components/list/list_thread.vue';
import list_trend from '/src/components/list/list_trend.vue';
import list_type from '/src/components/list/list_type.vue';
import list_user from '/src/components/list/list_user.vue';
import list_video from '/src/components/list/list_video.vue';

// 导航
import nav_bottom from '/src/components/nav/nav_bottom.vue';
import nav_main from '/src/components/nav/nav_main.vue';
import nav_path from '/src/components/nav/nav_path.vue';
import nav_quick from '/src/components/nav/nav_quick.vue';
import nav_side from '/src/components/nav/nav_side.vue';
import nav_top from '/src/components/nav/nav_top.vue';
import nav_user from '/src/components/nav/nav_user.vue';

// 轮播
import swiper_card from '/src/components/swiper/swiper_card.vue';
import swiper_rotate_card from '/src/components/swiper/swiper_rotate_card.vue';
import swiper_image from '/src/components/swiper/swiper_image.vue';
import swiper_menu from '/src/components/swiper/swiper_menu.vue';
import swiper_page from '/src/components/swiper/swiper_page.vue';
import swiper_vertical_page from '/src/components/swiper/swiper_vertical_page.vue';
import swiper_text from '/src/components/swiper/swiper_text.vue';

// 表格
import table_coin from '/src/components/table/table_coin.vue';
import table_stock from '/src/components/table/table_stock.vue';

// 图表
import chart_bar from '/src/components/chart/chart_bar.vue';
import chart_depth from '/src/components/chart/chart_depth.vue';
import chart_k from '/src/components/chart/chart_k.vue';
import chart_line from '/src/components/chart/chart_line.vue';
import chart_panel from '/src/components/chart/chart_panel.vue';
import chart_pie from '/src/components/chart/chart_pie.vue';

// 拓展
import expand_drag from '/src/components/expand/expand_drag.vue';
import expand_pay from '/src/components/expand/expand_pay.vue';
import expand_pre from '/src/components/expand/expand_pre.vue';
import expand_qrcode from '/src/components/expand/expand_qrcode.vue';
import expand_sptite from '/src/components/expand/expand_sptite.vue';

/* === 创建全局组件 === */
export default {
	install(Vue, options) {
		
		// 栏目组件
		Vue.component('bar_action', bar_action);
		Vue.component('bar_ad', bar_ad);
		Vue.component('bar_buy', bar_buy);
		Vue.component('bar_chat', bar_chat);
		Vue.component('bar_count', bar_count);
		Vue.component('bar_filter', bar_filter);
		Vue.component('bar_menu', bar_menu);
		Vue.component('bar_search', bar_search);
		Vue.component('bar_sort', bar_sort);
		Vue.component('bar_tab', bar_tab);
		Vue.component('bar_title', bar_title);
		Vue.component('bar_tool', bar_tool);
		Vue.component('bar_user', bar_user);

		// 列表项
		Vue.component('item_address', item_address);
		Vue.component('item_analyse', item_analyse);
		Vue.component('item_article', item_article);
		Vue.component('item_audio', item_audio);
		Vue.component('item_base', item_base);
		Vue.component('item_chat', item_chat);
		Vue.component('item_comment', item_comment);
		Vue.component('item_contact', item_contact);
		Vue.component('item_count', item_count);
		Vue.component('item_date', item_date);
		Vue.component('item_forum', item_forum);
		Vue.component('item_goods', item_goods);
		Vue.component('item_image', item_image);
		Vue.component('item_media', item_media);
		Vue.component('item_message', item_message);
		Vue.component('item_music', item_music);
		Vue.component('item_news', item_news);
		Vue.component('item_number', item_number);
		Vue.component('item_order', item_order);
		Vue.component('item_question', item_question);
		Vue.component('item_recommend', item_recommend);
		Vue.component('item_reply', item_reply);
		Vue.component('item_tag', item_tag);
		Vue.component('item_text', item_text);
		Vue.component('item_thread', item_thread);
		Vue.component('item_trend', item_trend);
		Vue.component('item_type', item_type);
		Vue.component('item_user', item_user);
		Vue.component('item_video', item_video);

		// 列表
		Vue.component('list_address', list_address);
		Vue.component('list_analyse', list_analyse);
		Vue.component('list_article', list_article);
		Vue.component('list_audio', list_audio);
		Vue.component('list_base', list_base);
		Vue.component('list_chat', list_chat);
		Vue.component('list_comment', list_comment);
		Vue.component('list_contact', list_contact);
		Vue.component('list_count', list_count);
		Vue.component('list_date', list_date);
		Vue.component('list_forum', list_forum);
		Vue.component('list_goods', list_goods);
		Vue.component('list_image', list_image);
		Vue.component('list_media', list_media);
		Vue.component('list_message', list_message);
		Vue.component('list_music', list_music);
		Vue.component('list_news', list_news);
		Vue.component('list_number', list_number);
		Vue.component('list_order', list_order);
		Vue.component('list_question', list_question);
		Vue.component('list_recommend', list_recommend);
		Vue.component('list_reply', list_reply);
		Vue.component('list_tag', list_tag);
		Vue.component('list_text', list_text);
		Vue.component('list_thread', list_thread);
		Vue.component('list_trend', list_trend);
		Vue.component('list_type', list_type);
		Vue.component('list_user', list_user);
		Vue.component('list_video', list_video);

		// 导航
		Vue.component('nav_bottom', nav_bottom);
		Vue.component('nav_main', nav_main);
		Vue.component('nav_path', nav_path);
		Vue.component('nav_quick', nav_quick);
		Vue.component('nav_side', nav_side);
		Vue.component('nav_top', nav_top);
		Vue.component('nav_user', nav_user);

		// 轮播
		Vue.component('swiper_card', swiper_card);
		Vue.component('swiper_rotate_card', swiper_rotate_card);
		Vue.component('swiper_image', swiper_image);
		Vue.component('swiper_menu', swiper_menu);
		Vue.component('swiper_page', swiper_page);
		Vue.component('swiper_vertical_page', swiper_vertical_page);
		Vue.component('swiper_text', swiper_text);

		// 拓展
		Vue.component('expand_drag', expand_drag);
		Vue.component('expand_pay', expand_pay);
		Vue.component('expand_pre', expand_pre);
		Vue.component('expand_qrcode', expand_qrcode);
		Vue.component('expand_sptite', expand_sptite);
		
		// 图表
		Vue.component('chart_bar', chart_bar);
		Vue.component('chart_depth', chart_depth);
		Vue.component('chart_k', chart_k);
		Vue.component('chart_line', chart_line);
		Vue.component('chart_panel', chart_panel);
		Vue.component('chart_pie', chart_pie);
		
		/**
		 * 转换时间
		 * @param {String} timeStr 时间字符串
		 * @param {String} format 转换格式
		 * @return {String} 返回转换后的结果
		 */
		Vue.prototype.$to_time = function(timeStr, format){
			var time = timeStr.toTime();
			if(format){
				return time.toStr(format);
			}
			else {
				var date = time.toStr("yyyy-MM-dd");
				var now = new Date();
				if(date == now.toStr("yyyy-MM-dd")){
					return time.toStr("hh:mm")
				}
				else if(date == now.addDays(-1).toStr("yyyy-MM-dd")){
					return "昨天" + time.toStr("hh:mm")
				}
				else if(time.toStr("yyyy") == now.toStr("yyyy")){
					return time.toStr("MM-dd");
				}
				else {
					return date;
				}
			}
		}
	}
}
