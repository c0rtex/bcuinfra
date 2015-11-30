<cfcomponent output="false" displayname="roleDAO" hint="I am a role data access object.">

	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="role" type="fw.model.user.role.role" required="yes">
		<cfif arguments.role.getUsertype_id() neq 0>
			<cfset update(arguments.role)>
		<cfelse>
			<cfset create(arguments.role)>
		</cfif>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="role" type="fw.model.user.role.role" required="yes">
		<cfset var data = role.getInstanceMemento()>
		<cfset var newrole = 0>
		<cftransaction>
		<cfquery name="newrole" datasource="#variables.dsn#">
            INSERT INTO usertype (usertype_code, usertype_name, usertype_desc)
            VALUES (
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.usertype_code#" null="#yesnoformat(len(data.usertype_code) eq 0)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.usertype_name#" null="#yesnoformat(len(data.usertype_name) eq 0)#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.usertype_desc#" null="#yesnoformat(len(data.usertype_desc) eq 0)#">
            )
		</cfquery>
		<cfquery name="qMaxID" datasource="#variables.dsn#">
			SELECT MAX(usertype_id) as maxID from usertype
		</cfquery>
		</cftransaction>
		<cfset role.setUsertype_id(qMaxID.maxID)>

	</cffunction>

	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="role" type="fw.model.user.role.role" required="yes">
		<cfset var data = role.getInstanceMemento()>
		<cfset var updaterole = 0>
		<cfquery name="updaterole" datasource="#variables.dsn#">
            UPDATE usertype
            SET 
                usertype_code = 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.usertype_code#" null="#yesnoformat(len(data.usertype_code) eq 0)#">,
                usertype_name = 
                    <cfqueryparam cfsqltype="cf_sql_bit" value="#data.usertype_name#" null="#yesnoformat(len(data.usertype_name) eq 0)#">
                usertype_desc = 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.usertype_desc#" null="#yesnoformat(len(data.usertype_desc) eq 0)#">
            WHERE usertype_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#data.usertype_id#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.user.role.role" output="false">
		<cfargument name="roleID" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var role = 0>
		<cfset var readrole = 0>
		<cfif arguments.roleID neq 0>
			<cfquery name="readrole" datasource="#variables.dsn#">
                SELECT usertype_id, usertype_code, usertype_name, usertype_desc
                FROM usertype
                WHERE usertype_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#roleID#">
			</cfquery>
			<cfloop list="#readrole.columnList#" index="field">
				<cfset 'data.#field#' = evaluate('readrole.#field#')>
			</cfloop>
			<cfset role = createObject("component", "fw.model.user.role.role").init(argumentcollection=data)>
		<cfelse>
			<cfset role = createObject("component", "fw.model.user.role.role").init()>
		</cfif>
		<cfreturn role>
	</cffunction>

</cfcomponent>