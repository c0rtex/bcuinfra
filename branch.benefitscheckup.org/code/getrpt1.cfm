<cfparam name = "url.clientnum" default="584" type="numeric" >
<cfparam name = "WhereToDisplay" default="inBCU" type="string">

<cfset clientnum = url.clientnum >
<cfquery name="GetUserData" datasource="#application.dbSrc#">
SELECT wantChips, County, ST, ZIP, City
FROM tbl_user_ans
WHERE clientnum =<cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">
</cfquery>

<cfquery name="GetUserPrgs" datasource="#application.dbSrc#">
SELECT prg_id
FROM tbl_user_prgid
WHERE clientnum = <cfqueryparam cfsqltype="cf_sql_integer" value="#clientnum#" maxlength="10">
</cfquery>

<cfoutput query="GetUserData">#wantchips#-#County#-#ST#-#ZIP#-#City#</cfoutput>	
<br>
<br>
<cfoutput query="GetUserPrgs">#prg_id#</cfoutput>	

<!--- Put GetUserPrgs in a list --->
<cfset session.prg_list = "">
<cfloop query="GetUserPrgs">
	<cfset session.prg_list = session.prg_list & "'" & #GetUserPrgs.prg_id# & "',">
</cfloop>


<cfif Len(session.prg_list)>
	<cfset session.prg_list = Left(session.prg_list, Len(session.prg_list)-1)>
</cfif>
<cfoutput>
<!--- Set report content values --->
<cfset session.BUFF_LIST = "">
<cfset session.wantchips = "#GetUserData.wantChips#">
<cfset session.county = "#GetUserData.County#">
<cfset session.city = "#GetUserData.City#">
<cfset session.zip = "#GetUserData.ZIP#">
<cfset session.ST = "#GetUserData.ST#">
<cf_screenPrintedReport pdfname="test" >
</cfoutput>

<cfoutput>#session.RANDOMNAME#</cfoutput>
<cflocation url="pdf/test#session.RANDOMNAME#.pdf">
<table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
  <TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
  <font face="arial" size="4">Your report has been created.  You may access it in two different formats: HTML or PDF.  Any web browser should be able to view the HTML version of the report, but you must have Adobe's Acrobat Reader installed to view the PDF version.  You can download Acrobat Reader from this site: <a href="http://www.adobe.com/products/acrobat/readstep.html">www.adobe.com/products/acrobat/readstep.html</a></font><br><br>
  <cfoutput><font face="arial" size="4"><a href="frmreportframeset.cfm?CFID=#session.cfid#&CFTOKEN=#session.cftoken#" target="_parent">PDF - Better formatting, better organization, longer document</a></font></cfoutput>
  <br><br>
  <cfoutput><font face="arial" size="4"><a href="frmshowreport.cfm" target="_parent">HTML  - Standard design, shorter document</a></font></cfoutput><br><br><br>

  </FONT></TD></TR>
  </TBODY>
</TABLE> 