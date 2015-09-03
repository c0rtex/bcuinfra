<cfcomponent output="false" displayname="role" hint="I am a role.">

	<cfproperty name="usertype_id" type="numeric" default="0" required="false">
	<cfproperty name="usertype_code" type="string" default="" required="false">
	<cfproperty name="usertype_name" type="string" default="" required="false">
    <cfproperty name="usertype_desc" type="string" default="" required="false">

	<cfset variables.instance = structNew()>
	<cfset variables.instance.usertype_id = 0>
    <cfset variables.instance.usertype_code = "">
	<cfset variables.instance.usertype_name = "">
	<cfset variables.instance.usertype_desc = "">

	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="usertype_id" required="no" type="numeric" default="0">
		<cfargument name="usertype_code" required="no" type="string" default="">
		<cfargument name="usertype_name" required="no" type="string" default="">
        <cfargument name="usertype_desc" required="no" type="string" default="">
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getUsertype_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.usertype_id>
	</cffunction>
	<cffunction name="setUsertype_id" access="public" output="no" returntype="void">
		<cfargument name="usertype_id" required="yes" type="numeric">
		<cfset variables.instance.usertype_id = arguments.usertype_id>
	</cffunction>
	<cffunction name="getUsertype_code" access="public" output="no" returntype="string">
		<cfreturn variables.instance.usertype_code>
	</cffunction>
	<cffunction name="setUsertype_code" access="public" output="no" returntype="void">
		<cfargument name="usertype_code" required="yes" type="string">
		<cfset variables.instance.usertype_code = arguments.usertype_code>
	</cffunction>
	<cffunction name="getUsertype_name" access="public" output="no" returntype="string">
		<cfreturn variables.instance.usertype_name>
	</cffunction>
	<cffunction name="setUsertype_name" access="public" output="no" returntype="void">
		<cfargument name="usertype_name" required="yes" type="string">
		<cfset variables.instance.usertype_name = arguments.usertype_name>
	</cffunction>
    <cffunction name="getUsertype_desc" access="public" output="no" returntype="string">
		<cfreturn variables.instance.usertype_desc>
	</cffunction>
	<cffunction name="setUsertype_desc" access="public" output="no" returntype="void">
		<cfargument name="usertype_desc" required="yes" type="string">
		<cfset variables.instance.usertype_desc = arguments.usertype_desc>
	</cffunction>
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data.usertype_id = getUsertype_id()>
		<cfset data.usertype_code = getUsertype_code()>
		<cfset data.usertype_name = getUsertype_name()>
        <cfset data.usertype_desc = getUsertype_desc()>
		<cfreturn data>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setUsertype_id(arguments.data.usertype_id)>
		<cfset setUsertype_code(arguments.data.usertype_code)>
		<cfset setUsertype_name(arguments.data.usertype_name)>
        <cfset setUsertype_desc(arguments.data.usertype_desc)>
	</cffunction>

</cfcomponent>