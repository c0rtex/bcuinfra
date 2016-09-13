//<script>
/***************************************************************
 *	Current Version: 4
 *  Authors: Pete Freitag
 *  		 Matt Finn
 *	File: user.js
 *	Description: Activedit API (AEAPI) User Controlled Functions
 *
****************************************************************/

/*
function aeapi_init(aeObject) {
	//Run at component initialization
	//This may be before the control is completely loaded
	//...
}
*/

function aeapi_onLoad(aeObject) {
	//Run once activedit is loaded
}

function aeapi_onBeforeSave(aeObject) {
	//run just before calling the save / submit function
	//overrides native function, an aeapi_local_onBeforeSave() will override this function
	
	//use the DOM to filter out just what's inside the body
	var content = aeObject.contentDocument.body.innerHTML;

	content = (ae_xhtml[1]) ? formatHTML(content) : content;
	//convert style attributes to lower case
	content = content.replace(/style="[^"]+"/gi, function(w) { return w.toLowerCase() })
	return content;
}


/*
function aeapi_onAfterSave(aeObject) {
	//runs after sucessful completion of the save functionality
	//this function will not be called if type=form
	
	//This function will override the CF_Activedit onsave="x" attribute
	//so keep it commented out, unless you intend to replace the current onsave implementation
	
	//...
}
*/

//</script>
