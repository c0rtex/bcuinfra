//font resize goes here
$(function(){

	jQuery.cookie = function (key, value, options) {
	
	    // key and at least value given, set cookie...
	    if (arguments.length > 1 && String(value) !== "[object Object]") {
	        options = jQuery.extend({}, options);
	
	        if (value === null || value === undefined) {
	            options.expires = -1;
	        }
	
	        if (typeof options.expires === 'number') {
	            var days = options.expires, t = options.expires = new Date();
	            t.setDate(t.getDate() + days);
	        }
	
	        value = String(value);
	
	        return (document.cookie = [
	            encodeURIComponent(key), '=',
	            options.raw ? value : encodeURIComponent(value),
	            options.expires ? '; expires=' + options.expires.toUTCString() : '', // use expires attribute, max-age is not supported by IE
	            options.path ? '; path=' + options.path : '',
	            options.domain ? '; domain=' + options.domain : '',
	            options.secure ? '; secure' : ''
	        ].join(''));
	    }
	
	    // key and possibly options given, get cookie...
	    options = value || {};
	    var result, decode = options.raw ? function (s) { return s; } : decodeURIComponent;
	    return (result = new RegExp('(?:^|; )' + encodeURIComponent(key) + '=([^;]*)').exec(document.cookie)) ? decode(result[1]) : null;
	};
		
	//check for cookie
	/*if($.cookie('clicks')){
	    // set variable to value of cookie
	    var clicks = parseFloat($.cookie('clicks'));
	    font_number = $.cookie('h1_font_size');
	    $('.col1').find('h1').animate({fontSize: font_number},100);
		$('.col1').find('h1').animate({fontSize: font_number},600);
		$('.col1').find('h2').animate({fontSize: font_number - 4},600);
		$('.col1').find('h3').animate({fontSize: font_number - 8},600);
		$('.col1').find('p').animate({fontSize: font_number - 10},600);
		$('.col1').find('INPUT').animate({fontSize: font_number - 10},600);
		$('.col1').find('SELECT').animate({fontSize: font_number - 10},600);
		$('.col1').find('a').animate({fontSize: font_number - 10},600);
		$('.col1').find('ul').animate({fontSize: font_number - 10},600);
		$('.col1').find('cite').animate({fontSize: font_number - 10},600);
		//disable link
		if (clicks == 3){
			$('#larger').hide();
			$('#larger_disabled').show();
		}
		if (clicks == -3){
			$('#smaller').hide();
			$('#smaller_disabled').show();
		}
	} else {
		//cookies do not exist; set cookies
		var h1_font_size = $('.col1').find('h1').css('font-size');
		if (h1_font_size == undefined || h1_font_size == '') {
		        h1_font_size = 24;
		} 
	    var clicks = 0;
	    $.cookie('clicks', clicks, { expires: 7, path: '/'  });
        $.cookie('h1_font_size', h1_font_size, { expires: 7, path: '/' });
	}*/
	
	//make font larger
	/*$('a#larger').click(function(){
		//if clicks is less than 3, increase the font size
		if (clicks < 3){
			//increase font size by 2 pixels
			font_number = parseFloat($.cookie('h1_font_size'));
			font_number += 2;
			clicks += 1;
			$.cookie('clicks', clicks, { expires: 7, path: '/' });
			$.cookie('h1_font_size', font_number, { expires: 7, path: '/' });
			$('.col1').find('h1').animate({fontSize: font_number},100);
			$('.col1').find('h1').animate({fontSize: font_number},600);
			$('.col1').find('h2').animate({fontSize: font_number - 4},600);
			$('.col1').find('h3').animate({fontSize: font_number - 8},600);
			$('.col1').find('p').animate({fontSize: font_number - 10},600);
			$('.col1').find('INPUT').animate({fontSize: font_number - 10},600);
			$('.col1').find('SELECT').animate({fontSize: font_number - 10},600);
			$('.col1').find('a').animate({fontSize: font_number - 10},600);
			$('.col1').find('ul').animate({fontSize: font_number - 10},600);
			$('.col1').find('cite').animate({fontSize: font_number - 10},600);
			$('#larger').show();
			$('#larger_disabled').hide();
			$('#smaller').show();
			$('#smaller_disabled').hide();
			return false;
		} else {
			//ELSE do nothing but disable the link to increase font size
			$('#larger').hide();
			$('#larger_disabled').show();
			return false;
		}
	});*/
	
	//make font smaller
	/*$('a#smaller').click(function(){
		//if clicks is greater than -3, increase the font size
		if (clicks > -3){
			//decrease font size by 2 pixels
			font_number = parseFloat($.cookie('h1_font_size'));
			font_number -= 2;
			clicks -= 1;
			// set number of clicks in cookie
			$.cookie('clicks', 0, { expires: 7, path: '/' });
			$.cookie('h1_font_size', font_number, { expires: 7, path: '/' });
			$('.col1').find('h1').animate({fontSize: font_number},100);
			$('.col1').find('h1').animate({fontSize: font_number},600);
			$('.col1').find('h2').animate({fontSize: font_number - 4},600);
			$('.col1').find('h3').animate({fontSize: font_number - 8},600);
			$('.col1').find('p').animate({fontSize: font_number - 10},600);
			$('.col1').find('INPUT').animate({fontSize: font_number - 10},600);
			$('.col1').find('SELECT').animate({fontSize: font_number - 10},600);
			$('.col1').find('a').animate({fontSize: font_number - 10},600);
			$('.col1').find('ul').animate({fontSize: font_number - 10},600);
			$('.col1').find('cite').animate({fontSize: font_number - 10},600);
			$('#smaller').show();
			$('#smaller_disabled').hide();
			$('#larger').show();
			$('#larger_disabled').hide();
			return false;
		} else {
			//ELSE do nothing but disable the link to increase font size
			$('#smaller').hide();
			$('#smaller_disabled').show();
			return false;
		}
	});*/
	
	//reset
	/*$('a#reset').click(function(){
			//reset all fonts
			font_number = 24;
			clicks = 0;
			// set number of clicks in cookie
			$.cookie('clicks', clicks, { expires: 7, path: '/' });
			$.cookie('h1_font_size', font_number, { expires: 7, path: '/' });
			$('.col1').find('h1').animate({fontSize: font_number},100);
			$('.col1').find('h1').animate({fontSize: font_number},600);
			$('.col1').find('h2').animate({fontSize: font_number - 4},600);
			$('.col1').find('h3').animate({fontSize: font_number - 8},600);
			$('.col1').find('p').animate({fontSize: font_number - 10},600);
			$('.col1').find('INPUT').animate({fontSize: font_number - 10},600);
			$('.col1').find('SELECT').animate({fontSize: font_number - 10},600);
			$('.col1').find('a').animate({fontSize: font_number - 10},600);
			$('.col1').find('ul').animate({fontSize: font_number - 10},600);
			$('.col1').find('cite').animate({fontSize: font_number - 10},600);
			$('#larger').show();
			$('#larger_disabled').hide();
			$('#smaller').show();
			$('#smaller_disabled').hide();
			return false;
	});*/
	
	//check for cookie
	if($.cookie('clicks')){
	    // set variable to value of cookie
	    font_number = $.cookie('h1_font_size');
	    $('.col1').find('h1').css('font-size',font_number);
		$('.col1').find('h1').css('font-size',font_number);
		$('.col1').find('h2').css('font-size',font_number - 4);
		$('.col1').find('h3').css('font-size',font_number - 8);
		$('.col1').find('p').css('font-size',font_number - 10);
		//$('.col1').find('INPUT').css('font-size',font_number - 12);
		//$('.col1').find('SELECT').css('font-size',font_number - 12);
		$('.col1').find('a').css('font-size',font_number - 10);
		$('.col1').find('ul').css('font-size',font_number - 10);
		$('.col1').find('cite').css('font-size',font_number - 10);
		
		//questionnaire
		$('.row').find('h1').css('font-size',font_number);
		$('.row').find('h1').css('font-size',font_number);
		$('.row').find('h2').css('font-size',font_number - 4);
		$('.row').find('h3').css('font-size',font_number - 8);
		$('.row').find('p').css('font-size',font_number - 10);
		//$('.row').find('INPUT').css('font-size',font_number - 12);
		//$('.row').find('SELECT').css('font-size',font_number - 12);
		$('.row').find('a').css('font-size',font_number - 10);
		$('.row').find('ul').css('font-size',font_number - 10);
		$('.row').find('cite').css('font-size',font_number - 10);
		
		//reset font size on banner section of home page
		$('#feature').find('h1').css('font-size',24);
		$('#feature').find('h2').css('font-size',24 - 4);
		$('#feature').find('h3').css('font-size',24 - 8);
		$('#feature').find('p').css('font-size',24 - 10);
		$('#feature').find('a').css('font-size',24 - 10);
		//disable link
		if (font_number == 24){
			$('#reset').hide();
			$('#reset_disabled').show();
		}
		if (font_number == 28){
			$('#larger').hide();
			$('#larger_disabled').show();
		}
		if (font_number == 32){
			$('#largest').hide();
			$('#largest_disabled').show();
		}
	} else {
		//cookies do not exist; set cookies
		var h1_font_size = $('.col1').find('h1').css('font-size');
		if (h1_font_size == undefined || h1_font_size == '') {
		        h1_font_size = 24;
		} 
        $.cookie('h1_font_size', h1_font_size, { expires: 7, path: '/' });
        $('#reset').hide();
		$('#reset_disabled').show();
	}
	
	$('a#larger').click(function(){
			font_number = 28;
			$.cookie('h1_font_size', font_number, { expires: 7, path: '/' });
			$('.col1').find('h1').css('font-size',font_number);
			$('.col1').find('h1').css('font-size',font_number);
			$('.col1').find('h2').css('font-size',font_number - 4);
			$('.col1').find('h3').css('font-size',font_number - 8);
			$('.col1').find('p').css('font-size',font_number - 10);
			//$('.col1').find('INPUT').css('font-size',font_number - 12);
			//$('.col1').find('SELECT').css('font-size',font_number - 12);
			$('.col1').find('a').css('font-size',font_number - 10);
			$('.col1').find('ul').css('font-size',font_number - 10);
			$('.col1').find('cite').css('font-size',font_number - 10);
			$('#reset').show();
			$('#reset_disabled').hide();
			$('#larger').hide();
			$('#larger_disabled').show();
			$('#largest').show();
			$('#largest_disabled').hide();
			return false;
	});

	$('a#largest').click(function(){
			font_number = 32;
			$.cookie('h1_font_size', font_number, { expires: 7, path: '/' });
			$('.col1').find('h1').css('font-size',font_number);
			$('.col1').find('h1').css('font-size',font_number);
			$('.col1').find('h2').css('font-size',font_number - 4);
			$('.col1').find('h3').css('font-size',font_number - 8);
			$('.col1').find('p').css('font-size',font_number - 10);
			//$('.col1').find('INPUT').css('font-size',font_number - 12);
			//$('.col1').find('SELECT').css('font-size',font_number - 12);
			$('.col1').find('a').css('font-size',font_number - 10);
			$('.col1').find('ul').css('font-size',font_number - 10);
			$('.col1').find('cite').css('font-size',font_number - 10);
			$('#reset').show();
			$('#reset_disabled').hide();
			$('#larger').show();
			$('#larger_disabled').hide();
			$('#largest').hide();
			$('#largest_disabled').show();
			return false;
	});	
	
	//reset
	$('a#reset').click(function(){
			//reset all fonts
			font_number = 24;
			clicks = 0;
			// set number of clicks in cookie
			$.cookie('clicks', clicks, { expires: 7, path: '/' });
			$.cookie('h1_font_size', font_number, { expires: 7, path: '/' });
			$('.col1').find('h1').css('font-size',font_number);
			$('.col1').find('h1').css('font-size',font_number);
			$('.col1').find('h2').css('font-size',font_number - 4);
			$('.col1').find('h3').css('font-size',font_number - 8);
			$('.col1').find('p').css('font-size',font_number - 10);
			//$('.col1').find('INPUT').css('font-size',font_number - 12);
			//$('.col1').find('SELECT').css('font-size',font_number - 12);
			$('.col1').find('a').css('font-size',font_number - 10);
			$('.col1').find('ul').css('font-size',font_number - 10);
			$('.col1').find('cite').css('font-size',font_number - 10);
			$('#reset').hide();
			$('#reset_disabled').show();
			$('#larger').show();
			$('#larger_disabled').hide();
			$('#largest').show();
			$('#largest_disabled').hide();
			return false;
	});
	
});