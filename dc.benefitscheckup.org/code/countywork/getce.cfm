<cfmodule template="../header.cfm">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>View Non Exisiting counties in sntry points</TITLE>
</HEAD>

<BODY>

<CFOUTPUT><H2> STATE = #SelSt#<BR> <BR>
GROUP ID = #SelGrp#<BR><BR></H2></CFOUTPUT>

<CFQUERY NAME="qrySt" DATASOURCE="#application.dbSrc#">
	SELECT DISTINCT state FROM tbl_zip
	ORDER BY state
</CFQUERY>


	<CFSET CurrentSt = SelSt>

	<CFQUERY NAME="qryEntryCounties" DATASOURCE="#application.dbSrc#">
		SELECT org_id, org_name, counties_served
		FROM tbl_entry
		WHERE st = '#CurrentSt#'
		AND group_id = #SelGrp#
	</CFQUERY>
	
	<BR>
	<h3>These counties are not in the zip code table but are listed in the counties served field.</h3>
	 <TABLE>
		<TR bgcolor="tan">
				<TD>Org Id</TD>
				<TD>Org Name</TD>
				<TD>County</TD>
		</TR>
				
	<CFLOOP QUERY="qryEntryCounties">
		<CFSET CurrentCountiesServed = counties_served>
		<CFSET CurrentOrgName = org_name>
		<CFSET CurrentOrgId = org_id>
		
		<CFLOOP INDEX="CurrentCounty" LIST="#CurrentCountiesServed#">
			<CFQUERY NAME="qryCounty" DATASOURCE="#application.dbSrc#">
				SELECT COUNT(*) as num_recs
				FROM tbl_zip
				WHERE state = '#CurrentSt#'
				AND county like '#TRIM(CurrentCounty)#'
			</CFQUERY>
			<CFIF qryCounty.num_recs EQ 0>
				<CFINCLUDE TEMPLATE="IncSetTrBgColor.cfm">
				<CFOUTPUT>
				<TR BGCOLOR="#Bgclr#">
					<TD>#CurrentOrgId#</TD>
					<TD>#CurrentOrgName#</TD>
					<TD BGCOLOR="FF8080">#CurrentCounty# </TD>
				</TR>
				</CFOUTPUT>
			</CFIF>
		</CFLOOP>
	
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