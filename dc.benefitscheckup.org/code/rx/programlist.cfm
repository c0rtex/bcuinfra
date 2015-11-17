<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<cfparam name = "session.user_level" type="string" default="">

<cfset title="Complete Listing of Programs">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<cfquery name="rx" datasource="#application.dbSrc#">
	select RecID, prg_id, prg_nm, inactive_flag
	from tbl_prg_all
	order by prg_nm, prg_id
</cfquery>

<table border="0" cellpadding="3" cellspacing="3">
	<tr bgcolor="#application.color.program.med#">
		<td width="150"><b>ID</b></td>
		<td><b>Name</b></td>
		<td><b>Actions</b></td>
		<td><b>Inactive</b></td>
	</tr>
<cfloop query="rx">
	<tr bgcolor="#application.color.program.light#">
		<td valign="top">#prg_id#</td>
		<td valign="top"><cfif inactive_flag eq 1><strike><i></cfif>#prg_nm#<cfif inactive_flag eq 1></i></strike></cfif></td>
		<td valign="top"><cf_checkAccessLink level="5" href="programview.cfm?program_id=#recid#">view&nbsp;details</cf_checkAccessLink></td>
		<td align="center" valign="top"><cfif inactive_flag eq 1>X<cfelse>&nbsp;</cfif></td>
	</tr>
</cfloop>
</table>

</cfoutput>
</cf_buildPage>