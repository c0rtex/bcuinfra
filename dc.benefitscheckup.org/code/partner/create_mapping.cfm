<cfquery name="partner" datasource="#application.dbsrc#">
	SELECT *
	FROM tbl_partner
	WHERE partner_id = #partner_id#
</cfquery>

<cfquery name="wrapper" datasource="#application.dbsrc#">
	SELECT *
	FROM wrapper
	WHERE wrapper_partner_id = #partner_id#
</cfquery>

<cfparam name="wrapper_code" default="#partner.partner_code#">

<cfset website_path = "/var/www/web/BCU">

<cffile action="write" file="#website_path#/#wrapper_code#/index.cfm" output='<cf_sessionPassVars var="redirectURL" href="/index.cfm" partner_id="#partner_id#" source_id="5">
	<cflocation url="##redirectURL##" AddToken="No">'>

<cflocation url="pl.cfm?partner_id=#partner_id#&wrapper_id=#wrapper.wrapper_id#">



