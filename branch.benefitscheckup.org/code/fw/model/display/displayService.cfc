<cfcomponent output="no" displayname="displayService" hint="I am a display service.">

	<!--- Setters for dependency injections via ColdSpring CAN USE DPENDS TOO --->
	<cffunction name="setDisplayDAO" access="public" returntype="void" output="false">
		<cfargument name="displayDAO" type="any" required="yes">
		<cfset variables.displayDAO = arguments.displayDAO>
	</cffunction>
	<cffunction name="setDisplayGateway" access="public" returntype="void" output="false">
		<cfargument name="displayGateway" type="fw.model.display.displayGateway" required="yes">
		<cfset variables.displayGateway = arguments.displayGateway>
	</cffunction>	
	<cffunction name="setDisplayLanguageService" access="public" returntype="void" output="false">
		<cfargument name="displaylanguageService" type="fw.model.display.displaylanguage.displaylanguageService" required="yes">
		<cfset variables.displaylanguageService = arguments.displaylanguageService>
	</cffunction>
	<cffunction name="setDisplaygroupService" access="public" returntype="void" output="false">
		<cfargument name="displaygroupService" type="fw.model.display.displaygroup.displaygroupService" required="yes">
		<cfset variables.displaygroupService = arguments.displaygroupService>
	</cffunction>

	<cffunction name="getDisplay" access="public" returntype="fw.model.display.display" output="false">
		<cfargument name="display_id" type="numeric" required="no" default="0">
		<cfset var display = "">
        <cfset var displaylanguages = 0>
        <cfset DistinctLanguages = arrayNew(1)>
        <cfset var i = 0>
		<cfif arguments.display_id neq 0>
			<cfset display = variables.displayDAO.read(arguments.display_id)>
            <cfset displaylanguages  = display.getDisplaylanguages()>
            <cfset DistinctLanguages = variables.displaylanguageService.getDistinctLanguages(arguments.display_id)>
            <cfloop from="1" to="#arrayLen(DistinctLanguages)#" index="i">
				<cfset displaylanguages[i] = variables.displaylanguageService.getDisplaylanguage(arguments.display_id,distinctLanguages[i])>
            </cfloop>
            <cfset display.setDisplaylanguages(displaylanguages)>
		<cfelse>
			<cfset display = createObject("component", "fw.model.display.display").init()>
		</cfif>
		<cfreturn display>
	</cffunction>
	<cffunction name="getDisplayTO" access="public" returntype="struct" output="false">
		<cfargument name="display_id" type="numeric" required="no" default="0">
		<cfset var display = getDisplay(arguments.display_id)>
		<cfset var displayTO = display.getInstanceMemento()>
		<cfreturn displayTO>
	</cffunction>
	<cffunction name="saveDisplay" access="public" returntype="void" output="false">
		<cfargument name="display" _type="fw.model.display.display" required="yes">
		<cfset variables.displayDAO.save(arguments.display)>
	</cffunction>
	<cffunction name="getDisplays" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="any" default="">
		<cfset var dipsplays = "">
		<cfif isStruct(args)>
			<cfset displays = variables.displayGateway.getDisplays(argumentcollection=arguments.args)>
		<cfelse>
			<cfset displays = variables.displayGateway.getDisplays()>
		</cfif>
		<cfreturn displays>
	</cffunction>

</cfcomponent>