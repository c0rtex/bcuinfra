<cfset url_id=form.url_id>
<cfquery name="reactivateurl" datasource="#application.dbSrc#">
	UPDATE url
	SET active_flag=1
	WHERE url_id=#url_id#
</cfquery>
<cflocation url="urllist.cfm">