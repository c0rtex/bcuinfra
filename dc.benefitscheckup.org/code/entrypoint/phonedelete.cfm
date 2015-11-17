<cfsilent>
<cfparam name="id" type="numeric">
<cfparam name="name" type="string" default="">

<cfif name neq ''>
	<cfset name = "###name#">
</cfif>

<cfquery name="phget" datasource="#application.dbSrc#">
	select entrypoint_id
	from phone
	where phone_id=#id#
</cfquery>
<cfquery name="phdel" datasource="#application.dbSrc#">
	delete from phone
	where phone_id=#id#
</cfquery>

</cfsilent><cflocation addtoken="no" url="entrypointview.cfm?id=#phget.entrypoint_id##name#">