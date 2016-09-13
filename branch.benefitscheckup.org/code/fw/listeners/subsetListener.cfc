<cfcomponent output="false" extends="MachII.framework.Listener" 
	displayname="subsetListener" hint="I am a subset listener."
	depends="SubsetService">

	<cffunction name="configure" access="public" returntype="void" output="false">
		<cfset variables.serviceFactory = getProperty("serviceFactory")>
		<!--- REMOTE SERVICES NOT USED YET
		<cfset variables.remoteUserService = serviceFactory.getBean("userService_remote")> 
		--->
	</cffunction>

	<!--- Because of the new  "depends" attribute in Mach II 1.6 I don't need these anymore
	<cffunction name="setSubsetService" access="public" returntype="void" output="false">
		<cfargument name="userService" type="fw.model.subset.subsetService" required="true">
		<cfset variables.subsetService = arguments.subsetService>
	</cffunction>
	--->

	<cffunction name="saveUser" access="public" returntype="void" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
        <cfif arguments.event.isArgDefined("subset_id")>
        	<cfset var newID = arguments.event.getArg("subset_id")>
        <cfelse>
        	<cfset var newID = 0>
        </cfif>
        
		<cfset var subset = variables.subsetService.getSubset(newID)>
        		
		<cfset user.setsubsettype_id(event.getArg("subsettype_id"))>
		<cfset user.setCode(event.getArg("code"))>
		<cfset user.setDescription(event.getArg("description"))>
        <cfset user.setDisplay_id(event.getArg("display_id"))>
		<cfset user.setAltDisplay_id(event.getArg("alt_display_id"))>
        <cfset user.setSpq_display_id(event.getArg("spq_display_id"))>
        <cfset user.setOe_name(event.getArg("oe_name"))>
        
        <cfset user.setIntro_display_id(event.getArg("intro_display_id"))>
        <cfset user.setResultpage_id(event.getArg("resultpage_id"))>
        <cfset user.setShadow_subset_id(event.getArg("shadow_subset_id"))>
        <cfset user.setBranding_partner_id(event.getArg("branding_partner_id"))>
        <cfset user.setActive_flag(event.getArg("active_flag"))>
        <cfset user.setTest_flag(event.getArg("test_flag"))>
        <cfset user.setEform_flag(event.getArg("eform_flag"))>
        <cfset user.setReport_flag(event.getArg("report_flag"))>
        <cfset user.setCreate_user_id(event.getArg("create_user_id"))>
        <cfset user.setCreate_date(event.getArg("create_date"))>
        <cfset user.setModify_user_id(event.getArg("modify_user_id"))>
        <cfset user.setModify_date(event.getArg("modify_date"))>
       
		<cfset variables.subsetService.saveSubset(subset)>
	</cffunction>

	<cffunction name="getSubset" access="public" _returntype="fw.model.subset.subset" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.subsetService.getSubset(event.getArg("subset_id"))>
	</cffunction>

	<cffunction name="getSubsets" access="public" returntype="query" output="false">
		<cfargument name="event" type="MachII.framework.Event" required="yes">
		<cfreturn variables.subsetService.getSubsets(arguments.event.getArgs())>
	</cffunction>
	
</cfcomponent>