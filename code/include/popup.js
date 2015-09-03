function addEvent(obj, evType, fn, useCapture){
	var enable = false;
	if (typeof document.body.style.maxHeight != 'undefined') enable = true;
	if (enable && obj.addEventListener) {
		obj.addEventListener(evType, fn, useCapture);
		obj.href = 'javascript:void(0);';
		return true;
	} else if (enable && obj.attachEvent) {
		var r = obj.attachEvent('on' + evType, fn);
		obj.href = 'javascript:void(0);';
		return r;
	} else {
		void(0);
	}
}
function showPopup(e, title, text) {
	var posx;
	var posy;
	var doit = false;
	if (!e) var e = window.event;
	if (e.pageX || e.pageY) {
		posx = e.pageX;
		posy = e.pageY;
		doit = true;
	} else if (e.clientX || e.clientY) {
		posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
		posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
		doit = true;
	}
	if (doit) {
		document.getElementById('popupClose').innerHTML = ' &nbsp;[<a href="javascript:hidePopup();" class="defPopupCloseLink">close</a>]';
		document.getElementById('popupTitle').innerHTML = title;
		document.getElementById('popupBody').innerHTML = text;
		//document.getElementById('popupLayer').style.left = posx;
		//document.getElementById('popupLayer').style.top = posy;
		var portw;
		var porth;
		if (window.innerWidth) {
			portw = window.innerWidth;
			porth = window.innerHeight;
		} else {
			var x = document.body.getBoundingClientRect();
			portw = x.right - x.left;
			porth = x.bottom - x.top;
		}
		var scrollx = document.body.scrollLeft;
		var scrolly = document.body.scrollTop;
		document.getElementById('popupLayer').style.display = 'block';
		document.getElementById('shadowLayer').style.display = 'none'; 
		var popupw = document.getElementById('popupLayer').clientWidth;
		var popuph = document.getElementById('popupLayer').clientHeight;
		if (posx + popupw > scrollx + portw - 10) {
			posx = scrollx + portw - popupw - 37;
			document.getElementById('popupLayer').style.left = posx;
		}
		if (posy + popuph > scrolly + porth - 10) {
			posy = scrolly + porth - popuph - 20;
			document.getElementById('popupLayer').style.top = posy;
		}
		//document.getElementById('shadowLayer').style.width = popupw;
		//document.getElementById('shadowLayer').style.height = popuph;
		//document.getElementById('shadowLayer').style.left = posx + 10;
		//document.getElementById('shadowLayer').style.top = posy + 10;
		
		jQuery.fn.center = function () {
	    this.css("position","absolute");
	    this.css("top", (($(window).height() - this.outerHeight()) / 2) + $(window).scrollTop() + "px");
	    this.css("left", (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px");
	    this.css("top", this.position().top);
	    this.css("left", (($(window).width() - this.outerWidth()) / 2) + $(window).scrollLeft() + "px");
	    this.css("margin-left", "300px");
	    this.css("margin-top", "0px");
	    //this.css("position", "absolute"); 

    	//dialog.slideDown(500);
	    return this;
		}
	
	  //$('#popupLayer').center();
			
	}
}
function hidePopup(e) {
	document.getElementById('popupLayer').style.display = 'none';
	document.getElementById('shadowLayer').style.visibility = 'hidden'; 
}