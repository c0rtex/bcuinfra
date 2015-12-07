<cfcomponent output="false" displayname="userDAO" hint="I am a user data access object.">





	<cffunction name="init" access="public" returntype="any" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="user" type="fw.model.user.user" required="yes">
		<cftransaction>	
			<cfif arguments.user.getUser_id() neq 0>
				<cfset update(arguments.user)>
				<cfset deleteUserRoles(arguments.user)>
			<cfelse>
				<cfset create(arguments.user)>
			</cfif>
			<cfset saveUserRoles(arguments.user)>
		</cftransaction>
	</cffunction>
	
	<cffunction name="deleteUserRoles" access="private" returntype="void" output="false">
		<cfargument name="user" type="fw.model.user.user" required="yes">
		<cfset var deleteUserRoles = 0>
		<cfquery name="deleteUserRoles" datasource="#variables.dsn#">
			DELETE FROM user_usertype
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getUser_id()#">
		</cfquery>
	</cffunction>
	
	<cffunction name="saveUserRoles" access="private" returntype="void" output="false">
		<cfargument name="user" type="fw.model.user.user" required="yes">
		<cfset var saveUserRoles = 0>
		<cfset var roles = arguments.user.getRoles()>
		<cfset var i = 0>
		<cfloop from="1" to="#arrayLen(roles)#" index="i">
			<cfquery name="saveUserRoles" datasource="#variables.dsn#">
				INSERT INTO user_usertype (user_id, usertype_id)
				VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user.getUser_id()#">,
				<cfqueryparam cfsqltype="cf_sql_integer" value="#roles[i].getUsertype_id()#">)
			</cfquery>
		</cfloop>
	</cffunction>

	<cffunction name="create" access="private" returntype="void" output="false">
		<cfargument name="user" type="fw.model.user.user" required="yes">
		<cfset var data = user.getInstanceMemento()>
		<cfset var newuser = 0>
		<cftransaction>
            <cfquery name="newuser" datasource="#variables.dsn#">
                INSERT INTO `user` (username, password, firstname, lastname, email, active, last_login_date, create_user_id, create_date, modify_user_id, modify_date, address_id, usertype_id)
                VALUES (
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.username#" null="#yesnoformat(len(data.username) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.password#" null="#yesnoformat(len(data.password) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.firstname#" null="#yesnoformat(len(data.firstname) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#data.lastname#" null="#yesnoformat(len(data.lastname) eq 0)#">,
                	<cfqueryparam cfsqltype="cf_sql_varchar" value="#data.email#" null="#yesnoformat(len(data.email) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_bit" value="#data.active#" null="#yesnoformat(len(data.active) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#data.last_login_date#" null="#yesnoformat(len(data.last_login_date) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.create_user_id#" null="#yesnoformat(len(data.create_user_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#data.create_date#" null="#yesnoformat(len(data.create_date) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_integer" value="#data.modify_user_id#" null="#yesnoformat(len(data.modify_user_id) eq 0)#">,
                    <cfqueryparam cfsqltype="cf_sql_date" value="#data.modify_date#" null="#yesnoformat(len(data.modify_date) eq 0)#">,
                	<cfqueryparam cfsqltype="" value="#arguments.user.getAddress().getId()#"null="#yesnoformat(len(arguments.user.getAddress().getId()) eq 0)#">,
                    5
                )
            </cfquery>
            <cfquery name="qMaxID" datasource="#variables.dsn#">
            	SELECT MAX(user_id) as maxID from `user`
            </cfquery>
		</cftransaction>
		<cfset user.setUser_id(qMaxID.maxID)>
	</cffunction>
<!---

[user_id] [int] IDENTITY(1,1) NOT NULL,
	[usertype_id] [int] NOT NULL,
	[username] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[password] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[firstname] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[lastname] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[email] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [tinyint] NULL,
	[last_login_date] [datetime] NULL,
	[create_user_id] [int] NOT NULL,
	[create_date] [datetime] NOT NULL,
	[modify_user_id] [int] NOT NULL,
	[modify_date] [datetime] NOT NULL,
--->
	<cffunction name="update" access="private" returntype="void" output="false">
		<cfargument name="user" type="fw.model.user.user" required="yes">
		<!--- <cfset var data = user.getInstanceMemento()> --->
		<cfset var updateuser = 0>
		<cfquery name="updateuser" datasource="#variables.dsn#">
			UPDATE `user`
			SET 
				username = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getUsername()#" null="#yesnoformat(len(user.getUsername()) eq 0)#">,
				password = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getPassword()#" null="#yesnoformat(len(user.getPassword()) eq 0)#">,
				firstname = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getFirstname()#" null="#yesnoformat(len(user.getFirstname()) eq 0)#">,
                lastname = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getLastname()#" null="#yesnoformat(len(user.getLastname()) eq 0)#">,
				email = 
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#user.getEmail()#" null="#yesnoformat(len(user.getEmail()) eq 0)#">,
                active = 
					<cfqueryparam cfsqltype="cf_sql_bit" value="#user.getActive()#" null="#yesnoformat(len(user.getActive()) eq 0)#">,
                last_login_date = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#user.getLast_login_date()#" null="#yesnoformat(len(user.getLast_login_date()) eq 0)#">,
                create_user_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getCreate_user_id()#" null="#yesnoformat(len(user.getCreate_user_id()) eq 0)#">,
                create_date = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#user.getCreate_date()#" null="#yesnoformat(len(user.getCreate_date()) eq 0)#">,
                modify_user_id = 
					<cfqueryparam cfsqltype="cf_sql_integer" value="#user.getModify_user_id()#" null="#yesnoformat(len(user.getModify_user_id()) eq 0)#">,
                modify_date = 
					<cfqueryparam cfsqltype="cf_sql_date" value="#user.getModify_date()#" null="#yesnoformat(len(user.getModify_date()) eq 0)#">,
				address_id = 
					<cfqueryparam cfsqltype="" value="#arguments.user.getAddress().getId()#" null="#yesnoformat(len(arguments.user.getAddress().getId()) eq 0)#">
			WHERE user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#user.getUser_id()#">
		</cfquery>
	</cffunction>

	<cffunction name="read" access="public" returntype="fw.model.user.user" output="false">
		<cfargument name="user_id" type="numeric" required="yes">
		<cfset var data = structNew()>
		<cfset var user = 0>
		<cfset var readuser = 0>
		<cfquery name="readuser" datasource="#variables.dsn#">
            SELECT 	
            	u.user_id, u.username, u.password, u.firstname, u.lastname, u.email, u.active, u.last_login_date, 
                u.create_user_id, u.create_date, u.modify_user_id, u.modify_date, u.address_id, ur.usertype_id
            FROM 	`user` u
            	left join user_usertype ur ON u.user_id = ur.user_id
            WHERE 	u.user_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.user_id#">
		</cfquery>
		<cfloop list="#readuser.columnList#" index="field">
			<cfset 'data.#field#' = evaluate('readuser.#field#')>
		</cfloop>
		<cfset user = createObject("component", "fw.model.user.user").init(argumentcollection=data)>
		<cfif readuser.address_id neq ""><cfset user.getAddress().setId(readuser.address_id)></cfif>
		<cfloop query="readuser">
			<cfif readuser.usertype_id neq "">
				<cfset user.addRole(createObject("component", "fw.model.user.role.role").init(readuser.usertype_id))>
			</cfif>
		</cfloop>
		<cfreturn user>
	</cffunction>

</cfcomponent>