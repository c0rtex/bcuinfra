<cfparam name="attributes.name" type="string" default="bcuProgramPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.id" type="numeric" default="0">
<cfparam name="attributes.legacy" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuProgram">
<cfparam name="attributes.codevar" type="string" default="code">
<cfparam name="prg_id" default="">
<cfset multiLanguage = false>

<cfif attributes.code eq '' and attributes.id eq 0 and attributes.legacy eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or not IsDefined("application.#attributes.name#.legacy") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.p" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>
	<cfset "application.#attributes.name#.id" = StructNew()>
	<cfset "application.#attributes.name#.legacy" = StructNew()>

	<cfquery name="pvars" datasource="#application.dbSrc#">
		select p.program_id, p.program_code, pc.code, pc.programcategory_id,pg.code as grp,
			p.state_id, p.url, p.significant_flag, p.legacy_prg_id, p.name_display_id, p.desc_display_id,
			p.supersort, ifnull(p.supersort, 999999999) bigsort
		from program p inner join programcategory pc
				on p.programcategory_id=pc.programcategory_id
			left outer join programgroup pg
				on p.programgroup_id=pg.programgroup_id
		where p.active_flag=1
		order by bigsort, pc.sort, p.sort
	</cfquery>
    <cfif pvars.name_display_id NEQ "" OR pvars.desc_display_id NEQ "">
        <cfquery name="checkDisplayName" datasource="#application.dbSrc#">
            SELECT update_flag
            FROM display_language
            WHERE (display_id = #pvars.name_display_id# AND update_flag = 0 AND (language_id = 'EN' OR language_id =  'ES'))
        </cfquery>
        <cfquery name="checkDescriptionName" datasource="#application.dbSrc#">
            SELECT update_flag
            FROM display_language
            WHERE (display_id = #pvars.desc_display_id# AND update_flag = 0 AND (language_id = 'EN' OR language_id =  'ES'))
        </cfquery>
    </cfif>
    
    <cfif checkDisplayName.recordCount GT 1 AND checkDescriptionName.recordCount GT 1>
    	<cfset multiLanguage = true>
    <cfelse>
    	<cfset multiLanguage = false>
    </cfif>
	<cfset pCount = 0>
	<cfloop query="pvars">
		<cfif Not IsDefined("application.#attributes.name#.p.#program_code#")>
			<cfset pCount = pCount + 1>
			<cfset "application.#attributes.name#.p.#program_code#" = StructNew()>
			<cfset "application.#attributes.name#.p.#program_code#.id" = program_id>
			<cfset "application.#attributes.name#.p.#program_code#.cat" = code>
			<cfset "application.#attributes.name#.p.#program_code#.group" = grp>
			<cfset "application.#attributes.name#.p.#program_code#.st" = state_id>
			<cfset "application.#attributes.name#.p.#program_code#.url" = url>
			<cfset "application.#attributes.name#.p.#program_code#.sig" = significant_flag>
			<cfset "application.#attributes.name#.p.#program_code#.cat_id" = programcategory_id>
            <cfset "application.#attributes.name#.p.#program_code#.multiLang" = multiLanguage>
			<cfif legacy_prg_id eq ''>
				<cfset "application.#attributes.name#.p.#program_code#.legacy" = "XXX-XXX-#program_id#-XX-XX">
			<cfelse>
				<cfset "application.#attributes.name#.p.#program_code#.legacy" = legacy_prg_id>
			</cfif>
			<cfset "application.#attributes.name#.p.#program_code#.supersort" = supersort>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), pCount, program_code)>
			<cfset StructInsert(Evaluate("application.#attributes.name#.id"), program_id, program_code)>
			<cfif legacy_prg_id eq ''>
				<cfset StructInsert(Evaluate("application.#attributes.name#.legacy"), "XXX-XXX-#program_id#-XX-XX", program_code)>
			<cfelse>
				<cfset StructInsert(Evaluate("application.#attributes.name#.legacy"), legacy_prg_id, program_code)>
			</cfif>
            <cfset "application.#attributes.name#p.#program_code#.multiLang" = multiLanguage>
		</cfif>
	</cfloop>
</cfif>

<cfif attributes.code eq '' and attributes.id neq 0>
	<cfset attributes.code = StructFind(Evaluate("application.#attributes.name#.id"), attributes.id)>
	<cfset "caller.#attributes.codevar#" = attributes.code>
<cfelseif attributes.code eq '' and attributes.legacy neq ''>
	<cftry>
	<cfset attributes.code = StructFind(Evaluate("application.#attributes.name#.legacy"), attributes.legacy)>
	<cfcatch>
		<cfset attributes.code = prg_id>
	</cfcatch>
	</cftry>
	<cfset "caller.#attributes.codevar#" = attributes.code>
