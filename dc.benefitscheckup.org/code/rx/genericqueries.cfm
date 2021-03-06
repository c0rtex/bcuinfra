<cfquery name="getname" datasource="#application.dbSrc#">
	select a.answerfield_id, substring(dl.display_text, 1, 255) as mname
	from answerfield a, display_language dl
	where a.answerfieldtype_id=14
		and a.display_id=dl.display_id
		and dl.language_id='EN'
		and dl.display_text like '%#name#%'
	order by mname
</cfquery>
<cfquery name="getsound" datasource="#application.dbSrc#">
	select a.answerfield_id, substring(dl.display_text, 1, 255) as mname
	from answerfield a, display_language dl
	where a.answerfieldtype_id=14
		and a.display_id=dl.display_id
		and dl.language_id='EN'
		and dl.display_text not like '%#name#%'
		and difference(substring('#name#', 1, 255), dl.display_text) = 4
	order by mname
</cfquery>