<cfparam name="zip" type="string" default="">
<cfparam name="qaire" type="numeric" default="0">
<cf_sessionLoadVars>
<cf_cacheSubsetPool action="get" subset_id="#session.subset_id#" var="sobj">
<cfif sobj.type eq 'application'>
	<cfset hurl = '/questions.cfm'>
	<cfset session.state_id = ''>
<cfelseif qaire eq 0>
	<cfset hurl = '/full.cfm'>
<cfelseif qaire eq 1>
	<cfset hurl = '/fullprint.cfm'>
<cfelse>
	<cfset hurl = '/frmwelcome2.cfm'>
</cfif>
<cf_sessionPassVars href="#hurl#" extralist="zip=#zip#" addtoken="true" var="redir">
<cflocation url="#redir#">