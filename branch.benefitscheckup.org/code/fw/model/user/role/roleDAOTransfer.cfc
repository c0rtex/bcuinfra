<cfcomponent output="false" displayname="roleDAOTransfer">

	<cffunction name="setTransfer" access="public" returntype="void" output="false">
		<cfargument name="transfer" type="any" required="yes">
		<cfset variables.transfer = arguments.transfer>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="role" type="dc-fw2.model.user.role.roleDecorator" required="yes">
		<cfset variables.transfer.save(arguments.role)>
	</cffunction>

	<cffunction name="read" access="public" returntype="dc-fw2.model.user.role.roleDecorator" output="false">
		<cfargument name="roleID" type="numeric" required="yes">
		<cfset var role = variables.transfer.get("role", arguments.roleID)>
		<cfreturn role>
	</cffunction>

</cfcomponent>