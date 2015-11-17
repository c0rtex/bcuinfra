<cfset url_id=form.url_id>
<cfquery name="deactivateurl" datasource="#application.dbSrc#">
	UPDATE url
	SET active_flag=0
	WHERE url_id=#url_id#
</cfquery>
<cflocation url="urllist.cfm">