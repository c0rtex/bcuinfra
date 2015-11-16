<cfquery name="gettagid" datasource="#application.dbSrc#">
	select formtag_id
	from formtag
	where tag_name='#tagline#'
</cfquery>
<cfif gettagid.RecordCount eq 0>
	<cfset tag_id = 0>
<cfelse>
	<cfset tag_id = gettagid.formtag_id>
</cfif>