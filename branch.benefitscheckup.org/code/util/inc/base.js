/************************************************
 * Activsoftware's ActivEdit Java Script Functions 
 *
 * Authors: Pete Freitag, Matt Finn, Greg Alton
 * URL: 	http://www.activsoftware.com
 * Email: 	support@activsoftware.com
 * Current 	Version: 5.0
 *
 * Notes:
 *   Modification of source requires an open source license
 *   Reverse Engineering of this code is prohibited
 *   All Rights Reserved Copyright 1999-2005 ActivSoftware, ActivSoftware Inc.
 ************************************************/

////////////////////////////
//    global variables    //
////////////////////////////

//debugging parameter
errlevel = 0;

var ae_olddocmd; //saves the old ondocument click function pointer 

aeObjects = new Array(); //needs to be global for spell checker
var aeFieldnames = new Array();
var ae_count;
var ae_hot; //This tells which Activedit the context menu is for
var ae_sourceview=false; //Are we viewing source?
var ae_oldfontfamily=''; //Store the old font family for inline view source 
var ae_oldfontsize=''; //Store the old font size for inline view source
var ae_HTMLMode = new Array(); //true if current control is in html mode
var ae_forms=new Array();
var ae_savedrange;
var ae_selectedImage;

var AE_DISABLED=0;
var AE_ENABLED=1;
var AE_LATCHED=2;
var AE_NINCHED=3;
var ELEMENT_NODE=1;
var ATTRIBUTE_NODE=2;
var TEXT_NODE=3;
var ae_current_font;
var ae_current_fontsize;

var ae_inc_version="5.0.52";
if(typeof(ae_version)=="undefined" || ae_inc_version!=ae_version) {
	alert("Warning: Detected mismatched versions of custom tag and inc directory!\n\n"+
		"tag version: "+ae_version+"\n"+
		"inc version: "+ae_inc_version);
}


var ae_global_styles=[
	"TABLE.ae_noborder","border:1px dashed #CCCCCC; border-collapse: collapse;",
	"TABLE.ae_noborder TR TD", "border:1px dashed #CCCCCC"];

////////////////////////////
//initialization function //
////////////////////////////

function ae_initialize(num) {
	//initializes the control
	var instance;
	ae_count=num;
	instance = document.getElementById('ae_frame'+num);
	thisContentItem=document.getElementById('ae_tx_content'+num);
	aeObjects[num] = instance;
	aeObjects[thisContentItem.name] = instance;
	aeFieldnames[num] = thisContentItem.name;
	
	var sels=document.getElementById('ae_tbar'+num).getElementsByTagName('SELECT');
	
	for(var i=0;i<sels.length;i++) {
		if(sels[i].id.indexOf('ae_select_')==0) {
			var api_function=eval('aeapi_'+sels[i].id.substring(3)+'_init');
			if(typeof(api_function)=='function') {
				api_function(sels[i]);
			}
		}
	}
		
	var node=document.getElementById('ae_tx_content'+num);
	while(node.parentNode&&node.nodeName!="FORM"&&node.nodeName!="BODY") {
		node=node.parentNode;
	}
	if(node.nodeName=="FORM") {
		if(node!=ae_forms[ae_forms.length-1]) {
			ae_forms[ae_forms.length]=node;
			node._ae_orig_submit=node.submit;
			node.submit=new Function('', 'ae_submitForm('+(ae_forms.length-1)+');');
		}
		
		//bind onSubmit event to ae_onSubmit()
		if(node.addEventListener) {
			node.addEventListener('submit', ae_onSubmit, false);
		} else if(node.attachEvent) {
			node.attachEvent('onsubmit',ae_onSubmit);
		} else {
			node.onsubmit=ae_onSubmit;
		}
	} else {
		alert("Activedit must be contained in a form.", "", true);
		return;
	}
	
	//initialize member functions
	instance.pasteHTML=ae_bs_proto_pasteHTML;
	instance.stylizeText=ae_bs_proto_stylizeText;	

	ae_bs_init(num);
	ae_HTMLMode[num] = false;
	setTimeout("ae_onLoad("+num+");", 100);	
}

function ae_onLoad(num) {
	var instance=aeObjects[num];
	if(ae_bs_busycheck(num)) {
		setTimeout("ae_onLoad("+num+");", 100);	
		return;
	}

	ae_bs_load(num);
	
	instance.DOM=instance.contentDocument; //for backward compatibility with ae4

	if(num==1) {
		if(window.addEventListener) {
			window.addEventListener("unload",ae_onUnload,false);
		} else if(window.attachEvent) {
			window.attachEvent("onunload",ae_onUnload);
		} else {
			window.onunload=ae_onUnload;
		}
	}


	if(ae_defaultfont[num].length) 
		instance.contentDocument.body.style.font=ae_defaultfont[num];

	if(ae_backgroundcolor[num].length) {
		instance.contentDocument.body.style.backgroundColor=ae_backgroundcolor[num];	
	}
			
	ae_refreshToolbar(num);
	if(typeof(aeapi_local_onLoad)=='function')
		aeapi_local_onLoad(instance, aeFieldnames[num]);
	if (typeof(aeapi_onLoad)=='function')
		aeapi_onLoad(instance, aeFieldnames[num]);

	ae_dress_wysiwyg(num);
}

function ae_dress_wysiwyg(num) {
	var instance=aeObjects[num];
        var tables=instance.contentDocument.getElementsByTagName('table');
	for(var i=0;i<tables.length;i++) {
		ae_dress_table(tables[i]);
	}

	var base=ae_baseurl[num];
	if(base.charAt(base.length-1)!='/')
		base=base+'/';

	var links=instance.contentDocument.getElementsByTagName('a');
	for(var i=0;i<links.length;i++) {
		links[i].href=ae_absolutify_url(base, links[i].href);
	}

	var images=instance.contentDocument.getElementsByTagName('img');
	for(var i=0;i<images.length;i++) {
		images[i].src=ae_absolutify_url(base, images[i].src);
	}
}

function ae_absolutify_url(base, url) {

	if(url.charAt(0)=='/') { 
		var basebase=base.replace(/(.*:\/\/[^\/]*)\/?.*/,"$1");
		return basebase+url;
	} else if(url.indexOf(':')==-1) {
		return base+url;
	} else {
		return url;
	}
}

function ae_relativize_url(base, url) {
	if(url.length>base.length&&url.substring(0,base.length)==base) {
		return url.substring(base.length);
	} else {
		return url;
	}
}

function ae_dress_table(table) {
	if((typeof table.border =='undefined' || table.border=='' || table.border=='0')) {
		if(table.className=='') {
			table.className='ae_noborder';
		}
	}
}

function ae_undress_table(table) {
	if(table.className=='ae_noborder') {
		table.className='';
		table.removeAttribute("class");
		table.removeAttribute("className");
	}
}

function ae_undress_wysiwyg(num) {
	var instance=aeObjects[num];
        var tables=instance.contentDocument.getElementsByTagName('table');
	for(var i=0;i<tables.length;i++) {
		ae_undress_table(tables[i]);
	}
	
	var base=ae_baseurl[num];
	if(base.charAt(base.length-1)!='/')
		base=base+'/';

	var links=instance.contentDocument.getElementsByTagName('a');
	for(var i=0;i<links.length;i++) {
		links[i].href=ae_relativize_url(base, links[i].href);
	}

	var images=instance.contentDocument.getElementsByTagName('img');
	for(var i=0;i<images.length;i++) {
		images[i].src=ae_relativize_url(base, images[i].src);
	}
}

var ae_formatTags=new Array("SPAN", "FONT", "B", "I", "U", "STRIKE", "EM", "SUB", "SUP", "DEL", "SMALL", "BIG");

function ae_isFormatTag(tagName) {
	var utagname=tagName.toUpperCase();
	for(var i=0;i<ae_formatTags.length;i++) {
		if(utagname==ae_formatTags[i]) return true;
	}
	return false;
}

function ae_onUnload() {
	var ae_content = "";
	var i;	
	var instance
	for(i=1;i<=ae_count;i++) {
		instance=aeObjects[i];
		thisContentItem = document.getElementById("ae_tx_content"+i);
		if(ae_sourceview) ae_editsourceinline(i,false);
		var content = instance.contentDocument.body.innerHTML;
		thisContentItem.value = content;
	}
}
////////////////////////////
//   event listeners      //
////////////////////////////

function ae_submitForm(num) {
	try {
		ae_onSubmit();
	} catch(e) {}
	
	ae_forms[num]._ae_orig_submit();
}

