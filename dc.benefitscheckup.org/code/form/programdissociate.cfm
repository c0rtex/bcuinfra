<cfquery name="dissociateprogram" datasource="#application.dbSrc#">
	DELETE FROM program_form
	WHERE form_id=#form_id#
		AND program_id='#program_id#'
</cfquery>