<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="genericnew.cfm">
<cfelse>

<cfinclude template="genericqueries.cfm">

<cf_drugmenu title="Adding Generic Drug"><cfoutput>

<table border="0" cellpadding="3" cellspacing="3">

<tr bgcolor="#application.color.generic.dark#">
	<td colspan="2"><font size="+1"><b>#name#</b></font></td>
</tr>

<cfif name neq "">
<tr bgcolor="#application.color.generic.med#">
	<td colspan="2"><b>Existing generic drugs containing exact string</b></td>
</tr>
	<cfif getname.recordcount eq 0>
<tr bgcolor="#application.color.generic.light#">
		<td colspan="2"><i>none</i></td>
</tr>
	<cfelse>
		<cfloop query="getname">
<tr bgcolor="#application.color.generic.light#">
			<td>#mname#</td>
			<td><a href="genericview.cfm?generic_id=#answerfield_id#">view&nbsp;details</a></td>
</tr>
		</cfloop>
	</cfif>
	<cfif getsound.recordcount gt 0>
<tr bgcolor="#application.color.generic.med#">
		<td colspan="2"><b>Existing generic drugs containing similar strings</b></td>
</tr>
		<cfloop query="getsound">
<tr bgcolor="#application.color.generic.light#">
			<td>#mname#</td>
			<td><a href="genericview.cfm?generic_id=#answerfield_id#">view&nbsp;details</a></td>
</tr>
		</cfloop>
	</cfif>
</cfif>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.generic.med#">
<form action="genericadd.cfm" method="post">
	<tr><td><font size="+1"><b>Add generic drug as is</b></font></td></tr>
	<tr><td><input type="hidden" name="name" value="#name#">
	<input type="submit" value="Submit"></td></tr>
</form>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.generic.med#">
<form action="genericmatch.cfm" method="post">
	<tr><td><font size="+1"><b>Edit generic drug and resubmit</b></font></td></tr>
	<tr><td><input type="text" name="name" size="60" value="#name#"></td></tr>
	<tr><td><input type="submit" value="Resubmit"></td></tr>
</form>
</table>

</cfoutput><cfmodule template="../footer.cfm">
</cfif>
