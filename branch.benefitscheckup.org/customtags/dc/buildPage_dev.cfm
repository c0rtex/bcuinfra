<cfparam name="attributes.pos" type="string" default="">
<cfparam name="attributes.bounce" type="boolean" default="true">
<cfparam name="attributes.js" type="string" default="">
<cfparam name="attributes.title" type="string" default="Data Collector">
<cfparam name="attributes.section" type="string" default="">
<cfparam name="attributes.bgcolor" type="string" default="##FFFFFF">

<!--- bounce to login page if not logged in --->
<cfif attributes.bounce AND (NOT IsDefined('session.user') OR session.user eq '' or (application.maintenanceFlag and session.level gt 1))>
	<cflocation url="#session.serverpath#/login.cfm?p=#URLEncodedFormat(cgi.script_name)#&q=#URLEncodedFormat(cgi.query_string)#" addtoken="no">
	<cfabort>
<cfelse>

<cfif attributes.title neq 'Data Collector'>
	<cfset pagetitle = 'Data Collector : ' & attributes.title>
<cfelse>
	<cfset pagetitle = attributes.title>
</cfif>

<!--- page start --->
<cfif ThisTag.ExecutionMode eq 'start' AND (ThisTag.HasEndTag OR (NOT ThisTag.HasEndTag AND attributes.pos neq 'end'))>
	<cf_loadColors>
	<cfoutput>
<html>
<head>
	<title>#pagetitle#</title>
	<style type="text/css">
		.normal {
			font-size: 10pt;
			font-family: Arial, Helvetica, Verdana, sans-serif;
		}
		.small {
			font-size: 9pt;
			font-family: Arial, Helvetica, Verdana, sans-serif;
		}
		.tiny {
			font-size: 8pt;
			font-family: Arial, Helvetica, Verdana, sans-serif;
		}
	</style>
	<cfif attributes.js eq 'order'>
