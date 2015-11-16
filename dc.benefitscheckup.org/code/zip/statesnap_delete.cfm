<cfparam name="state" type="string" default=""> <!--- state --->
<cfparam name="state_snap_id" type="numeric">
<cfparam name="saving" type="numeric" default="0"> 
<cfparam name="name" type="string" default="">
<cfparam name="action" type="string" default="delete">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>



<cfquery name="scdelete" datasource="#application.dbSrc#">
	delete from state_snap
	where state_id='#state#'
		and state_snap_id='#state_snap_id#'
</cfquery>


<cflocation addtoken="no" url="statesnapview.cfm?id=#state#">


