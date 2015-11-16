<cfquery name="gettype" datasource="#application.dbSrc#">
	select type_code
	from formtype
	where formtype_id='#type_id#'
</cfquery>
<cfset tname=gettype.type_code>