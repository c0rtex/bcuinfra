<cfcomponent>

<!---
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.a" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null template obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.id" = ''>
	<cfset "application.#attributes.name#.null.type" = ''>
	<cfset "application.#attributes.name#.null.rx" = ''>
	<cfset "application.#attributes.name#.null.length" = ''>
	<cfset "application.#attributes.name#.null.req" = ''>
	<cfset "application.#attributes.name#.null.def" = ''>
	<cfset "application.#attributes.name#.null.spqdef" = ''>
	<cfset "application.#attributes.name#.null.oedef" = ''>
	<cfset "application.#attributes.name#.null.state_id" = ''>
	<cfset "application.#attributes.name#.null.rule" = ''>
	<cfset "application.#attributes.name#.null.valid" = ''>
	<cfset "application.#attributes.name#.null.sort" = ''>
	
	<cfif Not IsDefined("application.#attributes.name#.a.#answerfield#")>
		<cfset asort = asort + 1>
		<cfset "application.#attributes.name#.a.#answerfield#" = StructNew()>
		<cfset "application.#attributes.name#.a.#answerfield#.exists" = true>
		<cfset "application.#attributes.name#.a.#answerfield#.id" = answerfield_id>
		<cfset "application.#attributes.name#.a.#answerfield#.type" = code>
		<cfif ListFind('drug,generic,rxco', code)>
			<cfset "application.#attributes.name#.a.#answerfield#.rx" = true>
		<cfelse>
			<cfset "application.#attributes.name#.a.#answerfield#.rx" = false>
		</cfif>
		<cfset "application.#attributes.name#.a.#answerfield#.length" = max_length>
		<cfset "application.#attributes.name#.a.#answerfield#.req" = required_flag>
		<cfset "application.#attributes.name#.a.#answerfield#.def" = default_value>
		<cfset "application.#attributes.name#.a.#answerfield#.spqdef" = spq_default_value>
		<cfset "application.#attributes.name#.a.#answerfield#.oedef" = oe_default_value>
		<cfset "application.#attributes.name#.a.#answerfield#.state_id" = state_id>
		<cfset "application.#attributes.name#.a.#answerfield#.rule" = rule_code>
		<cfset "application.#attributes.name#.a.#answerfield#.valid" = validation_code>
		<cfset "application.#attributes.name#.a.#answerfield#.sp" = StructNew()>
		<cfset "application.#attributes.name#.a.#answerfield#.sort" = StructNew()>
		<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), asort, answerfield)>
	</cfif>
	<cfif option_code neq ''>
		<cfset StructInsert(Evaluate("application.#attributes.name#.a.#answerfield#.sort"), sort, option_code)>
	</cfif>
