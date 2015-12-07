<cfcomponent output="false" displayname="addressService" hint="I am a address service.">

	<cffunction name="setAddressDAO" access="public" returntype="void" output="false">
		<cfargument name="addressDAO" type="any" required="yes">
		<!--- appbooster.model.address.addressDAOTransfer --->
		<cfset variables.addressDAO = arguments.addressDAO>
	</cffunction>

	<cffunction name="setAddressGateway" access="public" returntype="void" output="false">
		<cfargument name="addressGateway" _type="fw.model.address.addressGateway" required="yes">
		<cfset variables.addressGateway = arguments.addressGateway>
	</cffunction>

	<cffunction name="getAddress" access="public" _returntype="fw.model.address.address" output="false">
		<cfargument name="address_id" type="numeric" required="yes">
		<cfset var address = "">
		<cfset address = variables.addressDAO.read(arguments.address_id)>
		<cfreturn address>
	</cffunction>

	<cffunction name="saveAddress" access="public" returntype="void" output="false">
		<cfargument name="address" _type="fw.model.address.address" required="yes">
		<cfset variables.addressDAO.save(arguments.address)>
	</cffunction>

	<cffunction name="getAddresss" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="struct" default="struct">
		<cfreturn variables.addressGateway.getaddresss(argumentcollection=arguments.args)>
	</cffunction>

</cfcomponent>