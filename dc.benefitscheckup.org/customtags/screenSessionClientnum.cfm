<!--- SET AND STORE CLIENTNUM --->
<cfstoredproc procedure="sp_NextKey" datasource="#application.dbSrc#">
	<cfprocparam type="out" variable="varclientnum" cfsqltype="cf_sql_numeric">
	<cfprocresult name="nextkey" resultset="1">
</cfstoredproc>
<cfif IsDefined('session.client_id')>
	<cfset localtag_client_id = session.client_id>
<cfelse>
	<cfset localtag_client_id = 'NULL'>
</cfif>
<cfif IsDefined('session.user_id')>
	<cfset localtag_user_id = session.user_id>
<cfelse>
	<cfset localtag_user_id = 'NULL'>
</cfif>
<cfquery datasource="#application.dbSrc#">
	<!--- set identity_insert tbl_user_info on--->
	INSERT INTO tbl_user_info
		(clientNum, user_name, client_id, user_id)
	VALUES
		(#varclientnum#, 'customtag', #localtag_client_id#, #localtag_user_id#)
	<!--- set identity_insert tbl_user_info off --->
</cfquery>
<cfset session.clientnum = varclientnum>
