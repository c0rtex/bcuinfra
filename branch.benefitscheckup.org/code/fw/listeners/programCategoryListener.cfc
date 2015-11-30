<cfcomponent output="false" extends="MachII.framework.Listener" 
	displayname="userListener" hint="I am a user listener."
	depends="programCategoryService">

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

	<cffunction name="saveProgramCategory" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
        <cfif arguments.event.isArgDefined("programCategory_id")>
        	<cfset var programCategory_id = arguments.event.getArg("programCategory_id")>
        <cfelse>
        	<cfset var programCategory_id = 0>
        </cfif>
        
		<cfset var programCategory = variables.programCategoryService.getProgramCategory(programCategory_id)>
		<!--- <cfset var address = user.getAddress()> 
		<cfset var role_id = 0>
		<cfset var role = 0>--->
		
		<cfset programCategory.setUsername(event.getArg("username"))>
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

	<cffunction name="getProgram" access="public" _returntype="fw.model.program.program" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.programService.getProgram(event.getArg("program_id"))>
	</cffunction>

	<cffunction name="getPrograms" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.programService.getPrograms(arguments.event.getArgs())>
	</cffunction>
	
</cfcomponent>