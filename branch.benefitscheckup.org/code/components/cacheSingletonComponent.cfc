<cfcomponent>

	<cfproperty name="internalContent" type="array">

	<cffunction name="getInstance" access="public" output="no">
		<cfargument name="objName" type="string" default="" required="no">

		<cfset displayname = objName>

		<cfif objName eq "">
			<cfset displayname = this.getDisplayName()>
		</cfif>

		<cfif not isdefined("application.#displayname#")>
			<cfinvoke component="#this#" method="init">
			<cfset application[displayname] = this>
		</cfif>

		<cfreturn application[displayname]>

	</cffunction>

	<cffunction name="init" output="no">
		<cfinvoke component="#this#" method="actionRefresh">
	</cffunction>

	<cffunction name="getDisplayName" output="no">
		<cfreturn getMetaData(this).displayname>
	</cffunction>

</cfcomponent>>