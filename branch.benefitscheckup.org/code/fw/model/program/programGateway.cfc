<cfcomponent output="false" displayname="programGateway" hint="I am a program gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
<!---
	programcategory_id, programgroup_id, state_id, program_code, name_display_id, desc_display_id, url,
	exclude_flag, significant_flag, active_flag, funder_id, reference_id, last_update, notes, supersort, sort,
	legacy_prg_id, legacy_pri_sec, create_user_id, create_date, modify_user_id, modify_date
--->
	<cffunction name="getPrograms" access="public" returntype="query" output="false">
		<cfargument name="programcategory_id" required="no" type="numeric" default="0">
		<cfargument name="state_id" required="no" type="string" default="">
		<cfargument name="program_code" required="no" type="string" default="">
        <cfargument name="name_display_id" required="no" type="numeric" default="0">
        <cfargument name="desc_display_id" required="no" type="numeric" default="0">
        <cfargument name="url" required="no" type="string" default="">
        <cfargument name="exclude_flag" required="no" type="boolean" default="0">
        <cfargument name="significant_flag" required="no" type="boolean" default="0">
        <cfargument name="active_flag" required="no" type="boolean" default="0">
        <cfargument name="funder_id" required="no" type="numeric" default="0">
        <cfargument name="reference_id" required="no" type="numeric" default="0">
        <cfargument name="notes" required="no" type="string" default="">
        <cfargument name="supersort" required="no" type="numeric" default="0">
        <cfargument name="sort" required="no" type="numeric" default="0">
        <cfargument name="legacy_prg_id" required="no" type="string" default="">
        <cfargument name="legacy_pri_sec" required="no" type="numeric" default="0">
        <cfargument name="create_user_id" required="no" type="numeric" default="0">
        <cfargument name="modify_user_id" required="no" type="numeric" default="0">
 		<cfset var qPrograms = 0>
		<cfquery name="qPrograms" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	program a
            WHERE 	(1=1)
                <cfif arguments.programcategory_id neq 0>
                    AND programcategory_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.programcategory_id#">
                </cfif>
                <cfif arguments.state_id neq "">
                    AND state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state_id#">
                </cfif>
                <cfif arguments.program_code neq "">
                    AND program_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.program_code#">
                </cfif>
                <cfif arguments.name_display_id neq 0>
                    AND a.name_display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.name_display_id#">
                </cfif>
                <cfif arguments.desc_display_id neq 0>
                    AND a.desc_display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.desc_display_id#">
                </cfif>
                <cfif arguments.url neq "">
                    AND a.url = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.url#">
                </cfif>
                <cfif arguments.exclude_flag neq 0>
                    AND exclude_flag = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.exclude_flag#">
                </cfif>
                <cfif arguments.significant_flag neq 0>
                    AND significant_flag = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.significant_flag#">
                </cfif>
                <cfif arguments.active_flag neq 0>
                    AND active_flag = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.active_flag#">
                </cfif>
                <cfif arguments.funder_id neq 0>
                    AND funder_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.funder_id#">
                </cfif>
                <cfif arguments.reference_id neq 0>
                    AND a.reference_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.reference_id#">
                </cfif>
                <cfif arguments.notes neq "">
                    AND a.notes = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.notes#">
                </cfif>
                 <cfif arguments.supersort neq 0>
                    AND a.supersort = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.supersort#">
                </cfif>
                <cfif arguments.sort neq 0>
                    AND sort = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sort#">
                </cfif>
                <cfif arguments.legacy_prg_id neq "">
                    AND legacy_prg_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.legacy_prg_id#">
                </cfif>
                <cfif arguments.legacy_pri_sec neq 0>
                    AND legacy_pri_sec = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.legacy_pri_sec#">
                </cfif>
                <cfif arguments.create_user_id neq 0>
                    AND create_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.create_user_id#">
                </cfif>
                <cfif arguments.modify_user_id neq 0>
                    AND a.modify_user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.modify_user_id#">
                </cfif>
			ORDER BY program_id
		</cfquery>
		<cfreturn qPrograms>
	</cffunction>
    <cffunction name="getProgramsJSON" access="public" returntype="query">      
    	<cfargument name="sidx" required="no" default="" hint="Sort Column">
    	<cfargument name="sord" required="no" default="ASC" hint="Sort Order"> 
        <cfquery name="qPrograms" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	program
            <cfif Arguments.sidx NEQ "">                  
            	ORDER BY #Arguments.sidx# #Arguments.sord#
            <cfelse>
            	ORDER BY program_id #Arguments.sord#
            </cfif>
        </cfquery>
        <!---<cfset stcReturn = SerializeJSON(qPrograms)>
        
		<cfset var start = ((arguments.page-1)*arguments.rows)+1>
		<cfset var end = (start-1) + arguments.rows>
		<cfset var i = 1>
		<cfloop query="qPrograms" startrow="#start#" endrow="#end#">	
			<cfset arrPrograms[i] = [#program_id#,#program_code#,#url#,#legacy_prg_id#,#create_date#]>
			<cfset i = i + 1>			
		</cfloop>
		<cfset totalPages = Ceiling(qPrograms.recordcount/arguments.rows)>
		<cfset stcReturn = {total=#totalPages#,page=#Arguments.page#,records=#qPrograms.recordcount#,rows=arrPrograms}>
		--->
		<cfreturn qPrograms />
    </cffunction>
    

</cfcomponent>