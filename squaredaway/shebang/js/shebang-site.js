$(document).ready(function(){
	initQuicksand();
	initPrint();
	initCloseButtons();
	initTagCleaner();
	initHomePageSlider();
	initHomePageBillboard();
	imgLinkFix();
	initSquareClasser();
	initMenus();
	initAutoComplete();
	initBookmarks();
	initFixedScroll();
	fixTables();
	initSiteNag();
	$('.trigger-qs').first().click();
});

function initSiteNag(){
	var stopNag = shebangGetValue('stop_nag');
	if (!$('body').hasClass('getting-squared-away') && !stopNag){
		$('.nag-container').fadeIn(1000);
		$('.nag-close').click(function(e){
			e.preventDefault();
			shebangSaveValue('stop_nag', true);
			$('.nag-container').fadeOut(350);
		});
	}
}

function fixTables(){
	$('.article-text table').each(function(){
		var table = $(this);
		var parent = table.closest('.excel-upload-output');
		if (!parent.length){
			table.addClass('table');
		}
	});
}

function initFixedScroll(){
	$('#fixed-article-body-nav').fixedScroll({fixedClass:'fixed', topLimit:10, container:'.article-body-col-group', forceTop:true});
}

function initBookmarks(){
	$('.trigger-bookmark').bind('click', function(){
		if (window.sidebar){ 
		// firefox
			window.sidebar.addPanel(title, url, "");
		} else if ($.browser.opera){ // opera
			var elem = document.createElement('a');
			elem.setAttribute('href',url);
			elem.setAttribute('title',title);
			elem.setAttribute('rel','sidebar');
			elem.click();
		} else if($.browser.msie){ 
			window.external.AddFavorite(url, title);
		} else {
			$(this).hide();
		}
	});
	if ($.browser.webkit){
		$('.trigger-bookmark').hide();
	}
}

function initAutoComplete(){
	
	var userSearch;
	
	var acOptions = {
		ajax:'/wp-content/themes/shebang/search/search_instant.php',
		autoFill:true,
		minChars:3,
		newList:true,
		postVar:'q',
		requestType:'get',
		rollover:'search-result-li-hover',
		onListFormat:onAutoCompleteResult,
		onRollover:onAutoCompleteRollover,
		onSelect:onAutoCompleteSelect,
		onLoad:onAutoCompleteLoad,
	}	
	if (document.domain == 'localhost'){
		acOptions.ajax = '/wp-content/themes/shebang/search/search_static_test.php';
	}
	$('.instant-search').autoComplete(acOptions);
	trace($('.instant-search'));
	acOptions.width = 400;
	$('.instant-search-small').css('position', 'relative').autoComplete(acOptions);
	function onAutoCompleteLoad(event, ui){
		trace('load');
		trace(ui);
		ui.list.push({title:ui.cache.val, permalink:'http://'+document.domain+'/index.php?s='+ui.cache.val, post_type:'search'});
		return ui.list;
	}
	
	function onAutoCompleteSelect(event, ui){
		if (ui.data){
			window.location = ui.data.permalink;
		} 
	}
	
	function onAutoCompleteRollover(event, ui){
		trace('rollover');
		var title = userSearch;
		if (ui.data){
			title = ui.data.title;
		}
		var input = ui.ul.prevAll('.instant-search').first();
		input.val(title);
	}
	
	function onAutoCompleteResult(event, ui){
		trace(ui);
		var ul = ui.ul;
		ul.empty();
		ul.removeClass('hasSearch');
		var input = $(event.currentTarget);
		var size = 'large';
		if (input.hasClass('instant-search-small')){
			size = 'small';
		}
		ul.attr('id', 'search-dropdown-'+size);
		ul.addClass('search-dropdown-'+size);
		$(event.currentTarget).after(ul);
		userSearch = $(event.currentTarget).val();
		trace(ui.list);
		$.each(ui.list, function(index, item){
			var li = $('<li class="search-result-li"></li>');
			item.label = item.post_type;
			if (item.label == 'search'){
				var li = $('<li class="search-result-li search-result-full-search"></li>');
				var a = $('<div class="search-result search-result-full"><span class="search-result-h-full">Full Results Page</div>');
			} else {
				var newLabel = item.label.replace('-', ' ');
				newLabel = newLabel.replace(/^(.)|\s(.)/g, function($1){ return $1.toUpperCase(); });
				var a = $('<div href="'+item.permalink+'" class="search-result">' +
				         '<img class="search-result-img" src="'+item.thumb_src+'" />' +
				         '<span class="search-result-h" href="#">'+item.title+'</span>' + 
				         '<span class="subheader-tag '+item.label+'-tag">'+newLabel+'</span>' +
				         '<p class="search-result-description">'+item.excerpt+'</p></div>');
			}
			if (!ul.hasClass('hasSearch')){
				li.append(a);
				ul.append(li);
			}
			ul.fadeIn();
			if (item.label == 'search'){
				ul.addClass('hasSearch');
			}
		});
		if (size == 'small'){
			ul.css('left', '320px !important');
		}

	}
}


