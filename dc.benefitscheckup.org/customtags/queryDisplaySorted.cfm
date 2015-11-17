<cfsilent>
<cfparam name="attributes.language_id" type="string" default="">
<cfparam name="attributes.grouplist" type="string" default="">
<cfparam name="attributes.var" type="string" default="query">

<cf_cacheLanguagePool action="default" var="defLan">
<cfif attributes.language_id eq ''>
	<cfset attributes.language_id = defLan>
</cfif>

<cfif attributes.grouplist eq ''>
	<cfset whereClause = ''>
<cfelse>
	<cfset whereClause = "d.displaygroup_id in (#attributes.grouplist#) and ">
</cfif>

<cfquery name="caller.#attributes.var#" datasource="#application.dbSrc#">
	<cfif defLan eq attributes.language_id>
		select d.display_code
		from display d, display_language dl
		where #whereClause#d.display_id=dl.display_id
			and dl.language_id='EN'
			and substring(dl.display_text, 1, 255) != ''
		order by substring(dl.display_text, 1, 255)
	<cfelse>
		select q.display_code
		from (
				select d.display_id, d.display_code, max(l.default_flag + q.target_flag + sign(length(substring(dl.display_text))), 1, 255) language_key_id
				from display d, display_language dl, language l, (
						select language_id, 2 as target_flag from language where language_id='ES'
						union
						select language_id, 0 as target_flag from language where default_flag=1
					) q
				where #whereClause#d.display_id=dl.display_id
					and dl.language_id=l.language_id
					and l.language_id=q.language_id
				group by d.display_id, d.display_code
			) q, (
				select language_id, 3 as language_key_id from language where language_id='ES'
				union
				select language_id, 2 as language_key_id from language where default_flag=1
			) k, display_language dl
		where q.language_key_id=k.language_key_id
			and q.display_id=dl.display_id
			and k.language_id=dl.language_id
			and substring(dl.display_text, 1, 255) != ''
		order by substring(dl.display_text, 1, 255)	
	</cfif>
</cfquery>

</cfsilent>