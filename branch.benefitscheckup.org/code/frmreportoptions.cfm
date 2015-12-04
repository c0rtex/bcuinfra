<cfif IsDefined('url.report_only')>
	<cf_sessionLoadVars checksubset="false">
<cfelse>
	<cf_sessioncheck>
</cfif>
<cf_tagHeader>
<script language="JavaScript1.1">
<!--
function markCheckbox(action, start, end) {
	var frm = document.custom;
	switch (action) {
		case 0:
			for (i = start; i < end; i++)
				if (frm.elements[i].type == 'checkbox' && frm.elements[i].name.substring(0, 4) == 'prg-')
					frm.elements[i].checked = true;
			break;
		case 1:
			for (i = start; i < end; i++)
				if (frm.elements[i].type == 'checkbox' && frm.elements[i].name.substring(0, 4) == 'prg-')
					frm.elements[i].checked = !(frm.elements[i].checked);
			break;
		default:
			for (i = start; i < end; i++)
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
<cfif IsDefined('session.org_id') and session.org_id gt 0>
--->
<cfif 1 eq 0>

<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#">

<cfoutput>
<font face="arial" size="4">Your report has been created.  You may access it in two different formats: HTML or PDF.  Any web browser should be able to view the HTML version of the report, but you must have Adobe's Acrobat Reader installed to view the PDF version.  You can download Acrobat Reader from this site: <a href="http://www.adobe.com/products/acrobat/readstep.html">www.adobe.com/products/acrobat/readstep.html</a><br><br>
<a href="#application.transferType#://#application.serverPath#/pdf/#session.CFToken#-#session.cfid#.pdf" target="_parent">PDF - Better formatting, better organization, longer document</a><br>
<br>
<a href="#application.transferType#://#application.serverPath#/frmshowreport.cfm" target="_parent">HTML  - Standard design, shorter document</a></center></font>
</cfoutput>

<br><br>


<cfelse>




<cfoutput>
<form action="/cf/frmreportwrite.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#&RequestTimeout=300<cfif IsDefined('url.report_only')>&report_only=1</cfif>" method="post" name="custom">

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
<cfif IsDefined('session.org_id') and session.org_id gt 0>
<input type="checkbox" name="re_local" value="true"> Local programs<br>
	<cfset localCount = 1>
<cfelse>
	<cfset localCount = 0>
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


<CFQUERY DATASOURCE="#application.dbSrc#" NAME="prgs">
	select q.program_code, q.bigsort, q.pcsort, q.ppsort, ifnull(pg.sort, 0) groupsort
	from (
		select pp.program_code, pp.programgroup_id, ifnull(pp.supersort, 999999999) bigsort, pc.sort pcsort, pp.sort ppsort
		from tbl_prg_all p, program pp, programcategory pc
		where 
		<cfif #len(session.prg_list)# gt  10>
		p.prg_id in (#PreserveSingleQuotes(session.prg_list)#)
		<cfelse>
		1 = 0
		</cfif>

			and p.RecID=pp.program_id
			and pp.programcategory_id=pc.programcategory_id
		<cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''>
		and (pc.legacy_code is null or pc.legacy_code not in (333, 334))	
		</cfif>
		) q left outer join programgroup pg
			on q.programgroup_id=pg.programgroup_id
	order by groupsort, q.bigsort, q.pcsort, q.ppsort
</CFQUERY>
<cfset checkPrgStart = 11 + localCount>
<cfset checkPrgEnd = checkPrgStart + prgs.RecordCount>

<cfif isdefined('session.buff_list') and session.buff_list neq ''>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="buffs">
		select q.program_code, q.bigsort, q.pcsort, q.ppsort, ifnull(pg.sort, 0) groupsort
		from (
			select pp.program_code, pp.programgroup_id, ifnull(pp.supersort, 999999999) bigsort, pc.sort pcsort, pp.sort ppsort
			from tbl_prg_all p, program pp, programcategory pc
			where 
			<cfif #len(session.buff_list)# gt 10>
			p.prg_id in (#PreserveSingleQuotes(session.buff_list)#)
			<cfelse>
			1 = 0
			</cfif>
				and p.RecID=pp.program_id
				and pp.programcategory_id=pc.programcategory_id
			<cfif Not IsDefined('session.subset_id') Or session.subset_id eq 0 Or session.subset_id eq 21 Or session.subset_id eq ''>
				and (pc.legacy_code is null or pc.legacy_code not in (333, 334))
			</cfif>
			) q left outer join programgroup pg
				on q.programgroup_id=pg.programgroup_id
		order by groupsort, q.bigsort, q.pcsort, q.ppsort
	</CFQUERY>
	<cfset checkBuffStart = checkPrgEnd>
	<cfset checkBuffEnd = checkBuffStart + buffs.RecordCount>
</cfif>
<b>Programs to include</b>
&nbsp;&nbsp; <i><a href="javascript:markCheckbox(0, #checkPrgStart#, #checkPrgEnd#)">mark all</a></i> &nbsp;
|
&nbsp; <i><a href="javascript:markCheckbox(1, #checkPrgStart#, #checkPrgEnd#)">toggle all</a></i> &nbsp;
|
&nbsp; <i><a href="javascript:markCheckbox(2, #checkPrgStart#, #checkPrgEnd#)">clear all</a></i>
<br>
<cfloop query="prgs">
	<cf_cacheProgramPool action="get" code="#program_code#" var="pobj">
	<cf_displayText group="program" code="program_#program_code#" var="prg_nm">
	<cfif isdefined('pobj.legacy')><input type="checkbox" name="prg-#pobj.legacy#">#prg_nm#<br></cfif>
</cfloop>
<cfif isdefined('session.buff_list') and session.buff_list neq ''>
	<br /><b>Other programs to consider</b>
&nbsp;&nbsp; <i><a href="javascript:markCheckbox(0, #checkBuffStart#, #checkBuffEnd#)">mark all</a></i> &nbsp;
|
&nbsp; <i><a href="javascript:markCheckbox(1, #checkBuffStart#, #checkBuffEnd#)">toggle all</a></i> &nbsp;
|
&nbsp; <i><a href="javascript:markCheckbox(2, #checkBuffStart#, #checkBuffEnd#)">clear all</a></i>
<br />
	<cfloop query="buffs">
		<cf_cacheProgramPool action="get" code="#program_code#" var="pobj">
		<cf_displayText group="program" code="program_#program_code#" var="prg_nm">
		<cfif isdefined('pobj.legacy')><input type="checkbox" name="prg-#pobj.legacy#">#prg_nm#<br></cfif>
	</cfloop>
</cfif>
<br>

<input type="hidden" name="customflag" value="true">
<input type="submit" value="Create Report">
</form>
</cfoutput>
</cfif>
<br><br>
<cfif not IsDefined('url.report_only')>
<cfoutput>
<form action="/cf/frmeligibility.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post">

<input type="submit" value="Return to Results">

</form>
</cfoutput>
<cfelseif session.client_id neq 'null' and session.partner_id neq 61 and session.partner_id neq 81>
<cfoutput>
			

			<form action="#application.transferType#://#application.serverPathOE#/clientDetail.do?id=#session.client_id#" method="post" target="_top">

				<input type="submit" value="Return to Client Detail">

			</form>
</cfoutput>
</cfif>

</font></td></tr></table>
<cf_tagFooter>