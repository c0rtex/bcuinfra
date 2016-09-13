<cfcomponent>
	<cffunction name="init" access="public" returntype="any">
		<cfset variables.instance.questions = structNew()>
		<cfset variables.instance.questions.lastRefresh = Now()>
		<cfset variables.instance.questions.q = StructNew()>
		<cfset variables.instance.questions.sort = StructNew()>
        
        <cfset qQuestions = getQuestionsAsQuery()>
        <cfset setQuestions(qQuestions)>
		<cfreturn this />
	</cffunction>
    <cffunction name="getQuestionsAsQuery" access="public" returntype="query">
    	<cfset qQuestions = "">
        <cfquery name="qQuestions" datasource="#application.dbSrc#">
        	SELECT q.question_id, q.question_code, q.suppress_qno_flag suppress, q.spq_exclude_flag spx,
			q.sort qsort, qt.code, qc.questioncategory_code cat, qd.code head, f.format_code format,
			d.display_code short, d2.display_code spq, d3.display_code help, r.code rule,
			a.answerfield_id, a.answerfield, qa.sort asort
            FROM question q INNER JOIN questiontype qt
                    ON q.questiontype_id=qt.questiontype_id
                INNER JOIN questioncategory qc
                    ON q.questioncategory_id=qc.questioncategory_id
                LEFT OUTER JOIN questionheader qd
                    ON q.questionheader_id=qd.questionheader_id
                LEFT OUTER JOIN format f
                    ON q.format_id=f.format_id
                LEFT OUTER JOIN display d
                    ON q.short_display_id=d.display_id
                LEFT OUTER JOIN display d2
                    ON q.spq_display_id=d2.display_id
                LEFT OUTER JOIN question_help qh
                    ON q.question_id=qh.question_id
                LEFT OUTER JOIN help h
                    ON qh.help_id=h.help_id
                LEFT OUTER JOIN display d3
                    ON h.display_id=d3.display_id
                LEFT OUTER JOIN rule r
                    ON q.rule_id=r.rule_id
                LEFT OUTER JOIN question_answerfield qa
                    ON q.question_id=qa.question_id
                LEFT OUTER JOIN answerfield a
                    ON qa.answerfield_id=a.answerfield_id
            ORDER BY q.sort, qa.sort
        </cfquery>
        <cfreturn qQuestions />
    </cffunction>
    <cffunction name="setQuestions" access="private" returntype="void">
    	<cfargument name="questions" type="query" required="yes">
    	<cfset qCount = 0>
        <cfloop query="arguments.questions">
            <cfif IsDefined("variables.instance.questions.q.#question_code#")>
                <cfset qCount = qCount + 1>
            <cfelse>
                <cfset qCount = 1>
                <cfset "variables.instance.questions.q.#question_code#" = StructNew()>
                <cfset "variables.instance.questions.q.#question_code#.id" = question_id>
                <cfset "variables.instance.questions.q.#question_code#.type" = code>
                <cfset "variables.instance.questions.q.#question_code#.spx" = spx>
                <cfset "variables.instance.questions.q.#question_code#.sup" = suppress>
                <cfset "variables.instance.questions.q.#question_code#.cat" = cat>
                <cfset "variables.instance.questions.q.#question_code#.head" = head>
                <cfset "variables.instance.questions.q.#question_code#.format" = format>
                <cfset "variables.instance.questions.q.#question_code#.rule" = rule>
                <cfset "variables.instance.questions.q.#question_code#.help" = help>
                <cfset "variables.instance.questions.q.#question_code#.sort" = StructNew()>
                <cfset StructInsert(Evaluate("variables.instance.questions.sort"), qsort, question_code)>
            </cfif>
            <cfif answerfield neq ''>
                <cfset StructInsert(Evaluate("variables.instance.questions.q.#question_code#.sort"), qCount, answerfield)>
            </cfif>
            <cfif code eq 'grid'>
                <cfset qcode = question_code>
                <cfquery name="gcvars" datasource="#application.dbSrc#">
                    select g.code as gccode
                    from question_gridcolumn qg, gridcolumn g
                    where qg.question_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#question_id#" maxlength="4">
                        and qg.gridcolumn_id=g.gridcolumn_id
                    order by g.sort
                </cfquery>
                <cfset gcCount = 0>
                <cfset "variables.instance.questions.q.#qcode#.gsort" = StructNew()>
                <cfloop query="gcvars">
                    <cfset gcCount = gcCount + 1>
                    <cfset StructInsert(Evaluate("variables.instance.questions.q.#qcode#.gsort"), gcCount, gccode)>
                </cfloop>
            </cfif>
        </cfloop>
    </cffunction>
    <cffunction name="getQuestion" access="public" returntype="any">
    	<cfargument name="code" type="string" required="yes">
		<cfif StructKeyExists(variables.instance.questions.q, arguments.code)>
			<cfreturn evaluate("variables.instance.questions.q.#arguments.code#") />
		<cfelse>
			<cfreturn false>
		</cfif>
    </cffunction>
    <cffunction name="getQuestions" access="public" returntype="any">
    	<cfreturn variables.instance.questions.q />
    </cffunction>
</cfcomponent>