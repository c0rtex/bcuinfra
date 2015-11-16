<cfif active>
	<!--- get list of display strings without translations in the target language --->
	<cfquery name="getnulldisplay" datasource="#application.dbSrc#">
		select d.display_id, ld.display_text
		from display d inner join display_language ld
				on d.display_id=ld.display_id
					and ld.language_id='en'
			left outer join display_language dl
				on d.display_id=dl.display_id
					and dl.language_id='#language_id#'
		where dl.display_text is null
		order by d.display_id
	</cfquery>
	<cfloop query="getnulldisplay">
		<cfif display_text eq ''>
			<cfset update_flag = 0>
		<cfelse>
			<cfset update_flag = 1>
		</cfif>
		<cfquery name="adddisplaystring" datasource="#application.dbSrc#">
			insert into display_language
				(display_id, language_id, display_text, update_flag)
			values
				(#display_id#, '#language_id#', '', #update_flag#)
		</cfquery>
	</cfloop>
</cfif>
<cfquery name="activatelanguage" datasource="#application.dbSrc#">
	update language
	set active=#active#
	where language_id='#language_id#'
</cfquery>
<cflocation url="languagelist.cfm">