<cfcomponent output="false" displayname="programGroupGateway" hint="I am a program group gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
<!---
	dipslay_id, code, description, legacy_code, sort
--->
	<cffunction name="getProgramGroups" access="public" returntype="query" output="false">
		<cfargument name="display_id" required="no" type="numeric" default="0">
		<cfargument name="code" required="no" type="string" default="">
		<cfargument name="description" required="no" type="string" default="">
		<cfargument name="blurb_display_id" required="no" type="numeric" default="0">
        <cfargument name="sort" required="no" type="numeric" default="0">
 		<cfset var qProgramGroups = 0>
		<cfquery name="qProgramGroups" datasource="#variables.dsn#">
            SELECT 	programgroup_id, display_id, code, description, blurb_display_id, sort
            FROM 	programgroup a
            WHERE 	(1=1)
                <cfif arguments.display_id neq 0>
                    AND display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.display_id#">
                </cfif>
                <cfif arguments.code neq "">
                    AND code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.code#">
                </cfif>
                <cfif arguments.description neq "">
                    AND description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.description#">
                </cfif>
                <cfif arguments.blurb_display_id neq 0>
                    AND blurb_display_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.blurb_display_id#">
                </cfif>
                <cfif arguments.sort neq 0>
                    AND a.sort = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sort#">
                </cfif>
			ORDER BY programgroup_id
		</cfquery>
		<cfreturn qProgramGroups>
	</cffunction>

</cfcomponent>