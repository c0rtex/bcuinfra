<cfquery name="getform" datasource="#application.dbSrc#">
	select form_name
	from form
	where form_id='#form_id#'
</cfquery>
<cfset fname=getform.form_name>