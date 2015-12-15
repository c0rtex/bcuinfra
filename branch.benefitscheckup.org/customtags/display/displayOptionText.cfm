<cfsilent>
<cfparam name="attributes.option_id" type="any" default="">
<cfparam name="attributes.language_id" type="string" default="">
<cfparam name="attributes.var" type="string" default="displayOptionText">

<cfif IsNumeric(attributes.option_id)>
	<cfif attributes.language_id eq ''>
		<cfquery name="gettext" datasource="#application.dbSrc#">
			select dl.display_text
			from `option` o, display_language dl, `language` l
			where o.option_id=#attributes.option_id#
				and o.display_id=dl.display_id
				and dl.language_id=l.language_id
				and l.default_flag=1
				and l.active=1
		</cfquery>
	<cfelse>
		<cfquery name="gettext" datasource="#application.dbSrc#">
			select dl.display_text
			from `option` o, display_language dl
			where o.option_id=#attributes.option_id#
				and o.display_id=dl.display_id
				and dl.language_id='#attributes.language_id#'
		</cfquery>
	</cfif>
	<cfif gettext.RecordCount eq 0>
		<cfset "caller.#attributes.var#" = attributes.option_id>
	<cfelse>
		<cfset "caller.#attributes.var#" = gettext.display_text>
	</cfif>
<cfelse>
	<cfset "caller.#attributes.var#" = attributes.option_id>
</cfif>
</cfsilent>