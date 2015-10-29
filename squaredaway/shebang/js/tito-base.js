$(document).ready(function() {
	// Add objects that should automatically receive a "first" or "last" class
	var first_last = new Array(
		'table tr',
		'table td',
		'dl dt',
		'ul li',
		'.table_container .table_default',
		'.col',
		'.ui-article-block',
		'.ui-pattern-small-art'
		);


	for (var i=0; i<first_last.length; i++){
		var f = first_last[i];
		$(f+":first-child").addClass("first");
		$(f+":last-child").addClass("last");
		}

	$("table tr:odd").addClass("odd");

	// Bind tabbing action from all uls with a class of 'tabs' to all divs
	// with a class of '.pane' that share the same container div
	$("ul.tabs").tabs("> .pane",{
			current:'active'
		});	
		
	
	// Add a class to every third and fourth instance of a square tease 
	// so we can target them with CSS in IE
/*
	$("square-tease:nth-child(3n)").addClass("third");
	$("square-tease:nth-child(4n)").addClass("fourth");
*/
	
	

/*
	// Set up tooltips
	$(".tip-trigger").tooltip({
			delay:'30',
			effect: 'toggle', //other option: 'fade'
			position: 'bottom center',
			//offset: [-50, -80],
			//fadeOutSpeed: 100,
			predelay: 0
		});	
*/

	// Set dropdowns on click
	$(".dropdown-trigger").toggle(
		function() {
			$(this).parent(".dropdown-container").addClass("dropdown-active");
		},
		function() {
			$(this).parent(".dropdown-container").removeClass("dropdown-active");
		});

	// Set dropdowns on hover
	$(".dropdown-trigger-hover").hover(
        function() {
            $(this).addClass("dropdown-active");
        },
        function() {
            $(this).removeClass("dropdown-active");
        });

    $(".dot-bar").toggle(
        function() {
            $(this).addClass("active");
        },
        function() {
            $(this).removeClass("active");
        });


	$(".spending-cat-footer").toggle(
        function() {
            $(this).parent(".spending-cat-box").addClass("active");
            $(this).find(".spending-cat-more-text").text("Less");
        },
        function() {
            $(this).parent(".spending-cat-box").removeClass("active");
            $(this).find(".spending-cat-more-text").text("More");
        });

	$("#treatment-mini .treatment-submenu-trigger").hover(
        function() {
            $(this).addClass("active");
        },
        function() {
            $(this).removeClass("active");
        });

	$(document.body).delegate(".tip-trigger", "mouseenter mouseleave", function() {
        $(this).toggleClass("tip-active");
  });


	

	/* 	Make the Drawdown graph follow user down page */
	$('#drawdown-viz-wrap').fixedScroll({fixedClass:'graph-fixed', topLimit:55});

	// Make Homepage Slider
/*
	$(".hp-billboard-nav").tabs(".hp-billboard-panes > .pane",{
			current:'nav-active',
			effect: 'horizontal',
			event:'mouseover'
		}).slideshow();
*/ 
	// Make slide group title show/hide when user hovers in/out of area
	$("#dot-nav .col-b").hover(
		
		function () {
			trace('updated');
        	$(".prevNext-group-large").animate({ 
    		opacity: 0.75
    		}, 300);

        	$(".about-page .slide-source").animate({ 
    		opacity: 1.0
    		}, 0);
		},
			function () {
        	$(".prevNext-group-large").animate({ 
    		opacity: 0.0
    		}, 300);
    		
        	$(".about-page .slide-source").animate({ 
    		opacity: 0.0
    		}, 0);
    	}
	);


$(".gsa-selection-item a").bind("click", function () {
	var parent = $(this).parent();
        siblings = parent.siblings(),
        isOn = parent.toggleClass('gsa-active').hasClass('gsa-active');

    siblings.removeClass('gsa-active', !isOn);

});

	
        
        
	}) /* end jQuery functions */
	
	function trace(msg){
		try{
			console.log(msg);
		} catch(e){}
	}
/*
;(function($){
	$.fn.fixedScroll = function(opts){
	
		var defaults = {fixedClass:'fixed', topLimit:0, bottomLimit:-1, absClass:'absolute', offset:0};
		var opts = $.extend(defaults, opts);
		
		return this.each(function(){
			var item = $(this);
			var over;
			$(window).bind('scroll resize', function(){
				var wt = $(window).scrollTop();
				var gt = 0;
				if (item.data('oy')){
					gt = item.data('oy');
				} else {
					gt = item.offset().top;
					item.data('oy', gt);
					item.data('ow', item.width());
				}	
				var dist = gt - wt;
				item.css('top', '');
				if (dist < opts.topLimit){
					item.addClass(opts.fixedClass);
					item.removeClass(opts.absClass);
					item.css('top', opts.topLimit);
					item.width(item.data('ow'));
				} else {
					item.removeClass(opts.fixedClass);
					item.removeClass(opts.absClass);
				}
				if (opts.bottomLimit > -1 ){
					if (wt > opts.bottomLimit - item.outerHeight()){
						if (!over){
							over = wt;
						}
						item.removeClass(opts.fixedClass);
						item.addClass(opts.absClass);
						var top = over - opts.offset;
 						item.css('top', top);
					}
				}
				
			
			});
			
		});
	}
})(jQuery);*/
