<cfsilent>
	<cfset variables.coldSpringWorks = false />
	<cfset variables.csProp = getProperty("coldSpringProperty")>
	<cfif IsStruct(variables.csProp)>
		<cfset variables.beanFactory = getProperty(variables.csProp.getParameter("beanFactoryPropertyName")) />
		<cfif IsStruct(variables.beanFactory) AND StructKeyExists(variables.beanFactory, "getBean" )>
			<cfset variables.coldSpringWorks = true />
		</cfif>
	</cfif>
    <cfset users = event.getArg("users")>
</cfsilent>
<cfoutput>
<cfif event.isArgDefined("errorMsg")>
	<div class="errorMessege">
    	#event.getArg("errorMsg")#
    </div>
</cfif>
</cfoutput>