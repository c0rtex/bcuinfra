<cfquery name="wrapper" datasource="#application.dbsrc#">
	UPDATE wrapper 
	SET 
	wrapper_deployment_status = 3
	WHERE wrapper_id = #wrapper_id#
</cfquery>

<cflocation url="deploymentlist.cfm">