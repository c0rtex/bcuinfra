<cfcomponent name="remoteProgramService" 
			displayname="remoteProgramService:RemoteProxyBean" 
			hint="Abstract Base Class for Aop Based Remote Proxy Beans" 
			output="false">
			
	<cfset variables.proxyId = CreateUUId() />
	<cfset variables.beanFactoryName = "serviceFactory" />
	<cfset variables.beanFactoryScope = "" />
	<cfset variables.constructed = false />
	<cfset setup() />
	
	<cffunction name="setup" access="public" returntype="void">
		<cfset var bfUtils = 0 />
		<cfset var bf = 0 />
		<cfset var error = false />
		<cfset var remoteFactory = "" />
		
		<!--- I want to make sure that the proxy id really exists --->
		<cfif not StructKeyExists(variables, "proxyId")>
			<cfset variables.proxyId = CreateUUId() />
		</cfif>
		
		<cflock name="RemoteProxyBean.#variables.proxyId#.Setup" type="readonly" timeout="5">
			<cfif not StructKeyExists(variables, "constructed") or not variables.constructed>
			
				<!--- it looks like there is an issue with setting up the variables scope in a static initializer
					  with remote methods, so we will make sure things are set up --->
				<cfif not StructKeyExists(variables, "constructed")>
					<cfset variables.beanFactoryName = "serviceFactory" />
					<cfset variables.beanFactoryScope = "" />
					<cfset variables.constructed = false />
				</cfif>
				<!--- make sure scope is setup (could have been set to '', meaning application, default) --->
				<cfif not len(variables.beanFactoryScope)>
					<cfset variables.beanFactoryScope = 'application' />
				</cfif>
				<cftry>		
					<cfset bfUtils = createObject("component","coldspring.beans.util.BeanFactoryUtils").init()/>
					<cfif not len(variables.beanFactoryName)>
						<cfset bf = bfUtils.getDefaultFactory(variables.beanFactoryScope) />
					<cfelse>
						<cfset bf = bfUtils.getNamedFactory(variables.beanFactoryScope, variables.beanFactoryName) />
					</cfif>
					<cfset remoteFactory = bf.getBean("&programService_remote") />
					<cfset variables.target = bf.getBean("programService_remote") />
					<cfset variables.adviceChains = remoteFactory.getProxyAdviceChains() />
					<cfset variables.constructed = true />
					<cfcatch>
						<cfset error = true />
					</cfcatch>
				</cftry>
			</cfif>
		</cflock>
		
		<cfif error>
			<cfthrow type="coldspring.remoting.ApplicationContextError" 
					 message="Sorry, a ColdSpring BeanFactory named #variables.beanFactoryName# was not found in #variables.beanFactoryScope# scope. Please make sure your bean factory is properly loaded. Perhapse your main application is not running?" />
		</cfif>
		
	</cffunction>

	<cffunction name="callMethod" access="private" returntype="any">
		<cfargument name="methodName" type="string" required="true" />
		<cfargument name="args" type="struct" required="true" />
		<cfset var adviceChain = 0 />
		<cfset var methodInvocation = 0 />
		<cfset var rtn = 0 />
		<cfset var method = 0 />
		
		<!--- make sure setup is called --->
		<cfif not StructKeyExists(variables, "constructed") or not variables.constructed>
			<cfset setup() />
		</cfif>
		
		<!--- if an advice chain was created for this method, retrieve a methodInvocation chain from it and proceed --->
		<cfif StructKeyExists(variables.adviceChains, arguments.methodName)>
			<cfset method = CreateObject('component','coldspring.aop.Method').init(variables.target, arguments.methodName, arguments.args) />
			<cfset adviceChain = variables.adviceChains[arguments.methodName] />
			<cfset methodInvocation = adviceChain.getMethodInvocation(method, arguments.args, variables.target) />
			<cfreturn methodInvocation.proceed() />
		<cfelse>
			<!--- if there's no advice chains to execute, just call the method --->
			<cfinvoke component="#variables.target#"
					  method="#arguments.methodName#" 
					  argumentcollection="#arguments.args#" 
					  returnvariable="rtn">
			</cfinvoke>
			<cfif isDefined('rtn')>
				<cfreturn rtn />
			</cfif>
		</cfif>
		
	</cffunction>
			
	<cffunction name="setDisplayService" access="remote" returntype="any" output="false" > 
    	<cfargument name="displayService" type="fw.model.display.displayService" required="yes" /> 
    	<cfset var rtn = callMethod('setDisplayService', arguments) />
    </cffunction>

    <cffunction name="getProgramsJSON" access="remote" returnformat="json"> 
        <cfargument name="page" required="no" default="1" hint="Page user is on">
        <cfargument name="rows" required="no" default="10" hint="Number of Rows to display per page">       
        <cfargument name="sidx" required="no" default="" hint="Sort Column">
        <cfargument name="sord" required="no" default="ASC" hint="Sort Order">
        
        <cfset var qPrograms = callMethod('getProgramsJSON', arguments) />
        
        <cfsetting showdebugoutput="no"  />
        <cfset var start = ((arguments.page-1)*arguments.rows)+1>
		<cfset var end = (start-1) + arguments.rows>
        <cfset var i = 1>
        <cfloop query="qPrograms" startrow="#start#" endrow="#end#">	
            <cfset arrPrograms[i] = [#program_id#,#program_code#,#url#,#legacy_prg_id#,#create_date#]>
            <cfset i = i + 1>			
        </cfloop>
        <cfset totalPages = Ceiling(qPrograms.recordcount/arguments.rows)>
        <cfset stcReturn = {total=#totalPages#,page=#arguments.page#,records=#qPrograms.recordcount#,rows=arrPrograms}>
            
        <cfreturn stcReturn />
    </cffunction>

<cffunction name="setProgramGateway" access="remote" returntype="any" output="false" > 
<cfargument name="programGateway" type="fw.model.program.programGateway" required="yes" /> 
<cfset var rtn = callMethod('setProgramGateway', arguments) />
</cffunction>

<cffunction name="setProgramDAO" access="remote" returntype="any" output="false" > 
<cfargument name="programDAO" type="fw.model.program.programDAO" required="yes" /> 
<cfset var rtn = callMethod('setProgramDAO', arguments) />
</cffunction>

<cffunction name="getPrograms" access="remote" returntype="any" output="false" > 
<cfargument name="args" type="any" required="no" default="" /> 
<cfset var rtn = callMethod('getPrograms', arguments) />
<cfif isDefined('rtn')><cfreturn rtn /></cfif>
</cffunction>

<cffunction name="getProgramTO" access="remote" returntype="any" output="false" > 
<cfargument name="program_id" type="numeric" required="no" default="0" /> 
<cfset var rtn = callMethod('getProgramTO', arguments) />
<cfif isDefined('rtn')><cfreturn rtn /></cfif>
</cffunction>

<cffunction name="setProgramCategoryService" access="remote" returntype="any" output="false" > 
<cfargument name="programCategoryService" type="fw.model.program.programCategory.programCategoryService" required="yes" /> 
<cfset var rtn = callMethod('setProgramCategoryService', arguments) />
</cffunction>

<cffunction name="saveProgram" access="remote" returntype="any" output="false" > 
<cfargument name="program" type="fw.model.program.program" required="yes" /> 
<cfset var rtn = callMethod('saveProgram', arguments) />
</cffunction>

<cffunction name="getProgram" access="remote" returntype="any" output="false" > 
<cfargument name="program_id" type="numeric" required="no" default="0" /> 
<cfset var rtn = callMethod('getProgram', arguments) />
<cfif isDefined('rtn')><cfreturn rtn /></cfif>
</cffunction>


	
</cfcomponent>
