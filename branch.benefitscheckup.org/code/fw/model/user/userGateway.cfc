<cfcomponent output="false" displayname="userGateway" hint="I am a user gateway.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" required="yes" type="string">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfargument name="username" required="no" type="string" default="">
		<cfargument name="password" required="no" type="string" default="">
		<cfargument name="firstname" required="no" type="string" default="">
        <cfargument name="lastname" required="no" type="string" default="">
		<cfargument name="email" required="no" type="string" default="">
        <cfargument name="active" required="no" type="boolean" default="false">
        <cfargument name="last_login_date" required="no" type="date" default="#now()#">
        <cfargument name="create_user_id" required="no" type="numeric" default="0">
        <cfargument name="address_id" required="no" type="numeric" default="0">
        <cfargument name="state" required="no" type="string" default="">
        <cfargument name="city" required="no" type="string" default="">
        <cfargument name="zip" required="no" type="string" default="">
 		<cfset var qUsers = 0>
		<cfquery name="qUsers" datasource="#variables.dsn#">
            SELECT 	
            	u.user_id, u.username,u.password,u.firstname,u.lastname,u.email,u.active,u.last_login_date,u.create_user_id,
                u.create_date,u.modify_user_id,u.modify_date,u.address_id,a.street, a.city, a.state, a.zip
            FROM 	`user` u
                left join address a ON u.address_id = a.id
            WHERE 	(1=1)
                <cfif arguments.username neq "">
                    AND username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
                </cfif>
                <cfif arguments.password neq "">
                    AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#">
                </cfif>
                <cfif arguments.email neq "">
                    AND email = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
                </cfif>
                <cfif arguments.firstname neq "">
                    AND firstname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.firstname#">
                </cfif>
                <cfif arguments.lastname neq "">
                    AND lastname = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lastname#">
                </cfif>
                <cfif arguments.address_id neq 0>
                    AND address_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.address_id#">
                </cfif>
                <cfif arguments.state neq "">
                    AND a.state = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state#">
                </cfif>
                <cfif arguments.zip neq "">
                    AND a.zip = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.zip#">
                </cfif>
                <cfif arguments.city neq "">
                    AND a.city = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#">
                </cfif>
			ORDER BY user_id
		</cfquery>
		<cfreturn qUsers>
	</cffunction>
	
	<cffunction name="authenticateUser" access="public" returntype="query" output="false">
		<cfargument name="username" required="yes" type="string">
		<cfargument name="password" required="yes" type="string">
		<cfargument name="role_id" required="no" type="string" default="">
		<cfset var qUsers = 0>
		<cfquery name="qUsers" datasource="#variables.dsn#">
            SELECT u.user_id, u.username, u.password, ur.usertype_id
            FROM 	`user` u
                    left join user_usertype ur ON u.user_id = ur.user_id
            WHERE (1 = 1)
                AND u.username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.username#">
                AND u.password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.password#">
                <cfif arguments.role_id neq "">
                    AND ur.role_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.role_id#">
                </cfif>
		</cfquery>
		<cfreturn qUsers>
	</cffunction>

</cfcomponent>