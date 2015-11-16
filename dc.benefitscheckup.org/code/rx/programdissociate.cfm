<cfparam name="program_id" type="numeric">
<cfparam name="answerfield_id" type="numeric">
<cfparam name="src" type="string">

<cfinclude template="programqueries.cfm">

<cf_drugmenu title="Dissociate #dtype# from Pharmaceutical Program">
<cfif dtid eq 13>
	<cfset section = 'drug'>
<cfelseif dtid eq 14>
	<cfset section = 'generic'>
<cfelse>
	<cfset section = 'drugcompany'>
</cfif>
<cfoutput>

<table border="0" cellpadding="3" cellspacing="3">
	<tr bgcolor="#application.color.program.dark#">
		<td colspan="2"><font size="+1"><b>Are you sure you want to dissociate these two items?</b></font></td>
	</tr>
	<tr>
		<td bgcolor="#application.color.program.med#" align="right"><font size="+1"><b>Program</b></font></td>
		<td bgcolor="#application.color.program.light#"><font size="+1">#pname#</font></td>
	</tr>
	<tr>
		<td bgcolor="#Evaluate("application.color.#section#.med")#" align="right"><font size="+1"><b>#dtype#</b></font></td>
		<td bgcolor="#Evaluate("application.color.#section#.light")#"><font size="+1">#dname#</font></td>
	</tr>
	<tr bgcolor="#application.color.program.med#">
	<form action="dissociate.cfm?program_id=#program_id#&answerfield_id=#answerfield_id#&src=#src#" method="post">
		<td align="right"><input type="submit" value="Yes"></td>
	</form>
	<cfif src eq 'p'>
	<form action="programview.cfm?program_id=#program_id#" method="post">
	<cfelseif src eq 'd'>
	<form action="drugview.cfm?brand_id=#answerfield_id#" method="post">
	<cfelseif src eq 'g'>
	<form action="genericview.cfm?generic_id=#answerfield_id#" method="post">
	<cfelse>
	<form action="companyview.cfm?company_id=#answerfield_id#" method="post">
	</cfif>
		<td><input type="submit" value="No"></td>
	</form>
	</tr>
</table>

</cfoutput></BODY>
</HTML>