<cfset id=url.id>

<cfset in="">
<cfif isdefined("form.name")>
	<cfset in=form.name>
	<cfif Trim(in) neq ''>
		<cfquery name="put" datasource="#application.dbSrc#">
			update tbl_prg_all
			set prg_nm = '#PreserveSingleQuotes(in)#'
			where prg_id='#id#'
		</cfquery>
	</cfif>
	<cflocation url="programview.cfm?prg_id=#id#">
<cfelse>

<cfquery name="get" datasource="#application.dbSrc#">
	select prg_nm
	from tbl_prg_all
	where prg_id='#id#'
</cfquery>

<cfif get.recordcount eq 0>
	<cfset name="">
<cfelse>
	<cfset name=get.prg_nm>
</cfif>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<cf_drugmenu title="Edit Program">
<cfoutput>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.program.med#">
<form action="programedit.cfm?id=#id#" method="post">
	<tr>
		<td><font size="+1"><b>Name</b></font></td>
		<td colspan="2"><input type="text" name="name" size="50" value="#name#"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="Modify"></td>
</form>
<form action="programview.cfm?prg_id=#id#" method="post">
		<td align="right"><input type="submit" value="Cancel"></td>
</form>
	</tr>
</table>

</cfoutput></BODY>
</HTML>

</cfif>