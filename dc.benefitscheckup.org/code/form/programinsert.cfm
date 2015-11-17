<cfquery name="insertprogram" datasource="#application.dbSrc#">
	INSERT INTO program_form
		(program_id, form_id, sort, formula)
	VALUES
		(#program_id#, #form_id#, #sort#, NULL)
</cfquery>