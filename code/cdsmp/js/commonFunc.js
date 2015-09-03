<!-- Start Hide

function get_url_param(name) { 
	name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]"); 
	var regexS = "[\\?&]"+name+"=([^&#]*)"; 
	var regex = new RegExp( regexS ); 
	var results = regex.exec( window.location.href ); 
	if( results == null )    return ""; 
	else return results[1];
}
function popupTest() {
	var winName = window.name;
	if (winName.indexOf("Popup") != -1) {
		window.opener.location.reload(true);
		window.close();
	}
}
function unhideID(divID,inDispOpt) {
	  var item = document.getElementById(divID);
	  if (item) {
	    item.style.display=(inDispOpt)?inDispOpt:'inline';
	  }
}
function hideID(divID) {
	  var item = document.getElementById(divID);
	  if (item) {
	    item.style.display = 'none';
	  }
}
function setPersonId() {
	var perId = get_url_param('personId');
	document.getElementById('personId').value = perId;
	return true;
}
function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
	w += 32;
	h += 96;
	var win = window.open(url,
				name,
				'width=' + w + ', height=' + h + ', ' +
				'location=no, menubar=no, ' +
				'status=no, toolbar=no, scrollbars=no, resizable=no');
	win.resizeTo(w, h);
	win.focus();
}
//End -->
