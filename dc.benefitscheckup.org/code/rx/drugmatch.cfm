<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="drugnew.cfm">
<cfelse>

<cfinclude template="drugqueries.cfm">

<cf_drugmenu title="Adding Brand-Name Drug"><cfoutput>

<table border="0" cellpadding="3" cellspacing="3">

<tr bgcolor="#application.color.drug.dark#">
	<td colspan="2"><font size="+1"><b>#name#</b></font></td>
</tr>

<cfif name neq "">
<tr bgcolor="#application.color.drug.med#">
	<td colspan="2"><b>Existing brand-name drugs containing exact string</b></td>
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
		<td colspan="2"><b>Existing brand-name drugs containing similar strings</b></td>
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

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
<form action="drugadd.cfm" method="post">
	<tr><td><font size="+1"><b>Add brand-name drug as is</b></font></td></tr>
	<tr><td><input type="hidden" name="name" value="#name#">
	<input type="submit" value="Submit"></td></tr>
</form>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
<form action="drugmatch.cfm" method="post">
	<tr><td><font size="+1"><b>Edit brand-name drug and resubmit</b></font></td></tr>
	<tr><td><input type="text" name="name" size="60" value="#name#"></td></tr>
	<tr><td><input type="submit" value="Resubmit"></td></tr>
</form>
</table>

</cfoutput><cfmodule template="../footer.cfm">
</cfif>
