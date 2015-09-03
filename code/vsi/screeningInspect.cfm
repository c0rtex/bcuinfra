<cfparam name="id" type="numeric">
<cfparam name="by" type="string" default="ans">
<cfparam name="dir" type="string" default="asc">
<cfparam name="rows" type="numeric" default="100">

<cfif by eq 'ans'>
	<cfset ansdir = dir>
	<cfset defdir = 'asc'>
<cfelse>
	<cfset ansdir = 'asc'>
	<cfset defdir = dir>
</cfif>
<cfset nullstring = 'zzzzzzzzzzzzzzzzz'>

<cfquery name="screen" datasource="#application.dbSrc#">
	select screening_id, prev_screening_id, cfid, cftoken, source_id, org_id, partner_id,
		subset_id, language_id, access_id, client_id, user_id, preset_state_id, test_flag,
		start_datetime, end_datetime
	from screening s
	where screening_id=#id#
	order by screening_id desc
</cfquery>

<html>
<head>
<title>Screening Response List</title>
</head>

<body>
<cfoutput>

<i><a href="./">variable space inspector</a> &nbsp;&gt;&nbsp; <a href="screeningList.cfm?rows=#rows#">recent screening list</a></i>

<h3>screening response list</h3>

<cfif screen.RecordCount eq 0>
<p><i>Data for screening_id #id# could not be found.</i></p>	
<cfelse>
<p><i>Below are user responses for the indicated screening.  Click on column headers to change sort.</i></p>

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
		<td align="right" valign="top">#screening_id#</td>
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
</table><br>

<cfquery name="ans" datasource="#application.dbSrc#">
	select pg, ans, type, response, retain, derive, approx, submit
	from (
			select sa.pagenum pg, a.answerfield ans, abs((sa.responsetype % 3) - 3) type,
				ifnull(sa.response, ifnull(o.option_code, '#nullstring#')) response,
				1 - ifnull(sa.retained_flag, 0) retain, 1 - ifnull(sa.derived_flag, 0) derive,
				1 - ifnull(sa.approximation_flag, 0) approx, sa.submit_datetime submit
			from screening_answerfield sa inner join answerfield a
					on sa.answerfield_id = a.answerfield_id
				left outer join `option` o 
					on sa.option_id = o.option_id
			where sa.screening_id=#id#
		) q
	order by <cfif by neq 'ans'>#by# #defdir#, </cfif>ans #ansdir#
</cfquery>

<table cellpadding="3" cellspacing="1" border="1">
	<tr style="font-family: Arial, Helvetica, sans-serif; font-size: 10pt; font-weight: bold;">
		<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=pg&dir=<cfif by eq 'pg' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">pg</a><cfif by eq 'pg'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>
		<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=ans&dir=<cfif by eq 'ans' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">answerfield</a><cfif by eq 'ans'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>
		<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=type&dir=<cfif by eq 'type' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">type</a><cfif by eq 'type'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>
		<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=response&dir=<cfif by eq 'response' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">response</a><cfif by eq 'response'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>
		<!---<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=retain&dir=<cfif by eq 'retain' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">retained</a><cfif by eq 'retain'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>--->
		<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=derive&dir=<cfif by eq 'derive' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">derived</a><cfif by eq 'derive'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>
		<!---<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=approx&dir=<cfif by eq 'approx' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">approximated</a><cfif by eq 'approx'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>--->
		<td align="left" valign="bottom"><a href="screeningInspect.cfm?id=#id#&by=submit&dir=<cfif by eq 'submit' and dir eq 'asc'>desc<cfelse>asc</cfif>&rows=#rows#">submitted</a><cfif by eq 'submit'>&nbsp;<cfif dir eq 'asc'>&uarr;<cfelse>&darr;</cfif></cfif></td>
	</tr>
	<cfloop query="ans">
	<tr style="font-family: Arial, Helvetica, sans-serif; font-size: 9pt;">
		<td align="right" valign="top">#pg#</td>
		<td align="left" valign="top">#ans#</td>
		<td align="left" valign="top"><cfif type eq 1>alpha<cfelseif type eq 2>numeric<cfelse>option</cfif></td>
		<td align="left" valign="top"><cfif response eq nullstring>&nbsp;<cfelse>#response#</cfif></td>
		<!---<td align="left" valign="top"><cfif retain eq 0>yes<cfelse>&nbsp;</cfif></td>--->
		<td align="left" valign="top"><cfif derive eq 0>yes<cfelse>&nbsp;</cfif></td>
		<!---<td align="left" valign="top"><cfif approx eq 0>yes<cfelse>&nbsp;</cfif></td>--->
		<td align="left" valign="top">#submit#</td>
	</tr>
	</cfloop>
</table>
<p><i>Below are user report content for this screening. (if any) </i></p>
<cfquery name="report_content" datasource="#application.dbSrc#">
SELECT
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id
from screening_content
where
screening_id = #id#
order by content_code asc 
</cfquery>
<cfdump var="#report_content#">

<p><i>Below are user programs for this screening. (if any) </i></p>
<cfquery name="programs" datasource="#application.dbSrc#">
	SELECT
screening_program.program_id,
program.program_code,
screening_program.screening_id,
screening_program.buffer_flag,
program.active_flag,
program.programcategory_id,
programcategory.`code`
FROM
screening_program
INNER JOIN program ON program.program_id = screening_program.program_id
INNER JOIN programcategory ON programcategory.programcategory_id = program.programcategory_id
WHERE
screening_program.screening_id = #id#
</cfquery>
<cfdump var="#programs#">


</cfif>
</cfoutput>
</body>
</html>