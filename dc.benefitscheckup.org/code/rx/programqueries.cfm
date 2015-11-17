<cfquery name="getprogram" datasource="#application.dbSrc#">
	select dl.display_text prg_nm
	from program p, display_language dl
	where p.program_id=#program_id#
		and p.name_display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>
<cfset pname=getprogram.prg_nm>

<cfquery name="getdrug" datasource="#application.dbSrc#">
	select a.answerfieldtype_id, at.name, dl.display_text
	from answerfield a, answerfieldtype at, display_language dl
	where a.answerfield_id=#answerfield_id#
		and a.answerfieldtype_id=at.answerfieldtype_id
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>
<cfset dtid=getdrug.answerfieldtype_id>
<cfset dtype=getdrug.name>
<cfset dname=getdrug.display_text>