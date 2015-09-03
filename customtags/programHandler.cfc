<cfcomponent displayname="programHandler" hint="Handles program data.">

    <!--- cacheProgramPool.cfm --->

    <cffunction name="getProgramPool" access="public" returntype="query">
 	<cfquery name="application.queryProgramPool" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(100,0,0,0)#">
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
        <cfreturn application.queryProgramPool />
    </cffunction>

   <cffunction name="getProgramRequisite" access="public" returntype="query">
	<cfargument name="code" required="yes" type="string">
	<cfquery name="application.queryProgramRequisite" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(100,0,0,0)#">
		select rq.code, prq.sort
		from program p, program_requisite prq, requisite rq
		where p.program_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#code#" maxlength="32">
			and p.program_id=prq.program_id
			and prq.requisite_id=rq.requisite_id
		order by prq.sort
	</cfquery>
        <cfreturn application.queryProgramRequisite />
    </cffunction>
 
    <cffunction name="getProgramIDByLegacyID" access="public" returntype="string">
	  <cfargument name="legacy_prg_id" required="yes" type="string">
	  <cfquery dbtype="query" name="application.getProgramIDByLegacyID" > 
    		SELECT program_id
    		FROM application.queryProgramPool
    		WHERE legacy_prg_id=<cfqueryparam value="#legacy_prg_id#" cfsqltype="cf_sql_varchar" maxLength="25">
	  </cfquery>
    	<cfreturn  application.getProgramIDByLegacyID.program_id />
    </cffunction>

	 <cffunction name="getLegacyIDByProgramID" access="public" returntype="string">
	  <cfargument name="program_id" required="yes" type="string">
	  <cfquery dbtype="query" name="application.getLegacyIDByProgramID" > 
    	SELECT legacy_prg_id
    	FROM application.queryProgramPool
    	WHERE program_id=<cfqueryparam value="#program_id#" cfsqltype="cf_sql_integer" maxLength="6">
	  </cfquery>
    	<cfreturn  application.getLegacyIDByProgramID.legacy_prg_id />
    </cffunction>
    
     <cffunction name="getProgramCodeByProgramID" access="public" returntype="string">
	  <cfargument name="program_id" required="yes" type="string">
	  <cfquery dbtype="query" name="application.getProgramCodeByProgramID" > 
    	SELECT program_code
    	FROM application.queryProgramPool
    	WHERE program_id=<cfqueryparam value="#program_id#" cfsqltype="cf_sql_integer" maxLength="6">
	  </cfquery>
    	<cfreturn  application.getProgramCodeByProgramID.program_code />
    </cffunction>
</cfcomponent>