function ae_onSubmit() {
	var ae_content = "";
	var i;
	var instance;
	var stored_e
	for(i=1;i<=ae_count;i++) {
		instance=aeObjects[i];
		if(ae_HTMLMode[i]) ae_editsourceinline(i,false);
		thisContentItem = document.getElementById("ae_tx_content"+i);
		if(typeof(aeapi_local_onBeforeSave)=='function') {
			try {
				ae_content = aeapi_local_onBeforeSave(instance, aeFieldnames[i]);
			} catch(e) {
				try {
					ae_content = aeapi_onBeforeSave(instance, aeFieldnames[i]);
				} catch(e) {
					ae_content = ae_onBeforeSave(instance, aeFieldnames[i]);
				}
			}
		} else if (typeof(aeapi_onBeforeSave)=='function') {
			try {
				ae_content = aeapi_onBeforeSave(instance, aeFieldnames[i]);
			} catch(e) {
				ae_content = ae_onBeforeSave(instance, aeFieldnames[i]);
			}
		} else {
			ae_content = ae_onBeforeSave(instance, aeFieldnames[i]);
		}
		thisContentItem.value = ae_content;
	}
	return true;
}

function ae_onclick(num) {
	ae_refreshToolbar(num);
}

function ae_ondisplaychange(num) {
 	ae_refreshToolbar(num);
}

////////////////////////////
//    member functions    //
////////////////////////////

function ae_onCommand(e, cmdid, num) {
	if(e==null) e=window.event;

	if(typeof(num)=="undefined") {
		num=ae_hot;
	} else {
		ae_hot=num;
	}
	
	document.getElementById('ae_rightmenu').style.visibility='hidden';
	
	var instance=aeObjects[num];
	if(e.preventDefault) e.preventDefault();
	e.returnValue=false;
	e.cancelBubble=true;
	
	//only find and replace should work in html mode
	if (ae_HTMLMode[num]) { if (cmdid != 'Replace' && cmdid != 'Find') return false; }


	var cmdFunction;
	try {
		cmdFunction=eval("ae_cmd_"+cmdid);
	} catch(e) {}
	if(typeof(cmdFunction)=="function") {
		cmdFunction(num);
	} else {
		ae_bs_command(cmdid, num);
	}
	ae_refreshToolbar(num);
	return false;
}

function ae_cmd_InsertImage(num) {
	var instance=aeObjects[num];
	ae_selectedImage=ae_bs_getSelectedImage(num);
	if(ae_selectedImage!=null) {
		ae_imagePropertiesWin(num);
	} else {
		onImagewin(num);
	}
}

function ae_cmd_EditSource(num) {
	var instance=aeObjects[num];
	if(ae_tabview[num]) {
		ae_editsourceinline(num);
		return true;
	} else { 
		ae_editsource(num);
	}
		
}

function dump(o) {
	var v='';
	for(var x in o) {
		v+=x+'\n';
	}
	var dumpwin=window.open('' ,"ae_dumpwin","scrollbars=yes,width=350,height=400, resizable=yes").focus();
	dumpwin.document.write('<pre>');
	dumpwin.document.write(v);
	dumpwin.document.write('</pre>');
	dumpwin.document.close();

}

function ae_cmd_Strike(num) {
	ae_bs_wrapTag(num, "STRIKE");
}
function ae_cmd_Subscript(num) {
	ae_bs_wrapTag(num, "SUB", ["SUB","SUP"]);
}
function ae_cmd_Superscript(num) {
	ae_bs_wrapTag(num, "SUP", ["SUB","SUP"]);
}

function ae_customExec(btnName, num) {
	//custom button api
	if (typeof(eval("aeapi_custom_"+btnName)) != "function") {
		alert("Custom API Function: aeapi_custom_" + btnName + "(aeNum)\nIs not accessible, or defined incorrectly.\nPlease refer to the documentation.");
		return;		
	}
	aeObject = aeObjects[num];
	eval("aeapi_custom_" + btnName + "(" + num + ")");
}

function ae_cmd_InsertHR(num) {
	var instance=aeObjects[num];
	instance.focus();
	//spawn image properties window
	var szURL=ae_inc + "hr.htm?instance=" + num;
	window.open(szURL ,"ae_hrwin","scrollbars=no,width=350,height=205, resizable=no").focus();
}

function equalsIgnoreCase (s1, s2) {
	return s1.toLowerCase()==s2.toLowerCase();
}

function ae_cmd_Highlight(num) {
	var instance = aeObjects[num];
	var textRange=ae_bs_range(instance);
	var node = textRange.parentElement();
	while (node!=null&&node.nodeName!='BODY') {
		if (node.nodeName == "SPAN" && node.style.backgroundColor == "yellow") {
			//remove the strike
			node.style.backgroundColor = "";
			if(node.style.cssText=='') {
				ae_bs_removeNode(node,false);
			}
			return;
		}
		node = node.parentNode;
	}
	ae_bs_wrapTag(num, 'SPAN', null, {style:'background-color:yellow;'});
}

function ae_cmd_ImageProperties(num) {
	ae_selectedImage=ae_bs_getSelectedImage(num);
   	if(ae_selectedImage!=null) ae_imagePropertiesWin(num);
}

function ae_imagePropertiesWin(num) {
	var instance=aeObjects[num];
	instance.contentDocument.body.focus();
	//spawn image properties window
	var szURL=ae_inc + "imageProperties.htm?instance=" + num;
	window.open(szURL ,"ae_imgpropwin","scrollbars=no,width=420,height=355, resizable=yes").focus();
}

function ae_cmd_Paste(num) {
        var instance=aeObjects[num];
        try {
                instance.contentDocument.execCommand("Paste");
        } catch(e) {
                alert('Your browser\'s security settings do not allow the Paste command. Please use Ctrl+V instead.');
        }
        replaceFontsWithSpans(instance, instance.contentDocument.body, null);
        ae_cleanWord(instance);
}

function ae_cmd_PasteText(num) {
	ae_bs_saveRange(num);
	ae_bs_cmd_PasteText(num);
}

function ae_cmd_ToggleDetails(num) {
	var instance=aeObjects[num];
	instance.ShowDetails = bVal;
}

function ae_cmd_EditTable(num) {
	window.open(ae_inc + 'edittable.htm', "editTbl", "directories=no,height=310,width=350,location=no,menubar=no,status=no,toolbar=no").focus();
}

function ae_cmd_InsertTable(num) {
	var instance=aeObjects[num];
	ae_bs_saveRange(num);
	
	if(ae_bs_getCommandState(instance,"InsertTable")==AE_DISABLED)
	{
	   	instance.focus();
	   	instance.contentDocument.body.focus();
	 	return;
	}	
	window.open(ae_inc + "table.htm", "ae_inserttablewin", "Width=480, Height=250").focus();
}

//dropdown table selector
function onTable(num) {
  	//open's table dialog window
	 //if it's in a tables

    //no buttons should work in html mode
	if (ae_HTMLMode[num]) { return; }
	var instance =aeObjects[num];
	if(ae_bs_getCommandState(instance, "InsertTable") == AE_DISABLED) 
	{
	   	instance.focus();
	   	instance.contentDocument.body.focus();
  		return;
	}
	if(	document.getElementById('quicktable').style.visibility == "visible" ) {
		closePopupFrame();
		return;
	}
	
	var str = makeTable(4, 5);
	str = str + "<div style=\"background-color:#FFFFFF;text-align:center;\" id=\"tblstat\">1 by 1 Table</div>";
	
	var obj=document.getElementById('ae_tbtn'+num);
	createPopupFrame(instance, obj, str);
	ae_hot=num;
	document.getElementById("quicktable").contentWindow.document.body.onmouseover = paintTable;	
	document.getElementById("quicktable").contentWindow.document.body.onmousedown = new Function("e","return insertTable(null,null,null,null,e);");
}

/* creates the popup iframe used for quick table, and quick font color */
function createPopupFrame(instance, btnObject, htmlSrc)
{
	var ifrm = document.getElementById("quicktable");
	var obj= btnObject;
	var x=0;
	var y=0;
	ifrm.contentWindow.document.body.innerHTML=htmlSrc;

	while(obj.nodeName!="BODY") {
		x+=obj.offsetLeft;
		y+=obj.offsetTop;
		obj=obj.offsetParent;
	}	
	ifrm.style.top = y + 24;
	ifrm.style.left = x;
	ifrm.style.width = 0;
	ifrm.style.height = 0;
	ifrm.style.visibility = "visible";

	//bind events
	if(typeof(document.onmousedown)=="function")
		ae_olddocmd = document.onmousedown;
	else ae_olddoccmd=null;
	
	document.onmousedown = closePopupFrame;

	ifrm.contentWindow.document.body.onselectstart=new Function("return false;");
	ifrm.style.width = (ifrm.contentWindow.document.getElementById('oTable').offsetWidth + 3)+'px';
	ifrm.style.height = (ifrm.contentWindow.document.getElementById('oTable').offsetHeight + 3+
		ifrm.contentWindow.document.getElementById('tblstat').offsetHeight)+'px';
}

