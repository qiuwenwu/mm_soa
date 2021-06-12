"use strict";

function import_picker($) {
	"use strict";
	var Picker = function(params) {
		var p = this;
		var defaults = {
			updateValuesOnMomentum: false,
			updateValuesOnTouchmove: true,
			rotateEffect: false,
			momentumRatio: 7,
			freeMode: false,
			// Common settings
			scrollToInput: true,
			inputReadOnly: true,
			toolbar: true,
			toolbarCloseText: '确定',
			toolbarTemplate: '<header class="bar bar-nav">\
                <nav>\
				<div class="fr">\
				<button class="btn btn-link pull-right close-picker">确定</button>\
                </div>\
				<div class="fm">请选择</div>\
				</nav>\
                </header>',
		};
		params = params || {};
		for (var def in defaults) {
			if (typeof params[def] === 'undefined') {
				params[def] = defaults[def];
			}
		}
		p.params = params;
		p.cols = [];
		p.initialized = false;

		// Inline flag
		p.inline = p.params.container ? true : false;

		// 3D Transforms origin bug, only on safari
		var originBug = $.device.ios || (navigator.userAgent.toLowerCase().indexOf('safari') >= 0 && navigator
			.userAgent.toLowerCase()
			.indexOf('chrome') < 0) && !$.device.android;

		// Value
		p.setValue = function(arrValues, transition) {
			var valueIndex = 0;
			for (var i = 0; i < p.cols.length; i++) {
				if (p.cols[i] && !p.cols[i].divider) {
					p.cols[i].setValue(arrValues[valueIndex], transition);
					valueIndex++;
				}
			}
		};
		p.updateValue = function() {
			var newValue = [];
			var newDisplayValue = [];
			for (var i = 0; i < p.cols.length; i++) {
				if (!p.cols[i].divider) {
					newValue.push(p.cols[i].value);
					newDisplayValue.push(p.cols[i].displayValue);
				}
			}
			if (newValue.indexOf(undefined) >= 0) {
				return;
			}
			p.value = newValue;
			p.displayValue = newDisplayValue;
			if (p.params.onChange) {
				p.params.onChange(p, p.value, p.displayValue);
			}
			if (p.input && p.input.length > 0) {
				$(p.input).val(p.params.formatValue ? p.params.formatValue(p, p.value, p.displayValue) : p.value
					.join(' '));
				$(p.input).trigger('change');
			}
		};

		// Columns Handlers
		p.initPickerCol = function(colElement, updateItems) {
			var colContainer = $(colElement);
			var colIndex = colContainer.index();
			var col = p.cols[colIndex];
			if (col.divider) return;
			col.container = colContainer;
			col.wrapper = col.container.find('.picker-items-col-wrapper');
			col.items = col.wrapper.find('.picker-item');

			var i, j;
			var wrapperHeight, itemHeight, itemsHeight, minTranslate, maxTranslate;
			col.replaceValues = function(values, displayValues) {
				col.destroyEvents();
				col.values = values;
				col.displayValues = displayValues;
				var newItemsHTML = p.columnHTML(col, true);
				col.wrapper.html(newItemsHTML);
				col.items = col.wrapper.find('.picker-item');
				col.calcSize();
				col.setValue(col.values[0], 0, true);
				col.initEvents();
			};
			col.calcSize = function() {
				if (p.params.rotateEffect) {
					col.container.removeClass('picker-items-col-absolute');
					if (!col.width) col.container.css({
						width: ''
					});
				}
				var colWidth, colHeight;
				colWidth = 0;
				colHeight = col.container[0].offsetHeight;
				wrapperHeight = col.wrapper[0].offsetHeight;
				itemHeight = col.items[0].offsetHeight;
				itemsHeight = itemHeight * col.items.length;
				minTranslate = colHeight / 2 - itemsHeight + itemHeight / 2;
				maxTranslate = colHeight / 2 - itemHeight / 2;
				if (col.width) {
					colWidth = col.width;
					if (parseInt(colWidth, 10) === colWidth) colWidth = colWidth + 'px';
					col.container.css({
						width: colWidth
					});
				}
				if (p.params.rotateEffect) {
					if (!col.width) {
						col.items.each(function() {
							var item = $(this);
							item.css({
								width: 'auto'
							});
							colWidth = Math.max(colWidth, item[0].offsetWidth);
							item.css({
								width: ''
							});
						});
						col.container.css({
							width: (colWidth + 2) + 'px'
						});
					}
					col.container.addClass('picker-items-col-absolute');
				}
			};
			col.calcSize();

			col.wrapper.transform('translate3d(0,' + maxTranslate + 'px,0)').transition(0);


			var activeIndex = 0;
			var animationFrameId;

			// Set Value Function
			col.setValue = function(newValue, transition, valueCallbacks) {
				if (typeof transition === 'undefined') transition = '';
				var newActiveIndex = col.wrapper.find('.picker-item[data-picker-value="' + newValue + '"]')
					.index();
				if (typeof newActiveIndex === 'undefined' || newActiveIndex === -1) {
					return;
				}
				var newTranslate = -newActiveIndex * itemHeight + maxTranslate;
				// Update wrapper
				col.wrapper.transition(transition);
				col.wrapper.transform('translate3d(0,' + (newTranslate) + 'px,0)');

				// Watch items
				if (p.params.updateValuesOnMomentum && col.activeIndex && col.activeIndex !==
					newActiveIndex) {
					$.cancelAnimationFrame(animationFrameId);
					col.wrapper.transitionEnd(function() {
						$.cancelAnimationFrame(animationFrameId);
					});
					updateDuringScroll();
				}

				// Update items
				col.updateItems(newActiveIndex, newTranslate, transition, valueCallbacks);
			};

			col.updateItems = function(activeIndex, translate, transition, valueCallbacks) {
				if (typeof translate === 'undefined') {
					translate = $.getTranslate(col.wrapper[0], 'y');
				}
				if (typeof activeIndex === 'undefined') activeIndex = -Math.round((translate -
					maxTranslate) / itemHeight);
				if (activeIndex < 0) activeIndex = 0;
				if (activeIndex >= col.items.length) activeIndex = col.items.length - 1;
				var previousActiveIndex = col.activeIndex;
				col.activeIndex = activeIndex;
				/*
				   col.wrapper.find('.picker-selected, .picker-after-selected, .picker-before-selected').removeClass('picker-selected picker-after-selected picker-before-selected');

				   col.items.transition(transition);
				   var selectedItem = col.items.eq(activeIndex).addClass('picker-selected').transform('');
				   var prevItems = selectedItem.prevAll().addClass('picker-before-selected');
				   var nextItems = selectedItem.nextAll().addClass('picker-after-selected');
				   */
				//去掉 .picker-after-selected, .picker-before-selected 以提高性能
				col.wrapper.find('.picker-selected').removeClass('picker-selected');
				if (p.params.rotateEffect) {
					col.items.transition(transition);
				}
				var selectedItem = col.items.eq(activeIndex).addClass('picker-selected').transform('');

				if (valueCallbacks || typeof valueCallbacks === 'undefined') {
					// Update values
					col.value = selectedItem.attr('data-picker-value');
					col.displayValue = col.displayValues ? col.displayValues[activeIndex] : col.value;
					// On change callback
					if (previousActiveIndex !== activeIndex) {
						if (col.onChange) {
							col.onChange(p, col.value, col.displayValue);
						}
						p.updateValue();
					}
				}

				// Set 3D rotate effect
				if (!p.params.rotateEffect) {
					return;
				}
				var percentage = (translate - (Math.floor((translate - maxTranslate) / itemHeight) *
						itemHeight + maxTranslate)) /
					itemHeight;

				col.items.each(function() {
					var item = $(this);
					var itemOffsetTop = item.index() * itemHeight;
					var translateOffset = maxTranslate - translate;
					var itemOffset = itemOffsetTop - translateOffset;
					var percentage = itemOffset / itemHeight;

					var itemsFit = Math.ceil(col.height / itemHeight / 2) + 1;

					var angle = (-18 * percentage);
					if (angle > 180) angle = 180;
					if (angle < -180) angle = -180;
					// Far class
					if (Math.abs(percentage) > itemsFit) item.addClass('picker-item-far');
					else item.removeClass('picker-item-far');
					// Set transform
					item.transform('translate3d(0, ' + (-translate + maxTranslate) + 'px, ' + (
							originBug ? -110 : 0) +
						'px) rotateX(' + angle + 'deg)');
				});
			};

			function updateDuringScroll() {
				animationFrameId = $.requestAnimationFrame(function() {
					col.updateItems(undefined, undefined, 0);
					updateDuringScroll();
				});
			}

			// Update items on init
			if (updateItems) col.updateItems(0, maxTranslate, 0);

			var allowItemClick = true;
			var isTouched, isMoved, touchStartY, touchCurrentY, touchStartTime, touchEndTime, startTranslate,
				returnTo,
				currentTranslate, prevTranslate, velocityTranslate, velocityTime;

			function handleTouchStart(e) {
				if (isMoved || isTouched) return;
				e.preventDefault();
				isTouched = true;
				touchStartY = touchCurrentY = e.type === 'touchstart' ? e.targetTouches[0].pageY : e.pageY;
				touchStartTime = (new Date()).getTime();

				allowItemClick = true;
				startTranslate = currentTranslate = $.getTranslate(col.wrapper[0], 'y');
			}

			function handleTouchMove(e) {
				if (!isTouched) return;
				e.preventDefault();
				allowItemClick = false;
				touchCurrentY = e.type === 'touchmove' ? e.targetTouches[0].pageY : e.pageY;
				if (!isMoved) {
					// First move
					$.cancelAnimationFrame(animationFrameId);
					isMoved = true;
					startTranslate = currentTranslate = $.getTranslate(col.wrapper[0], 'y');
					col.wrapper.transition(0);
				}
				e.preventDefault();

				var diff = touchCurrentY - touchStartY;
				currentTranslate = startTranslate + diff;
				returnTo = undefined;

				// Normalize translate
				if (currentTranslate < minTranslate) {
					currentTranslate = minTranslate - Math.pow(minTranslate - currentTranslate, 0.8);
					returnTo = 'min';
				}
				if (currentTranslate > maxTranslate) {
					currentTranslate = maxTranslate + Math.pow(currentTranslate - maxTranslate, 0.8);
					returnTo = 'max';
				}
				// Transform wrapper
				col.wrapper.transform('translate3d(0,' + currentTranslate + 'px,0)');

				// Update items
				col.updateItems(undefined, currentTranslate, 0, p.params.updateValuesOnTouchmove);

				// Calc velocity
				velocityTranslate = currentTranslate - prevTranslate || currentTranslate;
				velocityTime = (new Date()).getTime();
				prevTranslate = currentTranslate;
			}

			function handleTouchEnd(e) {
				if (!isTouched || !isMoved) {
					isTouched = isMoved = false;
					return;
				}
				isTouched = isMoved = false;
				col.wrapper.transition('');
				if (returnTo) {
					if (returnTo === 'min') {
						col.wrapper.transform('translate3d(0,' + minTranslate + 'px,0)');
					} else col.wrapper.transform('translate3d(0,' + maxTranslate + 'px,0)');
				}
				touchEndTime = new Date().getTime();
				var velocity, newTranslate;
				if (touchEndTime - touchStartTime > 300) {
					newTranslate = currentTranslate;
				} else {
					velocity = Math.abs(velocityTranslate / (touchEndTime - velocityTime));
					newTranslate = currentTranslate + velocityTranslate * p.params.momentumRatio;
				}

				newTranslate = Math.max(Math.min(newTranslate, maxTranslate), minTranslate);

				// Active Index
				var activeIndex = -Math.floor((newTranslate - maxTranslate) / itemHeight);

				// Normalize translate
				if (!p.params.freeMode) newTranslate = -activeIndex * itemHeight + maxTranslate;

				// Transform wrapper
				col.wrapper.transform('translate3d(0,' + (parseInt(newTranslate, 10)) + 'px,0)');

				// Update items
				col.updateItems(activeIndex, newTranslate, '', true);

				// Watch items
				if (p.params.updateValuesOnMomentum) {
					updateDuringScroll();
					col.wrapper.transitionEnd(function() {
						$.cancelAnimationFrame(animationFrameId);
					});
				}

				// Allow click
				setTimeout(function() {
					allowItemClick = true;
				}, 100);
			}

			function handleClick(e) {
				if (!allowItemClick) return;
				$.cancelAnimationFrame(animationFrameId);
				/*jshint validthis:true */
				var value = $(this).attr('data-picker-value');
				col.setValue(value);
			}

			col.initEvents = function(detach) {
				var method = detach ? 'off' : 'on';
				col.container[method]($.touchEvents.start, handleTouchStart);
				col.container[method]($.touchEvents.move, handleTouchMove);
				col.container[method]($.touchEvents.end, handleTouchEnd);
				col.items[method]('click', handleClick);
			};
			col.destroyEvents = function() {
				col.initEvents(true);
			};

			col.container[0].f7DestroyPickerCol = function() {
				col.destroyEvents();
			};

			col.initEvents();

		};
		p.destroyPickerCol = function(colContainer) {
			colContainer = $(colContainer);
			if ('f7DestroyPickerCol' in colContainer[0]) colContainer[0].f7DestroyPickerCol();
		};
		// Resize cols
		function resizeCols() {
			if (!p.opened) return;
			for (var i = 0; i < p.cols.length; i++) {
				if (!p.cols[i].divider) {
					p.cols[i].calcSize();
					p.cols[i].setValue(p.cols[i].value, 0, false);
				}
			}
		}
		$(window).on('resize', resizeCols);

		// HTML Layout
		p.columnHTML = function(col, onlyItems) {
			var columnItemsHTML = '';
			var columnHTML = '';
			if (col.divider) {
				columnHTML += '<div class="picker-items-col picker-items-col-divider ' + (col.textAlign ?
					'picker-items-col-' +
					col.textAlign : '') + ' ' + (col.cssClass || '') + '">' + col.content + '</div>';
			} else {
				for (var j = 0; j < col.values.length; j++) {
					columnItemsHTML += '<div class="picker-item" data-picker-value="' + col.values[j] + '">' + (
						col.displayValues ?
						col.displayValues[j] : col.values[j]) + '</div>';
				}

				columnHTML += '<div class="picker-items-col ' + (col.textAlign ? 'picker-items-col-' + col
						.textAlign : '') + ' ' +
					(col.cssClass || '') + '"><div class="picker-items-col-wrapper">' + columnItemsHTML +
					'</div></div>';
			}
			return onlyItems ? columnItemsHTML : columnHTML;
		};
		p.layout = function() {
			var pickerHTML = '';
			var pickerClass = '';
			var i;
			p.cols = [];
			var colsHTML = '';
			for (i = 0; i < p.params.cols.length; i++) {
				var col = p.params.cols[i];
				colsHTML += p.columnHTML(p.params.cols[i]);
				p.cols.push(col);
			}
			pickerClass = 'picker-modal picker-columns ' + (p.params.cssClass || '') + (p.params.rotateEffect ?
				' picker-3d' :
				'');
			pickerHTML =
				'<div class="' + (pickerClass) + '">' +
				(p.params.toolbar ? p.params.toolbarTemplate.replace(/{{closeText}}/g, p.params
					.toolbarCloseText) : '') +
				'<div class="picker-modal-inner picker-items">' +
				colsHTML +
				'<div class="picker-center-highlight"></div>' +
				'</div>' +
				'</div>';

			p.pickerHTML = pickerHTML;
		};

		// Input Events
		function openOnInput(e) {
			e.preventDefault();
			// 安卓微信webviewreadonly的input依然弹出软键盘问题修复
			if ($.device.isWeixin && $.device.android && p.params.inputReadOnly) {
				/*jshint validthis:true */
				this.focus();
				this.blur();
			}
			if (p.opened) return;
			p.open();
			if (p.params.scrollToInput) {
				var pageContent = p.input.parents('.content');
				if (pageContent.length === 0) return;

				var paddingTop = parseInt(pageContent.css('padding-top'), 10),
					paddingBottom = parseInt(pageContent.css('padding-bottom'), 10),
					pageHeight = pageContent[0].offsetHeight - paddingTop - p.container.height(),
					pageScrollHeight = pageContent[0].scrollHeight - paddingTop - p.container.height(),
					newPaddingBottom;
				var inputTop = p.input.offset().top - paddingTop + p.input[0].offsetHeight;
				if (inputTop > pageHeight) {
					var scrollTop = pageContent.scrollTop() + inputTop - pageHeight;
					if (scrollTop + pageHeight > pageScrollHeight) {
						newPaddingBottom = scrollTop + pageHeight - pageScrollHeight + paddingBottom;
						if (pageHeight === pageScrollHeight) {
							newPaddingBottom = p.container.height();
						}
						pageContent.css({
							'padding-bottom': (newPaddingBottom) + 'px'
						});
					}
					pageContent.scrollTop(scrollTop, 300);
				}
			}
		}

		function closeOnHTMLClick(e) {
			if (!p.opened) return;
			if (p.input && p.input.length > 0) {
				if (e.target !== p.input[0] && $(e.target).parents('.picker-modal').length === 0) p.close();
			} else {
				if ($(e.target).parents('.picker-modal').length === 0) p.close();
			}
		}

		if (p.params.input) {
			p.input = $(p.params.input);
			if (p.input.length > 0) {
				if (p.params.inputReadOnly) p.input.prop('readOnly', true);
				if (!p.inline) {
					p.input.on('click', openOnInput);
				}
			}
		}

		if (!p.inline) $('html').on('click', closeOnHTMLClick);

		// Open
		function onPickerClose() {
			p.opened = false;
			if (p.input && p.input.length > 0) p.input.parents('.content').css({
				'padding-bottom': ''
			});
			if (p.params.onClose) p.params.onClose(p);

			// Destroy events
			p.container.find('.picker-items-col').each(function() {
				p.destroyPickerCol(this);
			});
		}

		p.opened = false;
		p.open = function() {
			if (!p.opened) {

				// Layout
				p.layout();

				// Append
				if (p.inline) {
					p.container = $(p.pickerHTML);
					p.container.addClass('picker-modal-inline');
					$(p.params.container).append(p.container);
					p.opened = true;
				} else {
					p.container = $($.pickerModal(p.pickerHTML));
					$(p.container)
						.one('opened', function() {
							p.opened = true;
						})
						.on('close', function() {
							onPickerClose();
						});
				}

				// Store picker instance
				p.container[0].f7Picker = p;

				// Init Events
				p.container.find('.picker-items-col').each(function() {
					var updateItems = true;
					if ((!p.initialized && p.params.value) || (p.initialized && p.value)) updateItems =
						false;
					p.initPickerCol(this, updateItems);
				});

				// Set value
				if (!p.initialized) {
					if (p.params.value) {
						p.setValue(p.params.value, 0);
					}
				} else {
					if (p.value) p.setValue(p.value, 0);
				}
			}

			// Set flag
			p.initialized = true;

			if (p.params.onOpen) p.params.onOpen(p);
		};

		// Close
		p.close = function() {
			if (!p.opened || p.inline) return;
			$.closeModal(p.container);
			return;
		};

		// Destroy
		p.destroy = function() {
			p.close();
			if (p.params.input && p.input.length > 0) {
				p.input.off('click', openOnInput);
			}
			$('html').off('click', closeOnHTMLClick);
			$(window).off('resize', resizeCols);
		};

		if (p.inline) {
			p.open();
		}

		return p;
	};

	$(document).on("click", ".close-picker", function() {
		var pickerToClose = $('.picker-modal.modal-in');
		$.closeModal(pickerToClose);
	});

	$.fn.picker = function(params) {
		var args = arguments;
		return this.each(function() {
			if (!this) return;
			var $this = $(this);

			var picker = $this.data("picker");
			if (!picker) {
				var p = $.extend({
					input: this,
					value: $this.val() ? $this.val().split(' ') : ''
				}, params);
				picker = new Picker(p);
				$this.data("picker", picker);
			}
			if (typeof params === typeof "a") {
				picker[params].apply(picker, Array.prototype.slice.call(args, 1));
			}
		});
	};
};

