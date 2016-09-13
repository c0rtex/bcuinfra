<cfcomponent output="false" extends="MachII.framework.Listener" 
	displayname="userListener" hint="I am a user listener."
	depends="programService,displaylanguageService">

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

	<cffunction name="saveProgram" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
        <cfif arguments.event.isArgDefined("program_id")>
        	<cfset var program_id = arguments.event.getArg("program_id")>
        <cfelse>
        	<cfset var program_id = 0>
        </cfif>
        
		<cfset var program = variables.programService.getProgram(program_id)>
		<!--- <cfset var address = user.getAddress()> 
		<cfset var role_id = 0>--->
		<cfset var displaylanguage = 0>
		
		<cfset program.setUsername(event.getArg("username"))>
		<cfset program.setPassword(event.getArg("password"))>
		<cfset program.setFirstname(event.getArg("firstname"))>
        <cfset program.setLastname(event.getArg("lastname"))>
		<cfset program.setEmail(event.getArg("email"))>
        <cfset program.setActive(event.getArg("active"))>
        <cfset program.setLast_login_date(event.getArg("last_login_date"))>
        <cfset program.setCreate_user_id(event.getArg("create_user_id"))>
        <cfset program.setCreate_date(event.getArg("create_date"))>
        <cfset program.setModify_user_id(event.getArg("modify_user_id"))>
        <cfset program.setModify_date(event.getArg("modify_date"))>

		<cfset variables.userService.saveUser(user)>
	</cffunction>

	<cffunction name="getProgram" access="public" returntype="fw.model.program.program" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.programService.getProgram(event.getArg("program_id"))>
	</cffunction>
	<!--- <!--- <cffunction name="getProgramsJSON" access="public" returntype="struct" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.programService.getProgramsJSON(arguments.event.getArgs())>
	</cffunction> ---> --->
    
	<cffunction name="getPrograms" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.programService.getPrograms(arguments.event.getArgs())>
	</cffunction>
	
</cfcomponent>