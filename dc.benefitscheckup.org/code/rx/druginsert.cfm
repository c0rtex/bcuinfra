<cf_displaySave action="insert" value="#name#" group="rx" name="#answerfield#" code="#answerfield#" var="rx_display_id">

<cfquery name="ins" datasource="#application.dbSrc#">
	insert into answerfield
		(answerfieldtype_id, answerfield, display_id, required_flag, create_user_id, create_date, modify_user_id, modify_date)
	values
		(13, '#answerfield#', #rx_display_id#, 0, #session.user_id#, now(), #session.user_id#, now())
</cfquery>
<cfquery name="brand" datasource="#application.dbSrc#">
	select answerfield_id
	from answerfield
	where answerfield='#answerfield#'
</cfquery>
<cfset id = brand.answerfield_id>