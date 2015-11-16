<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
	<cfinclude template="programsearchqueries.cfm">
</cfif>

<cfset title="Program Search">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<form action="programsearch.cfm" method="post">
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.program.med#">
	<tr>
		<td><font size="+1"><b>Search term</b></font></td>
		<td><input type="text" name="name" size="60" value="#name#"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit" value="Search"></td>
	</tr>
</table>
</form>

<table border="0" cellpadding="3" cellspacing="3">
<cfif name neq "">
<tr bgcolor="#application.color.program.med#">
	<td colspan="2"><b>Programs containing exact string</b></td>
</tr>
	<cfif getname.recordcount eq 0>
<tr bgcolor="#application.color.program.light#">
		<td colspan="2"><i>none</i></td>
</tr>
	<cfelse>
		<cfloop query="getname">
<tr bgcolor="#application.color.program.light#">
			<td>#prg_nm#</td>
			<td><a href="programview.cfm?program_id=#recid#">view&nbsp;details</a></td>
			<cfif rx_only neq 0>
			<td><i>Rx</i></td>
			</cfif>
</tr>
		</cfloop>
	</cfif>
	<cfif getsound.recordcount gt 0>
<tr bgcolor="#application.color.program.med#">
		<td colspan="2"><b>Programs containing similar strings</b></td>
</tr>
		<cfloop query="getsound">
<tr bgcolor="#application.color.program.light#">
			<td>#prg_nm#</td>
			<td><a href="programview.cfm?program_id=#prg_id#">view&nbsp;details</a></td>
			<cfif rx_only neq '0'>
			<td><i>Rx</i></td>
			</cfif>
</tr>
		</cfloop>
	</cfif>
</cfif>
</table><br>

</cfoutput>
</cf_buildPage>
