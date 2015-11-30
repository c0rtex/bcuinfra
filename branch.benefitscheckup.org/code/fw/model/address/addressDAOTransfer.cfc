<cfcomponent output="false" displayname="userDAOTransfer">

	<cffunction name="setTransfer" access="public" returntype="void" output="false">
		<cfargument name="transfer" type="any" required="yes">
		<cfset variables.transfer = arguments.transfer>
	</cffunction>

	<cffunction name="save" access="public" returntype="void" output="false">
		<cfargument name="address" type="appbooster.model.address.addressDecorator" required="yes">
		<cfset variables.transfer.save(arguments.address)>
	</cffunction>

	<cffunction name="read" access="public" returntype="appbooster.model.address.addressDecorator" output="false">
		<cfargument name="addressID" type="numeric" required="yes">
		<cfset var address = 0>
		<cfif arguments.addressID eq 0>
			<cfset address = variables.transfer.new("address")>
		<cfelse>
			<cfset address = variables.transfer.get("address", arguments.addressID)>
		</cfif>
		<cfreturn address>
	</cffunction>

</cfcomponent>