<cfquery name="forminsert" datasource="#application.dbSrc#">
	insert into form
		(formtag_id, form_name, description, state_id)
	values
		(#tag_id#, '#name#', #PreserveSingleQuotes(description)#, #PreserveSingleQuotes(state_id)#)
</cfquery>
<cfquery name="newid" datasource="#application.dbSrc#">
	select max(form_id) as maxfid
	from form
</cfquery>
<cfset id = newid.maxfid>
