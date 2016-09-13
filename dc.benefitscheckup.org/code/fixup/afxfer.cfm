<!---
afxfer.cfm
utility template for transferring all program-to-answerfield associations from old table
"tbl_answerfield_prg" to new table "program_answerfield"
--->
<cfquery name="af" datasource="#session.datasrc#">
	select distinct a.answerfield_id, a.answerfieldtype_id, ap.answerfield, p.RecID as program_id, ap.prg_id
	from answerfield a, tbl_answerfield_prg ap, tbl_prg_all p
	where a.answerfield=ap.answerfield
		and ap.st <> 'mn2'
		and ap.prg_id=p.prg_id
	order by ap.answerfield, ap.prg_id
</cfquery>
<cfoutput>
<table border="1">
<tr>
	<td colspan="5">#af.RecordCount#</td>
</tr>
<cfloop query="af">
<tr>
	<td>#answerfield_id#</td>
	<td>#answerfield#</td>
	<td>#program_id#</td>
	<td>#prg_id#</td>
	<cfif answerfieldtype_id eq 13 or answerfieldtype_id eq 14 or answerfieldtype_id eq 15>
		<cfset rule_flag = 0>
	<cfelse>
		<cfset rule_flag = 1>
	</cfif>
	<td>#rule_flag#</td>
	<cfquery name="afins" datasource="#session.datasrc#">
		insert into program_answerfield
			(answerfield_id, program_id, rule_flag)
		values
			(#answerfield_id#, #program_id#, #rule_flag#)
	</cfquery>
</tr>
</cfloop>
</table>

</cfoutput>