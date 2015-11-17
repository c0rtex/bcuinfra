<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<cfmodule template="../header.cfm">
<HTML>
<HEAD>
	<TITLE>Counties Not in use</TITLE>
</HEAD>

<BODY>

<CFOUTPUT><H2> STATE = #SelSt#<BR> <BR>
GROUP ID = #SelGrp#<BR><BR></H2></CFOUTPUT>

<CFQUERY NAME="qrySt" DATASOURCE="#application.dbSrc#">
	SELECT DISTINCT state FROM tbl_zip
	ORDER BY state
</CFQUERY>


	<CFSET CurrentSt = qrySt.state>

	<CFQUERY NAME="qryCounty" DATASOURCE="#application.dbSrc#">
		SELECT DISTINCT county
		FROM tbl_zip
		WHERE state = '#SelSt#'
	</CFQUERY>
	
	<BR>
	<b>These Counties in the zip code table that are not listed in the Counties Served Field: </b><br><br>
	 <TABLE>
		<TR bgcolor="tan">
	
				<TD>County</TD>
		</TR>
				
	<CFLOOP QUERY="qryCounty">
		<CFSET CurrentCounty = county>
		
	
			<CFQUERY NAME="qryEntryCounties" DATASOURCE="#application.dbSrc#">
				SELECT COUNT(*) as num_recs
				FROM tbl_entry
				WHERE group_id = #SelGrp#
				AND st = '#SelSt#'
				AND counties_served LIKE '%#CurrentCounty#%'
			</CFQUERY>
			<CFIF qryEntryCounties.num_recs EQ 0>
				<!--- <CFINCLUDE TEMPLATE="IncSetTrBgColor.cfm"> --->
				<CFOUTPUT>
				<TR >
					<TD BGCOLOR="FF8080">#CurrentCounty# </TD>
				</TR>
				</CFOUTPUT>
			</CFIF>
	
	
	</CFLOOP> 
	</TABLE>

	<BR><BR>


			<CFQUERY NAME="qryAllCounty" DATASOURCE="#application.dbSrc#">
				SELECT Distinct county
				FROM tbl_zip
				WHERE state = '#SelSt#'
				ORDER BY county
			</CFQUERY>
	
	
	
		<H4><CFOUTPUT>Counties in #SelSt#</CFOUTPUT></H4>	<BR><BR>
		<CFOUTPUT QUERY="qryAllCounty">
			#county#<BR>
		</CFOUTPUT>
 
</BODY>
</HTML>
<cfmodule template="../footer.cfm">