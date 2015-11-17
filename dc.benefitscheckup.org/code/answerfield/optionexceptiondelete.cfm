<cfparam name="option_id" type="numeric">
<cfparam name="subset_id" type="any" default="">
<cfparam name="partner_id" type="any" default="">

<cfset subset_op = '='>
<cfset partner_op = '='>

<cfif subset_id eq ''>
	<cfset subset_id = 'NULL'>
	<cfset subset_op = ' IS '>
</cfif>
<cfif partner_id eq ''>
	<cfset partner_id = 'NULL'>
	<cfset partner_op = ' IS '>
</cfif>

<cfquery name="ospdel" datasource="#application.dbSrc#">
	delete from option_subset_partner
	where option_id=#option_id#
		and subset_id#subset_op##subset_id#
		and partner_id#partner_op##partner_id#
</cfquery>

<cflocation addtoken="no" url="optionview.cfm?id=#option_id###exceptionAssociate">