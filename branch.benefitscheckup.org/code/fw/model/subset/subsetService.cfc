<cfcomponent output="no" displayname="subsetService" hint="I am a subset service.">

	<!--- Setters for dependency injections via ColdSpring CAN USE DPENDS TOO --->
	<cffunction name="setSubsetDAO" access="public" returntype="void" output="false">
		<cfargument name="subsetDAO" type="any" required="yes">
		<cfset variables.subsetDAO = arguments.subsetDAO>
	</cffunction>
	<cffunction name="setSubsetGateway" access="public" returntype="void" output="false">
		<cfargument name="subsetGateway" type="fw.model.subset.subsetGateway" required="yes">
		<cfset variables.subsetGateway = arguments.subsetGateway>
	</cffunction>	
    <cffunction name="setDisplayService" access="public" returntype="void" output="false">
		<cfargument name="displayService" type="fw.model.display.displayService" required="yes">
		<cfset variables.displayService = arguments.displayService>
	</cffunction>

	<cffunction name="getSubset" access="public" returntype="fw.model.subset.subset" output="false">
		<cfargument name="subset_id" type="numeric" required="no" default="0">
		<cfset var subset = "">
		<cfif arguments.subset_id neq 0>
			<cfset subset = variables.subsetDAO.read(arguments.subset_id)>
            
            <!--- Getting display object by subsets display id and setting it to the program --->
            <cfset display = variables.displayService.getDisplay(subset.getDisplay_id())>
            <cfset subset.setDisplay(display)>
            <!--- Getting display object by subsets alt display id and setting it to the program --->
            <cfset displayAlt = variables.displayService.getDisplay(subset.getAlt_display_id())>
            <cfset subset.setDisplayAlt(displayAlt)>
            <!--- Getting display object by subsets spq id and setting it to the program --->
            <cfset displaySpq = variables.displayService.getDisplay(subset.getSpq_display_id())>
            <cfset subset.setDisplaySpq(displaySpq)>
            <!--- Getting display object by subsetsintro display id and setting it to the program --->
            <cfset displayIntro = variables.displayService.getDisplay(subset.getIntro_display_id())>
            <cfset subset.setDisplayIntro(displayIntro)>
		<cfelse>
			<cfset subset = createObject("component", "fw.model.subset.subset").init()>
		</cfif>
		<cfreturn subset>
	</cffunction>
	<cffunction name="getSubsetTO" access="public" returntype="struct" output="false">
		<cfargument name="subset_id" type="numeric" required="no" default="0">
		<cfset var subset = getSubset(arguments.subset_id)>
		<cfset var subsetTO = subset.getInstanceMemento()>
		<cfreturn subsetTO>
	</cffunction>
	<cffunction name="saveSubset" access="public" returntype="void" output="false">
		<cfargument name="subset" _type="fw.model.subset.subset" required="yes">
		<cfset variables.subsetDAO.save(arguments.subset)>
	</cffunction>
	<cffunction name="getSubsets" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="any" default="">
		<cfset var subsets = "">
		<cfif isStruct(args)>
			<cfset subsets = variables.subsetGateway.getSubsets(argumentcollection=arguments.args)>
		<cfelse>
			<cfset subsets = variables.subsetGateway.getSubsets()>
		</cfif>
		<cfreturn subsets>
	</cffunction>

</cfcomponent>