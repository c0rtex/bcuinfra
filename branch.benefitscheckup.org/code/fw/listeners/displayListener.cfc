<cfcomponent output="false" extends="MachII.framework.Listener" 
	displayname="displayListener" hint="I am a display listener."
	depends="displayService">

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

	<cffunction name="saveDisplay" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<!--- <cfset var user = event.getArg("user")>
		<cfset var address = event.getArg("address")> --->
        <cfif arguments.event.isArgDefined("display_id")>
        	<cfset var newID = arguments.event.getArg("display_id")>
        <cfelse>
        	<cfset var newID = 0>
        </cfif>
        
		<cfset var display = variables.displayService.getDisplay(newID)>
		
		<cfset display.setDsiplay_code(event.getArg("display_code"))>
		<cfset display.setDisplay_nane(event.getArg("display_name"))>
		<cfset display.setDisplay_desc(event.getArg("display_desc"))>
        <cfset display.setActive_flag(event.getArg("active_flag"))>

		<cfset variables.displayService.saveDisplay(display)>
	</cffunction>

	<cffunction name="getDisplay" access="public" _returntype="fw.model.display.display" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.displayService.getDisplay(event.getArg("display_id"))>
	</cffunction>

	<cffunction name="getDisplays" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.displayService.getDisplays(arguments.event.getArgs())>
	</cffunction>
	
	
</cfcomponent>