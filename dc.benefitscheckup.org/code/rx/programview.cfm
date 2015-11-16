<cfparam name="session.user_level" type="string" default="">
<cfparam name="program_id" type="numeric">

<cfquery name="rx" datasource="#application.dbSrc#">
	select dl.display_text prg_nm
	from program p, display_language dl
	where p.program_id=#program_id#
		and p.name_display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>

<cf_buildPage title="detailsProgram" section="rx">
<cfoutput>

<h2>Pharmaceutical Program View</h2>

<table border="0" cellpadding="3" cellspacing="3">
<tr>
  
	<td bgcolor="#application.color.program.dark#" colspan="2"><font size="+1"><b>#rx.prg_nm#</b></font></td>
	<td bgcolor="#application.color.program.med#"><cf_checkAccessLink level="5" href="../program/programview.cfm?id=#program_id#">view</cf_checkAccessLink> | <cf_checkAccessLink level="3" href="../program/programview.cfm?id=#program_id#&action=edit">edit</cf_checkAccessLink></td>
</tr>
</table><br>


<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.drug.dark#">
	<td colspan="5"><font size="+1"><b>Associated brand-name drugs</b></font></td>
</tr>
<cfquery name="drugs" datasource="#application.dbSrc#">
	select a.answerfield_id, a.answerfield, dl.display_text
	from view_program_answerfield pa, answerfield a, display_language dl
	where pa.program_id=#program_id#
		and pa.answerfield_id=a.answerfield_id
		and a.answerfieldtype_id=13
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>
<cfif drugs.RecordCount gt 0>
	<tr bgcolor="#application.color.drug.med#">
		<td><b>ID</b></td>
		<td><b>Answerfield</b></td>
		<td><b>Name</b></td>
		<td align="center" colspan="2"><b>Actions</b></td>
	</tr>
<cfloop query="drugs">
	<tr bgcolor="#application.color.drug.light#">
		<td>#answerfield_id#</td>
		<td>#answerfield#</td>
		<td>#display_text#</td>
		<td><cf_checkAccessLink level="5" href="drugview.cfm?brand_id=#answerfield_id#">view&nbsp;details</cf_checkAccessLink></td>
		<td><cf_checkAccessLink level="3" href="programdissociate.cfm?program_id=#program_id#&answerfield_id=#answerfield_id#&src=p">delete&nbsp;association</cf_checkAccessLink></td>
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.drug.light#">
		<td colspan="5"><i>none</i></td>
	</tr>
</cfif>
	<tr bgcolor="#application.color.drug.med#">
		<td colspan="5"><cf_checkAccessLink level="3" href="programassociate.cfm?program_id=#program_id#&src=d">Associate a brand-name drug with #rx.prg_nm#</cf_checkAccessLink></td>
	</tr>
</table><br>

<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.generic.dark#">
	<td colspan="5"><font size="+1"><b>Associated generic drugs</b></font></td>
</tr>
<cfquery name="generics" datasource="#application.dbSrc#">
	select a.answerfield_id, a.answerfield, dl.display_text
	from view_program_answerfield pa, answerfield a, display_language dl
	where pa.program_id=#program_id#
		and pa.answerfield_id=a.answerfield_id
		and a.answerfieldtype_id=14
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>
<cfif generics.RecordCount gt 0>
	<tr bgcolor="#application.color.generic.med#">
		<td><b>ID</b></td>
		<td><b>Answerfield</b></td>
		<td><b>Name</b></td>
		<td align="center" colspan="2"><b>Actions</b></td>
	</tr>
<cfloop query="generics">
	<tr bgcolor="#application.color.generic.light#">
		<td>#answerfield_id#</td>
		<td>#answerfield#</td>
		<td>#display_text#</td>
		<td><cf_checkAccessLink level="5" href="genericview.cfm?generic_id=#answerfield_id#">view&nbsp;details</cf_checkAccessLink></td>
		<td><cf_checkAccessLink level="3" href="programdissociate.cfm?program_id=#program_id#&answerfield_id=#answerfield_id#&src=p">delete&nbsp;association</cf_checkAccessLink></td>
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.generic.light#">
		<td colspan="5"><i>none</i></td>
	</tr>
</cfif>
	<tr bgcolor="#application.color.generic.med#">
		<td colspan="5"><cf_checkAccessLink level="3" href="programassociate.cfm?program_id=#program_id#&src=g">Associate a generic drug with #rx.prg_nm#</cf_checkAccessLink></td>
	</tr>
</table><br>

<cfquery name="companies" datasource="#application.dbSrc#">
	select a.answerfield_id, a.answerfield, dl.display_text
	from view_program_answerfield pa, answerfield a, display_language dl
	where pa.program_id=#program_id#
		and pa.answerfield_id=a.answerfield_id
		and a.answerfieldtype_id=15
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>

<table border="0" cellpadding="3" cellspacing="3">
<tr bgcolor="#application.color.drugcompany.dark#">
	<td colspan="5"><font size="+1"><b>Associated drug companies</b></font></td>
</tr>
<cfif companies.RecordCount gt 0>
	<tr bgcolor="#application.color.drugcompany.med#">
		<td><b>ID</b></td>
		<td><b>Answerfield</b></td>
		<td><b>Name</b></td>
		<td align="center" colspan="2"><b>Actions</b></td>
	</tr>
<cfloop query="companies">
	<tr bgcolor="#application.color.drugcompany.light#">
		<td>#answerfield_id#</td>
		<td>#answerfield#</td>
		<td>#display_text#</td>
		<td><cf_checkAccessLink level="5" href="companyview.cfm?company_id=#answerfield_id#">view&nbsp;details</cf_checkAccessLink></td>
		<td><cf_checkAccessLink level="3" href="programdissociate.cfm?program_id=#program_id#&answerfield_id=#answerfield_id#&src=p">delete&nbsp;association</cf_checkAccessLink></td>
	
	</tr>
</cfloop>
<cfelse>
	<tr bgcolor="#application.color.drugcompany.light#">
		<td colspan="5"><i>none</i></td>
	</tr>
</cfif>
	<tr bgcolor="#application.color.drugcompany.med#">
		<td colspan="5"><cf_checkAccessLink level="3" href="programassociate.cfm?program_id=#program_id#&src=c">Associate a pharmaceutical company with #rx.prg_nm#</cf_checkAccessLink></td>
	</tr>
</table><br>

<cf_buildList title="Eligibility Rules" table="rule" code="rule" key="#program_id#" crosstable="program_rule" crosscolumn="program_id" crossvalue="#program_id#" crossorder="sort" crossadd="false" crossdelete="false" linksection="rule">
	<cf_buildListProperty column="code" visible="false">
	<cf_buildListProperty column="description" visible="false">
	<cf_buildListProperty column="rx_program_id" display="notnull">
	<cf_buildListProperty column="legacy_pri_sec" visible="false">
</cf_buildList><br />

</cfoutput>
</cf_buildPage>