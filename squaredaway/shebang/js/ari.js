var articleNavigator;

$(document).ready(function() {
	
	function ArticleNavigator() {
		this.refresh();
	}

	$('#fixed-article-body-nav').localScroll({duration: 1000, onAfter: this.resetClicked});
	var wasClicked = false;
	
	ArticleNavigator.prototype.resetClicked = function() {
		wasClicked = false;
	}
	
	$(".article-body-nav-item").live('click', function() {
		if ($(this).hasClass('item-active')){
		} else {
			wasClicked = true;
			$(".article-body-nav").children().removeClass("item-active");
			$(this).addClass("item-active");
		}
	});
	
	ArticleNavigator.prototype.refresh = function(){
		if ($("#fixed-article-body-nav").is('*')) {
			// only do this if not ie7
			if (window.pageYOffset != undefined) {
				slideArray = new Array();
				
				$('.ui-article-block, tr.excel-output-header-marker').each(function(e) {
					var offset = $(this).offset().top - ($(window).height() * 0.2);
					var offsetBottom = $(this).height() + offset;
					var id = $(this).attr('id');
					if (!id){
						var newID = $(this).text();
						$(this).attr('id', newID);
						id = newID;
					}
					id = '#' + id;
					var itemArray = new Array(offset, offsetBottom, id);
					slideArray.push(itemArray);
				});
								
				$(window).scroll(function() {
					if (wasClicked == false) {
						var scrollPos = $(window).scrollTop();
						if (scrollPos == 0) {
							scrollPos = document.documentElement.scrollTop;
						}
						var docHeight = $(document).height();
						retarget();
					}
				});
			}
		}
	};
	
	function retarget() {
		var currentIndex;
		var scrollPos = $(window).scrollTop();
		if (scrollPos == 0) {
			scrollPos = document.documentElement.scrollTop;
		}
		slideSize = slideArray.length;
		
		// condition for if you are above the top item
		if (scrollPos < slideArray[0][0]) {
			$('.item-active').removeClass('item-active');
			$('.article-body-nav-item:eq(0)').addClass('item-active');
			
		// condition for if you're on the last item
		} else if (scrollPos > slideArray[slideSize-1][0]) {
			$('.item-active').removeClass('item-active');
			$('.article-body-nav-item:last').addClass('item-active');
			
		} else {
			// find current item's index
			for (var i=0; i<slideArray.length; i++) {
				if (scrollPos >= slideArray[i][0] && scrollPos < slideArray[i+1][0]) {
					currentIndex = i;
					break;
				}
			}
			$('.item-active').removeClass('item-active');
			$('.article-body-nav-item:eq('+currentIndex+')').addClass('item-active');
		}
		$('.navlink').show();
		//console.log('done');
	}
	
	articleNavigator = new ArticleNavigator();
});