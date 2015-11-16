<cfparam name="answerfield_id" type="numeric">
<cfparam name="subset_id" type="numeric">
<cfparam name="partner_id" type="any" default="">

<cfset partner_op = '='>
<cfif partner_id eq ''>
	<cfset partner_id = 'NULL'>
	<cfset partner_op = ' IS '>
</cfif>

<cfquery name="ospdel" datasource="#application.dbSrc#">
	delete from answerfield_subset_partner
	where answerfield_id=#answerfield_id#
		and subset_id=#subset_id#
		and partner_id#partner_op##partner_id#
</cfquery>

<cflocation addtoken="no" url="subsetview.cfm?id=#subset_id###defaultAssociate">