function import_datetimePicker($) {
	"use strict";

	var today = new Date();

	var getDays = function(max) {
		var days = [];
		for (var i = 1; i <= (max || 31); i++) {
			days.push(i < 10 ? "0" + i : i);
		}
		return days;
	};

	var getDaysByMonthAndYear = function(month, year) {
		var int_d = new Date(year, parseInt(month) + 1 - 1, 1);
		var d = new Date(int_d - 1);
		return getDays(d.getDate());
	};

	var formatNumber = function(n) {
		return n < 10 ? "0" + n : n;
	};

	var initMonthes = ('01 02 03 04 05 06 07 08 09 10 11 12').split(' ');

	var initYears = (function() {
		var arr = [];
		for (var i = 1950; i <= 2050; i++) {
			arr.push(i);
		}
		return arr;
	})();


	var defaults = {

		rotateEffect: false, //为了性能

		value: [today.getFullYear(), formatNumber(today.getMonth() + 1), formatNumber(today.getDate()), today
			.getHours(),
			formatNumber(today.getMinutes())
		],

		onChange: function(picker, values, displayValues) {
			var days = getDaysByMonthAndYear(picker.cols[1].value, picker.cols[0].value);
			var currentValue = picker.cols[2].value;
			if (currentValue > days.length) currentValue = days.length;
			picker.cols[2].setValue(currentValue);
		},

		formatValue: function(p, values, displayValues) {
			return displayValues[0] + '-' + values[1] + '-' + values[2] + ' ' + values[3] + ':' + values[4];
		},

		cols: [
			// Years
			{
				values: initYears
			},
			// Months
			{
				values: initMonthes
			},
			// Days
			{
				values: getDays()
			},

			// Space divider
			{
				divider: true,
				content: '  '
			},
			// Hours
			{
				values: (function() {
					var arr = [];
					for (var i = 0; i <= 23; i++) {
						arr.push(i);
					}
					return arr;
				})(),
			},
			// Divider
			{
				divider: true,
				content: ':'
			},
			// Minutes
			{
				values: (function() {
					var arr = [];
					for (var i = 0; i <= 59; i++) {
						arr.push(i < 10 ? '0' + i : i);
					}
					return arr;
				})(),
			}
		]
	};

	$.fn.datetimePicker = function(params) {
		return this.each(function() {
			if (!this) return;
			var p = $.extend(defaults, params);
			$(this).picker(p);
			if (params.value) $(this).val(p.formatValue(p, p.value, p.value));
		});
	};
};