function initMenus(){
	$('a[title="disabled"], a[title="disable"]').each(function(){
		$(this).addClass('disabled');
		$(this).attr('href', '#');
		$(this).click(function(e){
			e.preventDefault();
		});
	});
}

function initSquareClasser(){
	$('.square-tease').each(function(){
		var i = $(this).index();
		var div = 3;
		if ($('body').hasClass('home')){
			div = 4;
		}
		var nth = i%div + 1;
		$(this).addClass('nth-'+nth);
	});
}

function initHomePageBillboard(){
	/* When you click the Billboard item, go to the slide's link */
	$('.hp-billboard-nav-link').click(function(e){
		e.preventDefault();
		var s = $(this).data('slide');
		var slide = $('.hp-billboard-block').eq(s);
		window.location = slide.find('a').attr('href');
	});
}

function initHomePageSlider(){
	$('.hp-billboard-slider article').css('float', 'left');
	$('.hp-billboard-slider article').css('width', '960px');
	$('.hp-billboard-slider article').wrapAll('<div class="items"></div>');
	$('.hp-billboard-slider').css('position', 'relative');
	$('.hp-billboard-slider').css('overflow', 'hidden');
	$('.hp-billboard-slider').css('padding-top', '0px');
	$('.hp-billboard-slider').css('top', '150px');
	$('.hp-billboard-slider .items').css('width', '20000em');
	$('.hp-billboard-slider .items').css('position', 'absolute');
	var scroll = $('.hp-billboard-slider').scrollable({keyboard:false, onBeforeSeek:moveHomepageArrow, api:true, onSeek:onHomepageSeek});
	var hiConfig = {
		over:function(){
			var index = $(this).find('a').data('slide');
			scroll.seekTo(index);
		},
		out:function(){},
		interval:60,
		};
	$('.hp-billboard-nav-item').hoverIntent(hiConfig);
	$('.hp-billboard-nav-item').eq(0).addClass('nav-active');
	$('.hp-billboard-next-btn, .hp-billboard-prev-btn').click(function(e){
		e.preventDefault();
	});
}

function onHomepageSeek(event, index){
}

function moveHomepageArrow(event, index){
	var scroll = $('.hp-billboard-slider').data('scrollable');
	var currentIndex = scroll.getIndex();
	if (currentIndex == index){
		return;
	}
	var li = $('.hp-billboard-nav-item').eq(index);
	var left = '15%';
	if (index == 1){
		left = '48%';
	}
	if (index == 2){
		left = '81.75%';
	}
	$('.hp-billboard-nav-item').removeClass('nav-active');
	li.addClass('nav-active');
	$('.hp-billboard-active-arrow-group').css('left', left);
	/* Homepage Dollar Sign */
	var j = index + 1;
	if (j < 4){
		$('.hp-billboard-dollar-img').removeClass('slide-1 slide-2 slide-3');
		$('.hp-billboard-dollar-img').addClass('slide-'+j);
	}
}

function initCloseButtons(){
	$('.action-close-btn').click(function(e){
		e.preventDefault();
		$(this).closest('div, article').slideUp();
	})	
}

function initPrint(){
	$('.trigger-print').click(function(e){
		e.preventDefault();
		window.print();
	});
}

function initTagCleaner(){
	$('.ui-article-block p, .aside-text p').each(function(){
		var p = $(this);
		var phtml = p.html();
		if (phtml){
			if (!p.html().length){
				
			}
			if (!phtml.trim().length){
				p.remove();
			}
			if(p.html().trim() == ''){
				p.remove();
			}
		}
	});
	
	/* Wrap <p>s in lists */
	$('.ui-article-block li').wrapInner('<p>');
}
	
function initQuicksand(){
	$('.qs-sort-container').css('position', 'static');
	$('.tool-page-square-group, .tag-page-square-group').css('position', 'relative');
	$('.trigger-qs').each(function(){
		var target = $(this).data('target');
		var sel = '.'+target + ' a';
		if (!$(sel).length){
			$(this).slideUp();
		}
	});
	$('.trigger-qs').click(function(e){
		e.preventDefault();
		var target = $(this).data('target');
		var sel = '.'+target + ' a';
		$('.qs-sort-container').quicksand($(sel), {attribute:'data-id', adjustHeight:false}, onQuicksandComplete);
		var li = $(this).closest('li');
		li.siblings().removeClass('filter-active');
		li.addClass('filter-active');
	});
}

function onQuicksandComplete(e){
	var container = $(this).closest('.qs-sorter').addClass('.qs-active');
}

/* Traverses Learn More / How To pages and adds class of 'img-link' to any links that contain images */
function imgLinkFix() {
	$('img').parent('a').addClass('img-link');
}

function trace(msg){
	try{
		console.log(msg);
	} catch(e){}
}
