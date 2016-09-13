<!----=======================================
DESCRIPTION: shows listing of all entry points for a specific program listed in order by city
CALLED BY: frmEntryPoints.cfm
GOES TO: N/A
REQUIRED: prg_id = 103-309-2191-FD-FD, group_id= 9376
============================================---->
 <cf_tagHeader> 
 <table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font size="4" color="#000000">
<!--- pull program name by the prg_id passed in via URL --->
<CFQUERY DATASOURCE="#session.datasrc#" NAME="prg">
	SELECT prg_nm
	FROM tbl_prg_all 
	WHERE prg_id = '103-309-2191-FD-FD'
</CFQUERY>

<CFOUTPUT><B> #prg.prg_nm# Offices ( sorted by state)</B></CFOUTPUT>
<BR>
<BR>
<!---  Pull in all the entry points for the group id passed in via URL --->
<CFQUERY DATASOURCE="#session.datasrc#" NAME="entry">
	SELECT * FROM tbl_entry
	WHERE group_id = 9376
	ORDER BY st
</CFQUERY>

<CFOUTPUT QUERY="entry">
	<BR>
	<cfif st is not ""><font size="+1">#ST#:</font><br></cfif>
	#org_name#<BR>
	<!---<CFIF org_name2 IS NOT "">
		#org_name2#<BR>
	</cfif>
	<CFIF address IS NOT "">
		#address#<BR>
	</CFIF>
	<CFIF #address1# IS NOT "">
		#address1#<BR>
	</CFIF>
	<CFIF #address2# IS NOT "">
		#address2#<BR>
	</CFIF>--->
	<!---<CFIF city IS NOT "">
		#city#, #st# <CFSET strZip = #zip#>
				<CFSET strZip = "00#StrZip#">
				<CFSET strZip = right(strZip, 5)>#strZip#<BR>
	</CFIF>--->
	<CFIF #phone_no# IS NOT "">
		Phone: #phone_no# &nbsp; <!---<CFIF #fax# IS NOT "">Fax: #fax#</CFIF>---><BR>
	</CFIF>
	
	<!---<CFIF #email# IS NOT "null">  this doesn't work either
		Email: <A HREF="mailto:#email#">#email#</A><BR>
	</CFIF> --->
	<CFIF #web_site# IS NOT "">
		Web Site: <A HREF="http://#web_site#">http://#web_site#</A><BR>
	</CFIF>
	<!---<CFIF #hours# IS NOT "">
		Hours: #hours#<BR>
	</CFIF>
	<CFIF #contact_title# IS NOT "">
		Contact: #contact_title#<BR>
	</CFIF>--->
</CFOUTPUT>

<BR>

<FORM ACTION="" METHOD="POST">
<INPUT TYPE="button" VALUE="Back" ONCLICK="history.go(-1)">
</FORM>
</FONT></TD></TR></TBODY></TABLE>
<!--- Call to footer tag --->
<cf_tagFooter>
