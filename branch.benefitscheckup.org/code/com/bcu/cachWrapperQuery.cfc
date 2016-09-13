<cfcomponent displayname="Cache Wrapper Query" hint="I cache the wrappers query seeming in a application scope which isnt caching really.">
	
    
    <cffunction name="init" access="public" returntype="any">
		<cfargument name="name" type="string" required="no" default="bcuWrapperQuery">
        <cfargument name="partnerId" type="numeric" required="no">
		<cfscript>
			setName(arguments.name);
			setPartnerId(arguments.partnerId);
		</cfscript>
        
		<cfreturn this />
	</cffunction>
    
    <cffunction name="cacheAllWrappers" access="public" returntype="void">
    	<cfset allWrappers = getWrappers() />
    </cffunction>
    
    <cffunction name="getWrappers" output="no" returntype="query">
    	<cfargument name="partnerId" required="yes">
    	<cfset qVar = ''>
        <cfquery name="qVar" datasource="#application.dbSrc#">
        	select *
            from wrapper w left join tbl_partner p
                on w.wrapper_id=p.wrapper_id
            order by p.partner_id
        </cfquery>
        <cfreturn qVar />
    </cffunction>
    
    <cfset whash = "w#attributes.partner_id#">
	<!--- If var doesn't exist, initialize structure --->
    <cfif not IsDefined("application.#attributes.name#")>
        <cfset "application.#attributes.name#" = StructNew()>
        <cfset "application.#attributes.name#.lastRefresh" = Now()>
        <cfset "application.#attributes.name#.null" = StructNew()>
        <cfset "application.#attributes.name#.null.RecordCount" = 0>
        <cfquery name="wvars" datasource="#application.dbSrc#">
            select *
            from wrapper w left join tbl_partner p
                on w.wrapper_id=p.wrapper_id
            order by p.partner_id
        </cfquery>
        <cfloop query="wvars">
            <cfset localhash = "w#partner_id#">
            <cfif not StructKeyExists(Evaluate("application.#attributes.name#"), localhash)>
                <cfset "application.#attributes.name#.#localhash#" = StructNew()>
                <cfset StructInsert(Evaluate("application.#attributes.name#.#localhash#"), 'RecordCount', 1)>
                <cfloop list="#wvars.ColumnList#" index="x">
                    <cfif not StructKeyExists(Evaluate("application.#attributes.name#.#localhash#"), LCase(x))>
                        <cfset StructInsert(Evaluate("application.#attributes.name#.#localhash#"), LCase(x), Evaluate("wvars.#x#"))>
                    </cfif>
                </cfloop>
            <cfelse>
                <cfset StructUpdate(Evaluate("application.#attributes.name#.#localhash#"), 'RecordCount', StructFind(Evaluate("application.#attributes.name#.#localhash#"), 'RecordCount') + 1)>
            </cfif>
        </cfloop>
    </cfif>
    
    <cfif StructKeyExists(Evaluate("application.#attributes.name#"), whash)>
        <cfset "caller.#attributes.query#" = StructCopy(Evaluate("application.#attributes.name#.#whash#"))>
    <cfelseif StructKeyExists(Evaluate("application.#attributes.name#"), 'w')>
        <cfset "caller.#attributes.query#" = StructCopy(Evaluate("application.#attributes.name#.w"))>
    <cfelse>
        <cfset "caller.#attributes.query#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
    </cfif>
    
    <!--- GETTERS AND SETTERS --->
    <cffunction name="setPartnerId" output="no" returntype="any">
    	<cfargument name="partnerId" required="yes">
		<cfset variables.parnter_id = arguments.partnerId>
    </cffunction>
    <cffunction name="getPartnerId" output="no" returntype="any">
    	<cfreturn variables.partner_id />
    </cffunction>
    <cffunction name="setName" output="no" returntype="any">
    	<cfargument name="name" required="yes">
		<cfset variables.name = arguments.name>
    </cffunction>
    <cffunction name="getName" output="no" returntype="any">
    	<cfreturn variables.name />
    </cffunction>
    
    <cffunction name="getVars" output="no" returntype="query">
    	<cfargument name="partnerId" required="yes">
    	<cfset qVar = ''>
        <cfquery name="qVar" datasource="#application.dbSrc#">
        	select *
            from wrapper w left join tbl_partner p
                on w.wrapper_id=p.wrapper_id
            order by p.partner_id
        </cfquery>
        <cfreturn qVar />
    </cffunction>
</cfcomponent>