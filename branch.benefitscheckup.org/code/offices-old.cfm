<cfparam name="group_id" type="numeric" default="0">
<cfparam name="program_id" type="numeric" default="0">

<cf_cacheProgramPool action="get" id="#program_id#" var="pobj" codevar="prgcode">
<cf_displayText group="program" code="program_#prgcode#" var="prgname">

<cfif IsDefined('session.state_id') and session.state_id neq ''>
	<cfset localStateID = session.state_id>
<cfelseif IsDefined('session.st') and session.st neq ''>
	<cfset localStateID = session.st>
<cfelse>
	<cfset localStateID = pobj.st>
</cfif>
<cf_cacheStatePool action="get" state_id="#localStateID#" var="stobj">

<cfquery name="ep" datasource="#application.dbSrc#">
	select e.entrypoint_id
	from entrypoint_entrypointgroup eg, entrypoint e
	where eg.entrypointgroup_id=#group_id#
		and eg.entrypoint_id=e.entrypoint_id
		and e.active_flag=1
		and e.state_id='#localStateID#'
	order by e.city, e.zipcode
</cfquery>

<cf_buildHTML> 

 <table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
	<td bgcolor=#FFFFFF colspan=2>
<!--Dynamic Area-->
<div id="content">
<h2 class="screeningh2" style="display:none;">Offices</h2>

<cfoutput>
<strong>#prgname#<br />Offices Located in #stobj.name#<br />Sorted by city and zip code</strong>
<br>

<cfloop query="ep">
	<cf_displayEntrypoint entrypoint_id="#entrypoint_id#">
</cfloop>
<!--To show link to multiple national entry points for chips program --->
<cfif group_id eq 307>
	<br />
	<cf_displayText group="site" code="site_ep_schip_link">
	<br />
</cfif>

</cfoutput>

<br>
</div>

<FORM ACTION="" METHOD="POST">
<font face="Arial" size="3">
<INPUT TYPE="button" VALUE="Back" ONCLICK="history.go(-1)">
</font>
</FORM>

</TD></TR></TBODY></TABLE>
</cf_buildHTML>