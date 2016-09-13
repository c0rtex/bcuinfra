/*
 * BCU Javascript Library
 *
 * $Date: 2008-07-8 14:22:17 -0400 (Sat, 24 May 2008) $
 * $Rev: 1 $
 * 
 */
 
function highlight_off(item) {
	var tag = item + "h";
	if (document.getElementById(tag)) {
		var oetag = document.getElementById(tag);
		oetag.id = item;
	}
}

function highlight(item) {
	if (document.getElementById(item)) {
		var oetag = document.getElementById(item);
		oetag.id = item + "h";
	}
}

function fixpopups() {
	var tag = "privacy";
	if (document.getElementById(tag)) {
			var oetag = document.getElementById(tag);
			oetag.href = "javascript:help2('/privacy.cfm')";
		}
	
		var tag2 = "terms";
		if (document.getElementById(tag2)) {
			var oetag2 = document.getElementById(tag2);
			oetag2.href = "javascript:help2('/terms.cfm')";
		}
	}