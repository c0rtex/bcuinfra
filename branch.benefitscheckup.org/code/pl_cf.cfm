<cfparam name="filter" default="all">

<cfquery name="parents" datasource="#application.dbSrc#">
	SELECT t2.partner_id, t2.partner_name
	FROM tbl_partner t1
	LEFT JOIN  tbl_partner t2 ON t2.partner_id = t1.parent
	WHERE t1.parent > 0
	ORDER BY t2.partner_name, t1.partner_id

</cfquery>


<cfswitch expression="#filter#">
	<cfcase value="all">
        <cfset qFilter = "AND wrapper_deployment_status = 3">
	<!---	<cfset qFilter = ""> Changed to the above because we only want active not all--->
	</cfcase>
	
	<cfcase value="sponsor">
		<cfset qFilter = "AND wrapper_deployment_status = 3 AND t.partnertype_id = 1">	
	</cfcase>

	<cfcase value="nonsponsor">
		<cfset qFilter = "AND wrapper_deployment_status = 3 AND t.partnertype_id = 3">	
	</cfcase>

	<cfcase value="organization">
		<cfset qFilter = "AND wrapper_deployment_status = 3 AND t.partnertype_id = 5">	
	</cfcase>

	<cfcase value="Demo">
		<cfset qFilter = "AND wrapper_deployment_status = 3 AND demo = 1">	
	</cfcase>
        <cfcase value="inactive">
        <cfset qFilter = "AND wrapper_deployment_status = 0">
        </cfcase>
</cfswitch>

<cfloop query="parents">
	<cfif filter IS partner_id>
		<cfset qFilter = "AND parent = #partner_id#">	
	</cfif>	
</cfloop>


<cfquery name="wrapper" datasource="#application.dbSrc#">
	SELECT *
	FROM wrapper w
	LEFT JOIN tbl_partner t ON t.wrapper_id = w.wrapper_id
        LEFT JOIN partnertype pt ON t.partnertype_id = pt.partnertype_id
        WHERE NOT (wrapper_code = 'bcu') AND NOT (pt.code = 'nonpl') AND NOT (pt.code = 'batch') AND NOT (t.partner_id = '66')
	#qFilter#
	ORDER BY partner_name
</cfquery>

<h1 class="h1">Private Label List</h1>

<p>
<form action="pl.cfm" method="post">
<select name="filter" size="1">
	<option value="all" <cfif filter IS "">SELECTED</cfif>>Active</option>
	<option value="sponsor" <cfif filter IS "sponsor">SELECTED</cfif>>Sponsor</option>
	<option value="nonsponsor" <cfif filter IS "nonsponsor">SELECTED</cfif>>Non Sponsor</option>		
	<option value="demo" <cfif filter IS "demo">SELECTED</cfif>>Demo</option>			
	<cfoutput query="parents" group="partner_name">
	<option value="#partner_id#" <cfif filter IS partner_id>SELECTED</cfif>>#partner_name#</option>		
	</cfoutput>
	<option value="inactive" <cfif filter IS "inactive">SELECTED</cfif>>Inactive</option>			
</select> <input type="submit" value="Filter" />
</form>
</p>

<table  border="0" cellspacing="0" cellpadding="0" width="100%">

<tr>
<td class="text1" style="padding: 4px 16px 8px 0px; font-weight:bold; border-bottom:1px solid #ccc;">Private Label</td>
<td class="text1" style="padding: 4px 0px 8px; font-weight:bold; border-bottom:1px solid #ccc;">Website URL</td>
</tr>

<cfoutput query="wrapper" group="partner_name">
<tr>
<td class="text1" style="padding: 8px 16px 8px 0px; border-bottom:1px solid ##ccc;">#partner_name#</td>
<td class="text1" style="padding: 4px 0px 8px; border-bottom:1px solid ##ccc;"><a href="http://#client.serverPath#/#wrapper_code#" target="#partner_id#" style="text-decoration:none;">http://#client.serverPath#/#wrapper_code#</a></td>
</tr>
</cfoutput>
</table>

