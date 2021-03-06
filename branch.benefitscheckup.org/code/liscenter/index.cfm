<cfparam name="partner_id" type="any" default="19">
<cfparam name="skipintro" type="boolean" default="false">
<cf_sessionLoadVars>

<cfif session.org_id gt 0>
	<cfquery name="cobrandInfo" datasource="#application.dbSrcOE#">
		select o.organization_type_id
		from ORGANIZATION o 
		WHERE o.id=#session.org_id#
	</cfquery>
	<cfif cobrandInfo.RecordCount and cobrandInfo.organization_type_id eq 7>
		<cfset partner_id = 17>
	</cfif>
</cfif>

<cfif skipintro>
	<cfset destTemplate = '/questions.cfm'>
<cfelse>
	<cfset destTemplate = '/start.cfm'>
</cfif>

<cf_sessionPassVars href="#destTemplate#" partner_id="#partner_id#" subset_id="41" var="redirectURL">
<cflocation url="#redirectURL#" AddToken="No">