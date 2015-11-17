<cfparam name="brand_id" type="numeric">
<cfparam name="gname" type="string">

<cfquery name="get" datasource="#application.dbSrc#">
	select dl.display_text
	from answerfield a, display_language dl
	where a.answerfield_id=#brand_id#
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>

<cfif get.recordcount eq 0>
	<cfset name="">
<cfelse>
	<cfset name=get.display_text>
</cfif>

<cfif trim(gname) eq ''>
	<cflocation url="drugassociate.cfm?brand_id=#brand_id#">
<cfelse>

<cfset tname=name>
<cfset name=gname>
<cfinclude template="genericqueries.cfm">
<cfset name=tname>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<cf_drugmenu title="Associating New Generic Drug with Brand-Name Drug">
<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.drug.dark#" colspan="2" valign="top"><font size="+1"><b>Brand-name&nbsp;drug</b></font></td>
	<td bgcolor="#application.color.drug.med#" colspan="2" valign="top"><font size="+1">#name#</font></td>
</tr>
<tr>
	<td bgcolor="#application.color.generic.dark#" colspan="2" valign="top"><font size="+1"><b>Proposed&nbsp;generic&nbsp;drug</b></font></td>
	<td bgcolor="#application.color.generic.med#" colspan="2" valign="top"><font size="+1">#gname#</font></td>
</tr>
</table><br>

<table border="0" cellpadding="3" cellspacing="3">
<cfif gname neq "">
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
			<td><a href="associate.cfm?generic_id=#answerfield_id#&brand_id=#brand_id#&src=d">associate&nbsp;this&nbsp;instead</a></td>
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
			<td><a href="associate.cfm?generic_id=#answerfield_id#&brand_id=#brand_id#&src=d">associate&nbsp;this&nbsp;instead</a></td>
</tr>
		</cfloop>
	</cfif>
</cfif>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.generic.med#">
<form action="drugassociateadd.cfm" method="post">
	<tr><td><font size="+1"><b>Add and associate generic drug as is</b></font></td></tr>
	<tr><td><input type="hidden" name="gname" value="#gname#">
	<input type="hidden" name="brand_id" value="#brand_id#">
	<input type="submit" value="Submit"></td></tr>
</form>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.generic.med#">
<form action="drugassociatematch.cfm" method="post">
	<tr><td><font size="+1"><b>Edit generic drug and resubmit</b></font></td></tr>
	<tr><td><input type="text" name="gname" size="60" value="#gname#"></td></tr>
	<input type="hidden" name="brand_id" value="#brand_id#">
	<tr><td><input type="submit" value="Resubmit"></td></tr>
</form>
</table>

</cfoutput></BODY>
</HTML>
</cfif>
