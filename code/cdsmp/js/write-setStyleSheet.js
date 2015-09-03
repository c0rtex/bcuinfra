<!-- Start Hide
if(navigator.userAgent.indexOf('WebTV') == -1){ /* WebTV doesn't support stylesheet switching */
	var small = 'small';
	var medium = 'medium';
	var large = 'large';
	var huge = 'huge';
	document.write('<p>');
	document.write('<div id="textsize" align="center">');
	document.write('text size:&nbsp;');
	document.write("<a id='styleSheetSmall' href='#' onClick='setActiveStyleSheet(small); return false;'><img class='footer' src='../images/ncoasmallA.gif' alt='small font' /></a>&nbsp;");
	document.write("<a id='styleSheetMedium' href='#' onClick='setActiveStyleSheet(medium); return false;'><img class='footer' src='../images/ncoamediumA.gif' alt='medium font' /></a>&nbsp;");
	document.write("<a id='styleSheetLarge' href='#' onClick='setActiveStyleSheet(large); return false;'><img class='footer' src='../images/ncoalargeA.gif' alt='large font' /></a>&nbsp;");
	document.write("<a id='styleSheetHuge' href='#' onClick='setActiveStyleSheet(huge); return false;'><img class='footer' src='../images/ncoahugeA.gif' alt='huge font' /></a>");
	document.write('</div>');
	document.write('<p>');
	}
// End -->