<!-- Start Hide


function loadActiveStyleSheet() {
    var cookie = readCookie("style");
    var title = cookie ? cookie : getPreferredStyleSheet();
    setActiveStyleSheet(title);
}

function setActiveStyleSheet(title) {
    var i, a, main;
    for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
      if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title")) {
        a.disabled = true;
        if(a.getAttribute("title") == title) a.disabled = false;
      }
    }
    createCookie("style", title, 365);
    
    var smallLink = document.getElementById("styleSheetSmall");
    var mediumLink = document.getElementById("styleSheetMedium");
    var largeLink = document.getElementById("styleSheetLarge");
    var hugeLink = document.getElementById("styleSheetHuge");

		if (smallLink!=null) {/*if the links are showing, select the active link*/
	    if (title == "small") {
	   	  smallLink.className = "selectedStyleSheet";
	    	mediumLink.className = "notSelectedStyleSheet";
	    	largeLink.className = "notSelectedStyleSheet";
	    	hugeLink.className = "notSelectedStyleSheet";
	    }
	    if (title == "medium") {
	    	smallLink.className = "notSelectedStyleSheet";
	    	mediumLink.className = "selectedStyleSheet";
	    	largeLink.className = "notSelectedStyleSheet";
	    	hugeLink.className = "notSelectedStyleSheet";
	    }
	    if (title == "large") {
	    	smallLink.className = "notSelectedStyleSheet";
	    	mediumLink.className = "notSelectedStyleSheet";
	    	largeLink.className = "selectedStyleSheet";
	    	hugeLink.className = "notSelectedStyleSheet";
	    }
	    if (title == "huge") {
	    	smallLink.className = "notSelectedStyleSheet";
	    	mediumLink.className = "notSelectedStyleSheet";
	    	largeLink.className = "notSelectedStyleSheet";
	    	hugeLink.className = "selectedStyleSheet";
	    }
		}

  }

function getActiveStyleSheet() {
    var i, a;
    for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
      if(a.getAttribute("rel").indexOf("style") != -1 && a.getAttribute("title") && !a.disabled) return a.getAttribute("title");
    }
    return null;
  }

function getPreferredStyleSheet() {
    var i, a;
    for(i=0; (a = document.getElementsByTagName("link")[i]); i++) {
      if(a.getAttribute("rel").indexOf("style") != -1
         && a.getAttribute("rel").indexOf("alt") == -1
         && a.getAttribute("title")
         ) return a.getAttribute("title");
    }
    return null;
  }

function createCookie(name,value,days) {
    if (days) {
      var date = new Date();
      date.setTime(date.getTime()+(days*24*60*60*1000));
      var expires = "; expires="+date.toGMTString();
    }
    else expires = "";
    document.cookie = name+"="+value+expires+"; path=/";
  }

  function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1,c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
  }
// End -->