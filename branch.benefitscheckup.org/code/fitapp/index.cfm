<cfparam name="partner_id" type="any" default="19">
<cfparam name="skipintro" type="boolean" default="false">
<cf_sessionLoadVars>

<cfif session.partner_id eq 0 >
	<cfset partner_id = 76>
</cfif>
<cf_sessionPassVars href="../fit_start.cfm" partner_id="#partner_id#" subset_id="61" var="redirectURL">
<cflocation url="../fit_start.cfm?partner_id=76&subset_id=61" AddToken="No">