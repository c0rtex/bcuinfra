<cfsetting enablecfoutputonly="Yes">
<cfparam name="attributes.scope" type="string" default="application">
<cfparam name="attributes.name" type="string" default="bcuDisplayPool">
<cfparam name="attributes.code" type="string">
<cfparam name="attributes.group" type="string" default="">
<cfparam name="attributes.language_id" type="string" default="" >
<cfparam name="attributes.spacebefore" type="boolean" default="false">
<cfparam name="attributes.spaceafter" type="boolean" default="false">
<cfparam name="attributes.suppress" type="boolean" default="false">
<cfparam name="attributes.alt" type="string" default="">
<cfparam name="attributes.stripAllTags" type="boolean" default="false">
<cfparam name="attributes.stripTags" type="boolean" default="false">
<cfparam name="attributes.expandCodes" type="boolean" default="true">
<cfparam name="attributes.jsEscape" type="boolean" default="false">
<cfparam name="attributes.isTargetHTML" type="boolean" default="false">
<cfparam name="attributes.param1" type="string" default="">
<cfparam name="attributes.param2" type="string" default="">
<cfparam name="attributes.param3" type="string" default="">
<cfparam name="attributes.var" type="string" default="">

<cfset textStruct = "#attributes.scope#.#attributes.name#">
<cfif attributes.code neq '' and not attributes.suppress>
<cfset display_id = 0>
<cfset output = ''>
<cfif attributes.language_id eq ''>
	<cfif IsDefined('session.language_id') and session.language_id neq ''>
        <cfset attributes.language_id = session.language_id>
    <cfelse>
        <cf_cacheLanguagePool action="default" var="attributes.language_id">
    </cfif>
<cfelse>
</cfif>
<cfif not IsDefined(textStruct)>
	<cfset "#textStruct#" = StructNew()>
</cfif>
<cfif attributes.group eq ''>
	<cfquery name="getdisplaygroup" datasource="#application.dbSrc#">
		select d.display_id, dg.displaygroup_code
		from display d, displaygroup dg
		where d.display_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.code#" maxlength="64">
			and d.displaygroup_id=dg.displaygroup_id
	</cfquery>
	<cfif getdisplaygroup.RecordCount eq 0>
		<cfif attributes.alt eq ''>
			<cfset output = "<i>bad display code <b>"" #attributes.code# ""</b> entered</i>">
		<cfelse>
			<cfset output = attributes.alt>
		</cfif>
	<cfelse>
		<cfset display_id = getdisplaygroup.display_id>
		<cfset attributes.group = getdisplaygroup.displaygroup_code>
	</cfif>
</cfif>
<cfif output eq ''>
	<cfif attributes.group neq ''>
		<cfif not IsDefined("#textStruct#.#attributes.group#")>
			<cfset "#textStruct#.#attributes.group#" = StructNew()>
		</cfif>
		<cfif not IsDefined("#textStruct#.#attributes.group#.#attributes.language_id#")>
			<cfset "#textStruct#.#attributes.group#.#attributes.language_id#" = StructNew()>
		</cfif>
		<cfset isCodeDefined = false>
		<cfset isBadCode = false>
		<cfif IsDefined("#textStruct#.#attributes.group#.#attributes.language_id#.#attributes.code#")>
			<cfset isCodeDefined = true>
			<cfif IsDefined("#textStruct#.#attributes.group#.#attributes.language_id#.#attributes.code#.bad")>
				<cfset isBadCode = true>
			<cfelse>
				<cfset output = Evaluate("#textStruct#.#attributes.group#.#attributes.language_id#.#attributes.code#")>
			</cfif>
		</cfif>
		<cfif not isCodeDefined or isBadCode>
			<cfif isBadCode>
				<cfset getdisplay = QueryNew('display_text')>
			<cfelseif display_id gt 0>
				<cfquery name="getdisplay" datasource="#application.dbSrc#">
					select dl.display_text
					from display_language dl, language l
					where dl.display_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#display_id#" maxlength="10">
						and dl.language_id in ('#attributes.language_id#', 'EN')
						and dl.language_id=l.language_id
						and l.active = 1
					order by l.default_flag
				</cfquery>
			<cfelse>
 				<cfquery name="getdisplay" datasource="#application.dbSrc#">
					select dl.display_text
					from display d, display_language dl, language l
					where d.display_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.code#" maxlength="64">
						and d.display_id=dl.display_id
						and dl.language_id in ('#attributes.language_id#', 'EN')
						and dl.language_id=l.language_id
						and l.active = 1
					order by l.default_flag
				</cfquery>
			</cfif>
			<cfif getdisplay.RecordCount eq 0>
				<cfif attributes.alt eq '' and attributes.code neq 'answerfield_esi_client'>
					<cfset output = "<i>bad display code #isBadCode#<b>""#attributes.code#""</b> entered</i>">
				<cfelse>
					<cfset output = attributes.alt>
				</cfif>
				<cfif not isBadCode>
					<cfset "#textStruct#.#attributes.group#.#attributes.language_id#.#attributes.code#" = StructNew()>
					<cfset "#textStruct#.#attributes.group#.#attributes.language_id#.#attributes.code#.bad" = ''>
				</cfif>
			<cfelse>
				<cfloop query="getdisplay">
					<cfif output eq ''>
						<cfset output = display_text>
					</cfif>
				</cfloop>
				<cfset "#textStruct#.#attributes.group#.#attributes.language_id#.#attributes.code#" = output>
			</cfif>
		</cfif>

	</cfif>
</cfif>
<cfif attributes.expandCodes and output neq ''>
	<cf_expandTextCodes text="#output#" param1="#attributes.param1#" param2="#attributes.param2#" param3="#attributes.param3#" var="output">
</cfif>
<cfif output neq '' and (attributes.stripAllTags or attributes.stripTags)>
	<cf_stripTags text="#output#" all="#attributes.stripAllTags#" var="output">
</cfif>
<cfif attributes.jsEscape>
	<cfif output eq ''>
		<cfset output = "''">
	<cfelse>
		<cf_jsEscapeString text="#output#" isTargetHTML="#attributes.isTargetHTML#" var="output">
	</cfif>
</cfif>
<cfif attributes.spacebefore and output neq ''>
	<cfset output = ' &nbsp; ' & output>
</cfif>
<cfif attributes.spaceafter and output neq ''>
	<cfset output = output & ' &nbsp; '>
	</cfif>
	<cfif attributes.var eq ''>
		<cfoutput>#output#</cfoutput>
	<cfelse>
		<cfset "caller.#attributes.var#" = output>
	</cfif>
<cfelseif attributes.var neq ''>
	<cfset "caller.#attributes.var#" = ''>
</cfif>
<cfsetting enablecfoutputonly="No">