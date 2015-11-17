<cfquery name="get" datasource="#application.dbSrc#">
	select a.answerfield, dl.display_text as generic_name
	from answerfield a left outer join display_language dl
		on a.display_id=dl.display_id
			and dl.language_id='EN'
	where a.answerfield_id=#generic_id#
		and a.answerfieldtype_id=14
</cfquery>

<cfif get.recordcount eq 0>
	<cfset ans = ''>
	<cfset name = ''>
<cfelse>
	<cfset ans = get.answerfield>
	<cfset name = get.generic_name>
</cfif>

<cfset title="Generic Drug Details">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
	<td bgcolor="#application.color.generic.dark#" colspan="2"><font size="+1"><b>#name#</b></font></td>
	<td bgcolor="#application.color.generic.dark#" colspan="2"><font size="+1"><b>#ans#</b></font></td>
	<td bgcolor="#application.color.generic.med#"><cf_checkAccessLink level="3" href="genericedit.cfm?generic_id=#generic_id#">edit</cf_checkAccessLink></td>
</tr>
</table><br>


<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.drug.dark#">
	<td colspan="5"><font size="+1"><b>Associated brand-name drugs</b></font></td>
</tr>
<cfquery name="brand" datasource="#application.dbSrc#">
	SELECT a.answerfield_id as brand_id, a.answerfield, dl.display_text as brand_name
	FROM answerfield_relationship ar inner join answerfield a
			on ar.left_answerfield_id=a.answerfield_id
		left outer join display_language dl
			on a.display_id=dl.display_id
				and dl.language_id='EN'
	WHERE ar.right_answerfield_id=#generic_id#
		and ar.relationship_id=1
	ORDER BY substring(dl.display_text, 1, 255)
</cfquery>
<cfif brand.RecordCount gt 0>
	<tr bgcolor="#application.color.drug.med#">
		<td><b>ID</b></td>
		<td><b>Answerfield</b></td>
		<td><b>Name</b></td>
		<td align="center" colspan="2"><b>Actions</b></td>
	</tr>
<cfloop query="brand">
	<tr bgcolor="#application.color.drug.light#">
		<td>#brand_id#</td>
		<td>#answerfield#</td>
		<td>#brand_name#</td>
		<td><cf_checkAccessLink level="5" href="drugview.cfm?brand_id=#brand_id#">view&nbsp;details</cf_checkAccessLink></td>
		<td><cf_checkAccessLink level="3" href="genericdissociate.cfm?generic_id=#generic_id#&brand_id=#brand_id#">delete&nbsp;association</cf_checkAccessLink></td>
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.drug.light#">
		<td colspan="5"><i>none</i></td>
	</tr>
</cfif>
	<tr bgcolor="#application.color.drug.med#">
		<td colspan="5"><cf_checkAccessLink level="3" href="genericassociate.cfm?generic_id=#generic_id#">Associate a brand-name drug with #name#</cf_checkAccessLink></td>
	</tr>
</table><br>


<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.program.dark#">
	<td colspan="5"><font size="+1"><b>Associated programs</b></font></td>
</tr>
<cfquery name="rx" datasource="#application.dbSrc#">
	SELECT pa.program_id, program_code, substring(dl.display_text, 1, 255) program_name
	FROM view_program_answerfield pa, program p, display_language dl
	WHERE pa.answerfield_id = #generic_id#
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
		<td><cf_checkAccessLink level="5" href="programview.cfm?program_id=#program_id#">view&nbsp;details</cf_checkAccessLink></td>
		<td><cf_checkAccessLink level="3" href="programdissociate.cfm?answerfield_id=#generic_id#&program_id=#program_id#&src=g">delete&nbsp;association</cf_checkAccessLink></td>
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.program.light#">
		<td colspan="5"><i>none</i></td>
	</tr>
</cfif>
	<tr bgcolor="#application.color.program.med#">
		<td colspan="5"><cf_checkAccessLink level="3" href="programassociate.cfm?generic_id=#generic_id#&src=g">Associate a program with #name#</cf_checkAccessLink></td>
	</tr>
</table>

</cfoutput>
</cf_buildPage>