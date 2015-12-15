<cfif parameterExists(session.transferTypeCanonicalOverride)>
	<cfset urlType = session.transferTypeCanonicalOverride>
<cfelse>
	<cfset urlType = application.transferType>		
</cfif>	

<cfparam name="url.btnReturn" default="Yes" type="string">
<cfif IsDefined('session.partner_id') And session.partner_id eq 5>

  <cfif url.btnReturn eq "No">
	<cfset btnReturn = "No">
  <cfelse>
    <cfset btnReturn = "Yes">
  </cfif>

<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" coverpage="false" toc="false" ltccinfo="false" brandname="LTCC Public Programs">

<cf_tagHeader refreshurl="frmreportframeset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">

 <table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<cfoutput>
Your LTCC Public Programs report is being created.  If this page does not refresh within five seconds, please <a href="frmreportframeset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#">click here</a> to access your report.<br><br><br><br><br><br><br><br><br><br><br><br><br><br>
</cfoutput>

</TD></TR></TBODY></TABLE> 

<cfelse>

<cfif btnReturn is "No">
	<cf_sessionLoadVars>
	<cfset session.regeneratedReport = 1>
<cfelse>
	<cfset session.regeneratedReport = 0>
</cfif>

<cfif IsDefined('session.partner_id') And session.partner_id eq 6>
	<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" brandcover="webmd">
<cfelseif IsDefined('session.partner_id') And session.partner_id eq 7 >
	<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" brandcover="abc">
<cfelseif session.partner_id eq 17>
	<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" coverpage="false" toc="false" intro="false" addedinfo="false" ltccinfo="false" localprgs="false" pgbreaks="false" prgepnum="1" prgreqmat="false">
<cfelseif session.partner_id eq 22>
	<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" toc="false" intro="false" addedinfo="false" ltccinfo="false" localprgs="false" pgbreaks="false" prgepnum="2" prgreqmat="true">
<cfelseif (session.subset_id EQ 54 OR session.subset_id EQ 55 OR session.subset_id EQ 56)>
	<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#" addedinfo="false">
<cfelse>
	<cf_screenPrintedReport pdfname="#session.cftoken#-#session.cfid#">
</cfif>

<cf_tagHeader>

 <table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>

<cfif SESSION.partner_id EQ 80>
	<p class="report_header">Your report has been created.  You may access it in two different formats: HTML or PDF.  
Any web browser should be able to view the HTML version of the report, but you must have Adobe's Acrobat Reader installed 
to view the PDF version.  You can download Acrobat Reader from this site: 
<a target="_new" href="http://get.adobe.com/reader/">http://get.adobe.com/reader/</a></p>
<cfelse>
	<p class="report_header">Your report has been created.  You may access it in two different formats: HTML or PDF.  
Any web browser should be able to view the HTML version of the report, but you must have Adobe's Acrobat Reader installed 
to view the PDF version.  You can download Acrobat Reader from this site: 
<a target="_new" href="http://get.adobe.com/reader/">http://get.adobe.com/reader/</a><br><br>
</cfif>
<cfif session.partner_id eq 55>
<cfoutput><a class="report_header" href="frmreportframeset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" target="_blank">PDF - Better formatting, better organization, longer document</a></cfoutput>
<br><br>
<cfoutput><a class="report_header" href="frmshowreport.cfm" target="_blank">HTML  - Standard design, shorter document</a></cfoutput><br><br><br>
<cfelse>
<cfoutput><a class="report_header" href="frmreportframeset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" target="_parent">PDF - Better formatting, better organization, longer document</a></cfoutput>
<br><br>
<cfoutput><a class="report_header" href="frmshowreport.cfm" target="_parent">HTML  - Standard design, shorter document</a></cfoutput><br><br><br>
</cfif>
<cfif btnReturn is "Yes">
<cfoutput>
	<form action="frmeligibility.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" method="post">
	<div id="return_to_results">
		<input style="width:200px;" type="submit" value="Return to Results">
	</div>
	</form>
	</cfoutput>
</cfif>

</TD></TR></TBODY></TABLE> 
</cfif>
<cf_tagFooter>