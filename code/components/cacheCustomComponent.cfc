<cfcomponent>
	
	<cfproperty name="name" type="string">

	<cffunction access="public" name="getName">
		<cfreturn this.name>
	</cffunction>
	
	<cffunction access="public" name="setName">
		<cfargument name="name" type="string" required="true">
		<cfset this.name=arguments.name>
	</cffunction>
	
</cfcomponent>>