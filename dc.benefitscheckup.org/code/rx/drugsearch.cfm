<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
	<cfinclude template="drugqueries.cfm">
</cfif>

<cfset title="Brand-Name Drug Search">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<form action="drugsearch.cfm" method="post">
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
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
<tr bgcolor="#application.color.drug.med#">
	<td colspan="2"><b>Brand-name drugs containing exact string</b></td>
</tr>
	<cfif getname.recordcount eq 0>
<tr bgcolor="#application.color.drug.light#">
		<td colspan="2"><i>none</i></td>
</tr>
	<cfelse>
		<cfloop query="getname">
<tr bgcolor="#application.color.drug.light#">
			<td>#mname#</td>
			<td><a href="drugview.cfm?brand_id=#answerfield_id#">view&nbsp;details</a></td>
</tr>
		</cfloop>
	</cfif>
	<cfif getsound.recordcount gt 0>
<tr bgcolor="#application.color.drug.med#">
		<td colspan="2"><b>Brand-name drugs containing similar strings</b></td>
</tr>
		<cfloop query="getsound">
<tr bgcolor="#application.color.drug.light#">
			<td>#mname#</td>
			<td><a href="drugview.cfm?brand_id=#answerfield_id#">view&nbsp;details</a></td>
</tr>
		</cfloop>
	</cfif>
</cfif>
</table><br>

</cfoutput>
</cf_buildPage>