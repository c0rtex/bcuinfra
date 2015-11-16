<cfif not isdefined("RecID")> <cflocation url="users.cfm"></cfif>
<CFIF isdefined("gotoedit")>
	<cflocation url="edit_user.cfm?user=#user#&level=#level#&edituser=#edituser#">

<cfelseif isdefined("edit")>
	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="update">
		UPDATE tbl_users
		SET user_name = '#user_name#', user_level = '#user_level#', password = '#password#'
		WHERE RecID = #RecID#
	</CFQUERY>
<cfelseif isdefined("add")>
<CFPARAM NAME="Session.added_dt" DEFAULT="now()">
<CFPARAM NAME="Session.mod_dt" DEFAULT="now()">
<CFPARAM NAME="Session.user" DEFAULT="">
<cfoutput>#session.added_dt#</cfoutput>
	<cfinsert DATASOURCE="#application.dbSrc#" tableNAME="tbl_users" FORMfields="user_name,user_level,password,added_by,mod_by">

	<CFQUERY DATASOURCE="#application.dbSrc#" NAME="qryID">
		SELECT max(RecID) as updateID
		FROM tbl_users
	</CFQUERY>

	<CFQUERY DATASOURCE="#application.dbSrc#">
		UPDATE tbl_users
		SET added_dt=#session.added_dt#,mod_dt=#session.mod_dt#
		WHERE RecID=#qryID.updateID#
	</CFQUERY>
</CFIF>
<CFIF isdefined("form.Delete")>
<CFQUERY DATASOURCE="#application.dbSrc#" name="deleto">
		delete from tbl_users
		WHERE RecID=#RecID#
	</CFQUERY>

</cfif>
<CFLOCATION URL="users.cfm">
<cfmodule template="../footer.cfm">