<cfparam name="group_id" type="numeric" default="0">
<cfparam name="program_id" type="numeric" default="0">
<cfparam name="url.partner_id" type="numeric" default="14">
<cfset url.partner_id = 14>
<cf_cacheProgramPool action="get" id="#program_id#" var="pobj" codevar="prgcode">
<cf_displayText group="program" code="program_#prgcode#" var="prgname">

<cfif IsDefined('session.state_id') and session.state_id neq ''>
	<cfset localStateID = session.state_id>
<cfelseif IsDefined('session.st') and session.st neq ''>
	<cfset localStateID = session.st>
<cfelseif pobj.st neq ''>
	<cfset localStateID = pobj.st>
<cfelseif IsDefined('url.state_id') and url.state_id neq ''>
	<cfset localStateID = url.state_id>
<cfelse>
	<cfset localStateID = 'FD'>
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



 <table width=100% border="0" align="center" cellpadding=12 cellspacing=2>
	<TBODY>
	<tr>
    
	<td bgcolor=#FFFFFF colspan=2>
    <form action="" method="post">
    <font face="arial" size="3">
    <INPUT TYPE="button" VALUE="Back" ONCLICK="history.go(-1)">
    </font>
    </form><br />
<!--Dynamic Area-->
<cfif isdefined('session.partner_id') and (session.partner_id eq 0 or session.partner_id eq 77)>
<div id="content" style="width:840px;">
<cfelse>
<div id="content">
</cfif>

<h2 class="screeningh2" style="display:none;">Offices</h2>

<cfoutput>
<strong>#prgname#<br /><cfif isdefined('stobj.name')>Offices Located in #stobj.name#<br />Sorted by city and zip code</cfif></strong>
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


