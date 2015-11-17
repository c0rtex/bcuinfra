<cfquery name="get" datasource="#application.dbSrc#">
	select a.answerfield, dl.display_text as company_name
	from answerfield a left outer join display_language dl
		on a.display_id=dl.display_id
			and dl.language_id='EN'
	where a.answerfield_id=#company_id#
		and a.answerfieldtype_id=15
</cfquery>

<cfif get.recordcount eq 0>
	<cfset ans = ''>
	<cfset name = ''>
<cfelse>
	<cfset ans = get.answerfield>
	<cfset name = get.company_name>
</cfif>

<cfset title="Rx Company Details">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.drugcompany.dark#" colspan="2"><font size="+1"><b>#name#</b></font></td>
	<td bgcolor="#application.color.drugcompany.dark#" colspan="2"><font size="+1"><b>#ans#</b></font></td>
	<td bgcolor="#application.color.drugcompany.med#"><cf_checkAccessLink level="3" href="companyedit.cfm?company_id=#company_id#">edit</cf_checkAccessLink></td>
</tr>
</table><br>



<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.program.dark#">
	<td colspan="5"><font size="+1"><b>Associated programs</b></font></td>
</tr>
<cfquery name="rx" datasource="#application.dbSrc#">
	SELECT pa.program_id, p.program_code, substring(dl.display_text, 1, 255) program_name
	FROM view_program_answerfield pa, program p, display_language dl
	WHERE pa.answerfield_id = #company_id#
	    AND pa.program_id=p.program_id
		AND p.name_display_id=dl.display_id
		AND dl.language_id='EN'
	ORDER BY program_name
</cfquery>
<cfif rx.RecordCount gt 0>
	<tr bgcolor="#application.color.program.med#">
		<td><b>ID</b></td>
		<td><b>Code</b></td>
		<td><b>Name</b></td>
		<td align="center" colspan="2"><b>Actions</b></td>
	</tr>
<cfloop query="rx">
	<tr bgcolor="#application.color.program.light#">
		<td>#program_id#</td>
		<td>#program_code#</td>
		<td>#program_name#</td>
		<td><cf_checkAccessLink level="5" href="programview.cfm?program_id=#program_id#">view&nbsp;details</a></cf_checkAccessLink>
		<td><cf_checkAccessLink level="3" href="programdissociate.cfm?answerfield_id=#company_id#&program_id=#program_id#&src=c">delete&nbsp;association</cf_checkAccessLink></td>
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.program.light#">
		<td colspan="5"><i>none</i></td>
	</tr>
</cfif>
	<tr bgcolor="#application.color.program.med#">
		<td colspan="5"><cf_checkAccessLink level="3" href="programassociate.cfm?company_id=#company_id#&src=c">Associate a program with #name#</cf_checkAccessLink></td>
	</tr>
</table>

</cfoutput>
</cf_buildPage>