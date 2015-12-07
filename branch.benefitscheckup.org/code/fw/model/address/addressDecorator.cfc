<cfcomponent hint="Address Decorator" extends="transfer.com.TransferDecorator" output="false">
	
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data = getMemento()>
		<cfset data["__type__"] = "appbooster.model.address.address">
		<cfreturn data>
	</cffunction>

</cfcomponent>