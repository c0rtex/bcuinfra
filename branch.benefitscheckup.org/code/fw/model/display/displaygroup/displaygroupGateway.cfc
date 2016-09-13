<cfcomponent output="false" displayname="displaygroupGateway" hint="I am a displaygroup gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="getDisplaygroups" access="public" returntype="query" output="false">
		<cfargument name="displaygroup_code" required="no" type="string" default="">
		<cfargument name="displaygroup_name" required="no" type="string" default="">
		<cfargument name="displaygroup_desc" required="no" type="string" default="">
 		<cfset var qDisplays = "">
		<cfquery name="qDisplaygroups" datasource="#variables.dsn#">
            SELECT 	*
            FROM 	displaygroup
            WHERE 	(1=1)
                <cfif arguments.displaygroup_code neq "">
                    AND displaygroup_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.displaygroup_code#">
                </cfif>
                <cfif arguments.displaygroup_name neq "">
                    AND displaygroup_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.displaygroup_name#">
                </cfif>
                <cfif arguments.displaygroup_desc neq "">
                    AND displaygroup_desc = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.displaygroup_desc#">
                </cfif>
			ORDER BY displaygroup_id
		</cfquery>
		<cfreturn qDisplaygroups>
	</cffunction>

</cfcomponent>