<cfcomponent output="false" displayname="display" hint="I am a display object.">

	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="displaygroup_id" required="no" type="numeric" default="0">
		<cfargument name="displaygroup_code" required="no" type="string" default="">
		<cfargument name="displaygroup_name" required="no" type="string" default="">
        <cfargument name="displaygroup_desc" required="no" type="string" default="">
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>
	<cffunction name="getDisplaygroup_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.displaygroup_id>
	</cffunction>
	<cffunction name="setDisplaygroup_id" access="public" output="no" returntype="void">
		<cfargument name="displaygroup_id" required="yes" type="numeric">
		<cfset variables.instance.displaygroup_id = arguments.displaygroup_id>
	</cffunction>
	<cffunction name="getDisplaygroup_code" access="public" output="no" returntype="string">
		<cfreturn variables.instance.displaygroup_code>
	</cffunction>
	<cffunction name="setDisplaygroup_code" access="public" output="no" returntype="void">
		<cfargument name="displaygroup_code" required="yes" type="string">
		<cfset variables.instance.displaygroup_code = arguments.displaygroup_code>
	</cffunction>
	<cffunction name="getDisplay_name" access="public" output="no" returntype="string">
		<cfreturn variables.instance.display_name>
	</cffunction>
	<cffunction name="setDisplaygroup_name" access="public" output="no" returntype="void">
		<cfargument name="displaygroup_name" required="yes" type="string">
		<cfset variables.instance.displaygroup_name = arguments.displaygroup_name>
	</cffunction>
    <cffunction name="getDisplaygroup_desc" access="public" output="no" returntype="string">
		<cfreturn variables.instance.displaygroup_desc>
	</cffunction>
	<cffunction name="setDisplaygroup_desc" access="public" output="no" returntype="void">
		<cfargument name="displaygroup_desc" required="yes" type="string">
		<cfset variables.instance.displaygroup_desc = arguments.displaygroup_desc>
	</cffunction>
   
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data.displaygroup_id = getDisplaygroup_id()>
		<cfset data.displaygroup_code = getDisplaygroup_code()>
		<cfset data.displaygroup_name = getDisplaygroup_name()>
        <cfset data.displaygroup_desc = getDisplaygroup_desc()>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setDisplaygroup_id(arguments.data.displaygroup_id)>
		<cfset setDisplaygroup_code(arguments.data.displaygroup_code)>
		<cfset setDisplaygroup_name(arguments.data.displaygroup_name)>
        <cfset setDisplaygroup_desc(arguments.data.displaygroup_desc)>
	</cffunction>

</cfcomponent>