// Does the insert table for table selector
function insertTable(rows, cols, attrs, num, e) {
	//drop down table implementation
	if(num==null) num=ae_hot;
	ae_bs_restoreRange(num);
	var instance=aeObjects[num];
	if (rows==null) {
		if(e==null)
			e=document.getElementById('quicktable').contentWindow.event;
		var se = ae_bs_getEventSrc(e);
		if(se.nodeName=='DIV') se=se.parentNode;

		if(se.nodeName!='TD') {
			closePopupFrame();
			return;
		}
		rows = se.parentNode.rowIndex + 1;

		//this is a fix for safari always returning 0 for cellIndex
		sc= ( se.cellIndex == 0 ? -1 : se.cellIndex );
		var o=se;
		for ( var x = 0; sc == -1 && x < o.parentNode.cells.length; x++ ) {
			if ( o == o.parentNode.cells[x] )
				sc = x;
		}
		
		cols = sc + 1;
	  	attrs = new Array();
	  	attrs['border']='1';
	  	attrs['cellpadding']='0';
	  	attrs['cellspacing']='0';
	  	attrs['width']='75%';
		closePopupFrame();
	}
	var table=instance.contentDocument.createElement("table");
	var tbody=instance.contentDocument.createElement("tbody");
	
	for(var attrname in attrs) {
		table.setAttribute(attrname, attrs[attrname]);
	}
	
	for(var y=0;y<rows;y++) {
		var row=instance.contentDocument.createElement("tr");
		for(var x=0;x<cols;x++) {
			var col=instance.contentDocument.createElement("td");
			col.innerHTML="&nbsp;";
			row.appendChild(col);
		}
		tbody.appendChild(row);
	}
	table.appendChild(tbody);
	ae_bs_pasteNode(num, table);
	instance.contentWindow.focus();
	e.returnValue=false;
	return false;
}

//Paints the table selector
function paintTable(e) {
	if(e==null)
		e=document.getElementById('quicktable').contentWindow.event;
	var se = ae_bs_getEventSrc(e);
	var sr, sc, tbl;
	var doc=document.getElementById('quicktable').contentWindow.document;
	var tbl=doc.getElementById('oTable');
	
	if(se.nodeName=='DIV') se=se.parentNode;
	if(se.nodeName!='TD') {
		sr = 0;
		sc = 0;
		var str="&nbsp;Cancel";
		for(var r=0;r<tbl.rows.length;r++) {
			for(var c=0;c<tbl.rows[r].cells.length;c++) {
				if(tbl.rows[r].cells[c].style.backgroundColor!='#FFFFFF')
					tbl.rows[r].cells[c].style.backgroundColor='#FFFFFF';
			}
		}
		
		return;
	}
	
	sr=se.parentNode.rowIndex;
	
	//this is a fix for safari always returning 0 for cellIndex
	sc= ( se.cellIndex == 0 ? -1 : se.cellIndex );
	var o=se;
	for ( var x = 0; sc == -1 && x < o.parentNode.cells.length; x++ ) {
		if ( o == o.parentNode.cells[x] )
			sc = x;
	}

	var str=(sr+1) + " by " + (sc+1) + " Table";
	for(var r=0;r<tbl.rows.length;r++) {
		for(var c=0;c<tbl.rows[r].cells.length;c++) {
			if(r<=sr&&c<=sc) {
				if(tbl.rows[r].cells[c].style.backgroundColor!='#0000FF')
					tbl.rows[r].cells[c].style.backgroundColor='#0000FF';
			} else {
				if(tbl.rows[r].cells[c].style.backgroundColor!='#FFFFFF')
					tbl.rows[r].cells[c].style.backgroundColor='#FFFFFF'
			}
		}
	}
	doc.getElementById('tblstat').innerHTML = str;

	//Expand the table selector if its too small
	if(tbl.rows.length == sr+1) {
		var r = tbl.insertRow(-1);
		var td;
		for(var i=0;i<tbl.rows[1].cells.length;i++) {
			td = r.insertCell(-1);
			td.innerHTML = "<div style='cursor:default;width:15px;height:15px'>&nbsp;</div>";
			td.style.width = '20px';
			td.style.height = '20px';
			td.style.cursor='default';
			td.style.backgroundColor='#FFFFFF';
		}
			var bdy = doc.body;			
			var ifrm = document.getElementById('quicktable');
			document.getElementById('quicktable').style.width = (doc.getElementById('oTable').offsetWidth + 3)+'px';
			document.getElementById('quicktable').style.height = (doc.getElementById('oTable').offsetHeight + 3 +
				doc.getElementById('tblstat').offsetHeight) +'px';
	}
	if(tbl.rows[0].cells.length == sc+1) {
		var td;
		for(var i=0;i<tbl.rows.length;i++) {
			td = tbl.rows[i].insertCell(-1);
			td.innerHTML = "<div style='cursor:default;width:15px;height:15px'>&nbsp;</div>";
			td.style.width = '15px';
			td.style.height = '15px';
			td.style.cursor='default';
			td.style.backgroundColor='#FFFFFF';
		}			
			var bdy = doc.body;
			document.getElementById('quicktable').style.width = (doc.getElementById('oTable').offsetWidth + 3)+'px';
			document.getElementById('quicktable').style.height = (doc.getElementById('oTable').offsetHeight + 3 +
				doc.getElementById('tblstat').offsetHeight) +'px';
	}
}

//makes table html
function makeTable(rows, cols) {
	var a, b, str, n;
	str = "<table style=\"margin-bottom:0px;border-style:solid; cursor:default;\" "; 
	str = str + "id=\"oTable\" cellpadding=\"0\" ";
	str = str + "cellspacing=\"0\" cols=" + cols;
	str = str + " border=6>\n";
	for (a=0;a<rows;a++) {
		str = str + "<tr>\n";
		for(b=0;b<cols;b++) {			
			str = str + "<td style='background-color:#FFFFFF'>" 
			str = str + "<div style='cursor:default;width:15px;height:15px'>&nbsp;</div></td>\n";	
		}	
		str = str + "</tr>\n";
	}
	str = str + "</table>"
	return str;
}

//Closes table selector iframe and replaces document mousedown
function closePopupFrame() {
	document.onmousedown=null;
	document.getElementById('quicktable').style.visibility = "hidden";
	document.getElementById('quicktable').style.width = '0px';
	document.getElementById('quicktable').style.height = '0px';

	if(typeof(ae_olddocmd)=="function") {
		ae_olddocmd(false);
		document.onmousedown = ae_olddocmd;
	}
	ae_olddocmd = null;
	//Set DropDownTable IFrame to small
	document.getElementById('quicktable').style.width = '10px';
	document.getElementById('quicktable').style.height = '10px';
}

function ae_cmd_Replace(num) {
	var instance=aeObjects[num];
	instance.focus();
	window.open(ae_inc + "replace.htm" ,"ae_rewin","scrollbars=no,width=400,height=155, resizable=no").focus();
}

function onImagewin(num) {
	//if the focus never touched the control, you get an error, so lets touch the control
	var instance=aeObjects[num];
	ae_savedrange=ae_bs_range(instance);
	instance.focus();
	//spawn image window
	var szURL;
	szURL=ae_inc + "image.cfm?instance=" + num;
	szURL+="&imagedata=";
	szURL+=ae_imagedata[num];
	szURL+="&imageurl=";
	szURL+=ae_imageurl[num];
	window.open(szURL ,"ae_imgwin","scrollbars=yes,width=650,height=400, resizable=yes").focus();
}
//insert the image
function onImage(u, base_url, iborder, ialign, ialt, num) {
	var attr=Array();
	var instance=aeObjects[num];
	attr['src']=u;
	attr['border']=iborder;
	attr['align']=ialign;
	attr['alt']=ialt;
	ae_bs_pasteHTML(num, ae_savedrange, "img", attr);
}

