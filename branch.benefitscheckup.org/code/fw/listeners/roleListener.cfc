<cfcomponent output="false" extends="MachII.framework.Listener" 
	displayname="roleListener" hint="I am a role listener.">

	<cffunction name="configure" access="public" returntype="void" output="false">
		<!--- Because of the auto-wiring feature of the ColdSpring integration I don't need these lines 
		<cfset variables.serviceFactory = getProperty("serviceFactory")>
		<cfset variables.roleService = serviceFactory.getBean("roleService")> --->
	</cffunction>
	
	<cffunction name="setRoleService" access="public" returntype="void" output="false">
		<cfargument name="roleService" _type="fw.model.user.role.roleService" required="true">
		<cfset variables.roleService = arguments.roleService>
	</cffunction>

	<cffunction name="saveRole" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfset var role = variables.roleService.getRole(event.getArg("id"))>
		<cfset role.setName(event.getArg("name"))>
		<cfset role.setDescription(event.getArg("description"))>
		<cfset variables.roleService.saveRole(role)>
	</cffunction>

	<cffunction name="getRole" access="public" _returntype="fw.model.user.role.role" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.roleService.getRole(event.getArg("role_id",0))>
	</cffunction>

	<cffunction name="getRoles" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.roleService.getRoles(arguments.event.getArgs())>
	</cffunction>

</cfcomponent>