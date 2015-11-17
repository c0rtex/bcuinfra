<cfparam name="id" type="numeric">
<cfparam name="value" type="numeric">

<cf_checkAccess level="2">

<cfif value neq 0>
	<cfset value=1>
</cfif>
<cfquery name="activate" datasource="#application.dbSrc#">
	update `user`
	set active=#value#,
		modify_user_id=#session.user_id#,
		modify_date=now()
	where user_id=#id#
</cfquery>

<cflocation url="userlist.cfm">