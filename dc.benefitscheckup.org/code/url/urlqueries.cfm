<cfquery name="geturl" datasource="#application.dbSrc#">
	select url_code
	from url
	where url_id=#url_id#
</cfquery>
<cfset uname=geturl.url_code>