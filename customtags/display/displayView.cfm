<cfparam name="attributes.display_id" type="any">
<cfparam name="attributes.language_id" type="string" default="">
<cfparam name="attributes.edit" type="boolean" default="false">
<cfparam name="attributes.var" type="string" default="displayText">

<cfif attributes.display_id eq ''>
	<cfset attributes.display_id = 0>
</cfif>
<cfif attributes.language_id eq ''>
	<cfquery name="gettext" datasource="#application.dbSrc#">
		select dl.display_text
		from display_language dl, language l
		where dl.display_id=#attributes.display_id#
			and dl.language_id=l.language_id
			and l.default_flag=1
			and l.active=1
	</cfquery>
<cfelse>
	<cfquery name="gettext" datasource="#application.dbSrc#">
		select display_text
		from display_language
		where display_id=#attributes.display_id#
			and language_id='#attributes.language_id#'
	</cfquery>
</cfif>
<cfif gettext.RecordCount eq 0>
	<cfif attributes.edit>
		<cfset "caller.#attributes.var#" = ''>
	<cfelse>
		<cfset "caller.#attributes.var#" = '<i>no display text found</i>'>
	</cfif>
<cfelse>
	<cfset "caller.#attributes.var#" = gettext.display_text>
</cfif>