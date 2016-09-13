<cfcomponent output="false" displayname="programGroupService" hint="I am a program Group service.">

	<!--- Setters for dependency injections via ColdSpring CAN USE DPENDS TOO 
	<cffunction name="setUserDAO" access="public" returntype="void" output="false">
		<cfargument name="userDAO" type="any" required="yes">
		<!--- dc-fw2.model.user.userDAOTransfer --->
		<cfset variables.userDAO = arguments.userDAO>
	</cffunction>
	<cffunction name="setUserGateway" access="public" returntype="void" output="false">
		<cfargument name="userGateway" type="fw.model.user.userGateway" required="yes">
		<cfset variables.userGateway = arguments.userGateway>
	</cffunction>	
	<cffunction name="setAddressService" access="public" returntype="void" output="false">
		<cfargument name="addressService" type="fw.model.address.addressService" required="yes">
		<cfset variables.addressService = arguments.addressService>
	</cffunction>
	<cffunction name="setRoleService" access="public" returntype="void" output="false">
		<cfargument name="roleService" type="fw.model.user.role.roleService" required="yes">
		<cfset variables.roleService = arguments.roleService>
	</cffunction>
	--->

	<cffunction name="getUser" access="public" returntype="fw.model.user.user" output="false">
		<cfargument name="user_id" type="numeric" required="no" default="0">
		<cfset var user = "">
		<cfset var roles = 0>
		<cfset var i = 0>
		<!--- <cfset user = variables.userDAO.read(arguments.user_id)> --->
		<cfif arguments.user_id neq 0>
			<cfset user = variables.userDAO.read(arguments.user_id)>
			<cfset roles = user.getRoles()>
			<cfif user.getAddress().getID() neq 0>
				<cfset user.setAddress(getAddress(user.getAddress().getID()))>
			</cfif>
            <cfloop from="1" to="#arrayLen(roles)#" index="i">
				<cfset roles[i] = variables.roleService.getRole(roles[i].getID())>
            </cfloop>
            <cfset user.setRoles(roles)>
		<cfelse>
			<cfset user = createObject("component", "dc-fw2.model.user.user").init()>
		</cfif>
		<cfreturn user>
	</cffunction>
	<cffunction name="getUserTO" access="public" returntype="struct" output="false">
		<cfargument name="user_id" type="numeric" required="no" default="0">
		<cfset var user = getUser(arguments.user_id)>
		<cfset var userTO = user.getInstanceMemento()>
		<cfreturn userTO>
	</cffunction>
	<cffunction name="saveUser" access="public" returntype="void" output="false">
		<cfargument name="user" _type="fw.model.user.user" required="yes">
		<cfset variables.addressService.saveAddress(arguments.user.getAddress())>
		<cfset variables.userDAO.save(arguments.user)>
	</cffunction>
	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="any" default="">
		<cfset var users = 0>
		<cfif isStruct(args)>
			<cfset users = variables.userGateway.getusers(argumentcollection=arguments.args)>
		<cfelse>
			<cfset users = variables.userGateway.getusers()>
		</cfif>
		<cfreturn users>
		<!--- <cfreturn variables.userGateway.getusers(argumentcollection=arguments.args)> --->
	</cffunction>
	
	<cffunction name="getLastNameList" access="public" returntype="string" output="false">
		<cfargument name="lastName" required="true" type="string">
		<cfset var lastNameList = "">
		<cfset var users = variables.userGateway.getUsers(lastname=arguments.lastname)>
		<cfset lastNameList = valueList(users.lastname)>
		<cfreturn lastNameList>
	</cffunction>
	
	<cffunction name="authenticateAdminUser" access="public" returntype="query" output="false">
		<cfargument name="username" required="yes" type="string">
		<cfargument name="password" required="yes" type="string">
		<cfset var qUser = 0>
		<cfset qUser = variables.userGateway.authenticateUser(arguments.username, arguments.password, 1)>
		<cfreturn qUser>
	</cffunction>
	<cffunction name="authenticateUser" access="public" returntype="query" output="false">
		<cfargument name="username" required="yes" type="string">
		<cfargument name="password" required="yes" type="string">
		<cfset var qUser = 0>
		<cfset qUser = variables.userGateway.authenticateUser(arguments.username, arguments.password)>
		<cfreturn qUser>
	</cffunction>
	
	<cffunction name="saveAddress" access="public" returntype="void" output="false">
		<cfargument name="address" type="fw.model.address.address" required="yes">
		<cfset variables.addressService.saveAddress(arguments.address)>
	</cffunction>
	<cffunction name="getAddress" access="public" _returntype="fw.model.address.address" output="false">
		<cfargument name="id" type="numeric" required="yes">
		<cfset var address = variables.addressService.getAddress(arguments.id)>
		<cfreturn address>
	</cffunction>
	<cffunction name="getAddresss" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="struct" default="struct">
		<cfreturn variables.addressService.getAddresss(arguments.args)>
	</cffunction>

	<cffunction name="getRole" access="public" _returntype="fw.model.user.role.role" output="false">
		<cfargument name="id" type="numeric" required="yes">
		<cfset var role = variables.roleService.getRole(arguments.id)>
		<cfreturn role>
	</cffunction>
	<cffunction name="getRoles" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="struct" default="struct">
		<cfreturn variables.roleService.getRoles(arguments.args)>
	</cffunction>

</cfcomponent>