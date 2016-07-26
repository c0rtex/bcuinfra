<cfsilent>
<cfparam name="attributes.language_id" type="string" default="EN" >
<cfparam name="attributes.grouplist" type="string" default="rx,generic">
<cfparam name="attributes.letter" type="string" default="">
<cfparam name="attributes.form" type="boolean" default="false">
<cfparam name="attributes.chop" type="numeric" default="0">
<cfparam name="attributes.object" type="string">

<cfif ThisTag.ExecutionMode eq 'start' and ThisTag.HasEndTag>

	<cfif ListFind(attributes.grouplist, 'rx')>
		<cfset rxBrand = true>
	<cfelse>
		<cfset rxBrand = false>
	</cfif>
	<cfif ListFind(attributes.grouplist, 'generic')>
		<cfset rxGeneric = true>
	<cfelse>
		<cfset rxGeneric = false>
	</cfif>
	<cfif ListFind(attributes.grouplist, 'rxco')>
		<cfset rxCompany = true>
	<cfelse>
		<cfset rxCompany = false>
	</cfif>
	<cfset alias = 'substring(dl.display_text, 1, 255)'>
	<cfif attributes.letter eq '##'>
		<cfset whereClause = "(substring(dl.display_text, 1, 1) < 'a' or substring(dl.display_text, 1, 1) > 'z')">
	<cfelse>
		<cfset whereClause = "#alias# like '#attributes.letter#%'">
	</cfif>
	<cfif rxBrand>
		<cfif rxCompany>
			<cfset inClause = ' in (13, 15)'>
		<cfelse>
			<cfset inClause = '=13'>
		</cfif>
	<cfelse>
		<cfif rxCompany>
			<cfset inClause = '=15'>
		<cfelse>
			<cfset inClause = ''>
		</cfif>
	</cfif>
	<cfif attributes.form>
		<cfquery name="rxGrab" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(2, 0, 0, 0)#">
			<cfif rxGeneric>
			select a.answerfield aanswerfield, #alias# txt
			from answerfield a, answerfield_relationship ar, program_answerfield pa,
				program p, program_form pf, display_language dl, language l
			where a.answerfield_id=ar.right_answerfield_id
				and ar.relationship_id=1
				and ar.left_answerfield_id=pa.answerfield_id
				and pa.program_id=p.program_id
				and p.active_flag=1
				and p.program_id=pf.program_id
				and a.display_id=dl.display_id
				and dl.language_id='#attributes.language_id#'
				<cfif attributes.letter neq ''>
				and #PreserveSingleQuotes(whereClause)#
				</cfif>
			<cfif not rxBrand and not rxCompany>
			group by aanswerfield, #alias#
			</cfif>
			</cfif>
			<cfif rxGeneric and (rxBrand or rxCompany)>
			union
			</cfif>
			<cfif rxBrand or rxCompany>
			select a.answerfield aanswerfield, #alias# txt
			from program_answerfield pa, answerfield a, program p, program_form pf,
				display_language dl, language l
			where pa.answerfield_id=a.answerfield_id
				and a.answerfieldtype_id#inClause#
				and pa.program_id=p.program_id
				and p.active_flag=1
				and p.program_id=pf.program_id
				and a.display_id=dl.display_id
				and dl.language_id='#attributes.language_id#'
				<cfif attributes.letter neq ''>
				and #PreserveSingleQuotes(whereClause)#
				</cfif>
			<cfif not rxGeneric>
			group by aanswerfield, #alias#
			</cfif>
			</cfif>
			order by txt, aanswerfield
		</cfquery>
	<cfelse>
		<cfquery name="rxGrab" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(2, 0, 0, 0)#">
			<cfif rxGeneric>
            select a.answerfield aanswerfield, #alias# txt
            from (
                select ar.right_answerfield_id
                from (
                    select a.answerfield_id
                        from answerfield a, rule_answerfield ra, program_rule pr, program p
                        where a.answerfieldtype_id#inClause#
                            and a.answerfield_id=ra.answerfield_id
                            and ra.rule_id=pr.rule_id
                            and pr.program_id=p.program_id
                            and p.active_flag=1
                        group by a.answerfield_id
                )aa, answerfield_relationship ar
                where aa.answerfield_id=ar.left_answerfield_id
                and ar.relationship_id = 1
                group by ar.right_answerfield_id
            ) x, answerfield a, display_language dl
            where x.right_answerfield_id = a.answerfield_id
                    and a.answerfieldtype_id=14
                    and a.display_id=dl.display_id
                    and dl.language_id='#attributes.language_id#'
                    <cfif attributes.letter neq ''>
                    and #PreserveSingleQuotes(whereClause)#
                    </cfif>
			<!--- Original commented out 10/1/10 for Bug 5758 and replaced with query above
			select a.answerfield aanswerfield, #alias# txt
			from answerfield a, display_language dl
			where a.answerfieldtype_id=14
				and a.display_id=dl.display_id
				and dl.language_id='#attributes.language_id#'
				<cfif attributes.letter neq ''>
				and #PreserveSingleQuotes(whereClause)#
				</cfif>--->
			</cfif>
			<cfif rxGeneric and (rxBrand or rxCompany)>
			union
			</cfif>
			<cfif rxBrand or rxCompany>
			select a.answerfield aanswerfield, #alias# txt
			from (
					select a.answerfield, a.answerfieldtype_id, a.display_id
					from answerfield a, rule_answerfield ra, program_rule pr, program p
					where a.answerfieldtype_id#inClause#
						and a.answerfield_id=ra.answerfield_id
						and ra.rule_id=pr.rule_id
						and pr.program_id=p.program_id
						and p.active_flag=1
					group by a.answerfield, a.answerfieldtype_id, a.display_id
				) a, display_language dl
			where a.display_id=dl.display_id
				and dl.language_id='#attributes.language_id#'
				<cfif attributes.letter neq ''>
				and #PreserveSingleQuotes(whereClause)#
				</cfif>
			</cfif>
			order by txt, aanswerfield
		</cfquery>
	</cfif>

	<cfset listPos = 1>
	<cfif rxGrab.RecordCount gt 0>
		<cfloop query="rxGrab" startrow="#listPos#" endrow="#listPos#">
			<cfif attributes.chop>
				<cf_stripTags text="#txt#" all="true" var="text">
				<cfset text = Left(text, attributes.chop)>
			<cfelse>
				<cfset text = txt>
			</cfif>
			<cfset "caller.#attributes.object#" = StructNew()>
			<cfset "caller.#attributes.object#.code" = aanswerfield>
			<cfset "caller.#attributes.object#.text" = text>
		</cfloop>
	<cfelse>
		<cfexit method="exitTag">
	</cfif>
<cfelseif ThisTag.ExecutionMode eq 'end'>
	<cfif rxGrab.RecordCount eq 0>
		<cfset ThisTag.GeneratedContent = ''>
	<cfelse>
		<cfset listPos = listPos + 1>
		<cfif listPos lte rxGrab.RecordCount>
			<cfloop query="rxGrab" startrow="#listPos#" endrow="#listPos#">
				<cfif attributes.chop>
					<cf_stripTags text="#txt#" all="true" var="text">
					<cfset text = Left(text, attributes.chop)>
				<cfelse>
					<cfset text = txt>
				</cfif>
				<cfset "caller.#attributes.object#" = StructNew()>
				<cfset "caller.#attributes.object#.code" = aanswerfield>
				<cfset "caller.#attributes.object#.text" = text>
			</cfloop>
			<cfexit method="loop">
		</cfif>
	</cfif>
</cfif>

</cfsilent>