function _defineProperty(obj, key, value) {
	if (key in obj) {
		Object.defineProperty(obj, key, {
			value: value,
			enumerable: true,
			configurable: true,
			writable: true
		});
	} else {
		obj[key] = value;
	}

	return obj;
}

function load_ui(jquery) {
	import_picker(jquery);
	import_datetimePicker(jquery);
	"use strict";
	/* 动效API */

	var _props;

	function __dealCssEvent(eventNameArr, callback) {
		var events = eventNameArr,
			i,
			dom = this;

		function fireCallBack(e) {
			if (e.target !== this) return;
			callback.call(this, e);

			for (i = 0; i < events.length; i++) {
				dom.off(events[i], fireCallBack);
			}
		}

		if (callback) {
			for (i = 0; i < events.length; i++) {
				dom.on(events[i], fireCallBack);
			}
		}
	}

	jquery.fn.dataset = function() {
		var dataset = {},
			ds = this[0].dataset;

		for (var key in ds) {
			var item = dataset[key] = ds[key];
			if (item === "false") dataset[key] = false;
			else if (item === "true") dataset[key] = true;
			else if (parseFloat(item) === item * 1) dataset[key] = item * 1;
		}

		return jquery.extend({}, dataset, this[0].__eleData);
	};

	jquery.fn.animationEnd = function(callback) {
		__dealCssEvent.call(this, ["webkitAnimationEnd", "animationend"], callback);

		return this;
	};

	jquery.fn.transitionEnd = function(callback) {
		__dealCssEvent.call(this, ["webkitTransitionEnd", "transitionend"], callback);

		return this;
	};

	jquery.fn.transition = function(duration) {
		if (typeof duration !== "string") {
			duration = duration + "ms";
		}

		for (var i = 0; i < this.length; i++) {
			var elStyle = this[i].style;
			elStyle.webkitTransitionDuration = elStyle.MozTransitionDuration = elStyle.transitionDuration =
			duration;
		}

		return this;
	};

	jquery.fn.transform = function(transform) {
		for (var i = 0; i < this.length; i++) {
			var elStyle = this[i].style;
			elStyle.webkitTransform = elStyle.MozTransform = elStyle.transform = transform;
		}

		return this;
	};

	(function($) {
		var _modalTemplateTempDiv = document.createElement("div");

		$.modalStack = [];

		$.modalStackClearQueue = function() {
			if ($.modalStack.length) {
				$.modalStack.shift()();
			}
		};

		$.modal = function(params) {
			params = params || {};
			var modalHTML = "";
			var buttonsHTML = "";

			if (params.buttons && params.buttons.length > 0) {
				for (var i = 0; i < params.buttons.length; i++) {
					buttonsHTML += "<span class=\"modal-button" + (params.buttons[i].bold ?
							" modal-button-bold" : "") + "\">" +
						params.buttons[i].text + "</span>";
				}
			}

			var extraClass = params.extraClass || "";
			var titleHTML = params.title ? "<div class=\"modal-title\">" + params.title + "</div>" : "";
			var textHTML = params.text ? "<div class=\"modal-text\">" + params.text + "</div>" : "";
			var afterTextHTML = params.afterText ? params.afterText : "";
			var noButtons = !params.buttons || params.buttons.length === 0 ? "modal-no-buttons" : "";
			var verticalButtons = params.verticalButtons ? "modal-buttons-vertical" : "";
			modalHTML = "<div class=\"modal " + extraClass + " " + noButtons +
				"\"><div class=\"modal-inner\">" + (titleHTML +
					textHTML + afterTextHTML) + "</div><div class=\"modal-buttons " + verticalButtons + "\">" +
				buttonsHTML +
				"</div></div>";
			_modalTemplateTempDiv.innerHTML = modalHTML;
			var modal = $(_modalTemplateTempDiv).children();
			$(defaults.modalContainer).append(modal[0]);
			modal.find(".modal-button").each(function(index, el) {
				$(el).on("click", function(e) {
					if (params.buttons[index].close !== false) $.closeModal(modal);
					if (params.buttons[index].onClick) params.buttons[index].onClick(modal, e);
					if (params.onClick) params.onClick(modal, index);
				});
			});
			$.openModal(modal);
			return modal[0];
		};

		$.alert = function(text, title, callbackOk) {
			if (typeof title === "function") {
				callbackOk = arguments[1];
				title = undefined;
			}

			return $.modal({
				text: text || "",
				title: typeof title === "undefined" ? defaults.modalTitle : title,
				buttons: [{
					text: defaults.modalButtonOk,
					bold: true,
					onClick: callbackOk
				}]
			});
		};

		$.confirm = function(text, title, callbackOk, callbackCancel) {
			if (typeof title === "function") {
				callbackCancel = arguments[2];
				callbackOk = arguments[1];
				title = undefined;
			}

			return $.modal({
				text: text || "",
				title: typeof title === "undefined" ? defaults.modalTitle : title,
				buttons: [{
					text: defaults.modalButtonCancel,
					onClick: callbackCancel
				}, {
					text: defaults.modalButtonOk,
					bold: true,
					onClick: callbackOk
				}]
			});
		};

		$.prompt = function(text, title, callbackOk, callbackCancel) {
			if (typeof title === "function") {
				callbackCancel = arguments[2];
				callbackOk = arguments[1];
				title = undefined;
			}

			return $.modal({
				text: text || "",
				title: typeof title === "undefined" ? defaults.modalTitle : title,
				afterText: "<input type=\"text\" class=\"modal-text-input\">",
				buttons: [{
					text: defaults.modalButtonCancel
				}, {
					text: defaults.modalButtonOk,
					bold: true
				}],
				onClick: function onClick(modal, index) {
					if (index === 0 && callbackCancel) callbackCancel($(modal).find(
						".modal-text-input").val());
					if (index === 1 && callbackOk) callbackOk($(modal).find(".modal-text-input")
						.val());
				}
			});
		};

		$.modalLogin = function(text, title, callbackOk, callbackCancel) {
			if (typeof title === "function") {
				callbackCancel = arguments[2];
				callbackOk = arguments[1];
				title = undefined;
			}

			return $.modal({
				text: text || "",
				title: typeof title === "undefined" ? defaults.modalTitle : title,
				afterText: "<input type=\"text\" name=\"modal-username\" placeholder=\"" + defaults
					.modalUsernamePlaceholder +
					"\" class=\"modal-text-input modal-text-input-double\"><input type=\"password\" name=\"modal-password\" placeholder=\"" +
					defaults.modalPasswordPlaceholder +
					"\" class=\"modal-text-input modal-text-input-double\">",
				buttons: [{
					text: defaults.modalButtonCancel
				}, {
					text: defaults.modalButtonOk,
					bold: true
				}],
				onClick: function onClick(modal, index) {
					var username = $(modal).find(".modal-text-input[name=\"modal-username\"]")
				.val();
					var password = $(modal).find(".modal-text-input[name=\"modal-password\"]")
				.val();
					if (index === 0 && callbackCancel) callbackCancel(username, password);
					if (index === 1 && callbackOk) callbackOk(username, password);
				}
			});
		};

		$.modalPassword = function(text, title, callbackOk, callbackCancel) {
			if (typeof title === "function") {
				callbackCancel = arguments[2];
				callbackOk = arguments[1];
				title = undefined;
			}

			return $.modal({
				text: text || "",
				title: typeof title === "undefined" ? defaults.modalTitle : title,
				afterText: "<input type=\"password\" name=\"modal-password\" placeholder=\"" + defaults
					.modalPasswordPlaceholder +
					"\" class=\"modal-text-input\">",
				buttons: [{
					text: defaults.modalButtonCancel
				}, {
					text: defaults.modalButtonOk,
					bold: true
				}],
				onClick: function onClick(modal, index) {
					var password = $(modal).find(".modal-text-input[name=\"modal-password\"]")
				.val();
					if (index === 0 && callbackCancel) callbackCancel(password);
					if (index === 1 && callbackOk) callbackOk(password);
				}
			});
		};

		$.showPreloader = function(title) {
			$.hidePreloader();
			$.showPreloader.preloaderModal = $.modal({
				title: title || defaults.modalPreloaderTitle,
				text: "<div class=\"preloader\"></div>"
			});
			return $.showPreloader.preloaderModal;
		};

		$.hidePreloader = function() {
			$.showPreloader.preloaderModal && $.closeModal($.showPreloader.preloaderModal);
		};

		$.showIndicator = function() {
			if ($(".preloader-indicator-modal")[0]) return;
			$(defaults.modalContainer).append(
				"<div class=\"preloader-indicator-overlay\"></div><div class=\"preloader-indicator-modal\"><span class=\"preloader preloader-white\"></span></div>"
			);
		};

		$.hideIndicator = function() {
			$(".preloader-indicator-overlay, .preloader-indicator-modal").remove();
		};

		$.showIndicatorDiy = function(htmlcontent) {
			if ($(".preloader-indicator-modal")[0]) return;
			$(defaults.modalContainer).append(
				"<div class=\"preloader-indicator-overlay\"></div><div class=\"preloader-indicator-modal\">" +
				htmlcontent +
				"</div>");
		};

		$.hideIndicatorDiy = function() {
			$(".preloader-indicator-overlay, .preloader-indicator-modal").remove();
		};

		$.actions = function(params) {
			var modal, groupSelector, buttonSelector;
			params = params || [];

			if (params.length > 0 && !$.isArray(params[0])) {
				params = [params];
			}

			var modalHTML;
			var buttonsHTML = "";

			for (var i = 0; i < params.length; i++) {
				for (var j = 0; j < params[i].length; j++) {
					if (j === 0) buttonsHTML += "<div class=\"actions-modal-group\">";
					var button = params[i][j];
					var buttonClass = button.label ? "actions-modal-label" : "actions-modal-button";
					if (button.bold) buttonClass += " actions-modal-button-bold";
					if (button.color) buttonClass += " font_" + button.color;
					if (button.bg) buttonClass += " bg_" + button.bg;
					if (button.disabled) buttonClass += " disabled";
					buttonsHTML += "<span class=\"" + buttonClass + "\">" + button.text + "</span>";
					if (j === params[i].length - 1) buttonsHTML += "</div>";
				}
			}

			modalHTML = "<div class=\"actions-modal\">" + buttonsHTML + "</div>";
			_modalTemplateTempDiv.innerHTML = modalHTML;
			modal = $(_modalTemplateTempDiv).children();
			$(defaults.modalContainer).append(modal[0]);
			groupSelector = ".actions-modal-group";
			buttonSelector = ".actions-modal-button";
			var groups = modal.find(groupSelector);
			groups.each(function(index, el) {
				var groupIndex = index;
				$(el).children().each(function(index, el) {
					var buttonIndex = index;
					var buttonParams = params[groupIndex][buttonIndex];
					var clickTarget;
					if ($(el).is(buttonSelector)) clickTarget = $(el);

					if (clickTarget) {
						clickTarget.on("click", function(e) {
							if (buttonParams.close !== false) $.closeModal(modal);
							if (buttonParams.onClick) buttonParams.onClick(modal, e);
						});
					}
				});
			});
			$.openModal(modal);
			return modal[0];
		};

		$.popup = function(modal, removeOnClose) {
			if (typeof removeOnClose === "undefined") removeOnClose = true;

			if (typeof modal === "string" && modal.indexOf("<") >= 0) {
				var _modal = document.createElement("div");

				_modal.innerHTML = modal.trim();

				if (_modal.childNodes.length > 0) {
					modal = _modal.childNodes[0];
					if (removeOnClose) modal.classList.add("remove-on-close");
					$(defaults.modalContainer).append(modal);
				} else return false;
			}

			modal = $(modal);
			if (modal.length === 0) return false;
			modal.show();
			modal.find(".content").scroller("refresh");

			if (modal.find("." + defaults.viewClass).length > 0) {
				$.sizeNavbars(modal.find("." + defaults.viewClass)[0]);
			}

			$.openModal(modal);
			return modal[0];
		};

		$.pickerModal = function(pickerModal, removeOnClose) {
			if (typeof removeOnClose === "undefined") removeOnClose = true;

			if (typeof pickerModal === "string" && pickerModal.indexOf("<") >= 0) {
				pickerModal = $(pickerModal);

				if (pickerModal.length > 0) {
					if (removeOnClose) pickerModal.addClass("remove-on-close");
					$(defaults.modalContainer).append(pickerModal[0]);
				} else return false;
			}

			pickerModal = $(pickerModal);
			if (pickerModal.length === 0) return false;
			pickerModal.show();
			$.openModal(pickerModal);
			return pickerModal[0];
		};

		$.loginScreen = function(modal) {
			if (!modal) modal = ".login-screen";
			modal = $(modal);
			if (modal.length === 0) return false;
			modal.show();

			if (modal.find("." + defaults.viewClass).length > 0) {
				$.sizeNavbars(modal.find("." + defaults.viewClass)[0]);
			}

			$.openModal(modal);
			return modal[0];
		};

		$.toast = function(msg, duration, extraclass) {
			var $toast = $("<div class=\"modal toast " + (extraclass || "") + "\">" + msg + "</div>").appendTo(
				document.body);
			$.openModal($toast, function() {
				setTimeout(function() {
					$.closeModal($toast);
				}, duration || 2000);
			});
		};

		$.openModal = function(modal, cb) {
			modal = $(modal);
			var isModal = modal.hasClass("modal"),
				isNotToast = !modal.hasClass("toast");

			if ($(".modal.modal-in:not(.modal-out)").length && defaults.modalStack && isModal && isNotToast) {
				$.modalStack.push(function() {
					$.openModal(modal, cb);
				});
				return;
			}

			var isPopup = modal.hasClass("popup");
			var isLoginScreen = modal.hasClass("login-screen");
			var isPickerModal = modal.hasClass("picker-modal");
			var isToast = modal.hasClass("toast");

			if (isModal) {
				modal.show();
			}

			var overlay;

			if (!isLoginScreen && !isPickerModal && !isToast) {
				if ($(".modal-overlay").length === 0 && !isPopup) {
					$(defaults.modalContainer).append("<div class=\"modal-overlay\"></div>");
				}

				if ($(".popup-overlay").length === 0 && isPopup) {
					$(defaults.modalContainer).append("<div class=\"popup-overlay\"></div>");
				}

				overlay = isPopup ? $(".popup-overlay") : $(".modal-overlay");
			}

			var clientLeft = modal[0].clientLeft;
			modal.trigger("open");

			if (isPickerModal) {
				$(defaults.modalContainer).addClass("with-picker-modal");
			}

			if (!isLoginScreen && !isPickerModal && !isToast) overlay.addClass("modal-overlay-visible");
			modal.removeClass("modal-out").addClass("modal-in").transitionEnd(function(e) {
				if (modal.hasClass("modal-out")) modal.trigger("closed");
				else modal.trigger("opened");
			});

			if (typeof cb === "function") {
				cb.call(this);
			}

			return true;
		};

		$.closeModal = function(modal) {
			modal = $(modal || ".modal-in");

			if (typeof modal !== "undefined" && modal.length === 0) {
				return;
			}

			var isModal = modal.hasClass("modal"),
				isPopup = modal.hasClass("popup"),
				isToast = modal.hasClass("toast"),
				isLoginScreen = modal.hasClass("login-screen"),
				isPickerModal = modal.hasClass("picker-modal"),
				removeOnClose = modal.hasClass("remove-on-close"),
				overlay = isPopup ? $(".popup-overlay") : $(".modal-overlay");

			if (isPopup) {
				if (modal.length === $(".popup.modal-in").length) {
					overlay.removeClass("modal-overlay-visible");
				}
			} else if (!(isPickerModal || isToast)) {
				overlay.removeClass("modal-overlay-visible");
			}

			modal.trigger("close");

			if (isPickerModal) {
				$(defaults.modalContainer).removeClass("with-picker-modal");
				$(defaults.modalContainer).addClass("picker-modal-closing");
			}

			modal.removeClass("modal-in").addClass("modal-out").transitionEnd(function(e) {
				if (modal.hasClass("modal-out")) modal.trigger("closed");
				else modal.trigger("opened");

				if (isPickerModal) {
					$(defaults.modalContainer).removeClass("picker-modal-closing");
				}

				if (isPopup || isLoginScreen || isPickerModal) {
					modal.removeClass("modal-out").hide();

					if (removeOnClose && modal.length > 0) {
						modal.remove();
					}
				} else {
					modal.remove();
				}
			});

			if (isModal && defaults.modalStack) {
				$.modalStackClearQueue();
			}

			return true;
		};

		function handleClicks(e) {
			var clicked = $(this);
			var url = clicked.attr("href");
			var clickedData = clicked.dataset();
			var popup;

			if (clicked.hasClass("open-popup")) {
				if (clickedData.popup) {
					popup = clickedData.popup;
				} else popup = ".popup";

				$.popup(popup);
			}

			if (clicked.hasClass("close-popup")) {
				if (clickedData.popup) {
					popup = clickedData.popup;
				} else popup = ".popup.modal-in";

				$.closeModal(popup);
			}

			if (clicked.hasClass("modal-overlay")) {
				if ($(".modal.modal-in").length > 0 && defaults.modalCloseByOutside) $.closeModal(
				".modal.modal-in");
				if ($(".actions-modal.modal-in").length > 0 && defaults.actionsCloseByOutside) $.closeModal(
					".actions-modal.modal-in");
			}

			if (clicked.hasClass("popup-overlay")) {
				if ($(".popup.modal-in").length > 0 && defaults.popupCloseByOutside) $.closeModal(
				".popup.modal-in");
			}
		}

		$(document).on("click", " .modal-overlay, .popup-overlay, .close-popup, .open-popup, .close-picker",
			handleClicks);
		var defaults = $.modal.prototype.defaults = {
			modalStack: true,
			modalButtonOk: "确定",
			modalButtonCancel: "取消",
			modalPreloaderTitle: "加载中",
			modalContainer: document.body
		};
	})(jquery);
	/* 组件 */


	var form_mixin = {
		model: {
			prop: 'value',
			event: 'input'
		},
		props: (_props = {
			// 宽度
			width: {
				type: String,
				default: ''
			},
			height: {
				type: String,
				default: ''
			},
			// 类型
			type: {
				type: String,
				default: 'text'
			},
			// 选项
			options: {
				type: Array,
				default: function _default() {
					return [];
				}
			},
			// 赋值
			value: {
				type: [String, Number, Boolean]
			},
			// 回调函数
			func: {
				type: Function,
				default: function _default(fun, param1, param2) {
					return null;
				}
			},
			// 显示方式
			display: {
				type: String,
				default: "1"
			},
			// 显示隐藏
			show: {
				type: Boolean,
				default: false
			},
			// 标题
			title: {
				type: String,
				default: ""
			},
			// 图标
			icon: {
				type: String,
				default: ''
			},
			// 单位
			unit: {
				type: String,
				default: ''
			},
			// 描述
			desc: {
				type: String,
				default: ""
			},
			// 错误提示
			tip: {
				type: String,
				default: ""
			},
			// 最小值
			min: {
				type: Number,
				default: 0
			},
			// 最大值
			max: {
				type: Number,
				default: 0
			},
			// 最小长度
			min_length: {
				type: Number,
				default: 0
			},
			// 最大长度
			max_length: {
				type: Number,
				default: 65535
			},
			// 主键
			field: {
				type: String,
				default: "value"
			}
		}, _defineProperty(_props, "type", {
			type: String,
			default: "text"
		}), _defineProperty(_props, "num", {
			type: Number,
			default: 1
		}), _defineProperty(_props, "text", {
			type: String,
			default: ""
		}), _defineProperty(_props, "disabled", {
			type: Boolean,
			default: false
		}), _defineProperty(_props, "url", {
			type: String,
			default: ""
		}), _defineProperty(_props, "user_group", {
			type: Array,
			default: function _default() {
				return [];
			}
		}), _defineProperty(_props, "user_admin", {
			type: Array,
			default: function _default() {
				return [];
			}
		}), _defineProperty(_props, "vip", {
			type: Number,
			default: 0
		}), _defineProperty(_props, "gm", {
			type: Number,
			default: 0
		}), _defineProperty(_props, "oauth", {
			type: Boolean,
			default: false
		}), _props),
		data: function data() {
			return {
				// 显示方式
				dy: this.display,
				// 显示隐藏
				sw: this.show,
				// 加载中
				load: this.loading,
				// 列表
				oj: this.obj,
				// 数量
				nm: this.num,
				// 文本
				txt: this.text,
				// 值
				val: this.value,
				// 禁用
				dd: this.disabled
			};
		},
		methods: {
			/// 可更改其他属性，默认绑定回调函数
			/// fun: 函数名
			/// param1: 参数1
			/// param2: 参数2
			/// param3: 参数3
			run: function run(fun, param1, param2, param3) {
				if (this.func) {
					return this.func(param1, param2, param3);
				}

				return null;
			},
			// 删除
			/// query: 查询条件
			del: function del() {
				var query = {};
				query[this.field] = this.id;
				this.run('del', query);
			},
			// 修改
			/// query: 查询条件
			/// obj: 修改的对象
			set: function set(obj) {
				var query = {};
				query[this.field] = this.id;
				this.run('set', query, obj);
			}
		}
	};
	var mm_btn = {
		template: "<button :type=\"type\" class=\"mm_btn\" v-if=\"!url\" @click=\"click_down()\"><slot></slot></button><button class=\"mm_btn\" @click=\"openBrowser()\" v-else-if=\"url.indexOf('http:') === 0 || url.indexOf('https:') === 0\"><slot></slot></button><router-link class=\"mm_btn\" :to=\"url\" v-else><slot></slot></router-link>",
		props: {
			url: {
				type: String,
				default: ""
			},
			type: {
				type: String,
				default: "button"
			},
			func: {
				type: Function,
				default: function _default() {}
			}
		},
		methods: {
			openBrowser: function openBrowser() {
				if (window) {
					window.open(this.url);
				}
			},
			click_down: function click_down() {
				if (this.func) {
					this.func();
				}
			}
		}
	};
	var mm_icon = {
		template: "<figure class=\"mm_icon\" v-if=\"src && src.indexOf('<') !== -1\" v-html=\"src\"></figure><figure class=\"mm_icon\" v-else-if=\"src\" :style=\"'background-image: url(' + src + ');'\"><img class=\"img\" :src=\"src\" :alt=\"alt\" :onerror=\"onerror\" /><figcaption v-if=\"$slots.default\"><slot></slot></figcaption></figure><figure class=\"mm_icon\" v-else></figure>",
		props: {
			src: {
				type: String,
				default: ""
			},
			src_default: {
				type: String,
				default: "/img/default.png"
			},
			height: {
				type: String,
				default: ""
			},
			alt: {
				type: String,
				default: "图片"
			}
		},
		computed: {
			onerror: function() {
				return "javascript:this.src='" + this.src_default + "'";
			}
		}
	};
	var mm_loading = {
		template: "<div class=\"mm_loading\"><div class=\"load\"><slot><img src=\"/img/loading.svg\" :style=\"'width:' + wh + ';height:' + ht\" v-if=\"display == '1'\" /><div class=\"progress\" :style=\"'width:' + wh + ';height:' + ht\" v-else></div></slot></div><div class=\"state\">{{ title }}<span class=\"value\" v-show=\"value\"> {{ value }}</span></div></div>",
		props: {
			value: {
				type: Number,
				default: 0
			},
			title: {
				type: String,
				default: "加载中"
			},
			width: {
				type: String,
				default: ""
			},
			height: {
				type: String,
				default: ""
			},
			display: {
				type: String,
				default: "1"
			}
		},
		data: function data() {
			var wh = "";
			var ht = "";

			if (this.width) {
				wh = this.width;
			} else {
				if (this.display === "1") {
					wh = "1.5rem";
				} else if (this.display === "2") {
					wh = "100%";
				}
			}

			if (this.height) {
				wh = this.height;
			} else {
				if (this.display === "1") {
					ht = "auto";
				} else if (this.display === "2") {
					ht = "4px";
				}
			}

			return {
				ht: ht,
				wh: wh
			};
		}
	};
	var mm_body = {
		template: "<div class=\"mm_body\"><slot></slot></div>"
	};
	var mm_col = {
		template: "<div :class=\"'mm_col' + this.wh\"><slot></slot></div>",
		props: {
			width: {
				type: String,
				default: ""
			}
		},
		data: function data() {
			return {
				wh: this.width
			};
		},
		created: function created() {
			var wh = this.wh;
			if (wh) {
				if (wh.indexOf("-") == -1) {
					this.wh = " w-" + wh;
				}
			}
		}
	};
	var mm_foot = {
		template: "<footer class=\"mm_foot\"><slot></slot></footer>"
	};
	var mm_row = {
		template: "<div :class=\"'mm_row' + cl\"><slot></slot></div>",
		props: {
			col: {
				type: Number,
				default: 0
			}
		},
		computed: {
			cl: function cl() {
				var cl = this.col;

				if (cl) {
					return " row-" + cl;
				}
				
				return "";
			}
		}
	};
	var mm_grid = {
		template: "<div :class=\"'mm_grid' + cl\"><slot></slot></div>",
		props: {
			col: {
				type: String,
				default: ""
			}
		},
		computed: {
			cl: function cl() {
				var cl = this.col;

				if (cl && cl.indexOf("-") == -1) {
					cl = " grid-" + cl;
				}

				return cl;
			}
		}
	};
	var mm_group = {
		template: "<div class=\"mm_group\"><slot></slot></div>"
	};
	var mm_head = {
		template: "<header class=\"mm_head\"><slot></slot></header>"
	};
	var mm_item = {
		template: "<div class=\"mm_item\" v-if=\"!url\"><slot></slot></div><div class=\"mm_item\" @click=\"openBrowser()\" v-else-if=\"url.indexOf('http:') === 0 || url.indexOf('https:') === 0\"><slot></slot></div><router-link class=\"mm_item\" :to=\"url\" v-else><slot></slot></router-link>",
		props: {
			url: {
				type: String,
				default: ""
			},
			type: {
				type: String,
				default: ""
			}
		},
		methods: {
			openBrowser: function openBrowser() {
				if (window) {
					window.open(this.url);
				}
			}
		}
	};
	var mm_list = {
		template: "<nav :class=\"'mm_list' + cl\"><slot></slot></nav>",
		props: {
			col: {
				type: Number,
				default: 0
			}
		},
		computed: {
			cl: function cl() {
				var cl = this.col;

				if (cl) {
					return " list-" + cl;
				}

				return "";
			}
		}
	};
	var mm_main = {
		template: "<div class=\"mm_main\"><slot></slot></div>"
	};
	var mm_modal = {
		template: "<div class=\"mm_modal\" v-bind:class=\"'from_' + display + (show ? '' : ' hide-x')\"><div class=\"modal_main\"><slot></slot></div><div class=\"mask\" v-if=\"mask && mask != 'false'\" @click=\"close()\"></div></div>",
		props: {
			display: {
				type: String,
				default: "default"
			},
			show: {
				type: Boolean,
				default: false
			},
			mask: {
				type: String,
				default: ""
			}
		},
		model: {
			prop: "show",
			event: "change"
		},
		methods: {
			close: function close() {
				this.$emit("change", false);
			}
		}
	};
	var mm_movable = {
		template: "<div class=\"mm_movable\"><slot></slot></div>"
	};
	var mm_page = {
		template: "<div class=\"mm_page\"><slot></slot></div>",
		props: {
			fun: {
				type: Function,
				default: function _default() {}
			}
		}
	};
	var mm_view = {
		template: "<div class=\"mm_view\" v-if=\"!url\"><slot></slot></div><div class=\"mm_view\" @click=\"openBrowser()\" v-else-if=\"url.indexOf('http:') === 0 || url.indexOf('https:') === 0\"><slot></slot></div><router-link class=\"mm_view\" :to=\"url\" v-else><slot></slot></router-link>",
		props: {
			url: {
				type: String,
				default: ""
			},
			type: {
				type: String,
				default: ""
			}
		},
		methods: {
			openBrowser: function openBrowser() {
				if (window) {
					window.open(this.url);
				}
			}
		}
	};

	var mm_card = {
		template: "<div class=\"mm_card\"><slot></slot></div>",
		props: {
			fun: {
				type: Function,
				default: function _default() {}
			}
		}
	};

	function bindResize(tag, target, func) {
		var width_init = $(target).width();
		var el = $(tag);
		var x = 0;
		var y = 0;
		el.mousedown(function(e) {
			x = e.clientX - el.offset().left;
			el.setCapture ? (el.setCapture(), el.onmousemove = function(ev) {
				mouseMove(ev || event);
			}, el.onmouseup = mouseUp) : $(document).bind("mousemove", mouseMove).bind("mouseup", mouseUp);
			e.preventDefault();
		});

		function mouseMove(e) {
			var width = e.clientX - x;

			if (width >= width_init) {
				$(target).width(width + "px");

				if (func) {
					func(width);
				}
			}
		}

		function mouseUp() {
			el.releaseCapture ? (el.releaseCapture(), el.onmousemove = el.onmouseup = null) : $(document).unbind(
				"mousemove",
				mouseMove).unbind("mouseup", mouseUp);
		}
	}

	var mm_side = {
		template: "<div class=\"mm_side\" :class=\"{'hide-x': hide, fold: fold}\" :id=\"side_id\"><slot></slot><div class=\"line\"></div><div class=\"mask\" @click=\"set_hide()\"></div></div>",
		model: {
			prop: "hide",
			event: "change"
		},
		props: {
			id: {
				type: String,
				default: ""
			},
			hide: {
				type: Boolean,
				default: false
			},
			fold: {
				type: Boolean,
				default: false
			},
			func: {
				type: Function,
				default: function _default(width) {}
			}
		},
		data: function data() {
			var id = this.id;

			if (!id) {
				id = "mm_side" + parseInt(Math.random() * 1000 + 1, 10);
			}

			return {
				side_id: id
			};
		},
		methods: {
			set_hide: function set_hide() {
				this.$emit('change', true);
			}
		},
		mounted: function mounted() {
			var target = "#" + this.side_id;
			bindResize(target + " .line", target, this.func);
		}
	};

	var mm_nav_top = {
		template: "<div class=\"mm_nav_top\" :class=\"{show: show}\"><button class=\"btn_link\" @click=\"$emit('change', !show)\"><i class=\"fa fa-bars\"></i></button><div class=\"nav_warp\"><nav><slot></slot></nav><div class=\"mask\" @click=\"$emit('change', false)\"></div></div></div>",
		model: {
			prop: 'show',
			event: 'change'
		},
		props: {
			show: {
				type: Boolean,
				show: false
			}
		},
		data: function() {
			return {}
		}
	};

	var mm_table = {
		template: "<div :class=\"'mm_table table-' + type\"><table><slot></slot></table></div>",
		props: {
			type: {
				type: String,
				default: "1"
			}
		}
	};

	var mm_warp = {
		template: "<div class=\"mm_warp\"><slot></slot></div>"
	};
	var mm_container = {
		template: "<div class=\"mm_container\"><slot></slot></div>"
	};

	var control_checkbox = {
		template: "<div class=\"control_checkbox\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><label v-for=\"(o, idx) in options\" :key=\"idx\" :class=\"{ 'active': has(o[field]), 'disabled': o.disabled }\" @click=\"selected(o[field])\"><span class=\"figure\"></span><span class=\"name\">{{ o.name }}</span></label></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		props: {
			symbol: {
				type: String,
				default: ","
			}
		},
		methods: {
			selected: function selected(val) {
				var arr = this.value.split(this.symbol);
				var idx = arr.indexOf(val);

				if (idx !== -1) {
					arr.splice(idx, 1);
				} else {
					arr.push(val);
				}

				var val = arr.join(this.symbol);

				if (val.indexOf(this.symbol) === 0) {
					val = val.substring(1);
				}

				this.$emit("input", val);
			},
			has: function has(val) {
				var arr = this.value.split(this.symbol);
				return arr.indexOf(val) !== -1;
			}
		}
	};
	var mm_code = {
		template: "<div class=\"mm_code\"><mm_icon :icon=\"icon\"></mm_icon><div class=\"title\" v-if=\"title\">{{ title }}</div><slot><mm_group><input type=\"text\" :value=\"value\" :placeholder=\"desc || placeholder\" @input=\"$emit('input', $event.target.value)\"></input><button :class=\"'btn-' + type\" v-html=\"btn\"></button></mm_group></slot><div class=\"tip\" v-if=\"tip\" v-html=\"tip\"></div></div>",
		mixins: [form_mixin],
		props: {
			placeholder: {
				type: String
			}
		},
		props: {
			btn: {
				type: String,
				default: "发送验证码"
			}
		},
		computed: {
			ds: function ds() {
				if (this.btn.indexOf("s") == -1) {
					return false;
				} else {
					return true;
				}
			}
		}
	};

	var control_input = {
		template: "<div class=\"control_input\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><input v-bind:class=\"{'auto-width': auto }\" :type=\"type\" :value=\"value\" :min=\"min\" :max=\"max\" :minlength=\"min_length\" :maxlength=\"max_length\" :placeholder=\"desc || placeholder\" @input=\"set\" :disabled=\"disabled\" :required=\"required\" @blur=\"$emit('blur')\" :style=\"style\" /><slot><span class=\"unit\" v-if=\"unit\">{{ unit }}</span></slot></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		props: {
			placeholder: {
				type: String
			},
			required: {
				type: Boolean,
				default: false
			},
			auto: {
				type: Boolean,
				default: false
			},
			size: {
				type: Number,
				default: 0.625
			}
		},
		methods: {
			set: function set(e) {
				if (this.type === "number") {
					var value = e.target.value ? e.target.value : "0";

					if (value.length > this.max_length && this.max_length !== 0) {
						value = value.substring(0, this.max_length);
					}

					var num = Number(value);

					if (num > this.max && this.max !== 0) {
						num = this.max;
					} else if (num < this.min) {
						num = this.min;
					}

					e.target.value = num.toString();
					this.$emit("input", num);
				} else {
					this.$emit("input", e.target.value);
				}
			}
		},
		computed: {
			style: function() {
				if (this.auto && this.value) {
					var len = this.value.length;
					return "width:" + ((len + 1) * this.size) + "rem";
				} else {
					return '';
				}
			}
		}
	};
	var control_number = {
		template: "<div class=\"control_number\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><mm_btn class=\"btn_primary btn_del\" @click.native=\"del\"><span></span></mm_btn><input type=\"number\" :value.number=\"value\" :min=\"min\" :max=\"max\" @input=\"set\" @blur=\"setInt\" :disabled=\"disabled\"/><mm_btn class=\"btn_primary btn_add\" @click.native=\"add\"><span></span></mm_btn></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		methods: {
			setInt: function setInt(e) {
				var value = e.target.value ? e.target.value : "0";
				var num = Number(value);
				this.call(num);
			},
			add: function add() {
				this.call(this.value + this.num);
			},
			del: function del() {
				this.call(this.value - this.num);
			},
			set: function set(e) {
				var value = e.target.value ? e.target.value : "0";
				if (value == '-' || value.endsWith('.')) {

				} else if (value == '0-') {
					e.target.value = '-';
				} else {
					var num = Number(value);
					e.target.value = this.call(num);
				}
			},
			call: function call(num) {
				if (num > this.max && this.max !== 0) {
					num = this.max;
				} else if (num < this.min) {
					num = this.min;
				}
				this.$emit("input", num);
				return num;
			}
		}
	};
	var control_pager = {
		template: "<div class=\"control_pager\"><nav><a href=\"javascript:void(0);\" v-if=\"display === '2'\" class=\"first\" @click=\"first\" v-bind:class=\"{ 'disabled': page === 1 }\"><span v-html=\"icons[0]\"></span></a><a href=\"javascript:void(0);\" class=\"previous\" @click=\"previous\" v-bind:class=\"{ 'disabled' : page <= 1 }\"><span v-html=\"icons[1]\"></span></a><a href=\"javascript:void(0);\" v-for=\"(p, i) in pages\" :key=\"i\" v-bind:class=\"{'active': page == p }\" @click=\"set(p)\">{{ p }}</a><a href=\"javascript:void(0);\" class=\"next\" v-bind:class=\"{ 'disabled': page >= ct }\" @click=\"next\"><span v-html=\"icons[2]\"></span></a><a href=\"javascript:void(0);\" v-if=\"display === '2'\" class=\"last\" v-bind:class=\"{ 'disabled': page == ct }\" @click=\"last\"><span v-html=\"icons[3]\"></span></a></nav><slot></slot></div>",
		model: {
			prop: "page",
			event: "input"
		},
		props: {
			display: {
				type: String,
				default: "1"
			},
			count: {
				type: Number,
				default: 1
			},
			num: {
				type: Number,
				default: 5
			},
			page: {
				type: Number,
				default: 1
			},
			func: {
				type: Function,
				default: function _default(page) {}
			},
			icons: {
				type: Array,
				default: function _default() {
					return ["<<", "<", ">", ">>"];
				}
			}
		},
		data: function data() {
			return {
				pe: this.page
			};
		},
		computed: {
			ct: function ct() {
				var c = this.count ? this.count : 1;
				return Math.ceil(c);
			},
			pages: function pages() {
				var pe = this.page;
				var arr = [pe];
				var len = this.num;
				var end = this.ct;

				for (var i = 0; i < len; i++) {
					var right = pe + i + 1;

					if (right <= end) {
						arr.push(right);
					}

					var left = pe - i - 1;

					if (left > 0) {
						arr.push(left);
					}
				}

				return arr.splice(0, len).sort(function(a, b) {
					return a - b;
				});
			}
		},
		methods: {
			goTo: function goTo(page) {
				if (this.func) {
					this.func(page);
				}
				this.$emit("input", page);
			},
			first: function first() {
				this.pe = 1;
				this.goTo(this.pe);
			},
			previous: function previous() {
				this.pe = this.page - 1;

				if (this.pe < 1) {
					this.pe = 1;
				}
				this.goTo(this.pe);
			},
			set: function set(p) {
				this.pe = p;
				this.goTo(this.pe);
			},
			next: function next() {
				this.pe = this.page + 1;
				if (this.pe > this.ct) {
					this.pe = this.ct;
				}
				this.goTo(this.pe);
			},
			last: function last() {
				this.pe = this.ct;
				this.goTo(this.pe);
			}
		}
	};
	var control_radio = {
		template: "<div class=\"control_radio\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><label v-for=\"(o, idx) in options\" :key=\"idx\" :class=\"{ 'active': value == o[field] }\" @click=\"$emit('input', $event.target.value)\"><input type=\"radio\" :name=\"name\" :value=\"o[field]\" /><span class=\"figure\"></span><span class=\"name\">{{ o.name }}</span></label></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		data: function data() {
			var name = this.name;

			if (!name) {
				name = $.md5(Math.random().toString()).substring(0, 8);
			}

			return {
				name: name
			};
		}
	};
	var control_reverse = {
		template: "<div class=\"control_reverse\"><div class=\"title\" v-if=\"title\" v-html=\"title\" @click=\"set\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><slot><div class=\"figure\" v-bind:class=\"{ 'reverse_arrow' : display !== '1' }\" @click=\"set\"><span class=\"up\" v-bind:class=\"{'active': selected === 0 }\"></span><span class=\"down\" v-bind:class=\"{'active': selected === 1 }\"></span></div></slot></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		methods: {
			set: function set() {
				var n = this.selected;
				n += 1;
				var lt = this.ops;
				var v = "";

				if (n < lt.length) {
					v = lt[n];
				} else if (n > lt.length) {
					n = 0;
					v = lt[0];
				}

				var val = this.value;
				var has = false;

				for (var i = 0; i < lt.length; i++) {
					var o = lt[i];

					if (val.indexOf(o) !== -1) {
						val = val.replace(o, v);
						has = true;
						val = val.replace(",,", ",");
						break;
					}
				}

				if (!has) {
					val += "," + v;
				}

				if (val.indexOf(",") === 0) {
					val = val.substring(1);
				}

				this.$emit("input", val.trim(','));

				if (this.func) {
					this.func(val);
				}
			}
		},
		computed: {
			ops: function ops() {
				var o = this.options;
				if (o) {
					if (typeof(o) === 'string') {
						return ["`" + o + "` asc", "`" + o + "` desc"]
					} else if (typeof(o) === 'object' && o.length > 1) {
						return o;
					} else if (this.field) {
						var f = this.field;
						return ["`" + f + "` asc", "`" + f + "` desc"]
					}
				}
				return ["asc", "desc"]
			},
			selected: function selected() {
				if (this.ops) {
					var lt = this.ops;
					var val = this.value;
					var selected = 2;

					for (var i = 0; i < lt.length; i++) {
						var o = lt[i];

						if (val.indexOf(o) !== -1) {
							selected = i;
							break;
						}
					}

					return selected;
				} else {
					return 0;
				}
			}
		}
	};
	var control_select = {
		template: "<div class=\"control_select\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><select v-if=\"type === 'text'\" :value=\"value\" @change=\"set\" :disabled=\"disabled\"><option v-for=\"(o, idx) in options\" :key=\"idx\" :value=\"o[field]\">{{ o.name }}</option></select><select v-else-if=\"type === 'multiple'\" :value=\"value\" @change=\"set\" :disabled=\"disabled\" multiple><option v-for=\"(o, idx) in options\" :key=\"idx\" :value=\"o[field]\">{{ o.name }}</option></select><a href=\"javascript:void(0)\" class=\"click\" v-else-if=\"type === 'click'\" v-bind:class=\"{ 'current': sw }\"><div :class=\"{'selected': !$slots.default}\" @click=\"sw = !sw\"><slot>{{ val_name }}</slot></div><div class=\"mm_box\"><ul><li v-for=\"(o, idx) in options\" :key=\"idx\" @click=\"click_fun(o[field]);sw = false\" :class=\"{ 'active': value === o[field] }\">{{ o.name }}</li></ul></div></a><a href=\"javascript:void(0)\" v-bind:class=\"type\" v-else><div class=\"selected\"><slot>{{ val_name }}</slot></div><div class=\"mm_box\"><ul><li v-for=\"(o, idx) in options\" :key=\"idx\" @click=\"click_fun(o[field])\" :class=\"{ 'active': value === o[field] }\">{{ o.name }}</li></ul></div></a></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		methods: {
			set: function set(e) {
				var value = e.target.value;
				this.$emit("input", value);
				if (this.value !== value) {
					this.$emit("change");
				}
			},
			click_fun: function click_fun(value) {
				this.$emit("input", value);
				this.func(value);
			}
		},
		computed: {
			val_name: function val_name() {
				var k = this.field;
				var v = this.value;
				var lt = this.options;
				var name = "";

				for (var i = 0; i < lt.length; i++) {
					var o = lt[i];

					if (o[k] === v) {
						name = o.name;
						break;
					}
				}

				return name;
			}
		}
	};
	var control_switch = {
		template: "<div class=\"control_switch\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><label :class=\"{ 'active': value === 1 }\" @click=\"set\"><div class=\"onoff\"><span class=\"on\" v-if=\"display === '1'\"></span><span class=\"off\" v-if=\"display === '1'\"></span></div></label></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		methods: {
			set: function set() {
				var val = 0;

				if (this.value === 0) {
					val = 1;
				}

				this.$emit("input", val);
			}
		}
	};
	var mm_nav = {
		template: "<nav class=\"mm_nav\"><ul><li v-for=\"(o, index) in list\" :key=\"index\"><a :href=\"o.url\" v-if=\"o.url.indexOf('http:') === 0 || o.url.indexOf('https:') === 0\">{{ o.title }}<span class=\"message\" v-show=\"o.message > 0\">{{ o.message }}</span></a><router-link :to=\"o.url\" v-else>{{ o.title }}<span class=\"message\" v-show=\"o.message > 0\">{{ o.message }}</span></router-link></li></ul></nav>",
		props: {
			list: {
				type: Array,
				default: function _default() {
					return [];
				}
			},
			vm: {
				type: Object,
				default: function _default() {
					return {
						icon: "icon",
						title: "title",
						desc: "desc",
						url: "url",
						name: "name",
						tip: "tip"
					};
				}
			}
		}
	};

	var bar_title = {
		template: "<div class=\"bar_title\"><slot></slot></div>",
		props: {}
	};
	var mm_content = {
		template: "<div class=\"mm_content\"><slot></slot></div>",
		props: {}
	};
	var mm_form = {
		template: "<form class=\"mm_form\"><slot></slot></form>",
		props: {}
	};

	var mm_upload_img = {
		template: "<div class=\"mm_upload_img\" v-bind:class=\"{ 'upload_add': !bg && !value }\">\t<div @click=\"choose()\"><mm_icon :src=\"value\" :style=\"'width:' + width + other\"></mm_icon>\t<slot></slot>\t<input type=\"file\" hidden @change=\"addImg\" :id=\"name\" accept=\"image/*\"/></div><div class=\"btns\"><mm_btn class='btn_default-x btn_link' v-if=\"value\" @click.native=\"preview = true\">预览</mm_btn><mm_btn class='btn_warning-x btn_link' v-if=\"value\" @click.native=\"$emit('input','')\">删除</mm_btn></div><mm_modal v-model=\"preview\" mask=\"true\"><div><img :src=\"value\" style=\"max-width:100%\" :alt=\"name\" /></div><mm_btn class=\"btn_close\" @click.native=\"preview = false\"><i class=\"fa-close\"></i></mm_btn></mm_modal></div>",
		model: {
			prop: 'value',
			event: 'input'
		},
		props: {
			name: {
				type: String,
				required: true
			},
			value: {
				type: String,
				default: ''
			},
			// 显示方式
			display: {
				type: String,
				default: '1'
			},
			// 显示隐藏
			show: {
				type: Boolean,
				default: false
			},
			func: {
				type: Function,
				default: function _default(obj) {}
			},
			width: {
				type: String,
				default: '5rem'
			},
			height: {
				type: String,
				default: ''
			},
			bg: {
				type: String,
				default: ''
			}
		},
		data: function data() {
			var other = this.bg ? '; background: url(' + this.bg +
				') center center no-repeat; background-size:100%' : '';

			if (this.height) {
				other += ';height:' + this.height;
			}

			return {
				other: other,
				preview: false
			};
		},
		methods: {
			choose: function choose() {
				this.$('.mm_upload_img #' + this.name).click();
			},
			addImg: function addImg(e) {
				var _this = this;

				var src,
					url = window.URL || window.webkitURL || window.mozURL,
					files = e.target.files;

				if (files.length > 0) {
					var file = files[0];
					var reader = new FileReader();
					reader.readAsDataURL(file);

					reader.onload = function(e) {
						src = this.result;

						_this.$emit('input', src);

						if (_this.func) {
							_this.func(src, file);
						}
					};
				}
			}
		}
	};

	var mm_time = {
		template: "<div class=\"mm_time\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><input :type=\"type || 'datetime'\" :value=\"value\" @blur=\"set\" :disabled=\"disabled\"></select></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div></div>",
		mixins: [form_mixin],
		methods: {
			set: function set(e) {
				this.$emit("input", e.target.value);
			}
		},
		watch: {
			value: function value(e) {
				if (this.type === 'date') {
					this.$emit("input", new Date(this.value).toStr('yyyy-MM-dd'));
				} else if (this.type === 'datetime-local') {
					this.$emit("input", new Date(this.value).toStr('yyyy-MM-ddThh:mm:ss'));
				} else if (this.value.indexOf('Z') !== -1) {
					this.$emit("input", new Date(this.value).toStr('yyyy-MM-ddThh:mm'));
				}
			}
		}
	};

	var control_textarea = {
		template: "<div class=\"control_textarea\" :class=\"{ 'show-expand': sw }\"><div class=\"title\" v-if=\"title\" v-html=\"title\"></div><div class=\"value\" v-bind:class=\"{'disabled': disabled }\"><textarea :value=\"value\" @blur=\"set\" :disabled=\"disabled\" :placeholder=\"desc || placeholder\" v-if=\"type == 'text'\"></textarea><button class=\"btn_expand\" type=\"button\" v-show=\"$slots.default\" @click=\"sw = !sw\"><i class=\"fa-expand\"></i></button></div><div class=\"tip\" v-if=\"tip\">{{ tip }}</div><slot></slot></div>",
		mixins: [form_mixin],
		props: {
			placeholder: {
				type: String
			}
		},
		methods: {
			set: function set(e) {
				this.$emit("input", e.target.value);
			}
		}
	};

	var control_file = {
		template: "<label class='mm_btn'><input type=\"file\" :id=\"file_id\" :accept=\"accept\" class=\"mm_btn btn_primary-x\" @change=\"change\" hidden /><slot>导入</slot></label>",
		mixins: [form_mixin],
		props: {
			accept: {
				type: String,
				// default: ".xls,.xlsx,.csv",
				default: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/vnd.ms-excel,.csv"
			}
		},
		data: function data() {
			var id = this.id;

			if (!id) {
				id = "control_file" + parseInt(Math.random() * 1000 + 1, 10);
			}

			return {
				file_id: id
			};
		},
		methods: {
			change: function change(e) {
				var _this = this;
				var src,
					url = window.URL || window.webkitURL || window.mozURL,
					files = e.target.files;
				if (files.length > 0) {
					var file = files[0];
					this.$emit('change', file);

					if (this.func) {
						this.func(file);
					}
				}
				$("#" + this.file_id).val("");
			}
		}
	};

	return {
		install: function install(Vue, options) {
			// 自定义拖动
			Vue.directive('drag',
				function(el, binding) {
					el.onmousedown = function(e) {
						let odiv = el; //获取当前元素
						let firstTime = '',
							lastTime = '';
						// 给当前元素添加属性，用于元素状态的判断
						odiv.setAttribute('ele-flag', false)
						odiv.setAttribute('draging-flag', true)

						e.preventDefault();
						let bw = document.body.clientWidth;
						let bh = document.body.clientHeight;
						//鼠标按下，计算当前元素距离可视区的距离
						let disX = e.clientX - el.offsetLeft;
						let disY = e.clientY - el.offsetTop;

						// 计算两边坐标
						document.onmousemove = function(e) {
							let l = 0,
								t = 0;
							// 拖动边界
							if (e.clientX >= bw) {
								l = bw - disX;
							} else if (e.clientX <= 0) {
								{
									l = 0 - disX;
								}
							} else {
								l = e.clientX - disX;
							}
							if (e.clientY >= bh) {
								t = bh - disY;
							} else if (e.clientY <= 0) {
								t = 0 - disY;
							} else {
								t = e.clientY - disY;
							}
							//移动当前元素
							el.style.left = l + 'px';
							el.style.top = t + 'px';
						};
						// 鼠标停止移动时，事件移除
						document.onmouseup = function(e) {
							document.onmousemove = null;
							document.onmouseup = null;
							console.log({
								x: e.clientX,
								y: e.clientY
							});
							lastTime = new Date().getTime();
							if ((lastTime - firstTime) > 200) {
								odiv.setAttribute('ele-flag', true)
								event.stopPropagation()
							}
							setTimeout(function() {
								odiv.setAttribute('draging-flag', false)
							}, 100)
						};
					};
				}
			);

			Vue.component("mm_icon", mm_icon);
			Vue.component("mm_btn", mm_btn);
			Vue.component("mm_loading", mm_loading);
			Vue.component("mm_body", mm_body);
			Vue.component("mm_row", mm_row);
			Vue.component("mm_col", mm_col);
			Vue.component("mm_foot", mm_foot);
			Vue.component("mm_grid", mm_grid);
			Vue.component("mm_group", mm_group);
			Vue.component("mm_head", mm_head);
			Vue.component("mm_item", mm_item);
			Vue.component("mm_list", mm_list);
			Vue.component("mm_main", mm_main);
			Vue.component("mm_modal", mm_modal);
			Vue.component("mm_movable", mm_movable);
			Vue.component("mm_page", mm_page);
			Vue.component("mm_view", mm_view);
			Vue.component("mm_card", mm_card);
			Vue.component("mm_side", mm_side);
			Vue.component("mm_table", mm_table);
			Vue.component("mm_warp", mm_warp);
			Vue.component("mm_container", mm_container);
			Vue.component("bar_title", bar_title);
			Vue.component("mm_content", mm_content);
			Vue.component("mm_form", mm_form);
			Vue.component("control_checkbox", control_checkbox);
			Vue.component("mm_code", mm_code);
			Vue.component("control_input", control_input);
			Vue.component("control_number", control_number);
			Vue.component("mm_time", mm_time);
			Vue.component("control_textarea", control_textarea);
			Vue.component("control_pager", control_pager);
			Vue.component("control_radio", control_radio);
			Vue.component("control_reverse", control_reverse);
			Vue.component("control_select", control_select);
			Vue.component("control_switch", control_switch);
			Vue.component("control_file", control_file);
			Vue.component("mm_nav", mm_nav);
			Vue.component("mm_nav_top", mm_nav_top);
			Vue.component("mm_upload_img", mm_upload_img);
		}
	};
}
if (window.define) {
	define(['jquery'], load_ui);
} else {
	window.mm_ui = load_ui(window.$);
}
