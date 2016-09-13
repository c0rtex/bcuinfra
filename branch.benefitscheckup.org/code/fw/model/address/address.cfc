<cfcomponent output="false" displayname="address" hint="Users address object">



	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="id" required="no" type="numeric" default="0">
		<cfargument name="street" required="no" type="string" default="">
		<cfargument name="city" required="no" type="string" default="">
		<cfargument name="state" required="no" type="string" default="">
		<cfargument name="zip" required="no" type="string" default="">
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getId" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.id>
	</cffunction>
	<cffunction name="setId" access="public" output="no" returntype="void">
		<cfargument name="id" required="yes" type="numeric">
		<cfset variables.instance.id = arguments.id>
	</cffunction>
	<cffunction name="getStreet" access="public" output="no" returntype="string">
		<cfreturn variables.instance.street>
	</cffunction>
	<cffunction name="setStreet" access="public" output="no" returntype="void">
		<cfargument name="street" required="yes" type="string">
		<cfset variables.instance.street = arguments.street>
	</cffunction>
	<cffunction name="getCity" access="public" output="no" returntype="string">
		<cfreturn variables.instance.city>
	</cffunction>
	<cffunction name="setCity" access="public" output="no" returntype="void">
		<cfargument name="city" required="yes" type="string">
		<cfset variables.instance.city = arguments.city>
	</cffunction>
	<cffunction name="getState" access="public" output="no" returntype="string">
		<cfreturn variables.instance.state>
	</cffunction>
	<cffunction name="setState" access="public" output="no" returntype="void">
		<cfargument name="state" required="yes" type="string">
		<cfset variables.instance.state = arguments.state>
	</cffunction>
	<cffunction name="getzip" access="public" output="no" returntype="string">
		<cfreturn variables.instance.zip>
	</cffunction>
	<cffunction name="setzip" access="public" output="no" returntype="void">
		<cfargument name="zip" required="yes" type="string">
		<cfset variables.instance.zip = arguments.zip>
	</cffunction>
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data.id = getId()>
		<cfset data.street = getStreet()>
		<cfset data.city = getCity()>
		<cfset data.state = getState()>
		<cfset data.zip = getzip()>
		<cfreturn data>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setId(arguments.data.id)>
		<cfset setStreet(arguments.data.street)>
		<cfset setCity(arguments.data.city)>
		<cfset setState(arguments.data.state)>
		<cfset setzip(arguments.data.zip)>
	</cffunction>

</cfcomponent>