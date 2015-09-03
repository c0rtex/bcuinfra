<cfcomponent output="false" displayname="programCategoryGateway" hint="I am a program category gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>
<!---
	dipslay_id, code, description, legacy_code, sort
--->
	<cffunction name="getProgramCategories" access="public" returntype="query" output="false">
		<cfargument name="display_id" required="no" type="numeric" default="0">
		<cfargument name="code" required="no" type="string" default="">
		<cfargument name="description" required="no" type="string" default="">
		<cfargument name="legacy_code" required="no" type="string" default="">
        <cfargument name="sort" required="no" type="numeric" default="0">
 		<cfset var qProgramCategories = 0>
		<cfquery name="qProgramCategories" datasource="#variables.dsn#">
            SELECT 	programcategory_id, display_id, code, description, legacy_code, sort
            FROM 	programcategory
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
                <cfif arguments.legacy_code neq "">
                    AND legacy_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.legacy_code#">
                </cfif>
                <cfif arguments.sort neq 0>
                    AND sort = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.sort#">
                </cfif>
			ORDER BY programcategory_id
		</cfquery>
		<cfreturn qProgramCategories>
	</cffunction>

</cfcomponent>