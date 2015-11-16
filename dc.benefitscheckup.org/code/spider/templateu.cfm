<cfquery name="updateSpider" datasource="#application.dbSrc#">
	UPDATE spider 
	SET spider_assigned_to = '#spider_assigned_to#', 
	spider_status = #spider_status#
	WHERE spider_id = #spider_id# 
</cfquery>

<cflocation url="template.cfm?spider_id=#spider_id#">