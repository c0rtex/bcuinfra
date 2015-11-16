<cf_displaySave action="insert" value="#name#" group="generic" name="#answerfield#" code="#answerfield#" var="generic_display_id">

<cfquery name="ins" datasource="#application.dbSrc#">
	insert into answerfield
		(answerfieldtype_id, answerfield, display_id, required_flag, create_user_id, create_date, modify_user_id, modify_date)
	values
		(14, '#answerfield#', #generic_display_id#, 0, #session.user_id#, now(), #session.user_id#, now())
</cfquery>
<cfquery name="generic" datasource="#application.dbSrc#">
	select answerfield_id
	from answerfield
	where answerfield='#answerfield#'
</cfquery>
<cfset id = generic.answerfield_id>