</cfif>

<cfif not doAll and (not IsDefined("application.#attributes.name#.p.#attributes.code#.sort") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.p.#attributes.code#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.p.#attributes.code#.sort" = StructNew()>
	<cfset "application.#attributes.name#.p.#attributes.code#.req" = StructNew()>
    <cfset "application.#attributes.name#.p.#attributes.code#.multiLang" = false>

	<cfquery name="rvars" datasource="#application.dbSrc#">
		select r.code, pr.sort, p.program_id, p.name_display_id, p.desc_display_id
		from program p, program_rule pr, rule r
		where p.program_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.code#" maxlength="32">
			and p.program_id=pr.program_id
			and pr.rule_id=r.rule_id
		order by pr.sort
	</cfquery>
	<cfloop query="rvars">
    	
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#attributes.code#.sort"), sort, code)>
        <cfif rvars.name_display_id NEQ "" OR rvars.desc_display_id NEQ "">
        	<cfquery name="checkDisplayName" datasource="#application.dbSrc#">
            	SELECT update_flag
            	FROM display_language
            	WHERE (display_id = #rvars.name_display_id# AND update_flag = 0 AND (language_id = 'EN' OR language_id =  'ES'))
        	</cfquery>
        	<cfquery name="checkDescriptionName" datasource="#application.dbSrc#">
            	SELECT update_flag
            	FROM display_language
            	WHERE (display_id = #rvars.desc_display_id# AND update_flag = 0 AND (language_id = 'EN' OR language_id =  'ES'))
        	</cfquery>
            <cfif checkDisplayName.recordCount GT 1 AND checkDescriptionName.recordCount GT 1>
				<cfset "application.#attributes.name#.p.#attributes.code#.multiLang" = true>
            <cfelse>
                <cfset "application.#attributes.name#.p.#attributes.code#.multiLang" = false>
            </cfif> 
    	</cfif>
	</cfloop>

	<cfquery name="rqvars" datasource="#application.dbSrc#">
		select rq.code, prq.sort
		from program p, program_requisite prq, requisite rq
		where p.program_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.code#" maxlength="32">
			and p.program_id=prq.program_id
			and prq.requisite_id=rq.requisite_id
		order by prq.sort
	</cfquery>
	<cfloop query="rqvars">
		<cfset StructInsert(Evaluate("application.#attributes.name#.p.#attributes.code#.req"), sort, code)>
	</cfloop>
    
    <!--- <cfif pvars.name_display_id NEQ "" OR pvars.desc_display_id NEQ "">
        <cfquery name="checkDisplayName" datasource="#application.dbSrc#">
            SELECT update_flag
            FROM display_language
            WHERE (display_id = #pvars.name_display_id# AND update_flag = 0 AND (language_id = 'EN' OR language_id =  'ES'))
        </cfquery>
        <cfquery name="checkDisplayName" datasource="#application.dbSrc#">
            SELECT update_flag
            FROM display_language
            WHERE (display_id = #pvars.desc_display_id# AND update_flag = 0 AND (language_id = 'EN' OR language_id =  'ES'))
        </cfquery>
    </cfif> --->
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="6" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td align="right"><strong>id</strong></td>
				<td><strong>program</strong></td>
				<td><strong><em>rule</em></strong></td>
				<td align="right"><strong>st</strong></td>
				<td align="right"><strong>cat</strong></td>
			</tr>
			<cfset pCount = 0>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="x">
				<cfset pCount = pCount + 1>
				<cf_cacheProgramPool action="get" code="#x#">
				<tr>
					<td align="right" valign="top">#pCount#</td>
					<td align="right" valign="top">#bcuProgram.id#</td>
					<td colspan="2" valign="top">#x#</td>
					<td align="right" valign="top">#bcuProgram.st#</td>
					<td align="right" valign="top">#bcuProgram.cat#</td>
				</tr>
				<cfset rCount = 0>
				<cf_loopPoolStruct struct="bcuProgram" index="y">
					<cfset rCount = rCount + 1>
					<tr>
						<td colspan="2"></td>
						<td align="right" valign="top"><em>#rCount#</em></td>
						<td colspan="3" valign="top"><em>#y#</em></td>
					</tr>
				</cf_loopPoolStruct>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif doAll>
			<cfset "caller.#attributes.var#" = false>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.p.#attributes.code#"))>
		</cfif>
	</cfcase>
</cfswitch>