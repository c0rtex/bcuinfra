<cfcomponent output="false" displayname="displaylanguage" hint="I am a displaylanguage object.">
	
    
    
    <cfproperty name="display_id" type="numeric" default="0" required="false">
	<cfproperty name="language_id" type="string" default="" required="false">
	<cfproperty name="display_text" type="string" default="" required="false">
    <cfproperty name="update_flag" type="boolean" default="" required="false">

	<cfset variables.instance = structNew()>
	<cfset variables.instance.display_id = 0>
    <cfset variables.instance.language_id = "">
	<cfset variables.instance.display_text = "">
	<cfset variables.instance.active_flag = "">
    
	<cffunction name="init" access="public" returntype="any" output="no">
		<cfargument name="display_id" required="no" type="numeric" default="0">
		<cfargument name="language_id" required="no" type="string" default="">
		<cfargument name="display_text" required="no" type="string" default="">
		<cfargument name="update_flag" required="no" type="boolean" default="0">
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
    
	<cffunction name="getLanguage_id" access="public" output="no" returntype="string">
		<cfreturn variables.instance.language_id>
	</cffunction>
	<cffunction name="setLanguage_id" access="public" output="no" returntype="void">
		<cfargument name="language_id" required="yes" type="string">
		<cfset variables.instance.language_id = arguments.language_id>
	</cffunction>
    
	<cffunction name="getDisplay_text" access="public" output="no" returntype="string">
		<cfreturn variables.instance.display_text>
	</cffunction>
	<cffunction name="setDisplay_text" access="public" output="no" returntype="void">
		<cfargument name="display_text" required="yes" type="string">
		<cfset variables.instance.display_text = arguments.display_text>
	</cffunction>
    
	<cffunction name="getUpdate_flag" access="public" output="no" returntype="boolean">
		<cfreturn variables.instance.update_flag>
	</cffunction>
	<cffunction name="setUpdate_flag" access="public" output="no" returntype="void">
		<cfargument name="update_flag" required="yes" type="boolean">
		<cfset variables.instance.update_flag = arguments.update_flag>
	</cffunction>
   
	<cffunction name="getInstanceMemento" access="public" returntype="struct" output="false">
		<cfset var data = structNew()>
		<cfset data.display_id = getDisplay_id()>
		<cfset data.language_id = getLanguage_id()>
		<cfset data.display_text = getDisplay_text()>
		<cfset data.update_flag = getUpdate_flag()>
	</cffunction>
	<cffunction name="setInstanceMemento" access="public" returntype="void" output="false">
		<cfargument name="data" type="struct" required="true">
		<cfset setDisplay_id(arguments.data.display_id)>
		<cfset setLanguage_id(arguments.data.language_id)>
		<cfset setDisplay_text(arguments.data.display_text)>
		<cfset setUpdate_flag(arguments.data.update_flag)>
	</cffunction>

</cfcomponent>