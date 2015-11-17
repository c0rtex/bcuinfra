<cfparam name="attributes.display_id" type="numeric">
<cfparam name="attributes.text" type="string">
<cfparam name="attributes.minoredit" type="boolean" default="false">

<cfquery name="insertdisplay" datasource="#application.dbSrc#">
	update display_language
	set display_text='#attributes.text#',
		update_flag=0
	where display_id=#attributes.display_id#
		and language_id='EN'
</cfquery>
<cfif not attributes.minoredit>
	<cfquery name="getotherlanguages" datasource="#application.dbSrc#">
		select language_id
		from display_language
		where display_id=#attributes.display_id#
			and language_id <> 'EN'
		order by language_id
	</cfquery>
	<cfloop query="getotherlanguages">
		<cfquery name="updatedisplay" datasource="#application.dbSrc#">
			update display_language
			set update_flag=1
			where display_id=#attributes.display_id#
				and language_id='#language_id#'
		</cfquery>
	</cfloop>
</cfif>