<cfquery name="dissociatetype" datasource="#application.dbSrc#">
	DELETE FROM form_formtype
	WHERE form_id=#form_id#
		AND formtype_id='#type_id#'
</cfquery>