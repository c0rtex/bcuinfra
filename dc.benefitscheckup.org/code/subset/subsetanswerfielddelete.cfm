<cfparam name="answerfield_id" type="numeric">
<cfparam name="subset_id" type="numeric">

<cfquery name="ospdel" datasource="#application.dbSrc#">
	delete from subset_answerfield
	where subset_id=#subset_id#
		and answerfield_id=#answerfield_id#
</cfquery>

<cflocation addtoken="no" url="subsetview.cfm?id=#subset_id###afAssociate">