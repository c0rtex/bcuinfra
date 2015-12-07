<cfcomponent output="false" displayname="program categories" hint="I am a program category object.">

	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="programcategory_id" required="no" type="numeric" default="0">
        <cfargument name="display_id" required="no" type="numeric" default="0">
        <cfargument name="code" required="no" type="string" default="">
        <cfargument name="description" required="no" type="string" default="">
		<cfargument name="legacy_code" required="no" type="string" default="">
        <cfargument name="sort" required="no" type="numeric" default="0">
        
        
		<!--- <cfargument name="address" required="no" type="fw.model.address.address" default="#createObject("component", "fw.model.address.address").init()#"> --->
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getProgramcategory_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.programcategory_id>
	</cffunction>
	<cffunction name="setProgramcategory_id" access="public" output="no" returntype="void">
		<cfargument name="programcategory_id" required="yes" type="numeric">
		<cfset variables.instance.programcategory_id = arguments.programcategory_id>
	</cffunction>
	<cffunction name="getDisplay_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.display_id>
	</cffunction>
	<cffunction name="setDisplay_id" access="public" output="no" returntype="void">
		<cfargument name="display_id" required="yes" type="numeric">
		<cfset variables.instance.display_id = arguments.display_id>
	</cffunction>
	<cffunction name="getCode" access="public" output="no" returntype="string">
		<cfreturn variables.instance.code>
	</cffunction>
	<cffunction name="setCode" access="public" output="no" returntype="void">
		<cfargument name="code" required="yes" type="string">
		<cfset variables.instance.code = arguments.code>
	</cffunction>
	<cffunction name="getDescription" access="public" output="no" returntype="string">
		<cfreturn variables.instance.description>
	</cffunction>
	<cffunction name="setDescription" access="public" output="no" returntype="void">
		<cfargument name="description" required="yes" type="string">
		<cfset variables.instance.description = arguments.description>
	</cffunction>
	<cffunction name="getLegacy_code" access="public" output="no" returntype="string">
		<cfreturn variables.instance.legacy_code>
	</cffunction>
	<cffunction name="setLegacy_code" access="public" output="no" returntype="void">
		<cfargument name="legacy_code" required="yes" type="string">
		<cfset variables.instance.legacy_code = arguments.legacy_code>
	</cffunction>
	<cffunction name="getSort" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.sort>
	</cffunction>
	<cffunction name="setSort" access="public" output="no" returntype="void">
		<cfargument name="sort" required="yes" type="numeric">
		<cfset variables.instance.sort = arguments.sort>
	</cffunction>
    
    <!---
	<cffunction name="addRole" access="public" output="no" returntype="void">
		<cfargument name="role" type="fw.model.user.role.role" required="true">
		<cfset arrayAppend(variables.instance.roles, arguments.role)>
	</cffunction>
	<cffunction name="hasRole" access="public" output="no" returntype="boolean">
		<cfargument name="roleName" required="yes" type="string">
		<cfset var i = 0>
		<cfloop from="1" to="#arrayLen(variables.instance.roles)#" index="i">
			<cfif variables.instance.roles[i].getName() eq arguments.roleName>
				<cfreturn true>
			</cfif>
		</cfloop>
		<cfreturn false>
	</cffunction> 
    <cffunction name="clearRole" access="public" output="no" returntype="void">
        	<cfset arrayClear(getRoles())>
    </cffunction>
    --->
    
    
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data.programcategory_id = getProgramcategory_id()>
		<cfset data.display_id = getDisplay_id()>
		<cfset data.code = getCode()>
		<cfset data.description = getDescription()>
		<cfset data.legacy_code = getLegacy_code()>
		<cfset data.sort = getSort()>
		<cfreturn data>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
        <cfset setProgramcategory_id(arguments.data.programcategory_id)>
		<cfset setDisplay_id(arguments.data.display_id)>
        <cfset setDescription(arguments.data.description)>
		<cfset setCode(arguments.data.code)>
		<cfset setLegacy_code(arguments.data.legacy_code)>
		<cfset setSort(arguments.data.sort)>
	</cffunction>

</cfcomponent>