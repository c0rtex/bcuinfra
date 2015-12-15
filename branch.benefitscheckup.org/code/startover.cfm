<!--- Load passed variables without initializing unspecified session variables --->
<cf_sessionLoadVars initAll="false">
<cfparam name="prev_id" type="any" default="0">

<!--- Check if prev_id is a list instead of a singular value --->
<cfif prev_id NEQ 0 AND ListLen(prev_id) GT 1>
	<cfset prev_id = ListLast(prev_id)>
	<cfset SESSION.prev_id = ListLast(prev_id)>
</cfif>

<!--- Used 'and false' to disable OE links for now --->
<cfif (session.source_id eq 2 or session.source_id eq 3) and False>
	<cfif session.client_id eq 'NULL'>
		<cfset repeatURL="http://#application.serverPathOE#/menu.do">
	<cfelse>
		<cfset repeatURL="http://#application.serverPathOE#/clients.do">
	</cfif>
<cfelseif IsDefined('session.screening.mode') and session.screening.mode eq 'full'>
	<cf_handleScreeningAnswerfield action="get" code="st" element="val" var="state_id">
	<cfif state_id eq ''>
		<cf_sessionPassVars var="repeatURL" href="full.cfm" prev_id="#prev_id#">
	<cfelse>
		<cf_sessionPassVars var="repeatURL" href="full.cfm" prev_id="#prev_id#" state_id="#state_id#">
	</cfif>
<cfelseif (session.partner_id eq 6 or session.partner_id eq 7) and False>
	<!--- this branch disabled currently by including the "false" --->
	<cf_sessionPassVars var="repeatURL" href="before_you_start.cfm?sc_partner_id=#session.sc_partner_id#" prev_id="#prev_id#">
<cfelse>
	<cf_sessionPassVars var="repeatURL" href="frmwelcome2.cfm?sc_partner_id=#session.sc_partner_id#" prev_id="#prev_id#">
</cfif>

<cflocation url="#repeatURL#" addtoken="yes">
