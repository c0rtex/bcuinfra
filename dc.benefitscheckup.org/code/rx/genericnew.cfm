<cfset title="Add Generic Drug">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<form action="genericmatch.cfm" method="post">
<table border="0" cellpadding="5" cellspacing="0" bgcolor="#application.color.generic.med#">
	<tr>
		<td><font size="+1"><b>Name</b></font></td>
		<td><input type="text" name="name" size="60" value=""></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><input type="submit"></td>
	</tr>
</table>
</form>

</cfoutput>
</cf_buildPage>