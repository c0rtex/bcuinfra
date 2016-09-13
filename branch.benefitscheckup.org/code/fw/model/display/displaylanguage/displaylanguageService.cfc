<cfcomponent output="no" displayname="displaylanguageService" hint="I am a displaylanguage service.">

	<!--- Setters for dependency injections via ColdSpring CAN USE DPENDS TOO --->
	<cffunction name="setDisplaylanguageDAO" access="public" returntype="void" output="false">
		<cfargument name="displaylanguageDAO" type="any" required="yes">
		<cfset variables.displaylanguageDAO = arguments.displaylanguageDAO>
	</cffunction>
	<cffunction name="setDisplaylanguageGateway" access="public" returntype="void" output="false">
		<cfargument name="displaylanguageGateway" type="fw.model.display.displaylanguage.displaylanguageGateway" required="yes">
		<cfset variables.displaylanguageGateway = arguments.displaylanguageGateway>
	</cffunction>

	<cffunction name="getDisplaylanguage" access="public" returntype="fw.model.display.displaylanguage.displaylanguage" output="false">
		<cfargument name="display_id" type="numeric" required="no" default="0">
        <cfargument name="language_id" type="string" required="no" default="EN">
		<cfset var displaylanguage = "">
		<cfif arguments.display_id neq 0>
			<cfset displaylanguage = variables.displaylanguageDAO.read(arguments.display_id,arguments.language_id)>
		<cfelse>
			<cfset displaylanguage = createObject("component", "fw.model.display.displaylanguage.displaylanguage").init()>
		</cfif>
		<cfreturn displaylanguage>
	</cffunction>
	<cffunction name="getDisplaylanguageTO" access="public" returntype="struct" output="false">
		<cfargument name="display_id" type="numeric" required="no" default="0">
        <cfargument name="language_id" type="string" required="no" default="EN">
		<cfset var displaylanguage = getDisplaylanguage(arguments.display_id,arguments.language_id)>
		<cfset var displaylanguageTO = displaylanguage.getInstanceMemento()>
		<cfreturn displaylanguageTO>
	</cffunction>
	<cffunction name="saveDisplaylanguage" access="public" returntype="void" output="false">
		<cfargument name="displaylanguage" _type="fw.model.display.displaylanguage.displaylanguage" required="yes">
		<cfset variables.displaylanguageDAO.save(arguments.displaylanguage)>
	</cffunction>
	<cffunction name="getDisplaylanguages" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="any" default="">
		<cfset var dipsplaylanguages = "">
		<cfif isStruct(args)>
			<cfset displaylanguages = variables.displaylanguageGateway.getDisplaylanguages(argumentcollection=arguments.args)>
		<cfelse>
			<cfset displaylanguages = variables.displaylanguageGateway.getDisplaylanguages()>
		</cfif>
		<cfreturn displaylanguages>
	</cffunction>
    <cffunction name="getDistinctLanguages" access="public" returntype="array" output="no">
    	<cfargument name="display_id" required="no" type="numeric" default="0">    	
		<cfreturn variables.displaylanguageGateway.getDistinctLanguages(arguments.display_id) />
    </cffunction>

</cfcomponent>