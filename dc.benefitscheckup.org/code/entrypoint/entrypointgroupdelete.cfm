<cfsilent>
<cfparam name="id" type="numeric">
<cfparam name="entrypoint_id" type="numeric">
<cfparam name="state_id" type="string" default="">
<cfparam name="name" type="string" default="">

<cfif state_id neq ''>
	<cfset state_id = "&state_id=#state_id#">
</cfif>
<cfif name neq ''>
	<cfset name = "###name#">
</cfif>

<cfquery name="egdel" datasource="#application.dbSrc#">
	delete from entrypoint_entrypointgroup
	where entrypoint_id=#entrypoint_id#
		and entrypointgroup_id=#id#
</cfquery>

</cfsilent><cflocation addtoken="no" url="entrypointgroupview.cfm?id=#id##state_id##name#">