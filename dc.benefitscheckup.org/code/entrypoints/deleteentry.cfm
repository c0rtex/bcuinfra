<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<HTML>
<HEAD>
	<TITLE>Untitled</TITLE>
</HEAD>

<BODY>
<CFIF ISDEFINED("st")>
	<CFSET StSrch = "&st=" & st>
<CFELSE>
	<CFSET StSrch = "">
</CFIF>

<!--- Delete Entry point --->
<CFQUERY NAME="QD1" DATASOURCE="#application.dbSrc#">
	DELETE FROM tbl_entry
	WHERE org_id = #OrgId#
</CFQUERY>

	<CFIF isdefined("group_id")>
		<CENTER><BR><BR><H2>Entry Succesfully Deleted</H2><BR>
		<CFOUTPUT><a href="entry_group.cfm?datasrc=#datasrc#&user=#user#&group_id=#group_id##StSrch#">Continue</a>
		</CFOUTPUT>
		</CENTER>
	<cfelse>
		<script language="javascript">{history.go(-2);}</script>
	</CFIF>
</BODY>
</HTML>
<cfmodule template="../footer.cfm">