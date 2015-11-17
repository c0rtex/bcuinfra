<cfquery name="getlanguage" datasource="#application.dbSrc#">
	select substring(dl.display_text, 1, 255) as language_name
	from language l, display_language dl, language ll
	where l.language_id='#language_id#'
		and l.display_id=dl.display_id
		and dl.language_id=ll.language_id
		and ll.default_flag=1
</cfquery>
<cfset language_name=getlanguage.language_name>