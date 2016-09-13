<cfcomponent output="false" displayname="roleGateway" hint="I am a role gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="getRoles" access="public" returntype="query" output="false">
		<cfargument name="usertype_id" required="no" type="numeric" default="0">
        <cfargument name="usertype_code" required="no" type="string" default="">
		<cfargument name="usertype_name" required="no" type="string" default="">
		<cfargument name="usertype_desc" required="no" type="string" default="">
		<cfset var qRoles = 0>
		<cfquery name="qRoles" datasource="#variables.dsn#">
            SELECT usertype_id, usertype_code, usertype_name, usertype_desc
            FROM usertype
            WHERE (1=1)
            	<cfif arguments.usertype_id neq "0">
                	AND usertype_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.usertype_id#" null="#yesnoformat(len(arguments.usertype_id) eq 0)#">
                </cfif>
                <cfif arguments.usertype_code neq "">
                	AND usertype_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.usertype_code#" null="#yesnoformat(len(arguments.usertype_code) eq 0)#">
                </cfif>
                <cfif arguments.usertype_name neq "">
                	AND usertype_name = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.usertype_name#" null="#yesnoformat(len(arguments.usertype_name) eq 0)#">
                </cfif>
                <cfif arguments.usertype_desc neq "">
                	AND usertype_desc = <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.usertype_desc#" null="#yesnoformat(len(arguments.usertype_desc) eq 0)#">
                </cfif>
            ORDER BY usertype_id
		</cfquery>
		<cfreturn qRoles>
	</cffunction>

</cfcomponent>