<script language="JavaScript">
	<!-- 
	var ns = (document.layers) ? true : false;
	var ie = (document.all) ? true : false;
	var clicks = 0;
	var timeout = 300;
	function reorderSubmit(elem1, elem2, elem3, elem4) {
		logElements(elem1, elem2);
		if (elem4 != null)
			logElements(elem3, elem4);
		orderby.submit();
	}
	function servedSubmit(elem1, elem2, elem3, elem4) {
		logElements(elem1, elem2);
		if (elem4 != null)
			logElements(elem3, elem4);
		served.submit();
	}
	function clicked(ck1, ck2, ck3, ck4, ck5, ck6) {
		clicks++;
		if (clicks > 1) {
			kill();
			moveElement(ck1, ck2, ck3, ck4, ck5, ck6);
		} else {
			setTimeout("kill()", timeout);
		}
	}
	function kill() {
		clicks = 0;
	}
	function swapSelectElements (elem, a, b) {
		if (elem.options[a].text.toLowerCase() > elem.options[b].text.toLowerCase()) {
			tempText = elem.options[a].text;
			elem.options[a].text = elem.options[b].text;
			elem.options[b].text = tempText;
			tempValue = elem.options[a].value;
			elem.options[a].value = elem.options[b].value;
			elem.options[b].value = tempValue;
		}
	}
	function swapSelectElementsNoAlpha (elem, a, b) {
		tempText = elem.options[a].text;
		elem.options[a].text = elem.options[b].text;
		elem.options[b].text = tempText;
		tempValue = elem.options[a].value;
		elem.options[a].value = elem.options[b].value;
		elem.options[b].value = tempValue;
	}
	function logElement(elem, pos, textDst) {
		if (pos > 0)
			textDst.value = textDst.value + ',';
		textDst.value = textDst.value + elem;
	}
	function logElements(selectSrc, textDst) {
		textDst.value = "";
		for (i = 0; i < selectSrc.options.length; i++)
			logElement(selectSrc.options[i].value, i, textDst);
	}
	function nudgeElement (selectSrc, direction, saveSrc, textDst) {
		elemNum = selectSrc.selectedIndex;
		if (elemNum > -1 ) {
			if ((elemNum > 0 && direction == -1) || (elemNum < selectSrc.options.length - 1 && direction == 1)) {
				swapSelectElementsNoAlpha(selectSrc, elemNum, elemNum + direction);
				selectSrc.selectedIndex = elemNum + direction;
				logElements(saveSrc, textDst);
			}
		}
	}
	function jumpElement (selectSrc, direction, saveSrc, textDst) {
		elemNum = selectSrc.selectedIndex;
		if (elemNum > -1 ) {
			targetNum = elemNum + (17 * direction);
			if (direction == -1 && targetNum < 0) {
				targetNum = 0;
			} else {
				if (direction == 1 && targetNum >= selectSrc.options.length) {
					targetNum = selectSrc.options.length - 1;
				}
			}
			if (elemNum != targetNum) {
				while (elemNum != targetNum) {
					swapSelectElementsNoAlpha(selectSrc, elemNum, elemNum + direction);
					elemNum += direction;
				}
				selectSrc.selectedIndex = elemNum;
				logElements(saveSrc, textDst);
			}
		}
	}
	function launchElement (selectSrc, direction, saveSrc, textDst) {
		elemNum = selectSrc.selectedIndex;
		if (elemNum > -1 ) {
			if (direction == -1) {
				targetNum = 0;
			} else {
				targetNum = selectSrc.options.length - 1;
			}
			if (elemNum != targetNum) {
				while (elemNum != targetNum) {
					swapSelectElementsNoAlpha(selectSrc, elemNum, elemNum + direction);
					elemNum += direction;
				}
				selectSrc.selectedIndex = elemNum;
				logElements(saveSrc, textDst);
			}
		}
	}
	function moveElement (selectSrc, selectDst, saveSrc, textDst, anotherSrc, anotherDst) {
		elemNum = selectSrc.selectedIndex;
		if (elemNum > -1 ) {
			elem = selectSrc.options[elemNum];
			insertNum = selectDst.options.length;
			insertElem(selectDst, insertNum, elem.text, elem.value);
			selectDst.selectedIndex = insertNum;
			deleteElem(selectSrc, elemNum);
			logElements(saveSrc, textDst);
			logElements(anotherSrc, anotherDst);
		}
	}
	function moveElementAlpha (selectSrc, selectDst, saveSrc, textDst, anotherSrc, anotherDst) {
		elemNum = selectSrc.selectedIndex;
		if (elemNum > -1 ) {
			elem = selectSrc.options[elemNum];
			insertNum = 0;
			while (insertNum < selectDst.options.length && elem.text > selectDst.options[insertNum].text)
				insertNum++;
			insertElem(selectDst, insertNum, elem.text, elem.value);
			selectDst.selectedIndex = insertNum;
			deleteElem(selectSrc, elemNum);
			logElements(saveSrc, textDst);
			logElements(anotherSrc, anotherDst);
		}
	}
	function insertElem(select, pos, text, value) {
		if (select.options.length == pos) {
			select.options[select.options.length] = new Option(text, value);
		} else {
			for (i = select.options.length; i > pos; i--) {
				select.options[i] = new Option(select.options[i - 1].text, select.options[i - 1].value);
			}
			select.options[pos] = new Option(text, value);
		}
	}
	function deleteElem(select, pos) {
		select.options[pos] = null;
	}
	// -->
</script>
	</cfif>
	<link rel="shortcut icon" href="#session.serverpath#/favicon.ico">
</head>
<body bgcolor="#attributes.bgcolor#">
	<cfif NOT IsDefined('session.user') OR session.user eq ''>
<table cellspacing="2" cellpadding="3" width="100%" align="center" bgcolor="##ccffcc" border="0">
	<tr>
		<td align="center">
			<FONT face="Arial" color="##00594b" size="4"><b>You must log in to use the Data Collector</b></FONT>
		</td>
	</tr>
</table>
<br>
	<cfelse>
<table cellspacing="2" cellpadding="3" width="100%" align="center" bgcolor="##ccffcc" border="0">
	<tr>
		<td align="center">
			<FONT face="Arial" color="##00594b" size="3">username <b>#session.user#</b> : type <b>#session.usertype#</b> : <a href="#session.serverpath#/logout.cfm">logout</a></FONT>
		</td>
	</tr>
</table>
		<cf_buildMenu_dev>
		<cfif application.maintenanceFlag and session.level eq 1>
			<div align="center"><font size="+1" color="##990000"><b>System maintenance is in effect.  Only superusers currently have access.</b></font></div>
		</cfif>
	</cfif>
	
	<cfif attributes.section neq ''>
		<br>
		<cf_buildMenu_dev section="#attributes.section#">
	</cfif>

	</cfoutput>
<!--- page end --->
<cfelse>

<br>
<table cellspacing="1" cellpadding="1" width="100%" align="center" bgcolor="#ccffcc" border="0">
	<tr>
		<td align="center">
			<FONT face="Arial" color="#00594b" size="2"><i>Powering BenefitsCheckUp</i></FONT>
		</td>
	</tr>
</table>

</body>
</html>

</cfif>

</cfif>