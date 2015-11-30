<cfcomponent output="false" displayname="display" hint="I am a display object.">

	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="display_id" required="no" type="numeric" default="0">
		<cfargument name="displaygroup_id" required="no" type="numeric" default="0">
		<cfargument name="display_code" required="no" type="string" default="">
		<cfargument name="display_name" required="no" type="string" default="">
        <cfargument name="display_desc" required="no" type="string" default="">
		<cfargument name="active_flag" required="no" type="boolean" default="0">
        
        <!--- injected objects --->
		<cfargument name="displayLanguages" required="no" type="array" default="#arrayNew(1)#">
        <cfargument name="displayGroup" required="no" type="fw.model.display.displaygroup.displaygroup" default="#createObject("component", "fw.model.display.displaygroup.displaygroup")#">
		<cfset setInstanceMemento(arguments)>
		<cfreturn this />
	</cffunction>

	<cffunction name="getDisplay_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.display_id>
	</cffunction>
	<cffunction name="setDisplay_id" access="public" output="no" returntype="void">
		<cfargument name="display_id" required="yes" type="numeric">
		<cfset variables.instance.display_id = arguments.display_id>
	</cffunction>
	<cffunction name="getDisplaygroup_id" access="public" output="no" returntype="numeric">
		<cfreturn variables.instance.displaygroup_id>
	</cffunction>
	<cffunction name="setDisplaygroup_id" access="public" output="no" returntype="void">
		<cfargument name="displaygroup_id" required="yes" type="numeric">
		<cfset variables.instance.displaygroup_id = arguments.displaygroup_id>
	</cffunction>
	<cffunction name="getDisplay_code" access="public" output="no" returntype="string">
		<cfreturn variables.instance.display_code>
	</cffunction>
	<cffunction name="setDisplay_code" access="public" output="no" returntype="void">
		<cfargument name="display_code" required="yes" type="string">
		<cfset variables.instance.display_code = arguments.display_code>
	</cffunction>
	<cffunction name="getDisplay_name" access="public" output="no" returntype="string">
		<cfreturn variables.instance.display_name>
	</cffunction>
	<cffunction name="setDisplay_name" access="public" output="no" returntype="void">
		<cfargument name="display_name" required="yes" type="string">
		<cfset variables.instance.display_name = arguments.display_name>
	</cffunction>
    <cffunction name="getDisplay_desc" access="public" output="no" returntype="string">
		<cfreturn variables.instance.display_desc>
	</cffunction>
	<cffunction name="setDisplay_desc" access="public" output="no" returntype="void">
		<cfargument name="display_desc" required="yes" type="string">
		<cfset variables.instance.display_desc = arguments.display_desc>
	</cffunction>
	<cffunction name="getActive_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.active_flag>
	</cffunction>
	<cffunction name="setActive_flag" access="public" output="no" returntype="void">
		<cfargument name="active_flag" required="yes" type="boolean">
		<cfset variables.instance.active_flag = arguments.active_flag>
	</cffunction>
    
    <!--- <cffunction name="getDisplayLanguage" access="public" output="no" returntype="fw.model.display.displaylanguage.displaylanguage">
		<cfreturn variables.instance.displayLanguage>
	</cffunction>
	<cffunction name="setDisplayLanguage" access="public" output="no" returntype="void">
		<cfargument name="displayLanguage" required="yes" type="fw.model.display.displaylanguage.displaylanguage">
		<cfset variables.instance.displayLanguage = arguments.displayLanguage>
	</cffunction> --->
    
    <cffunction name="getDisplayGroup" access="public" output="no" returntype="fw.model.display.displaygroup.displaygroup">
		<cfreturn variables.instance.displaygroup>
	</cffunction>
	<cffunction name="setDisplayGroup" access="public" output="no" returntype="void">
		<cfargument name="displaygroup" required="yes" type="fw.model.display.displaygroup.displaygroup">
		<cfset variables.instance.displaygroup = arguments.displaygroup>
	</cffunction>
    
    <cffunction name="getDisplaylanguages" access="public" output="no" returntype="array">
		<cfreturn variables.instance.displaylanguages>
	</cffunction>
	<cffunction name="setDisplaylanguages" access="public" output="no" returntype="void">
		<cfargument name="displaylanguages" required="yes" type="array">
		<cfset variables.instance.displaylanguages = arguments.displaylanguages>
	</cffunction>
	<cffunction name="addDisplaylanguage" access="public" output="no" returntype="void">
		<cfargument name="displaylanguage" type="fw.model.display.displaylanguage.displaylanguage" required="true">
		<cfset arrayAppend(variables.instance.displaylanguages, arguments.displaylanguage)>
	</cffunction>
	<cffunction name="hasDisplaylanguage" access="public" output="no" returntype="boolean">
		<cfargument name="language_id" required="yes" type="string">
		<cfset var i = 0>
		<cfloop from="1" to="#arrayLen(variables.instance.displaylanguages)#" index="i">
			<cfif variables.instance.displaylanguages[i].getLanguage_id() eq arguments.language_id>
				<cfreturn true>
			</cfif>
		</cfloop>
		<cfreturn false>
	</cffunction> 
    <cffunction name="clearLanguages" access="public" output="no" returntype="void">
        <cfset arrayClear(getDisplaylanguages())>
    </cffunction>
   
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
        <cfset var displayLanguages = getDisplayLanguages()>
		<cfset var i = 0>
		<cfset data.display_id = getDisplay_id()>
		<cfset data.displaygroup_id = getDisplaygroup_id()>
		<cfset data.display_code = getDisplay_code()>
		<cfset data.display_name = getDisplay_name()>
        <cfset data.display_desc = getDisplay_desc()>
		<cfset data.active_flag = getActive_flag()>
        <cfset data.displaygroup = getDisplaygroup()>
        <cfset data.displayLanguages = arrayNew(1)>
		<cfloop from="1" to="#arrayLen(displayLanguages)#" index="i">
			<cfset arrayAppend(data.displayLanguages, displayLanguages[i].getInstanceMemento())>
		</cfloop>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setDisplay_id(arguments.data.display_id)>
		<cfset setDisplaygroup_id(arguments.data.displaygroup_id)>
		<cfset setDisplay_code(arguments.data.display_code)>
		<cfset setDisplay_name(arguments.data.display_name)>
        <cfset setDisplay_desc(arguments.data.display_desc)>
		<cfset setActive_flag(arguments.data.active_flag)>
        <cfset setDisplayLanguages(arguments.data.displayLanguages)>
        <cfset setDisplaygroup(arguments.data.displaygroup)>
	</cffunction>

</cfcomponent>