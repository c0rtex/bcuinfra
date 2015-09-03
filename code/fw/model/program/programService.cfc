<cfcomponent output="false" displayname="programService" hint="I am a program service." depends="programCategoryService,DisplayService">


	<!--- Setters for dependency injections via ColdSpring CAN USE DPENDS TOO --->
	<!--- <cffunction name="setProgramCategoryDAO" access="public" returntype="void" output="false">
		<cfargument name="programCategoryDAO" type="any" required="yes">
		<cfset variables.programCategoryDAO = arguments.programCategoryDAO>
	</cffunction> --->
	<cffunction name="setProgramGateway" access="public" returntype="void" output="false">
		<cfargument name="programGateway" type="fw.model.program.programGateway" required="yes">
		<cfset variables.programGateway = arguments.programGateway>
	</cffunction>
    <cffunction name="setProgramDAO" access="public" returntype="void" output="false">
		<cfargument name="programDAO" type="fw.model.program.programDAO" required="yes">
		<cfset variables.programDAO = arguments.programDAO>
	</cffunction>		
	<cffunction name="setProgramCategoryService" access="public" returntype="void" output="false">
		<cfargument name="programCategoryService" type="fw.model.program.programCategory.programCategoryService" required="yes">
		<cfset variables.programCategoryService = arguments.programCategoryService>
	</cffunction>
    <cffunction name="setDisplayService" access="public" returntype="void" output="false">
		<cfargument name="displayService" type="fw.model.display.displayService" required="yes">
		<cfset variables.displayService = arguments.displayService>
	</cffunction>

	<cffunction name="getProgram" access="public" returntype="fw.model.program.program" output="false">
		<cfargument name="program_id" type="numeric" required="no" default="0">
		<cfset var program = "">
		<cfset var i = 0>
		<!--- <cfset user = variables.userDAO.read(arguments.user_id)> --->
		<cfif arguments.program_id neq 0>
			<cfset program = variables.programDAO.read(arguments.program_id)>
            
            <!--- Getting category object by programs category id and setting it t the program --->
           	<cfset category = variables.programCategoryService.getProgramcategory(program.getProgramCategory_id())>
            <cfset program.setProgramCategory(category)>
            <!--- Getting display object by programs name display id and setting it t the program --->
            <cfset displayName = variables.displayService.getDisplay(program.getName_display_id())>
            <cfset program.setDisplayName(displayName)>
            <!--- Getting display object by programs desc display id and setting it t the program --->
            <cfset displayDesc = variables.displayService.getDisplay(program.getDesc_display_id())>
            <cfset program.setDisplayDesc(displayDesc)>
		<cfelse>
			<cfset program = createObject("component", "fw.model.program.program").init()>
		</cfif>
		<cfreturn program>
	</cffunction>
    
	<cffunction name="getProgramTO" access="public" returntype="struct" output="false">
		<cfargument name="program_id" type="numeric" required="no" default="0">
		<cfset var program = getProgram(arguments.program_id)>
		<cfset var programTO = user.getInstanceMemento()>
		<cfreturn programTO>
	</cffunction>
    
	<cffunction name="saveProgram" access="public" returntype="void" output="false">
		<cfargument name="program" type="fw.model.program.program" required="yes">
		<cfset variables.programDAO.save(arguments.program)>
	</cffunction>
    
	<cffunction name="getPrograms" access="public" returntype="query" output="false">
		<cfargument name="args" required="no" type="any" default="">
		<cfset var programs = "">
		<cfif isStruct(args)>
			<cfset programs = variables.programGateway.getPrograms(argumentcollection=arguments.args)>
		<cfelse>
			<cfset programs = variables.programGateway.getPrograms()>
		</cfif>
		<cfreturn programs>
		<!--- <cfreturn variables.userGateway.getusers(argumentcollection=arguments.args)> --->
	</cffunction>
	<cffunction name="getProgramsJSON" access="remote" returntype="query">
    	<cfargument name="args" required="yes" type="any" default="">
		<cfset programs = variables.programGateway.getProgramsJSON(argumentcollection=arguments)>
		<cfreturn programs />
    </cffunction>

</cfcomponent>