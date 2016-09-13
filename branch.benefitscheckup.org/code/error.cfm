<cfparam name="sesssion.cfid" default="0">
<cfparam name="sesssion.cftoken" default="0">

<cfparam name="cfid" default="#sesssion.cfid#">
<cfparam name="cftoken" default="#sesssion.cftoken#">

<cfquery name="findOldSession" datasource="#application.dbSrc#">
		SELECT * FROM screening WHERE cfid = '#cfid#' AND cftoken = '#cftoken#' ORDER BY start_datetime DESC
</cfquery>

<cflocation url="/index.cfm?partner_id=#val(findOldSession.partner_id)#&org_id=#val(findOldSession.org_id)#">