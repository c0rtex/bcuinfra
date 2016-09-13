<cfparam name="brand_id" type="numeric">
<cfparam name="generic_id" type="numeric">

<cfinclude template="dissociatequeries.cfm">

<cf_drugmenu title="Dissociate Generic Drug from Brand-Name Drug">
<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
	<tr bgcolor="#application.color.generic.dark#">
		<td colspan="2"><font size="+1"><b>Are you sure you want to dissociate these two drugs?</b></font></td>
	</tr>
	<tr>
		<td bgcolor="#application.color.generic.med#" align="right"><font size="+1"><b>Generic</b></font></td>
		<td bgcolor="#application.color.generic.light#"><font size="+1">#gname#</font></td>
	</tr>
	<tr>
		<td bgcolor="#application.color.drug.med#" align="right"><font size="+1"><b>Brand-Name</b></font></td>
		<td bgcolor="#application.color.drug.light#"><font size="+1">#dname#</font></td>
	</tr>
	<tr bgcolor="#application.color.generic.med#">
	<form action="dissociate.cfm?generic_id=#generic_id#&brand_id=#brand_id#&src=g" method="post">
		<td align="right"><input type="submit" value="Yes"></td>
	</form>
	<form action="genericview.cfm?generic_id=#generic_id#" method="post">
		<td><input type="submit" value="No"></td>
	</form>
	</tr>
</table>

</cfoutput></BODY>
</HTML>
