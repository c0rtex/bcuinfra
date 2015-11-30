
<cfcomponent 
	displayname="security plugin" 
	extends="MachII.framework.Plugin" 
	output="false"
	hint="A simple security plugin.">

	<!---PROPERTIES--->
	
	<!---INITIALIZATION / CONFIGURATION--->
	<cffunction name="configure" access="public" returntype="void" output="false"hint="Configures the plugin.">
	</cffunction>
	
	<!---PUBLIC FUNCTIONS--->
	<cffunction name="preProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.preProcess()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preEvent" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.preEvent()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postEvent" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postEvent()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="preView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.preView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postView" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postView()<br /></cfoutput>
	</cffunction>
	
	<cffunction name="postProcess" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfoutput>&nbsp;SimplePlugin.postProcess()<br /></cfoutput>
	</cffunction>

	<cffunction name="onSessionStart" access="public" returntype="void" output="true">
		<!--- There is no access to the eventContext since sessions start asynchronously 
				from the Mach-II request life cycle--->
	</cffunction>
	
	<cffunction name="onSessionEnd" access="public" returntype="void" output="true">
		<cfargument name="sessionScope" type="struct" required="true"
			hint="The session scope is passed in since direct access to it is not available." />
		<!--- There is no access to the eventContext since sessions end asynchronously
			from the Mach-II request life cycle--->
	</cffunction>
	
	<cffunction name="handleException" access="public" returntype="void" output="true">
		<cfargument name="eventContext" type="MachII.framework.EventContext" required="true" />
		<cfargument name="exception" type="MachII.util.Exception" required="true" />
		<cfoutput>&nbsp;SimplePlugin.handleException()<br /></cfoutput>
	</cffunction>

	<!---ROTECTED FUNCTIONS--->

	<!---ACCESSORS--->

</cfcomponent>