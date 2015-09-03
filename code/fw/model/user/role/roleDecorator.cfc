<cfcomponent extends="transfer.com.TransferDecorator" output="false">
	
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data = getMemento()>
		<cfreturn data>
	</cffunction>

</cfcomponent>