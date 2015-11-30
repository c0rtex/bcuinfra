<cfparam name="program_id" type="numeric" default="0">
<cfparam name="zipcode" type="string" default="">
<cfparam name="city_id" type="string" default="">
<cfparam name="radius" type="numeric" default="100">
<cfparam name="limit" type="numeric" default="3">
<cfparam name="mode" type="string" default="full">
<cfset save_program_id = program_id>

<cfquery name="getprg" datasource="#application.dbSrc#">
	select program_id, program_code
	from program
	where active_flag=1
	order by program_code
</cfquery>

<html>
<head>
<title>Program Entry Point Test Page</title>
</head>

<body>
<i><a href="./">variable space inspector</a></i>

<h3>program entry point test page</h3>

<cfoutput>
<form action="entrypointTest.cfm" method="post">
<table cellpadding="3" cellspacing="2">
	<tr>
	<td align="right" valign="bottom">Program</td><td valign="bottom"><select name="program_id">
		<option value="0">-- select one --</option>
		<cfloop query="getprg">
			<option value="#program_id#"<cfif program_id eq save_program_id> selected</cfif>>#program_code#</option>
		</cfloop>
	</select></td>
	</tr>
	<tr>
	<td align="right" valign="bottom">Zip code</td><td valign="bottom"><input type="text" name="zipcode" value="#HTMLEditFormat(zipcode)#" size="5" maxlength="5"></td>
	</tr>
	<cfif zipcode neq ''>
		<cfquery name="citychk" datasource="#application.dbSrc#">
			select c.city_id cid, c.city_name, c.state_id
			from view_city_zip_preferred cz, city c
			where cz.zipcode='#zipcode#'
				and cz.city_id=c.city_id
			order by c.city_name
		</cfquery>
		<cfif citychk.RecordCount eq 0>
			<cfset city_id = ''>
			<tr>
			<td align="right" valign="bottom">City</td><td valign="bottom">NOT FOUND</td>
			</tr>
		<cfelseif citychk.RecordCount eq 1>
			<cfset city_id = ''>
			<tr>
			<td align="right" valign="bottom">City</td><td valign="bottom">#citychk.city_name#, #citychk.state_id#</td>
			</tr>
		<cfelse>
			<tr>
			<td align="right" valign="bottom">City</td><td valign="bottom"><select name="city_id">
				<option value="">-- select optional city --</option>
				<cfloop query="citychk">
					<option value="#cid#"<cfif cid eq city_id> selected</cfif>>#city_name#, #state_id#</option>
				</cfloop>
			</select></td>
			</tr>
		</cfif>
	</cfif>
	<tr>
	<td align="right" valign="bottom">Radius</td><td valign="bottom"><input type="text" name="radius" value="#radius#" size="4" maxlength="5"></td>
	</tr>
	<tr>
	<td align="right" valign="bottom">Limit</td><td valign="bottom"><input type="text" name="limit" value="#limit#" size="3" maxlength="3"></td>
	</tr>
	<tr>
	<td align="right" valign="bottom">Mode</td><td valign="bottom"><select name="mode">
		<option value="full"<cfif mode eq 'full'> selected</cfif>>normal</option>
		<option value="print"<cfif mode eq 'print'> selected</cfif>>print</option>
	</select></td>
	</tr>
	<tr>
	<td></td><td><input type="submit" value="test"></td>
	</tr>
	</table>
</form>

<cfif program_id gt 0 and zipcode neq ''>
<hr>
<cfquery name="zipchk" datasource="#application.dbSrc#">
	select zipcode
	from zip
	where zipcode='#zipcode#'
		and valid=1
</cfquery>

<cfif zipchk.RecordCount eq 0>
	Sorry, but #zipcode# is not a valid zip code
<cfelse>
	<cf_displayProgramDetailEntrypoints mode="#mode#" program_id="#program_id#" city_id="#city_id#" zipcode="#zipcode#" radius="#radius#" limit="#limit#" var="entrypointStr" debugvar="debugTrace">
	<small>#debugTrace#</small><hr>
	#entrypointStr#
</cfif>


</cfif>

</cfoutput>
</body>
</html>