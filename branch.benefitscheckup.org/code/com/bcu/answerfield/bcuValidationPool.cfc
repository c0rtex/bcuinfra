<cfcomponent>
	<cffunction name="init" access="public" returntype="any">
		<cfset variables.instance = StructNew()>
		<cfset variables.instance.lastRefresh = Now()>
		<cfset variables.instance.v = StructNew()>
		<cfset variables.instance.sort = StructNew()>
        
        <cfset variables.instance.null = StructNew()>
		<cfset variables.instance.null.exists = false>
		<cfset variables.instance.null.id = ''>
		<cfset variables.instance.null.formula = ''>
		<cfset variables.instance.null.msg = ''>
        
        <cfset qValidations = getValidationsAsQuery()>
        <cfset setValidations(qValidations)>
		<cfreturn this />
	</cffunction>
    <cffunction name="getValidationsAsQuery" access="public" returntype="query">
    	<cfset qValidations = "">
    	<cfquery name="qValidations" datasource="#application.dbSrc#">
            SELECT v.validation_id, v.validation_code, v.formula, d.display_code
            FROM validation v, display d
            WHERE v.display_id=d.display_id
            ORDER bY validation_code
        </cfquery>
        <cfreturn qValidations />
    </cffunction>
    <cffunction name="setValidations" access="private" returntype="void">
    	<cfargument name="qValidations" required="yes" type="query">
    	<cfset vCount = 0>
        <cfloop query="arguments.qValidations">
            <cfset vCount = vCount + 1>
            <cfif Not IsDefined("variables.instance.v.#validation_code#")>
                <cfset "variables.instance.v.#validation_code#" = StructNew()>
                <cfset "variables.instance.v.#validation_code#.exists" = true>
                <cfset "variables.instance.v.#validation_code#.id" = validation_id>
                <cfset "variables.instance.v.#validation_code#.formula" = formula>
                <cfset "variables.instance.v.#validation_code#.msg" = display_code>
                <cfset StructInsert(variables.instance.sort, vCount, validation_code)>
            </cfif>
        </cfloop>
    </cffunction>
    <cffunction name="getValidation" returntype="struct" access="public">
    	<cfargument name="code" type="string" required="yes">
    	<cfif arguments.code neq '' and StructKeyExists(variables.instance.v, arguments.code)>
			<cfreturn Evaluate("variables.instance.v.#arguments.code#") />
		<cfelse>
			<cfreturn StructCopy(variables.instance.null) />
		</cfif>
    </cffunction> 
    <cffunction name="getValidations" returntype="struct" access="public">
    	<cfreturn variables.instance.v />
    </cffunction>
</cfcomponent>