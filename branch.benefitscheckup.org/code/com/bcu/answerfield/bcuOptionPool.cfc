<cfcomponent>
	<cffunction name="init" access="public" returntype="any">
		<cfset variables.instance.options = StructNew()>
		<cfset variables.instance.options.lastRefresh = Now()>
		<cfset variables.instance.options.o = StructNew()>
		<cfset variables.instance.options.sort = StructNew()>
		<cfset qOptions = getOptionsAsQuery()>
        <cfset qOsOptions = getOsOptionsAsQuery()>
        <cfset setOptions(qOptions,qOsOptions)>
		<cfreturn this />
	</cffunction>
    <cffunction name="setOptions" access="public" returntype="void">
    	<cfargument name="qOptions" required="yes" type="query">
        <cfargument name="qOsOptions" required="yes" type="query">
        <cfloop query="qOptions">
			<cfif Not IsDefined("variables.instance.options.o.#option_code#")>
                <cfset "variables.instance.options.o.#option_code#" = StructNew()>
                <cfset "variables.instance.options.o.#option_code#.id" = option_id>
                <cfset "variables.instance.options.o.#option_code#.inc" = include_flag>
                <cfset "variables.instance.options.o.#option_code#.sp" = StructNew()>
                <cfset StructInsert(variables.instance.options.sort, option_id, option_code)>
            </cfif>
        </cfloop>
        <cfloop query="qOsOptions">
			<cfset "variables.instance.options.o.#option_code#.sp.s#subset_id#p#partner_id#" = include_flag>
        </cfloop>
    </cffunction>
    <cffunction name="getOptionsAsQuery" access="public" returntype="query">
    	<cfset ovars = "">
    	<cfquery name="ovars" datasource="#application.dbSrc#">
            select o.option_id, o.option_code, o.include_flag
            from `option` o
            order by o.option_id
        </cfquery>
        <cfreturn ovars />
    </cffunction>
    <cffunction name="getOsOptionsAsQuery" access="public" returntype="query">
    	<cfset ospvars = "">
    	<cfquery name="ospvars" datasource="#application.dbSrc#">
            select o.option_code, osp.subset_id, osp.partner_id, osp.include_flag
            from `option_subset_partner` osp, `option` o
            where osp.option_id=o.option_id
            order by osp.option_id, osp.subset_id, osp.partner_id
        </cfquery>
        <cfreturn ospvars />
    </cffunction>
	<!--- <cfcase value="getCodeByID">
		<cfif attributes.id gt 0 and StructKeyExists(Evaluate("application.#attributes.name#.sort"), attributes.id)>
			<cfset "caller.#attributes.var#" = StructFind(Evaluate("application.#attributes.name#.sort"), attributes.id)>
		<cfelse>
			<cfset "caller.#attributes.var#" = ''>
		</cfif>
	</cfcase> --->
    
    <cffunction name="getOption" access="public" returntype="struct">
    	<cfargument name="code" type="string" required="yes">
    	<cfif arguments.code neq '' and StructKeyExists(variables.instance.options.o, arguments.code)>
			<cfreturn StructCopy(Evaluate("variables.instance.options.o.#arguments.code#"))>
		<cfelse>
        	<cfreturn false>
        </cfif>
    </cffunction>
    <cffunction name="getOptions" access="public" returntype="struct">
		<cfreturn StructCopy(variables.instance.options)>
    </cffunction>
    <cffunction name="getOptionsById" access="public" returntype="any">
    	<cfargument name="id" type="numeric" required="yes">
        <cfif arguments.id gt 0 and StructKeyExists(variables.instance.options.sort, arguments.id)>
			<cfreturn StructFind(variables.instance.options.sort, arguments.id)>
		<cfelse>
			<cfreturn ''>
		</cfif>
    </cffunction>
</cfcomponent>