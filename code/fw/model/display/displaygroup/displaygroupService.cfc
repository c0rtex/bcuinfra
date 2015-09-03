<cfcomponent output="no" displayname="displaygroupService" hint="I am a displaygroup service.">

	<!--- Setters for dependency injections via ColdSpring CAN USE DPENDS TOO --->
	<cffunction name="setDisplaygroupDAO" access="public" returntype="void" output="false">
		<cfargument name="displaygroupDAO" type="any" required="yes">
		<cfset variables.displaygroupDAO = arguments.displaygroupDAO>
	</cffunction>
	<cffunction name="setDisplaygroupGateway" access="public" returntype="void" output="false">
		<cfargument name="displaygroupGateway" type="fw.model.display.displaygroup.displaygroupGateway" required="yes">
		<cfset variables.displaygroupGateway = arguments.displaygroupGateway>
	</cffunction>
	<!---	
	<cffunction name="setAddressService" access="public" returntype="void" output="false">
		<cfargument name="addressService" type="fw.model.address.addressService" required="yes">
		<cfset variables.addressService = arguments.addressService>
	</cffunction>
	<cffunction name="setRoleService" access="public" returntype="void" output="false">
		<cfargument name="roleService" type="fw.model.user.role.roleService" required="yes">
		<cfset variables.roleService = arguments.roleService>
	</cffunction>
	--->

	<cffunction name="getDisplaygroup" access="public" returntype="fw.model.display.displaygroup.displaygroup" output="false">
		<cfargument name="displaygroup_id" type="numeric" required="no" default="0">
		<cfset var displaygroup = "">
		<cfif arguments.displaygroup_id neq 0>
			<cfset displaygroup = variables.displaygroupDAO.read(arguments.displaygroup_id)>
		<cfelse>
			<cfset displaygroup = createObject("component", "fw.model.display.displaygroup.dsiplaygroup").init()>
		</cfif>
		<cfreturn displaygroup>
	</cffunction>
	<cffunction name="getDisplaygroupTO" access="public" returntype="struct" output="false">
		<cfargument name="displaygroup_id" type="numeric" required="no" default="0">
		<cfset var displaygroup = getDisplaygroup(arguments.display_id)>
		<cfset var displaygroupTO = displaygroup.getInstanceMemento()>
		<cfreturn displaygroupTO>
	</cffunction>
	<cffunction name="saveDisplaygroup" access="public" returntype="void" output="false">
		<cfargument name="displaygroup" _type="fw.model.display.displaygroup.displaygroup" required="yes">
		<cfset variables.displaygroupDAO.save(arguments.displaygroup)>
	</cffunction>
	<cffunction name="getDisplaygroups" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="any" default="">
		<cfset var dipsplaygroups = "">
		<cfif isStruct(args)>
			<cfset displaygroups = variables.displayGateway.getDisplays(argumentcollection=arguments.args)>
		<cfelse>
			<cfset displaygroups = variables.displaygroupGateway.getDisplaygroups()>
		</cfif>
		<cfreturn displaygroups>
	</cffunction>

</cfcomponent>