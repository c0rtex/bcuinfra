<cf_cacheProgramPool action="get" code="health_fd_schip" var="pobj">
<cf_displayText group="program" code="program_health_fd_schip" var="prgname">

<cf_buildHTML>
 <table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area--><font face="arial" size="4" color="#000000">

<cfoutput>
<strong>#prgname# Offices<br />sorted by state</strong>
<br>
<!---  Pull in all the entry points for the group id passed in via URL --->
<cfquery name="ep" datasource="#application.dbSrc#">
	select e.entrypoint_id, s.state_name
	from program_entrypointgroup pe, entrypoint_entrypointgroup eg, entrypoint e, state s
	where pe.program_id=#pobj.id#
		and pe.entrypointgroup_id=eg.entrypointgroup_id
		and eg.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
		and e.state_id=s.state_id
	order by s.statetype_id, s.state_name, e.city, e.zipcode
</cfquery>

<cfset prev_state = ''>
<cfloop query="ep">
	<br>
	<cfif state_name neq prev_state><font size="+1"><strong>#state_name#:</strong></font><br /></cfif>
	<cf_displayEntrypoint entrypoint_id="#entrypoint_id#" reduced="true">
	<cfset prev_state = state_name>
</cfloop>

</cfoutput>

<br>

<form action="" method="post">
	<input type="button" value="Back" onClick="history.go(-1)">
</form>
</FONT></TD></TR></TBODY></TABLE>
</cf_buildHTML>