<cfif IsDefined('url.report_only')>
	<cf_sessionLoadVars checksubset="false">
<cfelse>
	<cf_sessioncheck>
</cfif>
<cf_tagHeader>
<script language="JavaScript1.1">
<!--
function markCheckbox(action) {
	var frm = document.custom;
	switch (action) {
		case 0:
			for (i = 0; i < frm.elements.length; i++)
				if (frm.elements[i].type == 'checkbox' && frm.elements[i].name.substring(0, 4) == 'prg-')
					frm.elements[i].checked = true;
			break;
		case 1:
			for (i = 0; i < frm.elements.length; i++)
				if (frm.elements[i].type == 'checkbox' && frm.elements[i].name.substring(0, 4) == 'prg-')
					frm.elements[i].checked = !(frm.elements[i].checked);
			break;
		default:
			for (i = 0; i < frm.elements.length; i++)
				if (frm.elements[i].type == 'checkbox' && frm.elements[i].name.substring(0, 4) == 'prg-')
					frm.elements[i].checked = false;
	}
}
// -->
</script>
<table width="100%" border="0" align="center" cellpadding=12 cellspacing=2>
	<tr>
	<td bgcolor="#FFFFFF"><font face="arial" size="3" color="#000000">


<!--- CHANGE CONDITIONAL TO SKIP REPORT OPTIONS --->
<!--- was as follows to disallow customizing on OE
<cfif IsDefined("session.cobrand_cso_id") and session.cobrand_cso_id gt 0>
--->
<cfif 1 eq 0>

<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#">

<cfoutput>
<font face="arial" size="4">Your report has been created.  You may access it in two different formats: HTML or PDF.  Any web browser should be able to view the HTML version of the report, but you must have Adobe's Acrobat Reader installed to view the PDF version.  You can download Acrobat Reader from this site: <a href="http://www.adobe.com/products/acrobat/readstep.html">www.adobe.com/products/acrobat/readstep.html</a><br><br>
<a href="#session.transfertype#://#session.servername#/pdf/#session.CFToken#-#session.cfid#.pdf" target="_parent">PDF - Better formatting, better organization, longer document</a><br>
<br>
<a href="#session.transfertype#://#session.servername#/frmshowreport.cfm" target="_parent">HTML  - Standard design, shorter document</a></center></font>
</cfoutput>

<br><br>


<cfelse>




<cfoutput>
<form action="#session.transfertype#://#session.servername#/frmreportwrite.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#&RequestTimeout=300" method="post" name="custom">

<font size="5"><b>Customize Your Printed Report</b></font><br>

<font size="4">This page allows you to specify which programs and types of information you wish to have included for printing in your benefits report.  Checkmarks appear beside options that will be included.  Click the checkboxes to turn the options off and on.  The more options you choose to include, the longer your report will be and the more paper it will take to print.</font><br><br>


<b>Printed report format</b><br>
<table border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left" valign="top"><input type="radio" name="file_format" value="html"<cfif session.partner_id eq 17> checked</cfif>></td>
		<td align="left" valign="top"><font face="arial">&nbsp;HTML&nbsp;version&nbsp;&nbsp;</font></td>
		<td align="left" valign="top"><font face="arial"><i>Any web browser can view the HTML version of the report. This format features a basic design and produces a shorter document.</i></font></td>
	</tr>
	<tr>
		<td align="left" valign="top"><input type="radio" name="file_format" value="pdf"<cfif session.partner_id neq 17> checked</cfif>></td>
		<td align="left" valign="top"><font face="arial">&nbsp;PDF&nbsp;version&nbsp;&nbsp;</font></td>
		<td align="left" valign="top"><font face="arial"><i>You must have Adobe Acrobat Reader installed to view the PDF version.  (<a href="http://www.adobe.com/products/acrobat/readstep.html">Get it here</a>.)  This format features better organization and usually produces a longer document.</i></font></td>
	</tr>
</table><br>

<b>Report sections to include</b><br>
<input type="checkbox" name="re_cover" value="true"> Cover page<br>
<input type="checkbox" name="re_toc" value="true"> Table of contents page &nbsp;<i>(applies to PDF version only)</i><br>
<input type="checkbox" name="re_intro" value="true"> Introduction<br>
<input type="checkbox" name="re_addl" value="true"> Additional information<br>
<cfif IsDefined("session.cobrand_cso_id") and session.cobrand_cso_id gt 0>
<input type="checkbox" name="re_local" value="true"> Local programs<br>
</cfif>
<br>

<b>Report formatting</b><br>
<input type="checkbox" name="rf_break" value="true"> Page breaks between sections and programs &nbsp;<i>(applies to PDF version only)</i><br>
<br>

<b>Program information to include</b><br>
<input type="checkbox" name="pe_desc" value="true" checked> Program descriptions<br>
<input type="checkbox" name="pe_entry" value="true"<cfif session.partner_id eq 17> checked</cfif>> Local office locations &nbsp; <input type="text" name="pe_limit" size="2" maxlength="2" value="<cfif session.partner_id eq 17>1<cfelse>3</cfif>"> <i>Maximum locations to display</i><br>
<input type="checkbox" name="pe_req" value="true"> Materials to have available when applying<br>
<br>

<CFQUERY DATASOURCE="#session.datasrc#" NAME="prgs">
	SELECT prg_id, prg_nm
	FROM tbl_prg_all
	WHERE prg_id IN (#preservesinglequotes(session.prg_list)#)
		and cat_id NOT IN (333, 334)
	ORDER BY order_num, prg_nm
</CFQUERY> 
<b>Programs to include</b>
&nbsp;&nbsp; <i><a href="javascript:markCheckbox(0)">mark all</a></i> &nbsp;
|
&nbsp; <i><a href="javascript:markCheckbox(1)">toggle all</a></i> &nbsp;
|
&nbsp; <i><a href="javascript:markCheckbox(2)">clear all</a></i>
<br>
<cfloop query="prgs">
<input type="checkbox" name="prg-#prg_id#"> #prg_nm#<br>
</cfloop>
<br>

<input type="hidden" name="customflag" value="true">
<input type="submit" value="Create Report">

</form>
</cfoutput>




</cfif>


<cfoutput>
<form action="#session.transfertype#://#session.servername#/frmeligibility.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post">

<input type="submit" value="Return to Results">

</form>
</cfoutput>


</font></td></tr></table>
<cf_tagFooter hidehf="yes">