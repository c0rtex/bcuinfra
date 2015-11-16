<cfmodule template="../header.cfm">
<!--edit sponsoring agency-->
<HTML>
<HEAD>
	<TITLE>Org</TITLE>
</HEAD>

<BODY>
<CFQUERY DATASOURCE="#application.dbSrc#" NAME="org">
    SELECT address, city, st, zip, org_id, phone_no, org_name, web_site, 
            fax, email, org_name2, address1, address2, counties_served, cities_served, 
            zips_served, hours
    FROM tbl_entry
    WHERE org_id=<CFIF isdefined("org_id")>#org_id#<cfelse>#cfgridkey#</CFIF> 
        AND group_id=#group_id#
</CFQUERY>
<!---  --->

<cfFORM action="spons_agcy.cfm" method="post" NAME="edit_spons">

<CFOUTPUT>
		<CFIF isdefined("st")>
			<INPUT TYPE="hidden" NAME="srch_st" VALUE="#st#">
		</CFIF>
		<CFIF isdefined("group_id")>
			<INPUT TYPE="hidden" NAME="group_id" VALUE="#group_id#">
			<INPUT TYPE="button" VALUE="Refresh" onclick="window.location = 'edit_spons.cfm?datasrc=#application.dbSrc#&user=#session.user#&st=#st#&group_id=#group_id#&cfgridkey=#cfgridkey#'">
		</CFIF>
</CFOUTPUT>
	
<CFOUTPUT query="org">
<table border="1" width="100%">
		<tr>
		<td width="1%">Name</td><td colspan="3"><INPUT TYPE="text" NAME="org_name" VALUE="#org_name#" size="50"></td>
		</tr>
		<td width="1%">Name2</td><td colspan="3"><INPUT TYPE="text" NAME="org_name2" VALUE="#org_name2#" size="50"></td>
		</tr>
		<tr>
		<td width="1%">Address</td>
		<td colspan="3"><INPUT TYPE="text" NAME="address" VALUE="#address#" size="50"></td>
		</tr>
		<tr>
		<td width="1%">Address1</td>
		<td colspan="3"><INPUT TYPE="text" NAME="address1" VALUE="#address1#" size="50"></td>
		</tr>
		<tr>
		<td width="1%">Address2</td>
		<td colspan="3"><INPUT TYPE="text" NAME="address2" VALUE="#address2#" size="50"></td>
		</tr>
		<tr>
		<td width="1%">City</td>
		<td width="1%" colspan="3"><INPUT TYPE="text" NAME="city" VALUE="#city#" size="25"></td>
		</tr>
		<tr>
		<td width="1%">St</td>
		<td width="1%"><INPUT TYPE="text" NAME="st" VALUE="#st#" size="2"></td>
		<td width="1%">Zip</td>
		<td width="1%"><INPUT TYPE="text" maxlength="5" NAME="zip" VALUE="#zip#" size="5"></td>
		</tr>
		<tr>
		<td width="1%">Counties Served</td>
		<td colspan="3"><INPUT TYPE="text" NAME="counties_served" VALUE="#counties_served#" size="50"></td>
		</tr>
		<td width="1%">Cities Served</td>
		<td colspan="3"><INPUT TYPE="text" NAME="cities_served" VALUE="#cities_served#" size="50"></td>
		</tr>
		<td width="1%">Zips Served</td>
		<td colspan="3"><input type="text" name="zips_served" value="#zips_served#" size="50" maxlength="1000"></td>
		</tr>
		<tr>
		<td width="1%">Phone</td>
		<td colspan="3"><INPUT TYPE="text" NAME="phone_no" VALUE="#phone_no#" size="50"></td>
		</tr>
		<tr>
		<td width="1%">Fax</td>
		<td colspan="3"><INPUT TYPE="text" NAME="fax" VALUE="#fax#" size="50"></td>
		</tr>
		<tr>
		<td width="1%">Hours</td>
		<td colspan="3"><INPUT TYPE="text" NAME="hours" VALUE="#hours#" size="50"></td>
		</tr>
		<tr>
		<td width="1%">Web site</td>
		<td colspan="3"><INPUT TYPE="text" NAME="web_site" VALUE="#web_site#" size="50"></td>
		</tr>
		<td width="1%">E-mail</td>
		<td colspan="3"><INPUT TYPE="text" NAME="email" VALUE="#email#" size="50"></td>
		</tr>
</table>
	
		<!---- Mir Begin To prevent the Read only user from inserting or updating the data base ---->
		<CFIF "#session.user#" IS  "READUSER"> 
			<H3> You are a Read Only User </H3>
		<CFELSE> 
			<!--  Mir End  --->
			<INPUT TYPE="submit" NAME="edit" VALUE="Update">
			<CFSET AddedExpr = "&datasrc=" & datasrc & "&user=" & user >
			<CFIF isdefined("st")>
				<CFSET MySt = st>
				<CFSET AddedExpr = AddedExpr & "&st=" & st>
			</CFIF>
		
			<CFIF isdefined("group_id")>
				<CFSET MyGroupId = group_id>
				<CFSET AddedExpr = AddedExpr & "&group_id=" & MyGroupId>
			</CFIF>
		
			<INPUT TYPE="button" VALUE="Delete" onclick="if (confirm('Are you sure you want to delete this entry?')) {location.href='deleteentry.cfm?OrgId=#org_id##AddedExpr#'}"> <!--- Chaim Add 1/4/00 --->
		</cfif> <!---end Mir --->
			<INPUT TYPE="button" VALUE="Cancel" onclick="window.close();">
			


<INPUT TYPE="hidden" NAME="cfgridkey" VALUE="#cfgridkey#">
<INPUT TYPE="hidden" NAME="org_id" VALUE="#org_id#">
</CFOUTPUT>

</cfFORM>

</BODY>
</HTML>
<cfmodule template="../footer.cfm">