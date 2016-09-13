<cfcomponent output="false" displayname="displayGateway" hint="I am a display gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="getDisplays" access="public" returntype="query" output="false">
		<cfargument name="display_code" required="no" type="string" default="">
		<cfargument name="display_name" required="no" type="string" default="">
		<cfargument name="display_desc" required="no" type="string" default="">
        <cfargument name="active_flag" required="no" type="boolean" default="">
 		<cfset var qDisplays = "">
		<cfquery name="qDisplays" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	display
            WHERE 	(1=1)
                <cfif arguments.display_code neq "">
                    AND display_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.display_code#">
                </cfif>
                <cfif arguments.display_name neq "">
                    AND display_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.display_name#">
                </cfif>
                <cfif arguments.display_desc neq "">
                    AND display_desc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.display_desc#">
                </cfif>
                <cfif arguments.active_flag neq "">
                    AND active_flag = <cfqueryparam cfsqltype="cf_sql_bit" value="#arguments.active_flag#">
                </cfif>
			ORDER BY display_id
		</cfquery>
		<cfreturn qDisplays>
	</cffunction>

</cfcomponent>