<cfquery name="rx" datasource="#application.dbSrc#">
	select answerfield_id as company_id, a.answerfield, substring(dl.display_text, 1, 255) as name
	from answerfield a left outer join display_language dl
			on a.display_id=dl.display_id
				and dl.language_id='EN'
	where a.answerfieldtype_id=15
	order by name
</cfquery>

<cfset title="Complete Listing of Rx Companies">
<cf_buildPage title="#title#" section="rx">
<cfoutput>

<h2>#title#</h2>

<table cellpadding="3" cellspacing="3" border="0">
<tr bgcolor="#application.color.drugcompany.med#">
	<td><b>ID</b></td>
	<td><b>Answerfield</b></td>
	<td><b>Name</b></td>
	<td colspan="2" align="center"><b>Actions</b></td>
</tr>
<cfloop query="rx">
<tr bgcolor="#application.color.drugcompany.light#">
	<td valign="top">#company_id#</td>
	<td valign="top">#answerfield#</td>
	<td valign="top">#name#</td>
	<td valign="top"><cf_checkAccessLink level="5" href="companyview.cfm?company_id=#company_id#">view&nbsp;details</cf_checkAccessLink></td>
	<td valign="top"><cf_checkAccessLink level="3" href="companyedit.cfm?company_id=#company_id#">edit&nbsp;name</cf_checkAccessLink></td>
</tr>
</cfloop>
</table>

</cfoutput>
</cf_buildPage>