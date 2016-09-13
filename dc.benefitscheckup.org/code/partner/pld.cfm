<cfquery name="wrapper" datasource="#application.dbsrc#">
	SELECT *
	FROM wrapper w
</cfquery>

<cfdump var="#wrapper#">
