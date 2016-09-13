<cfcomponent output="false" displayname="subsetGateway" hint="I am a subset gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="getSubsets" access="public" returntype="query" output="false">
		<cfargument name="subsettype_id" required="no" type="numeric" default="0">
		<cfargument name="code" required="no" type="string" default="">
		<cfargument name="description" required="no" type="string" default="">
        <cfargument name="display_id" required="no" type="numeric" default="0">
		<cfargument name="alt_display_id" required="no" type="numeric" default="0">
        <cfargument name="spq_display_id" required="no" type="numeric" default="0">
 		<cfset var qSubsets = 0>
		<cfquery name="qSubsets" datasource="#variables.dsn#">
            SELECT 	
            	*
            FROM 	subset
            WHERE 	(1=1)
                <cfif arguments.subsettype_id neq 0>
                    AND subsettype_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.subsettype_id#">
                </cfif>
                <cfif arguments.code neq "">
                    AND code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.code#">
                </cfif>
                <cfif arguments.description neq "">
                    AND description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.description#">
                </cfif>
                <cfif arguments.display_id neq 0>
                    AND display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.display_id#">
                </cfif>
                <cfif arguments.alt_display_id neq 0>
                    AND alt_display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.alt_display_id#">
                </cfif>
                <cfif arguments.spq_display_id neq 0>
                    AND spq_display_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.spq_display_id#">
                </cfif>
			ORDER BY subset_id
		</cfquery>
		<cfreturn qSubsets>
	</cffunction>
	
</cfcomponent>