<cfparam name="generic_id" type="numeric">
<cfparam name="dname" type="string">

<cfquery name="get" datasource="#application.dbSrc#">
	select dl.display_text
	from answerfield a, display_language dl
	where a.answerfield_id=#generic_id#
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>

<cfif get.recordcount eq 0>
	<cfset name="">
<cfelse>
	<cfset name=get.display_text>
</cfif>

<cfif trim(dname) eq ''>
	<cflocation url="genericassociate.cfm?generic_id=#generic_id#">
<cfelse>

<cfset tname=name>
<cfset name=dname>
<cfinclude template="drugqueries.cfm">
<cfset name=tname>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<cf_drugmenu title="Associating New Brand-Name Drug with Generic Drug">
<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.generic.dark#" colspan="2" valign="top"><font size="+1"><b>Generic&nbsp;drug</b></font></td>
	<td bgcolor="#application.color.generic.med#" colspan="2" valign="top"><font size="+1">#name#</font></td>
</tr>
<tr>
	<td bgcolor="#application.color.drug.dark#" colspan="2" valign="top"><font size="+1"><b>Proposed&nbsp;brand-name&nbsp;drug</b></font></td>
	<td bgcolor="#application.color.drug.med#" colspan="2" valign="top"><font size="+1">#dname#</font></td>
</tr>
</table><br>

<table border="0" cellpadding="3" cellspacing="3">
<cfif dname neq "">
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
			<td><a href="associate.cfm?generic_id=#generic_id#&brand_id=#answerfield_id#&src=g">associate&nbsp;this&nbsp;instead</a></td>
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
			<td><a href="associate.cfm?generic_id=#generic_id#&brand_id=#answerfield_id#&src=g">associate&nbsp;this&nbsp;instead</a></td>
</tr>
		</cfloop>
	</cfif>
</cfif>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
<form action="genericassociateadd.cfm" method="post">
	<tr><td><font size="+1"><b>Add and associate brand-name drug as is</b></font></td></tr>
	<tr><td><input type="hidden" name="dname" value="#dname#">
	<input type="hidden" name="generic_id" value="#generic_id#">
	<input type="submit" value="Submit"></td></tr>
</form>
</table><br>

<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
<form action="genericassociatematch.cfm" method="post">
	<tr><td><font size="+1"><b>Edit brand-name drug and resubmit</b></font></td></tr>
	<tr><td><input type="text" name="dname" size="60" value="#dname#"></td></tr>
	<input type="hidden" name="generic_id" value="#generic_id#">
	<tr><td><input type="submit" value="Resubmit"></td></tr>
</form>
</table>

</cfoutput></BODY>
</HTML>
</cfif>
