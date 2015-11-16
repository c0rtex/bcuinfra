<cfquery name="wrapper" datasource="#application.dbsrc#">
	UPDATE wrapper 
	SET 
	wrapper_logo = ''
	WHERE wrapper_id = #wrapper_id#
</cfquery>

<cflocation url="#return#.cfm?wrapper_id=#wrapper_id#&partner_id=#partner_id#">