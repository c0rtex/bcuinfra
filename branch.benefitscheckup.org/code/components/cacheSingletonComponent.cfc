<!---
	Template Name: cacheSingleton
	Component Purpose: Abstract parent component component for all cache components

	Data Tables:

--->

<cfcomponent>

<!---
	Internal property - container for cache content
--->

	<cfproperty name="internalContent" type="array">

<!---
	Singleton pattern method, that controls using the same component instance in whole application
--->

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

<!---
	Constructor, that initializes component instance at the first usage. This method calls actionRefresh methods, implemented in all child components
--->

	<cffunction name="init" output="no">
		<cfinvoke component="#this#" method="actionRefresh">
	</cffunction>

<!---
	Method returns components display name, that set in displaname attribute of cfcomponent node in child component implementation
--->

	<cffunction name="getDisplayName" output="no">
		<cfreturn getMetaData(this).displayname>
	</cffunction>

</cfcomponent>>