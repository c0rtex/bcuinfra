<cfquery name="wrapper" datasource="#application.dbsrc#">
	UPDATE wrapper 
	SET 
	wrapper_cover_image = ''
	WHERE wrapper_id = #wrapper_id#
</cfquery>

<cflocation url="#return#.cfm?wrapper_id=#wrapper_id#&partner_id=#partner_id#">