<cfset name="">
<cfif isdefined("form.name")>
	<cfset name=form.name>
</cfif>
<cfif trim(name) eq ''>
	<cflocation url="companynew.cfm">
<cfelse>

<cfinclude template="companyqueries.cfm">

<cfset title="Adding Rx Company">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">

<tr bgcolor="#application.color.drugcompany.dark#">
	<td colspan="2"><font size="+1"><b>#name#</b></font></td>
</tr>

<cfif name neq "">
<tr bgcolor="#application.color.drugcompany.med#">
	<td colspan="2"><b>Existing Rx companies containing exact string</b></td>
</tr>
	<cfif getname.recordcount eq 0>
<tr bgcolor="#application.color.drugcompany.light#">
		<td colspan="2"><i>none</i></td>
</tr>
	<cfelse>
		<cfloop query="getname">
<tr bgcolor="#application.color.drugcompany.light#">
			<td>#mname#</td>
			<td><a href="companyview.cfm?company_id=#answerfield_id#">view&nbsp;details</a></td>
</tr>
		</cfloop>
	</cfif>
	<cfif getsound.recordcount gt 0>
<tr bgcolor="#application.color.drugcompany.med#">
		<td colspan="2"><b>Existing Rx companies containing similar strings</b></td>
</tr>
		<cfloop query="getsound">
<tr bgcolor="#application.color.drugcompany.light#">
			<td>#mname#</td>
			<td><a href="drugcompanyview.cfm?company_id=#answerfield_id#">view&nbsp;details</a></td>
</tr>
		</cfloop>
	</cfif>
</cfif>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drugcompany.med#">
<form action="companyadd.cfm" method="post">
	<tr><td><font size="+1"><b>Add Rx company as is</b></font></td></tr>
	<tr><td><input type="hidden" name="name" value="#name#">
	<input type="submit" value="Submit"></td></tr>
</form>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drugcompany.med#">
<form action="companymatch.cfm" method="post">
	<tr><td><font size="+1"><b>Edit Rx company and resubmit</b></font></td></tr>
	<tr><td><input type="text" name="name" size="60" value="#name#"></td></tr>
	<tr><td><input type="submit" value="Resubmit"></td></tr>
</form>
</table>

</cfoutput>
</cf_buildPage>
</cfif>
