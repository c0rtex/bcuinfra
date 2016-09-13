<cfcomponent output="false" displayname="roleService" hint="I am a role service.">

	<cffunction name="setRoleDAO" access="public" returntype="void" output="false">
		<cfargument name="roleDAO" type="any" required="yes">
		<!--- dc-fw2.model.user.role.roleDAOTransfer --->
		<cfset variables.roleDAO = arguments.roleDAO>
	</cffunction>

	<cffunction name="setRoleGateway" access="public" returntype="void" output="false">
		<cfargument name="roleGateway" type="fw.model.user.role.roleGateway" required="yes">
		<cfset variables.roleGateway = arguments.roleGateway>
	</cffunction>

	<cffunction name="getRole" access="public" _returntype="fw.model.user.role.role" output="false">
		<cfargument name="usertype_id" type="numeric" required="yes">
		<cfset var role = "">
		<cfset role = variables.roleDAO.read(arguments.usertype_id)>
		<cfreturn role>
	</cffunction>

	<cffunction name="saveRole" access="public" returntype="void" output="false">
		<cfargument name="role" _type="fw.model.user.role.role" required="yes">
		<cfset variables.roleDAO.save(arguments.role)>
	</cffunction>

	<cffunction name="getRoles" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="struct" default="struct">
		<cfreturn variables.roleGateway.getroles(argumentcollection=arguments.args)>
	</cffunction>

</cfcomponent>