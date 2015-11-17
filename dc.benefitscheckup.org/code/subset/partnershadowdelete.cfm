<cfparam name="subset_id" type="numeric">
<cfparam name="partner_id" type="numeric">

<cfquery name="ospdel" datasource="#application.dbSrc#">
	delete from subset_partner_shadow
	where subset_id=#subset_id#
		and partner_id=#partner_id#
</cfquery>

<cflocation addtoken="no" url="subsetview.cfm?id=#subset_id###shadowAssociate">