<cfparam name="rows" type="numeric" default="100">
<cfparam name="APPLICATION.DBSRC" default= "BCU_QA">
<cfparam name="application.serverPathCanonical" default= ""> 
<cfparam name="session.cfid" default= ""> 
<cfparam name="session.cftoken" default= ""> 
<cfquery name="screen" datasource="#application.dbSrc#">
	select screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id,
		subset_id, language_id, access_id, client_id, user_id, preset_state_id, test_flag,
		start_datetime, end_datetime
	from screening s
	order by screening_id desc limit 0, #rows#
</cfquery>

<html>
<head>
<title>Recent Screening List</title>
</head>

<body>
<i><a href="./">variable space inspector</a></i>

<h3>recent screening list</h3>

<cfoutput>

<form action="screeningList.cfm" method="get">
	<input type="text" name="rows" value="#rows#" size="5">
	<input type="submit" value="show rows">
</form>

<p><i>Listed here are the #rows# most recent screenings on #application.serverPathCanonical#.<br>Click a screening_id to inspect user responses.<br>Rows listed in <b>bold</b> have a CFID and CFTOKEN that match your current session.</i></p>

<table cellpadding="3" cellspacing="1" border="1">
	<tr style="font-family: Arial, Helvetica, sans-serif; font-size: 10pt; font-weight: bold; text-decoration: underline;">
		<td align="left" valign="bottom">id</td>
		<td align="left" valign="bottom">prev</td>
		<td align="left" valign="bottom">subset</td>
		<td align="left" valign="bottom">partner</td>
		<td align="left" valign="bottom">org</td>
		<td align="left" valign="bottom">state</td>
		<td align="left" valign="bottom">source</td>
		<td align="left" valign="bottom">client</td>
		<td align="left" valign="bottom">user</td>
		<td align="left" valign="bottom">test</td>
		<td align="left" valign="bottom">cfid</td>
		<td align="left" valign="bottom">cftoken</td>
		<td align="left" valign="bottom">start</td>
		<td align="left" valign="bottom">end</td>
		<td align="left" valign="bottom">you</td>
	</tr>
	<cfloop query="screen">
		<cfif cfid eq session.cfid and cftoken eq session.cftoken>
			<cfset yours = true>
			
		<cfelse>
			<cfset yours = false>
		</cfif>
	<tr style="font-family: Arial, Helvetica, sans-serif; font-size: 9pt;<cfif yours> font-weight: bold;</cfif>">
		<td align="right" valign="top"><a href="screeningInspect.cfm?id=#screening_id#&rows=#rows#">#screening_id#</a></td>
		<td align="right" valign="top"><cfif prev_screening_id eq 0>&nbsp;<cfelse><a href="screeningInspect.cfm?id=#prev_screening_id#&rows=#rows#">#prev_screening_id#</a></cfif></td>
		<td align="right" valign="top"><cfif subset_id eq ''>&nbsp;<cfelse>#subset_id#</cfif></td>
		<td align="right" valign="top">#partner_id#</td>
		<td align="right" valign="top"><cfif org_id eq 0>&nbsp;<cfelse>#org_id#</cfif></td>
		<td align="left" valign="top"><cfif preset_state_id eq ''>&nbsp;<cfelse>#preset_state_id#</cfif></td>
		<td align="right" valign="top"><cfif source_id eq 0>&nbsp;<cfelse>#source_id#</cfif></td>
		<td align="right" valign="top"><cfif client_id eq ''>&nbsp;<cfelse>#client_id#</cfif></td>
		<td align="right" valign="top"><cfif user_id eq ''>&nbsp;<cfelse>#user_id#</cfif></td>
		<td align="right" valign="top">#test_flag#</td>
		<td align="right" valign="top">#cfid#</td>
		<td align="right" valign="top">#cftoken#</td>
		<td align="left" valign="top">#start_datetime#</td>
		<td align="left" valign="top"><cfif end_datetime eq ''>&nbsp;<cfelse>#end_datetime#</cfif></td>
		<td align="center" valign="top"><cfif yours>x<cfelse>&nbsp;</cfif></td>
	</tr>
	</cfloop>
<table>

</cfoutput>
</body>
</html>