<cfparam name="generic_id" type="numeric">

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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">

<cf_drugmenu title="Associate Brand-Name Drug with Generic Drug">
<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.generic.dark#" colspan="2"><font size="+1"><b>Generic&nbsp;drug</b></font></td>
	<td bgcolor="#application.color.generic.med#" colspan="2"><font size="+1">#name#</font></td>
</tr>
</table><br>

<cfquery name="druglist" datasource="#application.dbSrc#">
	select a.answerfield_id, substring(dl.display_text, 1, 255) as chop
	from answerfield a, display_language dl
	where a.answerfieldtype_id=13
		and a.answerfield_id not in (
				select left_answerfield_id
				from answerfield_relationship
				where right_answerfield_id=#generic_id#
					and relationship_id=1
			)
		and a.display_id=dl.display_id
		and dl.language_id='EN'
	order by chop
</cfquery>

<form action="associate.cfm" method="post">
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
	<tr>
	<td><b>Choose a brand-name drug from this list...</b></td>
	</tr>
	<tr>
	<td><select name="brand_id">
	<cfloop query="druglist">
		<option value="#answerfield_id#">#chop#
	</cfloop>
	</select></td>
	</tr>
	<tr>
	<td><input type="hidden" name="generic_id" value="#generic_id#">
	<input type="hidden" name="src" value="g">
	<input type="submit" value="Associate this"></td>
	</tr>
</table>
</form>

<form action="genericassociatematch.cfm" method="post">
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.drug.med#">
	<tr>
	<td><b>...or enter the name of a new brand-name drug</b></td>
	</tr>
	<tr>
	<td><input type="text" name="dname" size="60" value=""></td>
	</tr>
	<tr>
	<td><input type="hidden" name="generic_id" value="#generic_id#">
	<input type="submit" value="Add and associate this"></td>
	</tr>
</table>
</form>

<form action="genericview.cfm?generic_id=#generic_id#" method="post">
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.generic.dark#">
	<tr><td><input type="submit" value="Cancel"></td></tr>
</table>
</form>

</cfoutput></BODY>
</HTML>
