<!---
	Template Name: ProgramPoolCache
	Component Purpose: Component manages local cache of programs

	Data Tables: Program, Programgroup, Display_language, Program_rule, Rule, Program_requisite, Requisite

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuProgramPoolComponent">

<!---
	Component property indicates if multilanguage is used for display programs
--->

	<cfproperty name="multiLanguage" type="boolean" default="false">

<!---
	Method initializes local cache and refresh them
--->

	<cffunction name="actionRefresh" output="no">
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.p = StructNew()>
		<cfset this.internalContent.sort = StructNew()>
		<cfset this.internalContent.id = StructNew()>
		<cfset this.internalContent.legacy = StructNew()>

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
	    	<cfset this.multiLanguage = true>
	    <cfelse>
	    	<cfset this.multiLanguage = false>
	    </cfif>
		<cfset pCount = 0>
		<cfloop query="pvars">
			<cfif Not StructKeyExists(this.internalContent.p, program_code)>
				<cfset pCount = pCount + 1>
				<cfset this.internalContent.p[program_code] = StructNew()>
				<cfset this.internalContent.p[program_code].id = program_id>
				<cfset this.internalContent.p[program_code].cat = code>
				<cfset this.internalContent.p[program_code].group = grp>
				<cfset this.internalContent.p[program_code].st = state_id>
				<cfset this.internalContent.p[program_code].url = url>
				<cfset this.internalContent.p[program_code].sig = significant_flag>
				<cfset this.internalContent.p[program_code].cat_id = programcategory_id>
	            <cfset this.internalContent.p[program_code].multiLang = this.multiLanguage>
				<cfif legacy_prg_id eq ''>
					<cfset this.internalContent.p[program_code].legacy = "XXX-XXX-#program_id#-XX-XX">
				<cfelse>
					<cfset this.internalContent.p[program_code].legacy = legacy_prg_id>
				</cfif>
				<cfset this.internalContent.p[program_code].supersort = supersort>
				<cfset StructInsert(this.internalContent.sort, pCount, program_code)>
				<cfset StructInsert(this.internalContent.id, program_id, program_code)>
				<cfif legacy_prg_id eq ''>
					<cfset StructInsert(this.internalContent.legacy, "XXX-XXX-#program_id#-XX-XX", program_code)>
				<cfelse>
					<cfset StructInsert(this.internalContent.legacy, legacy_prg_id, program_code)>
				</cfif>
	            <cfset this.internalContent.p[program_code].multiLang = this.multiLanguage>
			</cfif>
		</cfloop>
	</cffunction>

<!---
	Method refresh particular program with passed id in local cache
--->

	<cffunction name="refreshProgram" output="no">
		<cfargument name="code" type="string" default="">

		<cfset this.internalContent.p[code].lastRefresh = Now()>
		<cfset this.internalContent.p[code].sort = StructNew()>
		<cfset this.internalContent.p[code].req = StructNew()>
	    <cfset this.internalContent.p[code].multiLang = false>

		<cfquery name="rvars" datasource="#application.dbSrc#">
			select r.code, pr.sort, p.program_id, p.name_display_id, p.desc_display_id
			from program p, program_rule pr, rule r
			where p.program_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#code#" maxlength="32">
				and p.program_id=pr.program_id
				and pr.rule_id=r.rule_id
			order by pr.sort
		</cfquery>
		<cfloop query="rvars">

			<cfset StructInsert(this.internalContent.p[code].sort, sort, code)>
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
					<cfset this.internalContent.p[code].multiLang = true>
	            <cfelse>
	                <cfset this.internalContent.p[code].multiLang = false>
	            </cfif>
	    	</cfif>
		</cfloop>

		<cfquery name="rqvars" datasource="#application.dbSrc#">
			select rq.code, prq.sort
			from program p, program_requisite prq, requisite rq
			where p.program_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#code#" maxlength="32">
				and p.program_id=prq.program_id
				and prq.requisite_id=rq.requisite_id
			order by prq.sort
		</cfquery>
		<cfloop query="rqvars">
			<cfset StructInsert(this.internalContent.p[code].req, sort, code)>
		</cfloop>
	</cffunction>

<!---
	Method returns program code definition based on program id and legacy
--->

	<cffunction name="getCodeVar" output="no">
		<cfargument name="code" type="string" default="">
		<cfargument name="id" type="numeric" default="0">
		<cfargument name="legacy" type="string" default="">

		<cfif code eq '' and id neq 0>
			<cfreturn StructFind(this.internalContent.id, id)>
		<cfelseif code eq '' and legacy neq ''>
			<cftry>
				<cfreturn StructFind(this.internalContent.legacy, legacy)>
			<cfcatch>
				<cfreturn "">
			</cfcatch>
			</cftry>
		</cfif>
	</cffunction>

<!---
	Method returns html table with dump of cache content
--->

	<cffunction name="actionDump" output="yes">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="6" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
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
			<cfloop list="#Listsort(StructKeyList(this.internalContent.sort),'numeric')#" index="x">
				<cfset pCount = pCount + 1>
				<cfset bcuProgram = this.actionGet(this.internalContent.sort[x])>
				<tr>
					<td align="right" valign="top">#pCount#</td>
					<td align="right" valign="top">#bcuProgram.id#</td>
					<td colspan="2" valign="top">#x#</td>
					<td align="right" valign="top">#bcuProgram.st#</td>
					<td align="right" valign="top">#bcuProgram.cat#</td>
				</tr>
			</cfloop>
			</table>
		</cfoutput>
	</cffunction>

<!---
	Method returns struct contained program info for passed program code or couple of program id and legacy
--->

	<cffunction name="actionGet" output="no">
		<cfargument name="code" type="string" default="">
		<cfargument name="id" type="numeric" default="0">
		<cfargument name="legacy" type="string" default="">
		<cfif code eq '' and id eq 0 and legacy eq ''>
			<cfset doAll = true>
		<cfelse>
			<cfset doAll = false>
		</cfif>
		<cfif doAll>
			<cfreturn false>
		<cfelse>
			<cfset vCode=this.getCodeVar(code,id,legacy)>
			<cfif not StructKeyexists(this.internalContent.p,vCode)>
				<cfinvoke component="#this#" method="refreshprogram">
					<cfinvokeargument name="code" value="#vCode#">
				</cfinvoke>
			</cfif>
			<cfreturn StructCopy(this.internalContent.p[vCode])>
		</cfif>
	</cffunction>

</cfcomponent>