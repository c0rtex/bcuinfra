<cfparam name="brand_id" type="numeric">
<cfparam name="generic_id" type="numeric">
<cfparam name="src" type="string">

<cfquery name="dissociate" datasource="#application.dbSrc#">
	delete from answerfield_relationship
	where left_answerfield_id=#brand_id#
		and right_answerfield_id=#generic_id#
		and relationship_id=1
</cfquery>
<cfquery name="associate" datasource="#application.dbSrc#">
	insert answerfield_relationship
		(left_answerfield_id, right_answerfield_id, relationship_id)
	values
		(#brand_id#, #generic_id#, 1)
</cfquery>

<cfif src eq 'g'>
	<cflocation url="genericview.cfm?generic_id=#generic_id#">
<cfelse>
	<cflocation url="drugview.cfm?brand_id=#brand_id#">
</cfif>