function ae_cleanWord(aeObject) {
		var newData = aeObject.contentDocument.body.innerHTML;
		newData = newData.replace(/<o:p>&nbsp;<\/o:p>/g, ""); // Remove all instances of <o:p>
		newData = newData.replace(/<o\:p><\/o\:p>/g, "");
		newData = newData.replace(/<o:/g, "<"); // remove all o: prefixes
		newData = newData.replace(/<st1:[^>]*>/g, ""); // remove all SmartTags (from Word XP!)
		newData = newData.replace(/<\?xml:[^>]*>/g, ""); // remove all XML(from Word XP!)
	    newData = newData.replace(/\\r/g, "<BR>");
	    newData = newData.replace(/\\n/g, "<BR>");
		newData = newData.replace(/class=MsoNormal/g, "");
		newData = newData.replace(/class=class=MsoHeader/g, "");
		newData = newData.replace(/class=MsoBodyText/g, "");
		newData = newData.replace(/style=\"mso-cellspacing.*\"/g, "cellspacing=0");
		newData = newData.replace(/mso-[^\";]*/g, "");
		aeObject.contentDocument.body.innerHTML = newData;
		newData = aeObject.contentDocument.body.innerHTML;
		newData = newData.replace(/<P><\/P>/g, "");
	    newData = newData.replace(/<P> <\/P>/g, "");
		newData = newData.replace(/<SPAN><\/SPAN>/g, "");
		newData = newData.replace(/<SPAN> <\/SPAN>/g, " ");
		aeObject.contentDocument.body.innerHTML = newData;
}

var TEXT_STYLES=['textTransform','textDecoration','letterSpacing','fontFamily',
	'fontStyle','fontVariant','fontWeight','fontSize','color','backgroundColor'];
	
function ae_onlyTextStyles(node) {
	if(node.className!=null&&node.className!='')
		return false;

	var styles=ae_getStyles(node);
	for(var styleName in styles) {
		var found=false;	
		for(var j=0;j<TEXT_STYLES.length;j++) {
			if(styleName==TEXT_STYLES[j]) found=true;
		}
		if(!found) return false;
	}
	return true;
}

function ae_copyStyles(fromNode, toNode) {
	var nodeStyles=ae_getStyles(fromNode);
	for(var styleName in nodeStyles)
		toNode.style[styleName]=fromNode.style[styleName];
}

function AeStyle(name, value) {
	this.name=name;
	this.value=value;
}

function ae_getStyles(node) {
	var styles=new Object();
	var styleAttribute=node.getAttribute('style');
	if(typeof styleAttribute=='object')
		styleAttribute=styleAttribute.cssText;
	if(styleAttribute!=null) {
		var textstyles=styleAttribute.split(';');
		for(var i=0;i<textstyles.length;i++) {
			var tuple=textstyles[i].split(':',2);
			if(tuple.length==2) {
				var styleName=tuple[0];
				var newStyleName='';
				var capnext=false;
				for(var i=0;i<styleName.length;i++) {
					if(styleName.charAt(i)=='-') {
						capnext=true;
					} else if(capnext) {
						newStyleName+=styleName.charAt(i).toUpperCase();
						capnext=false;
					} else {
						newStyleName+=styleName.charAt(i).toLowerCase();
					}
					
				}
				styles[newStyleName]=tuple[1].replace(/^\s+|\s+$/g, "");
			}
		}
	}
	return styles;
}

function ae_condenseSpans(baseNode) {
	var node=baseNode;
	while(node!=null) {
		if(node.nodeName=='SPAN'&&ae_onlyTextStyles(node)) {
			if(node.parentNode&&node.parentNode.nodeName=='SPAN'&&
					node.nextSibling==null&&
					node.previousSibling==null) {
				var nextNode=node.parentNode;
				while(node.firstChild!=null) {
					node.parentNode.appendChild(node.firstChild);
				}
				ae_copyStyles(node,node.parentNode);
				node.parentNode.removeChild(node);
				node=nextNode;
				continue;
			} else if(node.parentNode.nodeName=='SPAN' && ae_onlyTextStyles(node.parentNode)) {
				if(node.previousSibling==null) {
					var newParent=node.parentNode.cloneNode(false);
					node.parentNode.parentNode.insertBefore(newParent,node.parentNode);
		
					ae_copyStyles(node,newParent);
					while(node.firstChild!=null) {
						newParent.appendChild(node.firstChild);
					}
					node.parentNode.removeChild(node);
					node=newParent;
					continue;
				} else if(node.nextSibling==null) {
					var newParent=node.parentNode.cloneNode(false);
					if(node.parentNode.nextSibling) {
						node.parentNode.parentNode.insertBefore(newParent,node.parentNode.nextSibling);
					} else {
						node.parentNode.parentNode.appendChild(newParent);
					}	
					
					ae_copyStyles(node,newParent);
					var n=node.firstChild;
					while(node.firstChild!=null) {
						newParent.appendChild(node.firstChild);
					}
					node.parentNode.removeChild(node);
					node=newParent;
					continue;
				} else {
					var newParent=node.parentNode.cloneNode(false);
					node.parentNode.parentNode.insertBefore(newParent,node.parentNode);
					while(node!=node.parentNode.firstChild) {
						newParent.appendChild(node.parentNode.firstChild);
					}
					
					ae_copyStyles(node.parentNode,node);
					node.parentNode.parentNode.insertBefore(node,node.parentNode);
					node=newParent;
					continue;
				}
			} else if(node.previousSibling&&
					node.previousSibling.nodeName=='SPAN' &&
					ae_onlyTextStyles(node.previousSibling)) {
				var equalStyles=true;
				var nodeStyles=ae_getStyles(node);
				for(var styleName in nodeStyles) {
					if(node.previousSibling.style[styleName]!=node.style[styleName]) {
						equalStyles=false;
						break;
					}
				}
				if(equalStyles) {
					var nextNode=node.previousSibling;
					while(node.firstChild) {
						node.previousSibling.appendChild(node.firstChild);
					}
					node.parentNode.removeChild(node);
					node=nextNode;
					continue;
				}
			}
		}

		if(node.firstChild) {
			node=node.firstChild;
		} else if(node.nextSibling) {
			node=node.nextSibling;
		} else {
			while(node&&node.parentNode) {
				node=node.parentNode;
				if(node.nextSibling) break;
			}
			if(node&&node.nextSibling) {
				node=node.nextSibling;
			} else {
				break;
			}
		}
	}
}

function ae_onBeforeSave(aeObject) {
	//use the DOM to filter out just what's inside the body
	var content = aeObject.contentDocument.body.innerHTML;
	content = (ae_xhtml[num]) ? formatHTML(content) : content;
	return content;
}

function ae_submit_form(obj, field) {
	//var ae_content = "";
	var i;	
	for(i=1;i<=ae_count;i++) {	
		var instance=aeObjects[i];
		ae_condenseSpans(instance.contentDocument.body);
		if (typeof(aeapi_local_onBeforeSave) == "function") {
			var ae_content = aeapi_local_onBeforeSave(instance);
		}
		else if (typeof(aeapi_onBeforeSave) == "function") {
			var ae_content = aeapi_onBeforeSave(instance);
		}
		else {
			var ae_content = instance.contentDocument.body.innerHTML;
		}
		//update the form value so it gets submitted
		eval(obj).elements[element_idx].value = ae_content;
	}
	//submit the form
	eval(obj).submit();
}

function replaceString(oldS,newS,fullS) {
	// Replaces oldS with newS in the string fullS
	for (var i=0; i<fullS.length; i++) {
 		if (fullS.substring(i,i+oldS.length) == oldS) {
			fullS = fullS.substring(0,i)+newS+fullS.substring(i+oldS.length,fullS.length);
		}
	}
 	return fullS;
}
function ae_cmd_Help() {
	window.showModalDialog(ae_inc + "help.htm","","dialogHeight: 380px; dialogWidth: 350px; dialogTop: 150px; dialogLeft: 150px; center: Yes; help: No; resizable: No; status: No;");
}
function ae_cmd_About() {
	window.showModalDialog(ae_inc + "about.htm","","dialogHeight: 260px; dialogWidth: 400px; dialogTop: 150px; dialogLeft: 150px; center: Yes; help: No; resizable: No; status: No;");
}

function ae_editsource(num) {
	var instance=aeObjects[num];
	instance.contentDocument.selection.empty();
	window.open(ae_inc + "editsource.htm","codewin","scrollbars=no,width=485,height=475").focus();
}

function ae_editsourceinline(num, bVal) {
	//Toggle the inline source view
	var instance=aeObjects[num];
	thisContentItem=document.getElementById("ae_tx_content"+num);
	
	if(ae_HTMLMode[num]==bVal) return;
	
	ae_bs_emptysel(instance);
	if(ae_HTMLMode[num]) { //Coming out of view source
		document.images["normaltab"+num].src=img_normaltabon.src;
		document.images["htmltab"+num].src=img_htmltaboff.src;
		if(ae_defaultfont[num].length) 
			instance.contentDocument.body.style.font=ae_defaultfont[num];
		else {
			instance.contentDocument.body.style.fontFamily="";	
			instance.contentDocument.body.style.fontSize="";
		}
		thisContentItem.value=ae_bs_getTextContent(instance);
		instance.contentDocument.body.innerHTML=thisContentItem.value;
		ae_dress_wysiwyg(num);
		ae_HTMLMode[num] = false;
	}
	else { //Going into view source
		ae_undress_wysiwyg(num);
		var re=/((<br\/?>)+)/ig;
		document.images["normaltab"+num].src=img_normaltaboff.src;
		document.images["htmltab"+num].src=img_htmltabon.src;
		ae_condenseSpans(instance.contentDocument.body);
		// Set the font to fixed width
		thisContentItem.value="test";
		thisContentItem.value = (ae_xhtml[num]) ? formatHTML(instance.contentDocument.body.innerHTML) : instance.contentDocument.body.innerHTML;
		thisContentItem.value = thisContentItem.value.replace(/style="[^"]+"/gi, function(w) { return w.toLowerCase() })
		instance.contentDocument.body.innerHTML = "";
		instance.contentDocument.body.style.fontFamily = "Courier New";
		instance.contentDocument.body.style.fontSize = "10pt";
		ae_bs_setTextContent(instance, thisContentItem.value.replace(re, "$1\n"));
		//re = new RegExp("style=[\"']([^\"']*)[\"']", "gi");
		ae_HTMLMode[num] = true;
	}
}

function ae_cmd_SpecialChars(num) {
	var instance=aeObjects[num];
	ae_savedrange=ae_bs_range(instance);
	window.open(ae_inc+"specialchars.htm" ,"ae_specialwin",",width=390,height=260, resizable=yes",true).focus();
}

function replaceFontsWithSpans(aeObject, oElement, sNewClass) {
	for(var i=0;i<oElement.childNodes.length;i++) {
		replaceFontsWithSpans(aeObject, oElement.childNodes[i], sNewClass);
	}
	if(oElement.tagName=="FONT") {
		if(oElement.face=="ae_newclass") {
			sPreserve=oElement.innerHTML;
			oNewNode=aeObject.contentDocument.createElement("SPAN");
			if(oElement.replaceNode)
				oElement.replaceNode(oNewNode);
			else
				oElement.parentNode.replaceChild(oElement, oNewNode);
			oNewNode.innerHTML=sPreserve;
			oNewNode.className=sNewClass;
		}
		if(oElement.xclass!=null) {
			sPreserve=oElement.innerHTML;
			sClass=oElement.xclass;
			oNewNode=aeObject.contentDocument.createElement("SPAN");
			if(oElement.replaceNode)
				oElement.replaceNode(oNewNode);
			else
				oElement.parentNode.replaceChild(oElement, oNewNode);
			oNewNode.innerHTML=sPreserve;
			oNewNode.className=sClass;
		}
		else {
			var style = "";
			if (oElement.face.length) {
				style += "font-family: " + oElement.face + ";";
			}	
			if (oElement.size.length) {
				var sizeMap = new Array(7,7,9,12,14,18,24,36);
				var size = oElement.size;
				if (size > 7) size = 7;
				if (size==-1) size = 2;
				if (size==-2) size = 1;
				if (size < -2) size = 1;
				var ptsize = sizeMap[size];
				style += "font-size: " + ptsize + "pt;";
			}
			if (oElement.color.length) {
				style += "color: " + oElement.color + ";";
			}
			if (style.length) {
				sPreserve=oElement.innerHTML;
				oNewNode=aeObject.contentDocument.createElement("SPAN");
				if(oElement.replaceNode)
					oElement.replaceNode(oNewNode);
				else
					oElement.parentNode.replaceChild(oElement, oNewNode);
				oNewNode.innerHTML=sPreserve;
				oNewNode.style.cssText=style;
			}
		}
	}
}

function ae_quickstyle(num){
	//no buttons should work in html mode
	ae_bs_restoreRange(num);
	if (ae_HTMLMode[num]) { return; }
	var instance=aeObjects[num];
	var oSel=document.getElementById('oQuickStyle'+num);
	var sClass = oSel.options[oSel.selectedIndex].value;
	var tr=ae_bs_range(instance);
	
	if (sClass == "ae_removeStyle") {
		ae_bs_wrapTag(num, null, ['SPAN','FONT','B','STRONG','I','DIV','EM','U','SUP','SUB']);
	}
	else {
		ae_bs_wrapTag(num, 'SPAN', ['SPAN','FONT','B','STRONG','I','DIV','EM','U','SUP','SUB'],
			{'class':sClass});
		replaceFontsWithSpans(instance, instance.contentDocument.body, sClass);
	   	oSel.selectedIndex = null;
		ae_bs_updateSelection(instance,tr);
	}
	instance.focus();
	instance.contentDocument.body.focus();
}

function ae_cmd_RemoveFormat(num) {
	instance = aeObjects[num];
	ae_bs_wrapTag(num, null, ['SPAN', 'FONT', 'B','STRONG','I', 'DIV', 'EM', 'U', 'STRIKE','SUP','SUB']);
	
//	if (parentElm.tagName == "TD") {
//		parentElm.style.cssText = "";
//	}
	
}

function ae_quickfont(num) {
	if (ae_HTMLMode[num]) { return; }
	var instance=aeObjects[num];
	ae_bs_restoreRange(num);
	oSel=document.getElementById('oQuickFont'+num);
	instance.contentDocument.execCommand('FontName', false, oSel.options[oSel.selectedIndex].value);
	instance.contentWindow.focus();
	replaceFontsWithSpans(instance, instance.contentDocument.body, null);
}
function ae_select_change(num,option_id) {
	ae_bs_restoreRange(num);
	var instance=aeObjects[num];
	var api_function=eval("aeapi_"+option_id+"_change");
	if (typeof(api_function) != "function")
		return;
	api_function(instance, document.getElementById('ae_'+option_id));
}

function ae_quickFontColor(num) {
	ae_bs_restoreRange(num);
	if (ae_HTMLMode[num]) { return; }
	var instance=aeObjects[num];
	var oSel=document.getElementById('oQuickFontColors'+num);
	if (oSel.selectedIndex == 0) {return;}	
	var sColor = oSel.options[oSel.selectedIndex].value;
	ae_setStyles(num, {color:sColor});
	oSel.selectedIndex = 0;
	instance.contentWindow.focus();
}

function ae_setStyles(num, styles) {
	var instance=aeObjects[num];
	instance.stylizeText(styles);
}

function recurseSetStyles(aeObject, oElement, styles) {
	for(var i=0;i<oElement.childNodes.length;i++) {
	  recurseSetStyles(aeObject, oElement.childNodes[i], styles);
	}
	if(oElement.nodeName=="FONT") {
		if(oElement.face=="ae_newclass"||(oElement.style&&oElement.style.fontFamily=="ae_newclass")) {
			sPreserve=oElement.innerHTML;
			oNewNode=aeObject.contentDocument.createElement("SPAN");
			if(oElement.replaceNode)
				oElement.replaceNode(oNewNode);
			else
				oElement.parentNode.replaceChild(oElement, oNewNode);
			oNewNode.innerHTML=sPreserve;
			for(var style in styles) {
				oNewNode.style[style]=styles[style];
			}
		} 
		if(oElement.xclass!=null) {
			sPreserve=oElement.innerHTML;
			sClass=oElement.xclass;
			oNewNode=aeObject.contentDocument.createElement("SPAN");
			if(oElement.replaceNode)
				oElement.replaceNode(oNewNode);
			else
				oElement.parentNode.replaceChild(oElement, oNewNode);
			oNewNode.innerHTML=sPreserve;
			oNewNode.className=sClass;
		}
	} else if (oElement.nodeName=="SPAN") {
		if(oElement.style.fontFamily=="ae_newclass") {
			oElement.style.fontFamily="";
			for(var style in styles) {
				oElement.style[style]=styles[style];
			}
		}
	}
}

function ae_quickfontsize(num) {
	ae_bs_restoreRange(num);
	if (ae_HTMLMode[num]) { return; }
	var instance=aeObjects[num];
	oSel=document.getElementById('oQuickFontSize'+num);
	ae_setStyles(num,{fontSize:oSel.options[oSel.selectedIndex].value+'pt'});
	instance.contentWindow.focus();
}

function ae_quickformat(num) {
	ae_bs_restoreRange(num);
	if (ae_HTMLMode[num]) { return; }
	var instance=aeObjects[num];
	oSel=document.getElementById('oQuickFormat'+num);
	if (oSel.options[oSel.selectedIndex].value == "quickformat") { return; }
	ae_bs_blockfmt(num, oSel.options[oSel.selectedIndex].value);
	oSel.selectedIndex = null;
	instance.contentWindow.focus();
}

function ae_cmd_Font(num) {
	var instance=aeObjects[num];
	ae_current_font=instance.contentDocument.queryCommandValue('FontName');
	ae_current_fontsize=ae_bs_getFontSizeInPoints(instance);
	
	var szURL=ae_inc + "font.html";
	window.open(szURL ,"ae_fontwin","scrollbars=auto,width=360,height=260, resizable=yes",true).focus();
}

function ae_setFontFace(num, face) {
	var instance=aeObjects[num];
	instance.contentDocument.execCommand('FontName', false, face);
}

function ae_cmd_Hyperlink(num) {
	var instance=aeObjects[num];
//	ae_bs_saveRange(num);
	var sel=ae_bs_sel(instance);
	if(sel.type=="Control") {
		var el=instance.contentDocument.selection.createRange().commonParentElement();
		var tr = instance.contentDocument.body.createTextRange();
		tr.moveToElementText(el);
		tr.select();
	}
	var szURL=ae_inc + "hyperlink.htm";
	window.open(szURL ,"ae_linkwin","scrollbars=auto,width=360,height=190, resizable=yes",true).focus();
	return false;
}

function ae_imageproperties(num, img, name, align, alt, border, height, width, vspace, hspace, src) {
	var instance=aeObjects[num];

	var base=ae_baseurl[num];
	if(base.charAt(base.length-1)!='/')
		base=base+'/';
	
	img.width=width;
	img.height=height;
	if(vspace.length)
		img.vspace=vspace;
	else
		img.removeAttribute('vspace');
	if(hspace.length) 
		img.hspace=hspace;
	else 
		img.removeAttribute('hspace');
	img.border=border;
	img.src=ae_absolutify_url(base,src);
	img.alt=alt;
	img.align=align;
}

function ae_hyperlink(num, iHref, iTarget, iStyle, iClass, iName) {
	var instance=aeObjects[num];
	
	if(iHref=="") { // Unlink
		var hyperlink=ae_getSelectedHyperlink(num);
		if(hyperlink!=null) {
			while(hyperlink.firstChild) {
				hyperlink.parentNode.insertBefore(hyperlink.firstChild,hyperlink);
			}
			hyperlink.parentNode.removeChild(hyperlink);
		}
	} else {
		var hyperlink=ae_getSelectedHyperlink(num);

		if(hyperlink==null) {
			var attr={};
			attr['href']=iHref;
			if(iTarget.length)
				attr['target']=iTarget;
			if(iStyle.length)
				attr['style']=iStyle;
			if(iClass.length)
				attr['class']=iClass;
			if(iName.length)
				attr['name']=iName;
			var sel=ae_bs_sel(instance);
			if((typeof(sel.isCollapsed)!='undefined'&&!sel.isCollapsed) || sel!='') {
				ae_bs_wrapTag(num, 'A', [], attr);
			} else {
				ae_bs_pasteHTML(num, ae_bs_range(instance), 'A', attr, iHref);
			}
				
		} else {
			hyperlink.href=iHref;
			if(iTarget.length)
				hyperlink.target=iTarget;
			if(iStyle.length)
				hyperlink.style=iStyle;
			if(iClass.length)
				hyperlink.className=iClass;
			if(iName.length)
				hyperlink.name=iName;
		}
	}
}

function ae_getSelectedHyperlink(num) {
	var instance=aeObjects[num];
	var hyperlink=ae_bs_getFirstSelectedTag(num, 'A');
	if(hyperlink!=null) {
		var range=ae_bs_range(instance);
		ae_bs_selectNode(range, hyperlink);
		ae_bs_updateSelection(instance, range);
	}

	return hyperlink;
}

function ae_cmd_SpellCheck(num) {
	spell('aeObjects[' + eval(num) + '].contentDocument.body.innerHTML');
}

function formatHTML(input) {
	var out = "";
	for (i=0;i<input.length;i++) {
		var c = input.charAt(i);
		if (c == '<') {
			out += '<';
			i++;
			var endTag = (input.charAt(i) == '/');
			var s=input.indexOf(' ',i);
			var e=input.indexOf('>',i);
			var tagName;
			if (s > e || s==-1 || endTag) { //no attr
				tagName = input.substring(i,e).toLowerCase();
				out+=tagName;
				if (tagName == "br" || tagName == "hr")	out += " /";
				out+=">";
				i=e;
			}			
			else {
				tagName = input.substring(i,s).toLowerCase();
				out+=tagName;
				var tagContents = input.substring(i+tagName.length,e);
				var s_attr = 1;
				var s_eq = 2;
				var s_val = 3;
				var quoted = false;
				var status = s_attr;
				for(var k=0;k<tagContents.length;k++) {
					c = tagContents.charAt(k);
					if (status == s_attr) {
						if (c == '=') status = s_eq;
						out+=c.toLowerCase();
					}
					else if (status == s_eq) {
						if (c == "\"") {
							 quoted = true;
							 status = s_val;
							 out +=c;
						}
						else if (c!=" " && c!="\t" && c!="\n") {
							 quoted=false;
							 out +="\"" + c;
							 status = s_val;
						}
						else out+=c;
					}
					else if (status == s_val) {
						if (c == "\"") status = s_attr;
						else if (!quoted && (c==' ' || c=="\t" || c=="\n" || c=='>')) {
							 status = s_attr;
							 out+="\"";
						}
						out+=c;
					}
				}
				if (status == s_val) out+="\"";
				if (tagName == "img") out+=" /";
				out+=">"
				i = e;
			}
			
		}
		else {
			out+=c;
		}
	}
	
	return out;
}



//////////////////////
// Style Functions  //
//////////////////////

//CSS style functions for buttons

function ae_m_out(e) {
	if(e==null) e=window.event;
	var src=ae_bs_getEventSrc(e);
	if(src==null) return true;
	
	//mouse out button style
	if(typeof(src.state)!="undefined") {
		if(src.state==AE_ENABLED) {
			src.className="ae_flat";
		} else if(src.state==AE_LATCHED) {
			src.className="ae_latched";
		} else if(src.state==AE_DISABLED) {
			src.className="ae_disabled";
		}
	} else if(src.getAttribute&&src.getAttribute('tag')=="btn") {
		src.className="ae_flat";
	}
	return true;
}

function ae_m_over(e) {
	if(e==null) e=window.event;
	var src=ae_bs_getEventSrc(e);
	if(src==null) return true;
	if(typeof(src.state)!="undefined" && (src.state==AE_DISABLED||src.state==AE_LATCHED)) {
			return true;
	}
	if(src.getAttribute&&src.getAttribute('tag')=="btn") {
		src.className="ae_outset";
	}
}

function ae_m_down(e) {
	if(e==null) e=window.event;
	var src=ae_bs_getEventSrc(e);
	if(src==null) return true;
	//mouse down button style
	if(typeof(src.state)!="undefined" && src.state==AE_DISABLED) return true;
	if(src.getAttribute&&src.getAttribute('tag')=="btn") {
		src.className="ae_inset";
	}
}

function ae_m_up(e) {
	if(e==null) e=window.event;
	var src=ae_bs_getEventSrc(e);
	if(src==null) return true;
	//mouse up button style
	if(typeof(src.state)!="undefined") {
		if(src.state==AE_ENABLED) {
			src.className="ae_outset";
		} else if(src.state==AE_LATCHED) {
			src.className="ae_latched";
		} else if(src.state==AE_DISABLED) {
			src.className="ae_disabled";
		}
	} else if(src.getAttribute&&src.getAttribute('tag')=="btn") {
		src.className="ae_outset";
	}
}

function hasParentTag(num, tag) {
	instance = aeObjects[num];
	var parentElm = ae_bs_range(instance).parentElement();
	//search for any tags that are parent of this.
	while (parentElm != null) {
		if (parentElm.tagName == tag) {
			return true;
		}		
		if (parentElm.tagName.toLowerCase() == "body") {
			return false;
		}
		parentElm = parentElm.parentElement;
	}
	return false;
}

function ae_isSimpleCommand(cid) {
	for(var i=0;i<simplecmds.length;i++) {
		if(cid == simplecmds[i]) {
			return true;
		}
	}
	return false;
}

function ae_queryCommandState(num, cid) {
	var instance=aeObjects[num];
	try {
		if(instance.contentDocument.queryCommandState(cid)) {
			return AE_LATCHED;
		} else if(instance.contentDocument.queryCommandIndeterm(cid)) {
			return AE_NINCHED;
		} else if(instance.contentDocument.queryCommandEnabled(cid)) {
			return AE_ENABLED;
		} else {
			return AE_DISABLED;
		}
	} catch(e) {
		return AE_ENABLED;
	}
}

function ae_refreshToolbar(num) {
	var instance=aeObjects[num];
	var tb=document.getElementById("ae_tbar"+num);
	var btns=tb.getElementsByTagName('img');
	var list='';
	var cid;
	for(var i=0;i<btns.length;i++) {
		var node=btns[i];
		cid=node.getAttribute("cid");
		if(cid!=null) {
			state=ae_bs_getCommandState(num,cid);
			if(state==AE_ENABLED) {
				node.className = "ae_flat";
			} else if(state==AE_DISABLED) {
				node.className = "ae_disabled";
			} else if(state==AE_LATCHED || state==AE_NINCHED) {
				node.className = "ae_latched";
			} else {
				node.className = "ae_flat";
			}
			node.state=state;
		}
	}
	if(oSel=document.getElementById('oQuickFont'+num)) {
		if(instance.contentDocument.queryCommandEnabled('FontName')) {
			if(oSel.disabled) oSel.disabled=false;
			fontname=instance.contentDocument.queryCommandValue("FontName");
			if(fontname!=""&&fontname!="undefined"&&fontname!=null) {
				fCreateNew=true;
				for(i=0;i<oSel.options.length;i++) {
					if(equalsIgnoreCase(oSel.options[i].value,fontname)) {
						oSel.options[i].selected=true;
						fCreateNew=false;
					}
				}
				if(fCreateNew) {
					oSel.options[oSel.options.length]=new Option(fontname, fontname);
				}
			}
			else {
				oSel.selectedIndex=-1;
			}
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}
	
	if(oSel=document.getElementById('oQuickFontSize'+num)){
		if(instance.contentDocument.queryCommandEnabled('FontSize')) {
			if(oSel.disabled) oSel.disabled=false; 
			fs=ae_bs_getFontSizeInPoints(instance);
			
			var found=false;
			if(fs!=null&&fs!="") {
				for(i=0;i<oSel.options.length;i++) {
					if(oSel.options[i].value==fs) {
						oSel.options[i].selected=true;
						found=true;
						break;
					}
				}
			}
			if(!found) 
				oSel.selectedIndex=-1;
		}
		else {
			if(!oSel.disabled) oSel.disabled=true;
		}
	}	
	
	
}

function ae_getAbsolutePos(o) {
	var x=0,y=0;
	while(o.nodeName!="BODY") {
		x+=o.offsetLeft;
		y+=o.offsetTop;
		o=o.offsetParent;
	}	
	return {x:x,y:y};	
}

function ae_mousedown(num) {
	var menu=document.getElementById("ae_rightmenu");
	if(menu.style.visibility=="visible") {
		menu.style.visibility="hidden";
	}
	if(document.getElementById('quicktable').style.visibility == "visible") {
		closePopupFrame();
	}

}

function ae_contextmenu(num, e) {
	if(e==null) e=window.event;
	if(e.preventDefault) e.preventDefault();
	if(e.stopPropagation) e.stopPropagation();
	e.returnValue=false;
	
	var pos=ae_getAbsolutePos(aeObjects[num]);
	var menu=Array();
	menu[menu.length]={type:"item",text:"Cut",cid:"Cut"};
	menu[menu.length]={type:"item",text:"Copy",cid:"Copy"};
	menu[menu.length]={type:"item",text:"Paste",cid:"Paste"};
	menu[menu.length]={type:"item",text:"Paste Text",cid:"PasteText"};
	ae_table_menu(num, menu);
	if(ae_bs_getSelectedImage(num)!=null) {
		menu[menu.length]={type:"spacer"};
		menu[menu.length]={type:"item",text:"Image Properties",cid:"ImageProperties"};
	}
		
	pos.x+=e.clientX;
	pos.y+=e.clientY;
	ae_showmenu(num, menu, pos);
}

function ae_cmd_InsertColumnAfter(num) {
	ae_InsertColumn(num, true);
}

function ae_cmd_InsertColumnBefore(num) {
	ae_InsertColumn(num, false);
}

function ae_InsertColumn(num, after) {
	var instance=aeObjects[num];
	var tableSel=ae_getTableSelection(num);
	var c,r;
	
	if(tableSel==null) return;
	
	var colskip=Array();
	var splitCol;
	
	//Calculate effective column to split
	for(r=0;r<tableSel.tableNode.rows.length;r++) {
		var effectiveColumn=0;
		for(c=0;c<tableSel.tableNode.rows[r].cells.length;c++) {
			var cell=tableSel.tableNode.rows[r].cells[c];
			if(colskip[r]!=null&&colskip[r][effectiveColumn]>0) {
				effectiveColumn+=colskip[r][effectiveColumn];
			}
			if(cell.rowSpan>1) {
				for(var x=1;x<cell.rowSpan;x++) {
					if(colskip[r+x]==null) colskip[r+x]=Array();
					colskip[r+x][effectiveColumn]=(cell.colSpan==0?1:cell.colSpan);
				}
			}
			
		
			if(r==tableSel.startRow&&c==tableSel.startColumn) {
				splitCol=effectiveColumn;
			}
			effectiveColumn+=(cell.colSpan==0?1:cell.colSpan);
		}
	}
	
	var afterCol=splitCol+1;
	var beforeCol=splitCol;
	
	for(r=0;r<tableSel.tableNode.rows.length;r++) {
		var effectiveColumn=0;
		for(c=0;c<tableSel.tableNode.rows[r].cells.length;c++) {
			var cell=tableSel.tableNode.rows[r].cells[c];
			if(colskip[r]!=null&&colskip[r][effectiveColumn]>0) {
				effectiveColumn+=colskip[r][effectiveColumn];
			}
			if(effectiveColumn<splitCol && effectiveColumn+(cell.colSpan==0?1:cell.colSpan)>beforeCol) {
				beforeCol=effectiveColumn;
			}
			if(effectiveColumn+(cell.colSpan==0?1:cell.colSpan)>afterCol&&effectiveColumn<afterCol) {
				afterCol=effectiveColumn+(cell.colSpan==0?1:cell.colSpan);
			}
				
			effectiveColumn+=(cell.colSpan==0?1:cell.colSpan);
		}
	}
	

	for(r=0;r<tableSel.tableNode.rows.length;r++) {
		var effectiveColumn=0;
		for(c=0;c<tableSel.tableNode.rows[r].cells.length;c++) {
			var cell=tableSel.tableNode.rows[r].cells[c];
			if(colskip[r]!=null&&colskip[r][effectiveColumn]>0) {
				if(!after&&effectiveColumn==beforeCol) {
					var newCell=tableSel.tableNode.rows[r].insertCell(c);
					newCell.innerHTML='&nbsp;';
				}
				effectiveColumn+=colskip[r][effectiveColumn];
			}
			if(effectiveColumn==(after?afterCol:beforeCol)) {
				var newCell=tableSel.tableNode.rows[r].insertCell(c);
				newCell.innerHTML='&nbsp;';
			}
			effectiveColumn+=(cell.colSpan==0?1:cell.colSpan);
		}
		if(after && effectiveColumn==afterCol) {
			var newCell=tableSel.tableNode.rows[r].insertCell(c);
			newCell.innerHTML='&nbsp;';
		}
	}
	

	
}


function ae_cmd_InsertRowBefore(num) {
	ae_InsertRow(num, false);
}

function ae_cmd_InsertRowAfter(num) {
	ae_InsertRow(num, true);
}

function ae_InsertRow(num, after) {
	var instance=aeObjects[num];
	var tableSel=ae_getTableSelection(num);
	var c,r;
	
	if(tableSel==null) return;
	
	var colskip=Array();
	var splitCol;
	var afterRow=tableSel.startRow+1;
	var beforeRow=tableSel.startRow;
	var newRowLength=0;
	
	//Calculate effective column to split
	for(r=0;r<tableSel.tableNode.rows.length;r++) {
		var effectiveColumn=0;
		for(c=0;c<tableSel.tableNode.rows[r].cells.length;c++) {
			var cell=tableSel.tableNode.rows[r].cells[c];
			if(colskip[r]!=null&&colskip[r][effectiveColumn]>0) {
				effectiveColumn+=colskip[r][effectiveColumn];
			}
			if(cell.rowSpan>1) {
				for(var x=1;x<cell.rowSpan;x++) {
					if(colskip[r+x]==null) colskip[r+x]=Array();
					colskip[r+x][effectiveColumn]=(cell.colSpan==0?1:cell.colSpan);
				}
			}
			
			if(r<tableSel.startRow && r+cell.rowSpan>beforeRow) {
				beforeRow=r;
			}
			if(r+cell.rowSpan>afterRow&&r<afterRow) {
				afterRow=r+cell.rowSpan;
			}
			
			if(r==tableSel.startRow&&c==tableSel.startColumn) {
				splitCol=effectiveColumn;
			}
			effectiveColumn+=(cell.colSpan==0?1:cell.colSpan);
		}
		if(newRowLength<effectiveColumn)
			newRowLength=effectiveColumn;
	}
	
	var newRow=tableSel.tableNode.insertRow((after?afterRow:beforeRow));
	
	for(var i=0;i<newRowLength;i++) {
		var newCell=newRow.insertCell(i);
		newCell.innerHTML='&nbsp;';
	}
	
}


function ae_cmd_SplitCell(num) {
	var instance=aeObjects[num];
	var tableSel=ae_getTableSelection(num);
	var c,r;
	
	if(tableSel==null) return;
	
	var selcell=tableSel.tableNode.rows[tableSel.startRow].cells[tableSel.startColumn];

	if(selcell.colSpan>1) {
		//Just need to split the colspan and we're done
		var newCell=tableSel.tableNode.rows[tableSel.startRow].insertCell(tableSel.startColumn+1);
		newCell.innerHTML='&nbsp;';
		selcell.colSpan=selcell.colSpan-1;
		return;
	}
	

	var colskip=Array();
	var splitCol;

	//Calculate effective column to split
	for(r=0;r<tableSel.tableNode.rows.length;r++) {
		var effectiveColumn=0;
		for(c=0;c<tableSel.tableNode.rows[r].cells.length;c++) {
			var cell=tableSel.tableNode.rows[r].cells[c];
			if(colskip[r]!=null&&colskip[r][effectiveColumn]>0) {
				effectiveColumn+=colskip[r][effectiveColumn];
			}
			if(cell.rowSpan>1) {
				for(var x=1;x<cell.rowSpan;x++) {
					if(colskip[r+x]==null) colskip[r+x]=Array();
					colskip[r+x][effectiveColumn]=(cell.colSpan==0?1:cell.colSpan);
				}
			}
			if(r==tableSel.startRow&&c==tableSel.startColumn) {
				splitCol=effectiveColumn;
			}
			effectiveColumn+=(cell.colSpan==0?1:cell.colSpan);
		}
	}
	var newCell=tableSel.tableNode.rows[tableSel.startRow].insertCell(tableSel.startColumn+1);
	newCell.innerHTML='&nbsp;';
	if(selcell.rowSpan>1)
		newCell.rowSpan=selcell.rowSpan;

	for(r=0;r<tableSel.tableNode.rows.length;r++) {
		var effectiveColumn=0;
		for(c=0;c<tableSel.tableNode.rows[r].cells.length;c++) {
			var cell=tableSel.tableNode.rows[r].cells[c];
			if(colskip[r]!=null&&colskip[r][effectiveColumn]>0) {
				effectiveColumn+=colskip[r][effectiveColumn];
			}
			if(r!=tableSel.startRow&&effectiveColumn<=splitCol&&
					effectiveColumn+(cell.colSpan==0?1:cell.colSpan)>splitCol) {
				cell.colSpan=(cell.colSpan==0?1:cell.colSpan)+1;
				break;
			}
			effectiveColumn+=(cell.colSpan==0?1:cell.colSpan);
		}
	}
	
}

function ae_cmd_MergeCells(num) {
	var instance=aeObjects[num];
	var tableSel=ae_getTableSelection(num);
	
	if(tableSel==null) return;
	var row=tableSel.startRow;
	var endcol;
	if(tableSel.endRow>tableSel.startRow) {
		endcol=tableSel.tableNode.rows[tableSel.startRow].cells.length-1;
	} else {
		endcol=tableSel.endColumn;
	}
	var c1=tableSel.tableNode.rows[row].cells[tableSel.startColumn];
	var c2=tableSel.tableNode.rows[row].cells[tableSel.startColumn+1];
	c1.colSpan=c1.colSpan==0?2:(c1.colSpan+1);
	c1.innerHTML=c1.innerHTML+c2.innerHTML;
	tableSel.tableNode.rows[row].deleteCell(tableSel.startColumn+1);

}

function ae_cmd_DeleteRow(num) {
	var instance=aeObjects[num];
	var tableSel=ae_getTableSelection(num);
	
	if(tableSel==null) return;
	tableSel.tableNode.deleteRow(tableSel.startRow);
}

function ae_getTableSelection(num) {
	var instance=aeObjects[num];
	var sel=ae_bs_sel(instance);

	var range=ae_bs_range(instance);
	
	if(!range.startContainer) {
		return ae_bs_getTableSelection(num);
	}

	var node=range.parentElement();
	
	var tableNode=null;
	while(node!=null&&node.nodeName!='BODY') {
		if(node.nodeName=='TABLE') {
			tableNode=node;
			break;
		}
		node=node.parentNode;
	}
	if(tableNode==null) return null;
	
	var info={};
	info['tableNode']=tableNode;
	
	var startCell;
	var endCell;
	
	startCell=range.startContainer;
	if(startCell.nodeName=='TR') {
		info['startColumn']=range.startOffset;
		info['startRow']=startCell.rowIndex;
	} else {
		while(startCell.nodeName!='TD') {
			startCell=startCell.parentNode;
		}
		info['startRow']=startCell.parentNode.rowIndex;

		var sc= ( startCell.cellIndex == 0 ? -1 : startCell.cellIndex );
		var o=startCell;
		for ( var x = 0; sc == -1 && x < o.parentNode.cells.length; x++ ) {
			if ( o == o.parentNode.cells[x] )
				sc = x;
		}
		info['startColumn']=sc;
	}
	
	endCell=range.endContainer;
	if(endCell.nodeName=='TR') {
		info['endColumn']=range.endOffset;
		info['endRow']=startCell.rowIndex;
	} else {
		while(endCell.nodeName!='TD') {
			endCell=endCell.parentNode;
		}
		info['endRow']=endCell.parentNode.rowIndex;

		var sc= ( endCell.cellIndex == 0 ? -1 : endCell.cellIndex );
		var o=endCell;
		for ( var x = 0; sc == -1 && x < o.parentNode.cells.length; x++ ) {
			if ( o == o.parentNode.cells[x] )
				sc = x;
		}
		info['endColumn']=sc;
	}

	return info;
}

function ae_table_menu(num, menu) {
	var instance=aeObjects[num];
	var range=ae_bs_range(instance);
	var tableSel=ae_getTableSelection(num, range);
	
	if(tableSel==null) return;

	menu[menu.length]={type:"spacer"};
	menu[menu.length]={type:"item",text:"Insert Column Before",cid:"InsertColumnBefore"};	
	menu[menu.length]={type:"item",text:"Insert Column After",cid:"InsertColumnAfter"};	
		
	menu[menu.length]={type:"item",text:"Insert Row Before",cid:"InsertRowBefore"};	
	menu[menu.length]={type:"item",text:"Insert Row After",cid:"InsertRowAfter"};	
	if(tableSel.endRow == tableSel.startRow && tableSel.endColumn - tableSel.startColumn==1) {
		menu[menu.length]={type:"item",text:"Merge Cells",cid:"MergeCells"};
	} else if(tableSel.endRow == tableSel.startRow && tableSel.endColumn == tableSel.startColumn) {
		menu[menu.length]={type:"item",text:"Split Cell",cid:"SplitCell"};
	}
	if(tableSel.endRow == tableSel.startRow) {
		menu[menu.length]={type:"item",text:"Delete Row",cid:"DeleteRow"};
	}
	menu[menu.length]={type:"item",text:"Edit Table",cid:"EditTable"};
}

function ae_menuover(e) {
	if(e==null) e=window.event;
	var src=ae_bs_getEventSrc(e);
	if(src==null) return true;
	src.className="ae_menuitem_over";
}
function ae_menuout(e) {
	if(e==null) e=window.event;
	var src=ae_bs_getEventSrc(e);
	if(src==null) return true;
	src.className="ae_menuitem";
}

function ae_showmenu(num, menustruct, pos) {
	var menu=document.getElementById("ae_rightmenu");
	menu.innerHTML="";
	for(var n=menu.firstChild;n!=null;n=n.nextSibling) {
		menu.removeChild(n);
	}
	
	for(var i=0;i<menustruct.length;i++) {
		var entry=menustruct[i];
		var item=document.createElement("DIV");
		if(entry.type && entry.type=="spacer") {
			item.className="ae_menuspacer";
		} else {
			item.innerHTML=entry.text;
			if(!ae_bs_getCommandState(item.cid)) {
				item.className="ae_menuitem_disabled";
			} else {
				item.className="ae_menuitem";
				item.onmouseover=ae_menuover;
				item.onmouseout=ae_menuout;
				item.onmousedown=new Function("e", "return ae_onCommand(e,'"+entry.cid+"',"+num+");");
			}
			item.style.cursor='default';
		}
		
		menu.appendChild(item);
	}
	
	menu.style.left=pos.x;
	menu.style.top=pos.y;
	menu.style.visibility="visible";
	menu.style.cursor="default";
}

//////////////////
//Image preloads//
//////////////////
var img_htmltabon=new Image();
img_htmltabon.src=ae_inc+"images/htmltabon.gif";
var img_htmltaboff=new Image();
img_htmltaboff.src=ae_inc+"images/htmltaboff.gif";
var img_normaltabon=new Image();
img_normaltabon.src=ae_inc+"images/normaltabon.gif";
var img_normaltaboff=new Image();
img_normaltaboff.src=ae_inc+"images/normaltaboff.gif";

