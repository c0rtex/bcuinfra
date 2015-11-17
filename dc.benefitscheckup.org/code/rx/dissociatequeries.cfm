<cfquery name="getgeneric" datasource="#application.dbSrc#">
	select dl.display_text
	from answerfield a, display_language dl
	where a.answerfield_id=#generic_id#
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>
<cfset gname=getgeneric.display_text>
<cfquery name="getdrug" datasource="#application.dbSrc#">
	select dl.display_text
	from answerfield a, display_language dl
	where a.answerfield_id=#brand_id#
		and a.display_id=dl.display_id
		and dl.language_id='EN'
</cfquery>
<cfset dname=getdrug.display_text>
