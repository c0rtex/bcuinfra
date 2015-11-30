<cfcomponent output="false" displayname="user" hint="I am a user object.">
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
	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="user_id" required="no" type="numeric" default="0">
		<cfargument name="username" required="no" type="string" default="">
		<cfargument name="password" required="no" type="string" default="">
		<cfargument name="firstname" required="no" type="string" default="">
        <cfargument name="lastname" required="no" type="string" default="">
		<cfargument name="email" required="no" type="string" default="">
        <cfargument name="active" required="no" type="boolean" default="false">
        <cfargument name="last_login_date" required="no" type="date" default="#now()#">
        <cfargument name="create_user_id" required="no" type="numeric" default="0">
        <cfargument name="create_date" required="no" type="date" default="#now()#">
        <cfargument name="modify_user_id" required="no" type="numeric" default="0">
        <cfargument name="modify_date" required="no" type="date" default="#now()#">
		<cfargument name="address" required="no" type="fw.model.address.address" default="#createObject("component", "fw.model.address.address").init()#">
		<cfargument name="roles" required="no" type="array" default="#arrayNew(1)#">
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getUser_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.id>
	</cffunction>
	<cffunction name="setUser_id" access="public" output="no" returntype="void">
		<cfargument name="id" required="yes" type="numeric">
		<cfset variables.instance.id = arguments.id>
	</cffunction>
	<cffunction name="getUsername" access="public" output="no" returntype="string">
		<cfreturn variables.instance.username>
	</cffunction>
	<cffunction name="setUsername" access="public" output="no" returntype="void">
		<cfargument name="username" required="yes" type="string">
		<cfset variables.instance.username = arguments.username>
	</cffunction>
	<cffunction name="getPassword" access="public" output="no" returntype="string">
		<cfreturn variables.instance.password>
	</cffunction>
	<cffunction name="setPassword" access="public" output="no" returntype="void">
		<cfargument name="password" required="yes" type="string">
		<cfset variables.instance.password = arguments.password>
	</cffunction>
	<cffunction name="getFirstname" access="public" output="no" returntype="string">
		<cfreturn variables.instance.firstname>
	</cffunction>
	<cffunction name="setFirstname" access="public" output="no" returntype="void">
		<cfargument name="firstname" required="yes" type="string">
		<cfset variables.instance.firstname = arguments.firstname>
	</cffunction>
    <cffunction name="getLastname" access="public" output="no" returntype="string">
		<cfreturn variables.instance.lastname>
	</cffunction>
	<cffunction name="setLastname" access="public" output="no" returntype="void">
		<cfargument name="lastname" required="yes" type="string">
		<cfset variables.instance.lastname = arguments.lastname>
	</cffunction>
	<cffunction name="getEmail" access="public" output="no" returntype="string">
		<cfreturn variables.instance.email>
	</cffunction>
	<cffunction name="setEmail" access="public" output="no" returntype="void">
		<cfargument name="email" required="yes" type="string">
		<cfset variables.instance.email = arguments.email>
	</cffunction>
    <cffunction name="getActive" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.active>
	</cffunction>
	<cffunction name="setActive" access="public" output="no" returntype="void">
		<cfargument name="active" required="yes" type="boolean">
		<cfset variables.instance.active = arguments.active>
	</cffunction>
    <cffunction name="getLast_login_date" access="public" output="no" returntype="date">
		<cfreturn variables.instance.last_login_date>
	</cffunction>
	<cffunction name="setLast_login_date" access="public" output="no" returntype="void">
		<cfargument name="last_login_date" required="yes" type="date">
		<cfset variables.instance.last_login_date = arguments.last_login_date>
	</cffunction>
    <cffunction name="getCreate_user_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.create_user_id>
	</cffunction>
	<cffunction name="setCreate_user_id" access="public" output="no" returntype="void">
		<cfargument name="create_user_id" required="yes" type="numeric">
		<cfset variables.instance.create_user_id = arguments.create_user_id>
	</cffunction>
    <cffunction name="getCreate_date" access="public" output="no" returntype="date">
		<cfreturn variables.instance.create_date>
	</cffunction>
	<cffunction name="setCreate_date" access="public" output="no" returntype="void">
		<cfargument name="create_date" required="yes" type="date">
		<cfset variables.instance.create_date = arguments.create_date>
	</cffunction>
    <cffunction name="getModify_user_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.modify_user_id>
	</cffunction>
	<cffunction name="setModify_user_id" access="public" output="no" returntype="void">
		<cfargument name="modify_user_id" required="yes" type="numeric">
		<cfset variables.instance.modify_user_id = arguments.modify_user_id>
	</cffunction>
    <cffunction name="getModify_date" access="public" output="no" returntype="date">
		<cfreturn variables.instance.modify_date>
	</cffunction>
	<cffunction name="setModify_date" access="public" output="no" returntype="void">
		<cfargument name="modify_date" required="yes" type="date">
		<cfset variables.instance.modify_date = arguments.modify_date>
	</cffunction>
	<cffunction name="getAddress" access="public" output="no" returntype="fw.model.address.address">
		<cfreturn variables.instance.address>
	</cffunction>
	<cffunction name="setAddress" access="public" output="no" returntype="void">
		<cfargument name="address" required="yes" type="fw.model.address.address">
		<cfset variables.instance.address = arguments.address>
	</cffunction>
	<cffunction name="getRoles" access="public" output="no" returntype="array">
		<cfreturn variables.instance.roles>
	</cffunction>
	<cffunction name="setRoles" access="public" output="no" returntype="void">
		<cfargument name="roles" required="yes" type="array">
		<cfset variables.instance.roles = arguments.roles>
	</cffunction>
	<cffunction name="addRole" access="public" output="no" returntype="void">
		<cfargument name="role" type="fw.model.user.role.role" required="true">
		<cfset arrayAppend(variables.instance.roles, arguments.role)>
	</cffunction>
	<cffunction name="hasRole" access="public" output="no" returntype="boolean">
		<cfargument name="usertype_code" required="yes" type="string">
		<cfset var i = 0>
		<cfloop from="1" to="#arrayLen(variables.instance.roles)#" index="i">
			<cfif variables.instance.roles[i].getUsertype_code() eq arguments.usertype_code>
				<cfreturn true>
			</cfif>
		</cfloop>
		<cfreturn false>
	</cffunction> 
    <cffunction name="clearRole" access="public" output="no" returntype="void">
        	<cfset arrayClear(getRoles())>
    </cffunction>
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset var roles = getRoles()>
		<cfset var i = 0>
		<cfset data.user_id = getUser_id()>
		<cfset data.username = getUsername()>
		<cfset data.password = getPassword()>
		<cfset data.firstname = getFirstname()>
        <cfset data.lastname = getLastname()>
		<cfset data.email = getEmail()>
        <cfset data.active = getActive()>
        <cfset data.last_login_date = getLast_login_date()>
        <cfset data.create_user_id = getCreate_user_id()>
        <cfset data.create_date = getCreate_date()>
        <cfset data.modify_user_id = getModify_user_id()>
        <cfset data.modify_date = getModify_date()>
		<cfset data.address = getAddress()>
		<cfset data.roles = arrayNew(1)>
		<cfloop from="1" to="#arrayLen(roles)#" index="i">
			<cfset arrayAppend(data.roles, roles[i].getInstanceMemento())>
		</cfloop>
		<cfreturn data>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setUser_id(arguments.data.user_id)>
		<cfset setUsername(arguments.data.username)>
		<cfset setPassword(arguments.data.password)>
		<cfset setFirstname(arguments.data.firstname)>
        <cfset setLastname(arguments.data.lastname)>
		<cfset setEmail(arguments.data.email)>
        <cfset setActive(arguments.data.active)>
        <cfset setLast_login_date(arguments.data.last_login_date)>
        <cfset setCreate_user_id(arguments.data.create_user_id)>
        <cfset setCreate_date(arguments.data.create_date)>
        <cfset setModify_user_id(arguments.data.modify_user_id)>
        <cfset setModify_date(arguments.data.modify_date)>
		<cfset setAddress(arguments.data.address)>
		<cfset setRoles(arguments.data.roles)>
	</cffunction>

</cfcomponent>