--->
	<cffunction name="init" access="public" returntype="any">
		<cfset variables.instance.answerfields = structNew()>
		<cfset variables.instance.answerfields.lastRefresh = Now()>
        <cfset variables.instance.answerfields.sort = StructNew()>
        
        <cfset qAnswerfields = getAnswerfieldVarsAsQuery()>
        <cfset setAnswerfields(qAnswerfields)>
        
        <cfset "variables.instance.answerfields.null" = StructNew()>
		<cfset "variables.instance.answerfields.null.exists" = false>
        <cfset "variables.instance.answerfields.null.id" = ''>
        <cfset "variables.instance.answerfields.null.type" = ''>
        <cfset "variables.instance.answerfields.null.rx" = ''>
        <cfset "variables.instance.answerfields.null.length" = ''>
        <cfset "variables.instance.answerfields.null.req" = ''>
        <cfset "variables.instance.answerfields.null.def" = ''>
        <cfset "variables.instance.answerfields.null.spqdef" = ''>
        <cfset "variables.instance.answerfields.null.oedef" = ''>
        <cfset "variables.instance.answerfields.null.state_id" = ''>
        <cfset "variables.instance.answerfields.null.rule" = ''>
        <cfset "variables.instance.answerfields.null.valid" = ''>
        <cfset "variables.instance.answerfields.null.sort" = ''>
		<!---<cfset setInstanceMemento(arguments)>--->
		<cfreturn this />
	</cffunction>
    <cffunction name="getAnswerfieldVarsAsQuery" access="public" returntype="query">
    	<cfset qAnswerfieldVars = "">
        <cfquery name="qAnswerfieldVars" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
        	SELECT a.answerfield_id, a.answerfield, a.max_length, a.required_flag, a.default_value,
                a.spq_default_value, a.oe_default_value, a.state_id, at.code, r.code AS rule_code,
                v.validation_code
            FROM answerfield a INNER JOIN answerfieldtype at ON a.answerfieldtype_id=at.answerfieldtype_id
                LEFT OUTER JOIN rule r ON a.rule_id=r.rule_id
                LEFT OUTER JOIN validation v ON a.validation_id = v.validation_id
            ORDER BY a.answerfield
        </cfquery>
        <cfreturn qAnswerfieldVars />
    </cffunction>
    <cffunction name="getOptionCodes" access="public" returntype="query">
    	<cfargument name="answerfield_id" type="numeric" required="yes">
        <cfset qOptionCodes = "">
        <cfquery name="qOptionCodes" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
        	SELECT o.option_id, o.option_code, ao.sort
            FROM  `option` o
            LEFT OUTER JOIN answerfield_option ao ON ao.answerfield_id = #arguments.answerfield_id#
            WHERE o.option_id = ao.option_id
            ORDER BY ao.sort
        </cfquery>
    	<cfreturn qOptionCodes />
    </cffunction>
    <cffunction name="getAspVarsAsQuery" access="public" returntype="query">
    	<cfset qAspVars = "">
    	<cfquery name="qAspVars" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
            SELECT a.answerfield, asp.subset_id, asp.partner_id, asp.default_value
            FROM answerfield_subset_partner asp, answerfield a
            WHERE asp.background_flag=0
                AND asp.answerfield_id=a.answerfield_id
            ORDER BY asp.answerfield_id, asp.subset_id, asp.partner_id
        </cfquery>
        <cfreturn qAspVars />
    </cffunction>
    <cffunction name="setAnswerfields" access="public" returntype="void">
    	<cfargument name="qAnswerfields" type="query" required="yes">
        <cfloop query="qAnswerfields">
        	<cfset "variables.instance.answerfields.#answerfield#" = structNew()>
     		<cfset "variables.instance.answerfields.#answerfield#.exists" = true>
            <cfset "variables.instance.answerfields.#answerfield#.id" = answerfield_id>
            <cfset "variables.instance.answerfields.#answerfield#.type" = code>
            <cfif ListFind('drug,generic,rxco', code)>
				<cfset "variables.instance.answerfields.#answerfield#.rx" = true>
            <cfelse>
                <cfset "variables.instance.answerfields.#answerfield#.rx" = false>
            </cfif>
            <cfset "variables.instance.answerfields.#answerfield#.length" = max_length>
			<cfset "variables.instance.answerfields.#answerfield#.req" = required_flag>
            <cfset "variables.instance.answerfields.#answerfield#.def" = default_value>
            <cfset "variables.instance.answerfields.#answerfield#.spqdef" = spq_default_value>
            <cfset "variables.instance.answerfields.#answerfield#.oedef" = oe_default_value>
            <cfset "variables.instance.answerfields.#answerfield#.state_id" = state_id>
            <cfset "variables.instance.answerfields.#answerfield#.rule" = rule_code>
            <cfset "variables.instance.answerfields.#answerfield#.valid" = validation_code>
            <cfset "variables.instance.answerfields.#answerfield#.sp" = StructNew()>
            <cfset "variables.instance.answerfields.#answerfield#.sort" = StructNew()>
            <cfset StructInsert(variables.instance.answerfields.sort, qAnswerfields.CurrentRow, answerfield)>
            <cfset qOptionCodes = getOptionCodes(answerfield_id)>
            <cfif qOptionCodes.recordCount GT 0>
            	<cfloop query="qOptionCodes"><cftry>
					<cfset StructInsert(Evaluate("variables.instance.answerfields.#qAnswerfields.answerfield#.sort"), qOptionCodes.sort, qOptionCodes.option_code)>
          <cfcatch></cfcatch></cftry>      </cfloop>
            </cfif>
        </cfloop>
        <cfset qAspVars = getAspVarsAsQuery()>
        <cfloop query="qAspVars">
            <cfset "variables.instance.answerfields.#answerfield#.sp.s#subset_id#p#partner_id#" = default_value>
        </cfloop>
    </cffunction>
    <cffunction name="getAnswerfields" access="public" returntype="struct">
    	<cfreturn variables.instance.answerfields />
    </cffunction>
    
    <cffunction name="getAnswerfield" access="public" returntype="struct">
    	<cfargument name="answerfieldName" required="yes" type="string">
	 <cfreturn evaluate("variables.instance.answerfields.#answerfieldName#")>    </cffunction>
    <cffunction name="setAnswerfield" access="public" returntype="void">
    
    </cffunction>
    <cffunction name="setInstancweMomento" access="public" returntype="void" output="no">
    	<cfargument name="data" type="struct" required="true">
    </cffunction>
    <cffunction name="getInstanceMomento" access="public" returntype="struct" output="no">
    	<cfset var data = structNew()>
    	<cfreturn data />
    </cffunction>
</cfcomponent>
