<cfcomponent output="false" extends="MachII.framework.Listener" 
	displayname="userListener" hint="I am a user listener."
	depends="UserService,RoleService">

	<cffunction name="configure" access="public" returntype="void" output="false">
		<cfset variables.serviceFactory = getProperty("serviceFactory")>
		<!--- REMOTE SERVICES NOT USED YET
		<cfset variables.remoteUserService = serviceFactory.getBean("userService_remote")> 
		--->
	</cffunction>

	<!--- Because of the new  "depends" attribute in Mach II 1.6 I don't need these anymore
	<cffunction name="setUserService" access="public" returntype="void" output="false">
		<cfargument name="userService" type="dc-fw2.model.user.userService" required="true">
		<cfset variables.userService = arguments.userService>
	</cffunction>
	<cffunction name="setRoleService" access="public" returntype="void" output="false">
		<cfargument name="roleService" type="dc-fw2.model.user.role.roleService" required="true">
		<cfset variables.roleService = arguments.roleService>
	</cffunction> 
	--->

	<cffunction name="saveUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<!--- <cfset var user = event.getArg("user")>
		<cfset var address = event.getArg("address")> --->
        <cfif arguments.event.isArgDefined("user_id")>
        	<cfset var newID = arguments.event.getArg("user_id")>
        <cfelse>
        	<cfset var newID = 0>
        </cfif>
        
		<cfset var user = variables.userService.getUser(newID)>
		<cfset var address = user.getAddress()>
		<cfset var role_id = 0>
		<cfset var role = 0>
		
		<cfset user.setUsername(event.getArg("username"))>
		<cfset user.setPassword(event.getArg("password"))>
		<cfset user.setFirstname(event.getArg("firstname"))>
        <cfset user.setLastname(event.getArg("lastname"))>
		<cfset user.setEmail(event.getArg("email"))>
        <cfset user.setActive(event.getArg("active"))>
        <cfset user.setLast_login_date(event.getArg("last_login_date"))>
        <cfset user.setCreate_user_id(event.getArg("create_user_id"))>
        <cfset user.setCreate_date(event.getArg("create_date"))>
        <cfset user.setModify_user_id(event.getArg("modify_user_id"))>
        <cfset user.setModify_date(event.getArg("modify_date"))>
		
		<cfset address.setID(address.getID())>
		<cfset address.setStreet(event.getArg("street"))>
		<cfset address.setCity(event.getArg("city"))>
		<cfset address.setState(event.getArg("state"))>
		<cfset address.setzip(event.getArg("zip"))>
		<cfset user.setAddress(address)>
		<cfset user.clearRole()> 
		<!--- <cfset user.setRoles(arrayNew(1))> --->
		
		<!--- user roles  --->
		<cfloop list="#event.getArg("role_ids")#" index="role_id">
			<cfset role = variables.roleService.getRole(role_id)>
			<cfset user.addRole(role)>
		</cfloop>
		<cfset variables.userService.saveUser(user)>
	</cffunction>

	<cffunction name="getUser" access="public" _returntype="fw.model.user.user" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.userService.getUser(event.getArg("user_id"))>
	</cffunction>

	<cffunction name="getUsers" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.userService.getUsers(arguments.event.getArgs())>
	</cffunction>
	
	<cffunction name="processAdminLogin" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfset var qUser = 0>
		<cfset qUser = variables.userService.authenticateAdminUser(
				arguments.event.getArg("username"), arguments.event.getArg("password"))>
		<cfif qUser.recordcount gt 0>
			<cfset session.user = variables.userService.getUser(qUser.id)>
			<cfset announceEvent("success", event.getArgs())>
			<cfif event.getArg("rememberme", 0) eq 1>
				<!--- TODO: remember me --->
				<cfcookie name="rememberme" value="#encrypt("#session.user.getEmail()#;#session.user.getPassword()#", "appb00ster")#">
			</cfif>
		<cfelse>
			<cfset event.setArg("message", "The email or password you entered was incorrect. Please try again.")>
			<cfset announceEvent("failed", event.getArgs())>
		</cfif>
	</cffunction>
	
	<cffunction name="processLogin" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfset var qUser = 0>
		<cfset qUser = variables.userService.authenticateUser(arguments.event.getArg("username"), arguments.event.getArg("password"))>
        <cfset session.user = structNew()>
		<cfif qUser.recordcount gt 0>
			<cfset session.user = variables.userService.getUser(qUser.user_id)>
            <cfset event.setArg("success", true)>
			<cfset announceEvent("admin.home")>
            <!---<cfset announceEvent("test", event.getArgs())>--->
		<cfelse>
			<cfset event.setArg("errorMsg", "The username or password you entered was incorrect. Please try again.")>
            <cfset event.setArg("success", false)>
            <cfset structClear(session.user) />
            <cfset session.user = createObject("component","fw.model.user.user").init() />
			<cfset announceEvent("admin.login", event.getArgs())>
            <!---<cfset announceEvent("test", event.getArgs())>--->
		</cfif>
	</cffunction>
	
</cfcomponent>