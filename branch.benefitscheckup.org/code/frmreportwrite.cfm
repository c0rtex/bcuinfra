<cfparam name="customflag" type="boolean" default="false">
<cfparam name="file_format" type="string" default="pdf">
<cfparam name="re_cover" type="boolean" default="false">
<cfparam name="re_toc" type="boolean" default="false">
<cfparam name="re_intro" type="boolean" default="false">
<cfparam name="re_addl" type="boolean" default="false">
<cfparam name="re_local" type="boolean" default="false">
<cfparam name="rf_break" type="boolean" default="false">
<cfparam name="pe_desc" type="boolean" default="false">
<cfparam name="pe_entry" type="boolean" default="false">
<cfparam name="pe_limit" type="numeric" default="3">
<cfparam name="pe_req" type="boolean" default="false">

<cf_sessioncheck>

<cfif not customflag and session.partner_id eq 17>
	<cfset file_format = "html">
	<cfset pe_desc = "true">
	<cfset pe_entry = "true">
	<cfset pe_limit = "1">
</cfif>

<cfset programlist="">
<cfloop index="formvar" list="#StructKeyList(form)#">
	<cfif Left(formvar, 4) eq 'prg-'>
		<cfset programlist = ListAppend(programlist, Right(formvar, Len(formvar) - 4))>
	</cfif>
</cfloop>

<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" fileformat="#file_format#" coverpage="#re_cover#" toc="#re_toc#" intro="#re_intro#" addedinfo="#re_addl#" localprgs="#re_local#" pgbreaks="#rf_break#" prgdesc="#pe_desc#" prgeps="#pe_entry#" prgepnum="#pe_limit#" prgreqmat="#pe_req#" prglist="#programlist#">

<cfif file_format eq 'html'>
	<cflocation url="frmshowreport.cfm?cover=#re_cover#&CFID=#session.cfid#&CFTOKEN=#session.cftoken#">
<cfelse>
	<!--- Commenting this redirect out because of problems with the report showing up immediately
	<cflocation url="frmreportframeset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">
	--->
	
	<cf_tagHeader>

<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<font face="arial" size="4">Your report has been created as a PDF file.  You must have Adobe's Acrobat Reader installed to view it.  You can download Acrobat Reader from this site: <a href="http://www.adobe.com/products/acrobat/readstep.html">www.adobe.com/products/acrobat/readstep.html</a></font><br><br>
<cfoutput><font face="arial" size="4"><b><a href="frmreportframeset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">Click here to view your report</a></b></font></cfoutput><br><br><br>
<cfif not IsDefined('url.report_only')>
<cfoutput>
<form action="#application.transferType#://#application.serverPath#/cf/frmeligibility.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post">

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
</FONT></TD></TR></TBODY></TABLE> 

	<cf_tagFooter>
	
</cfif>
