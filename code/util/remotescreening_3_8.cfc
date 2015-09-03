<cfcomponent   >
    <cffunction   access="remote" name="doScreening" output="false" returntype="query"  hint="accepts list of field responses in xml  and processes screening results - Version 1 ( to be upgraded)" >
        <!-- pass arguments -->
        <cfargument name="partner_id" type="numeric" required="yes" >
        <cfargument name="partner_screening_id" type="string" required="yes" >
        <cfargument name="campaign_id" type="string" required="yes" >
        <cfargument name="response_list" type="string" required="yes"  >
	<cfargument name="partner_session_id" type="string" required="yes"  >
        <cfset application.response_list = arguments.response_list >
	<cfparam name="REQUEST.PRG_LIST" default="">
	
        <!-- evaluate stuff -->
        <cfset org_id = "">
        <cfset client_id = "">
        <cfset program_list = "">
        <cfset language_id = "2" >
        <cfset screening_id = "" >
        <cfset error_code = "" >
	<cfset request.partner_id = arguments.partner_id >
        <cfset request.partner_screening_id = arguments.partner_screening_id >
        <cfset request.campaign_id = arguments.campaign_id >
        <!--Set Default Result Values -->
        <cfset testresults = arraynew(1)>
        <cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,campaign_id, org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title,state_id","integer,varchar,integer,varchar,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar,varchar")>
        <cfparam name="screeningresults.program_list" default = "">
        <cfparam name="screeningresults.date_time" default = "#dateformat(now())#">
        <cfparam name="screeningresults.language_id" default = "2">
        <cfparam name="screeningresults.error_code" default = "Success">
        <cfparam name="screeningresults.campaign_id" default = "#arguments.campaign_id#">
        <cfparam name="screeningresults.partner_screening_id" default = "#arguments.partner_screening_id#">
        <cfparam name="screeningresults.screening_id" default = 0>
        <cfparam name="screeningresults.report_url" default = "">
        <cfset session.st = 'MN'>
        <!-- do screening or display errors messages -->
        <cfif 1 eq 1>
            <cfinclude template="../servicexmlparser_3_3.cfm">
            <cfelse>
            <!-- This error code replacement displays no longer available text -->
            <cfset screeningresults.error_code = "This service is not available.">
        </cfif>
        <!-- Pass the results back to client in a string -->
	<cfif request.partner_id eq 14>
	<cfinvoke method="logAffinityClick" 
	returnvariable="responseFromService" 
	timeout = 5
	webservice="https://www.benefitscheckup.org/util/affinity.cfc?wsdl" >
	<cfinvokeargument name="internal_flag" value="1">
	<cfinvokeargument name="partner_id" value="14">
	<cfinvokeargument name="partner_session_id" value="#arguments.partner_session_id#">
	<cfinvokeargument name="url_id" value="63">
	<cfinvokeargument name="campaign_id" value="#arguments.campaign_id#">
	<cfinvokeargument name="ahn_contact_flag" value="0">
	<cfinvokeargument name="screening_id" value="#screeningresults.screening_id#">
	<cfinvokeargument name="click_id" value="0">
	</cfinvoke>
	</cfif>
        <cfreturn  resultset>
    </cffunction>


    <cffunction   access="remote" name="screen" output="false" returntype="query"  hint="accepts list of field responses in xml  and processes screening results - Version 2 upgraded" >
        <!-- pass arguments -->
        <cfargument name="partner_id" type="numeric" required="yes" >
        <cfargument name="response_list" type="string" required="yes"  >

        <!-- evaluate stuff -->
        <cfset program_list = "">
        <cfset language_id = "2" >
        <cfset screening_id = "" >
        <cfset error_code = "" >

        <!--Set Default Result Values -->
        <cfset testresults = arraynew(1)>
        <cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title","integer,varchar,integer,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar")>
        <cfparam name="screeningresults.program_list" default = "">
        <cfparam name="screeningresults.date_time" default = "#dateformat(now())#">
        <cfparam name="screeningresults.language_id" default = "2">
        <cfparam name="screeningresults.error_code" default = "Success">
        <cfparam name="screeningresults.screening_id" default = 0>
        <cfparam name="screeningresults.report_url" default = "">
        <cfset session.st = 'MN'>
        <!-- do screening or display errors messages -->
        <cfif 1 eq 1>
            <cfinclude template="../servicexmlparser_3_3.cfm">
            <cfelse>
            <!-- This error code replacement displays no longer available text -->
            <cfset screeningresults.error_code = "This service is not available.">
        </cfif>
        <!-- Pass the results back to client in a string -->
        <cfreturn  resultset>
    </cffunction>

    <cffunction   access="remote" name="doTriage" output="false" returntype="query"  hint="accepts list of field responses in xml  and processes screening results for screening triage" >
        <!-- pass arguments -->
        <cfargument name="partner_id" type="numeric" required="yes" >
        <cfargument name="partner_screening_id" type="string" required="yes" >
        <cfargument name="campaign_id" type="string" required="yes" >
        <cfargument name="response_list" type="string" required="yes"  >
	<cfargument name="partner_session_id" type="string" required="yes" >
        <cfset application.response_list = arguments.response_list >
        <cfset request.partner_screening_id = arguments.partner_screening_id >
        <cfset request.campaign_id = arguments.campaign_id >
        <!-- evaluate stuff -->
        <cfset program_list = "">
        <cfset language_id = "2" >
        <cfset screening_id = "" >
        <cfset error_code = "" >

        <!--Set Default Result Values -->
        <cfset testresults = arraynew(1)>
        <cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,campaign_id, org_id,subset_id,client_id,report_url,validation_error,next_subset_id,state_id","integer,varchar,integer,varchar, integer,integer,varchar,varchar,varchar,integer,varchar")>
        <cfparam name="screeningresults.program_list" default = "">
        <cfparam name="screeningresults.date_time" default = "#dateformat(now())#">
        <cfparam name="screeningresults.language_id" default = "2">
        <cfparam name="screeningresults.error_code" default = "Success">
        <cfparam name="screeningresults.screening_id" default = 0>
        <cfparam name="screeningresults.report_url" default = "">
        <cfparam name="screeningresults.nextsubset_id" default = "">
        <cfparam name="screeningresults.partner_id" default = "#arguments.partner_id#">
        <cfparam name="screeningresults.campaign_id" default = "#arguments.campaign_id#">
        <cfparam name="screeningresults.partner_screening_id" default = "#arguments.partner_screening_id#">
        <cfset testresults = arraynew(1)>
        <cfset resultset = QueryNew("screening_id,partner_screening_id,partner_id,campaign_id, org_id,subset_id,client_id,report_url,validation_error,program_list,screening_status,reentry_number,date_time,program_title,next_subset_id,state_id","integer,varchar,integer,varchar,integer,integer,varchar,varchar,varchar,varchar,varchar,integer,date,varchar,integer,varchar")>
        <cfparam name="REQUEST.PRG_LIST" default="">
        <!-- Pass the results back to client in a string -->
        <cfset session.st = 'MN'>
        <!-- do screening or display errors messages -->
        <cfif 1 eq 1>
            <cfinclude template="../servicexmlparser_3_3.cfm">
            <cfset screeningresults.nextsubset_id = request.next_subset_id >
            <cfelse>
            <!-- This error code replacement displays no longer available text -->
            <cfset screeningresults.error_code = "This service is not available.">
        </cfif>
        <cfinvoke method="logAffinityClick" 
	returnvariable="responseFromService" 
	timeout = 5
	webservice="https://www.benefitscheckup.org/util/affinity.cfc?wsdl" >
	<cfinvokeargument name="internal_flag" value="1">
	<cfinvokeargument name="partner_id" value="14">
	<cfinvokeargument name="partner_session_id" value="#arguments.partner_session_id#">
	<cfinvokeargument name="url_id" value="63">
	<cfinvokeargument name="campaign_id" value="#arguments.campaign_id#">
	<cfinvokeargument name="ahn_contact_flag" value="0">
	<cfinvokeargument name="screening_id" value="#screeningresults.screening_id#">
	<cfinvokeargument name="click_id" value="0">
	</cfinvoke>
        <cfreturn  resultset>
    </cffunction>

      <cffunction access="remote" name="getAllQuestionsBySubset" output="false" returntype="query"  hint="returns a sorted list of questions for a complete questionnaire by subset_id"  >
	<!-- pass arguments -->
	<cfargument name="subset_id" type="numeric" required="yes"  >
	<cfargument name="state_zip" type="string" required="yes" default="" >
        <cfargument name="partner_id" type="numeric" required="no"  default="0">
	<cfset state_id = state_zip>
	<!--- check state and zip data --->
		<cfif len(state_zip) lt 2>
		<cfset state_id = 'FD'>
		</cfif>
		<cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
		<cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery"> 
						<cfinvokeargument name="zipcode" value="#state_zip#"/>
		</cfinvoke>
		<cfset state_id = statequery.state_id>
		</cfif>
		<cfset queryQuestions = QueryNew("question_id,question_code,display_id, questioncategory_code , questiontype_code, rule_id,section_sort, question_sort")>
		<cfquery name="queryQuestions" datasource="#application.dbSrc#">
		SELECT q.question_id, q.question_code, q.display_id, qc.questioncategory_code , qt.code questiontype_code, q.rule_id, sqc.sort as section_sort, sq2.sort as question_sort
		FROM ( SELECT q.question_id, NULL AS page_id FROM ( SELECT pa.answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield a WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=a.answerfield_id AND ( a.state_id IS NULL or a.state_id='MN') UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') UNION SELECT pa.answerfield_id FROM subset_program_sum sps, program_answerfield pa, answerfield a WHERE sps.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> and pa.program_id = sps.program_id and a.answerfield_id = pa.answerfield_id and sps.program_id in ( select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> and (p.state_id = 'MN' or p.state_id IS NULL) ) UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND (partner_id is null OR partner_id=77) AND background_flag=1 ) and sp.program_id in (	select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> and ( p.state_id = 'NY' or p.state_id is NULL ) ) AND 				pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') ) AS a, question_answerfield qa, question q WHERE a.answerfield_id=qa.answerfield_id AND qa.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND exclude_flag=1 ) AND qa.question_id=q.question_id AND q.exclude_flag=0 UNION SELECT q.question_id, sq.page_id FROM subset_question sq, question q WHERE sq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sq.exclude_flag=0 AND sq.question_id=q.question_id UNION SELECT q.question_id, NULL AS page_id FROM question q WHERE q.include_flag=1 AND q.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND exclude_flag=1 ) ) 
		AS a, question q, questioncategory qc , questiontype qt, subset_questioncategory sqc, subset_question sq2
		WHERE a.question_id=q.question_id 
		AND q.question_id=sq2.question_id
		AND sq2.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		AND q.questioncategory_id=qc.questioncategory_id 
		AND q.questiontype_id = qt.questiontype_id
		AND sqc.questioncategory_id = qc.questioncategory_id
		AND sqc.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		AND q.question_code like 'mqc_%'
		ORDER BY qc.sort, sq2.sort
		</cfquery>
		<cfreturn  queryQuestions>
    </cffunction>


      <cffunction access="remote" name="getSubsetQuestionDetails" output="false" returntype="query"  hint="returns a sorted list of questions and details about question content such as sort order, section,  help text and question notes"  >
	<!-- pass arguments -->
	<cfargument name="subset_id" type="numeric" required="yes"  >
	<cfargument name="state_zip" type="string" required="yes" default="" >
        <cfargument name="partner_id" type="numeric" required="no"  default="0">
	<cfset state_id = state_zip>
	<!--- check state and zip data --->
	<cfif len(state_zip) lt 2>
		<cfset state_id = 'FD'>
	</cfif>
	<cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
		<cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery"> 
						<cfinvokeargument name="zipcode" value="#state_zip#"/>
		</cfinvoke>
		<cfset state_id = statequery.state_id>
	</cfif>
		<cfset queryQuestionDetails = QueryNew("question_id,question_code,display_id, questioncategory_code , questiontype_code, rule_id,section_sort, question_sort")>
		<cfquery name="queryQuestionDetails" datasource="#application.dbSrc#">

		SELECT
		q.question_id,
		q.question_code,
		q.display_id,
		qt.`code` AS questiontype_code,
		q.rule_id,
		qc.questioncategory_code,
		r.rule_text,
		dl.display_text AS question_text,
		qh.help_id,
		h.display_id as help_display_id,
		'' as help_text,
                '' as question_note,
		qc.alt_title AS section_title,
		sqc.sort AS section_sort,
		sq.sort AS question_sort,
		sqc.questioncategory_id,
		sq.required_flag as required
		FROM
		question q
		JOIN subset_question sq ON q.question_id = sq.question_id
		JOIN questiontype qt on q.questiontype_id =  qt.questiontype_id
		JOIN questioncategory qc on q.questioncategory_id = qc.questioncategory_id
		LEFT JOIN rule r on q.rule_id = r.rule_id
		LEFT JOIN question_help qh ON q.question_id = qh.question_id
		LEFT JOIN help h ON qh.help_id = h.help_id
		LEFT JOIN display_language dl on q.display_id = dl.display_id
		JOIN subset_questioncategory sqc on sq.subset_id = sqc.subset_id
		WHERE 
		sq.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		and sqc.questioncategory_id = qc.questioncategory_id
		and dl.language_id = 'EN'
		ORDER BY qc.sort, sq.sort
		</cfquery>
		<!-- add help text -->
		<cfset rownum = 0>
		<cfloop query="queryquestionDetails">
		<cfset rownum = rownum + 1>
		<cfquery name="question2" datasource="#application.dbSrc#">
		select display_text as help_text from display_language dl
		left join help h on h.display_id = dl.display_id 
		left join question_help qh on qh.help_id = h.help_id
		left join question q on qh.question_id = q.question_id
		where q.question_id = #queryQuestionDetails.question_id#
		and h.helptype_id = 1
		</cfquery>
		<cfif question2.recordcount gt 0>
  			<cfset result = #QuerySetCell(queryQuestionDetails, "help_text", question2.help_text,rownum)#>
		</cfif>
		</cfloop>
		<!-- add question notes -->
		<cfset rownum = 0>
		<cfloop query="queryquestionDetails">
		<cfset rownum = rownum + 1>
		<cfquery name="question3" datasource="#application.dbSrc#">
		select display_text as help_text from display_language dl
		left join help h on h.display_id = dl.display_id 
		left join question_help qh on qh.help_id = h.help_id
		left join question q on qh.question_id = q.question_id
		where q.question_id = #queryQuestionDetails.question_id#
		and h.helptype_id = 4
		</cfquery>
		<cfif question3.recordcount gt 0>
  			<cfset result = #QuerySetCell(queryQuestionDetails, "question_note", question3.help_text,rownum)#>
		</cfif>
		</cfloop>
		<cfreturn  queryQuestionDetails>
    </cffunction>
	

    <cffunction access="remote" name="getQuestionnaireVersion" output="false" returntype="string"  hint="Returns the version of the questionnaire subset based on subset_id"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset version = "1.01">
        <cfreturn  version>
    </cffunction>

    <cffunction access="remote" name="getProgramEntryPoints" output="false" returntype="string" hint="returns entry point offices by program"  >
        <!-- pass arguments -->
        <cfargument name="program_id" type="numeric" required="yes" >
        <cfargument name="partner_id" type="numeric" required="no" default="0" >
        <cfargument name="county" type="string" required="yes" >
        <cfargument name="city" type="string" required="no" >
        <cfargument name="state_id" type="string" required="yes" >
        <cfargument name="limit" type="numeric" required="no" default="3" >
        <cfargument name="radius" type="numeric" required="no" default="100" >
        <cfargument name="zip" type="string" required="yes" >
        <!-- cf_displayprogramdetailentrypoints proximityOverride="county" city="#city#" program_id="#program_id#" state_id="#state_id#" county="#county#" zip="#zip#" source="details" var="resultstring" google="#showgooglemaplink#" -->
        <cfset testzipcode = "#zip#">
        <cfset session.partner_id = 0>
        <cf_displayprogramdetailAgis program_id = "#program_id#" state_id="#state_id#" county="#county#" zip="#testzipcode#" source="ec" supressforms="true" suppressOfficesLink="true" eplimit="#limit#" requisites="false" description="false"  entrypoints="true"  var="resultstring"  >

        <cfreturn  resultstring>
    </cffunction>


    <cffunction access="remote" name="getProgramDetails" output="false" returntype="string"  hint="returns details and description about program" >
        <!-- pass arguments -->
        <cfargument name="program_id" type="numeric" required="yes" default="" >
        <cfargument name="state_id" type="string" required="yes" default="">
        <cfargument name="county" type="string" required="yes" default="">
        <cfargument name="zip" type="string"  default="0">
        <cfargument name="showdescription" type="boolean"  default="true">
        <cfargument name="showentrypoints" type="boolean"  default="true">
        <cfargument name="showrequisites" type="boolean"  default="true">
        <cfargument name="eplimit" type="numeric"  default="3">
        <cfset session.st = state_id >
        <cfset session.partner_id = 0>
        <cfset session.org_id = 0>
        <cfset resultstring = "">
        <cf_displayprogramdetailAgis program_id = "#program_id#" state_id="#state_id#" county="#county#" zip="#zip#" source="ec" eplimit="#eplimit#" requisites="#showrequisites#" description="#showdescription#"  entrypoints="#showentrypoints#"  var="resultstring" supressforms="true" suppressOfficesLink="true"  >

        <cfreturn  resultstring>
    </cffunction>

    <cffunction access="remote" name="getProgramForms" output="false" returntype="string" hint="returns application forms by program"   >
        <!-- pass arguments -->
        <cfargument name="program_id" type="numeric" required="true" hint="valid bcu program identified" >
        <cfargument name="state_id" type="string" required="true" hint="2 digit state abrev" >
        <cfargument name="format" type="string" required="true" default="html" hint="html or xml" >
        <cfset session.test_id = 1>
        <cfset session.partner_id = 0>
        <cfset session.state_id = state_id>
        <cfif format eq "html">
            <cf_displayprogramdetailformsAgis foodStampLegendVar="a" multiProgramLegendVar="b" fillableLegendVar="c" program_id = "#program_id#" state_id="#state_id#"  var="resultstring" formtype_id=0 source="details" >
            <cfelse>
            <cf_displayprogramdetailformsAgis foodStampLegendVar="a"  multiProgramLegendVar="b"  fillableLegendVar="c"  program_id = "#program_id#" state_id="#state_id#"  var="resultstring" formtype_id=0 source="details" format="xml">
        </cfif>
        <cfreturn  resultstring>
    </cffunction>

    <cffunction access="remote" name="getProgramCategories" output="false" returntype="query"  hint="return program categories"  >
        <!-- pass arguments -->
        <cfset session.test_id = 1>
        <cfset session.partner_id = 0>
        <cfset queryCat = QueryNew("program_category_id, category_code, category")>
        <cfquery name="queryCat" datasource="#application.dbSrc#">
		select programcategory_id,code as category_code, '' as category  from programcategory order by sort
	</cfquery>
        <cfreturn  queryCat>
    </cffunction>

    <cffunction access="remote" name="getSubsetPrograms" output="false" returntype="query"  hint="return all programs in subset"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset querySubsetProgram = QueryNew("program_id, program_category_id, subset_id, program_code, program_title, category_code")>
        <cfquery name="querySubsetProgram" datasource="#application.dbSrc#">
		select p.program_id, p.program_code, p.programcategory_id,sp.subset_id,
		pa.prg_nm as program_name,pc.code as category_code
		from subset_program_sum sp, program p, tbl_prg_all pa, programcategory pc
		where
		sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		and sp.program_id=p.program_id
		and p.active_flag=1
		and pa.recid = p.program_id
		and pc.programcategory_id = p.programcategory_id
		order by p.sort,p.program_id
		</cfquery>
        <cfreturn  querySubsetProgram>
    </cffunction>

    <cffunction access="remote" name="getEsiQuickcheckQuestions" output="false" returntype="query"  hint="return all questions in this subset"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset querySubsetProgram = QueryNew("question_id")>
        <cfquery name="querySubsetProgram" datasource="#application.dbSrc#">
SELECT q.question_id, q.question_code, q.rule_id, qc.questioncategory_code, q.display_id, qt.code as questiontype_code from question q, questiontype qt, subset_question sq, questioncategory qc where sq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> and sq.question_id = q.question_id and q.questioncategory_id = qc.questioncategory_id and q.questiontype_id = qt.questiontype_id;
		</cfquery>
        <cfreturn  querySubsetProgram>
    </cffunction>




    <cffunction access="remote" name="getProgramRequisites" output="false" returntype="query" hint="displays a list of program required materials for application processing"  >
        <!-- pass arguments -->
        <cfargument name="program_id" type="numeric" required="yes" >
        <cfargument name="state_id" type="string" required="yes" >
        <cfset session.test_id = 1>
        <cfset session.partner_id = 0>
        <cfset results = QueryNew("program_id, requisite_id, requisite_title, requisite_description")>
        <cfreturn  results>
    </cffunction>


<!--- Lynna Cekova: 2014 WS methods --->


    <cffunction access="remote" name="getSectionQuestions" output="false" returntype="query"  hint="return questions per section of a questionnaire by subset_id"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfargument name="section_code" type="string" required="yes"  >
        <cfargument name="state_id" type="string" required="no"  default="NA">
        <cfargument name="partner_id" type="numeric" required="no"  default="0">
        <cfset querySectionQuestions = QueryNew("subset_id, question_id, page_id, validation_type, validation_text")>
        <cfquery name="querySectionQuestions" datasource="#application.dbSrc#">
		SELECT q.question_id, q.question_code, q.display_id, qc.questioncategory_code , qt.code questiontype_code, q.rule_id, sqc.sort, sq2.sort
		FROM ( SELECT q.question_id, NULL AS page_id FROM ( SELECT pa.answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield a WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=a.answerfield_id AND ( a.state_id IS NULL or a.state_id='MN') UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') UNION SELECT pa.answerfield_id FROM subset_program_sum sps, program_answerfield pa, answerfield a WHERE sps.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> and pa.program_id = sps.program_id and a.answerfield_id = pa.answerfield_id and sps.program_id in ( select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> and (p.state_id = 'MN' or p.state_id IS NULL) ) UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND (partner_id is null OR partner_id=77) AND background_flag=1 ) and sp.program_id in (	select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> and ( p.state_id = 'NY' or p.state_id is NULL ) ) AND 				pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') ) AS a, question_answerfield qa, question q WHERE a.answerfield_id=qa.answerfield_id AND qa.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND exclude_flag=1 ) AND qa.question_id=q.question_id AND q.exclude_flag=0 UNION SELECT q.question_id, sq.page_id FROM subset_question sq, question q WHERE sq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND sq.exclude_flag=0 AND sq.question_id=q.question_id UNION SELECT q.question_id, NULL AS page_id FROM question q WHERE q.include_flag=1 AND q.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4"> AND exclude_flag=1 ) )
		AS a, question q, questioncategory qc , questiontype qt, subset_questioncategory sqc, subset_question sq2
		WHERE a.question_id=q.question_id
		AND q.question_id=sq2.question_id
		AND sq2.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		AND q.questioncategory_id=qc.questioncategory_id
		AND q.questiontype_id = qt.questiontype_id
		AND sqc.questioncategory_id = qc.questioncategory_id
		AND sqc.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		AND qc.questioncategory_code = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#section_code#" maxlength="30">
		AND q.question_code like 'mqc_%'
		ORDER BY qc.sort, sq2.sort

		</cfquery>
        <cfreturn  querySectionQuestions>
    </cffunction>


    <!-- 7/14 New Method Call to Get Page Validations -->
    <cffunction access="remote" name="getSubsetValidation" output="false" returntype="query"  hint="return all page validations for questionnaire by subset_id"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset querySubsetValidation = QueryNew("subset_id, question_id, page_id, validation_type, validation_text")>
        <cfquery name="querySubsetValidation" datasource="#application.dbSrc#">
		select id, subset_id, question_id, page_id, validation_type, validation_text
		from subset_validation sv
		where
		sv.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
        </cfquery>
        <cfreturn  querySubsetValidation>
    </cffunction>

    <!-- 7/14 New Method Call to Get Question Dependencies; in this case a whole question depends on an answerfield being selected -->
    <cffunction access="remote" name="getQuestionDependencies" output="false" returntype="query"  hint="return question dependencies for the subset"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset queryQuestionDependencies = QueryNew("id, question_answerfield_master, question_dependent, relationship, subset_id")>
        <cfquery name="queryQuestionDependencies" datasource="#application.dbSrc#">
		select id, question_answerfield_master, question_dependent, relationship, subset_id
		from question_answerfield_question_dependency qaqd
		where
		qaqd.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
        </cfquery>
        <cfreturn  querySubsetValidation>
    </cffunction>



    <!-- 7/14 New Method Call to Get Answer Dependencies; in this case an answerfield depends on another answerfield being selected, e.g. "none of the above" forces all other checkboxes to be hidden (which will be expressed in many dependencies) -->
    <cffunction access="remote" name="getAnswerDependencies" output="false" returntype="query"  hint="return answerfield dependencies for the subset"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset queryAnswerDependencies = QueryNew("id, question_answerfield_master, question_answerfield_dependent, relationship, subset_id")>
        <cfquery name="queryAnswerDependencies" datasource="#application.dbSrc#">
		select id, question_answerfield_master, question_answerfield_dependent, relationship, subset_id
		from question_answerfield_dependency qad
		where
		qad.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
        </cfquery>
        <cfreturn  querySubsetValidation>
    </cffunction>


    <!-- 7/14 New Method Call to Get Report Page Display Content Codes and Sort -->
    <cffunction access="remote" name="getSubsetContent" output="false" returntype="query"  hint="return all report page display content codes and sort "  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset querySubsetContent = QueryNew("subset_id, post_code, sort_order, section_code,bcu_link_flag")>
        <cfquery name="querySubsetContent" datasource="#application.dbSrc#">
		select subset_id, post_code, sort_order, section_code, 1 as programcategory_id,
		'' as program_id,
		'' as programgroup_id,
		0 as bcu_link_flag
		from subset_content sc
		where
		sc.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		order by section_code, sc.sort_order
		</cfquery>
        <cfreturn  querySubsetContent>
    </cffunction>

    <!-- get Section Content -->
    <cffunction access="remote" name="getSubsetSections" output="false" returntype="query"  hint="returns a list of question sections "  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset querySubsetSections = QueryNew("questioncategory_id,questioncategory_code,questionheader_id,display_id,code,sort")>
        <cfquery name="querySubsetSections" datasource="#application.dbSrc#">
		SELECT
		questioncategory.questioncategory_id,
		questioncategory.questioncategory_code,
		questionheader.questionheader_id,
		questionheader.display_id,
		questionheader.code,
		subset_questioncategory.sort
		FROM
		questioncategory
		INNER JOIN questionheader ON questioncategory.questioncategory_id = questionheader.questioncategory_id
		INNER JOIN subset_questioncategory ON questionheader.questioncategory_id = subset_questioncategory.questioncategory_id
		WHERE
		subset_questioncategory.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		and questionheader_id <> 11
		order by subset_questioncategory.sort
		</cfquery>
        <cfreturn  querySubsetSections>
    </cffunction>



    <!-- getQuestionHelp -->
    <cffunction access="remote" name="getQuestionHelp" output="false" returntype="query"  hint="return question help text by question id "  >
        <!-- pass arguments -->
        <cfargument name="question_id" type="numeric" required="yes"  >
        <cfset queryQuestionHelp = QueryNew("help_id,helptype_id,help_code,keyword,title_display_id,display_id,question_id,helptext,language_id,title")>
        <cfquery name="queryQuestionHelp" datasource="#application.dbSrc#">
		SELECT
		`help`.help_id,
		`help`.helptype_id,
		`help`.help_code,
		`help`.keyword,
		`help`.title_display_id,
		`help`.display_id,
		question_help.question_id,
		dl.display_text as helptext,
		dl.language_id,
		dl2.display_text as title
		FROM
		`help`
		INNER JOIN question_help ON `help`.help_id = question_help.help_id
		INNER JOIN display_language as dl ON `help`.display_id = dl.display_id
		INNER JOIN display_language as dl2 ON `help`.title_display_id = dl2.display_id
		WHERE
		question_help.question_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#question_id#" maxlength="4">
		and dl2.language_id = 'EN'
		and dl.language_id = 'EN'
		and `help`.helptype_id = 1
		</cfquery>
        <cfreturn  queryQuestionHelp>
    </cffunction>

        <!-- getQuestionNotes-->
    <cffunction access="remote" name="getQuestionNote" output="false" returntype="query"  hint="return question notes text by question id "  >
        <!-- pass arguments -->
        <cfargument name="question_id" type="numeric" required="yes"  >
        <cfset queryQuestionHelp = QueryNew("help_id,helptype_id,help_code,keyword,title_display_id,display_id,question_id,helptext,language_id,title")>
        <cfquery name="queryQuestionHelp" datasource="#application.dbSrc#">
		SELECT
		`help`.help_id,
		`help`.helptype_id,
		`help`.help_code,
		`help`.keyword,
		`help`.title_display_id,
		`help`.display_id,
		question_help.question_id,
		dl.display_text as helptext,
		dl.language_id,
		dl2.display_text as title
		FROM
		`help`
		INNER JOIN question_help ON `help`.help_id = question_help.help_id
		INNER JOIN display_language as dl ON `help`.display_id = dl.display_id
		INNER JOIN display_language as dl2 ON `help`.title_display_id = dl2.display_id
		WHERE
		question_help.question_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#question_id#" maxlength="4">
		and `help`.helptype_id = 4
		and dl2.language_id = 'EN'
		and dl.language_id = 'EN'
		</cfquery>
        <cfreturn  queryQuestionHelp>
    </cffunction>
    <!-- getDisplayTextByID -->
    <cffunction access="remote" name="getDisplayTextById" output="false" returntype="query"  hint="returns a list of question sections "  >
        <!-- pass arguments -->
        <cfargument name="display_id" type="numeric" required="yes"  >
        <cfset queryDisplayTextById = QueryNew("display_text")>
        <cfquery name="queryDisplayTextById" datasource="#application.dbSrc#">
						select dl.display_text
						from display_language dl, language l
						where dl.display_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#display_id#" maxlength="4">
						and dl.language_id in ('EN')
						and dl.language_id=l.language_id
						and l.active = 1
						order by l.default_flag
		</cfquery>
        <cfreturn  queryDisplayTextById>
    </cffunction>

    <!-- getDisplayTextByCode -->
    <cffunction access="remote" name="getDisplayTextByCode" output="false" returntype="query"  hint="returns display text by display code "  >
        <!-- pass arguments -->
        <cfargument name="display_code" type="string" required="yes"  >
        <cfset queryDisplayTextByCode = QueryNew("display_code")>
        <cfquery name="queryDisplayTextByCode" datasource="#application.dbSrc#">
						select dl.display_text
						from display_language dl, language l
						where dl.display_code = '#display_code#'
						and dl.language_id in ('EN')
						and dl.language_id=l.language_id
						and l.active = 1
						order by l.default_flag
		</cfquery>
        <cfreturn  queryDisplayTextByCode>
    </cffunction>

    <!-- getQTByQuestion -->
    <cffunction access="remote" name="getQTByQuestion" output="false" returntype="query"  hint="returns the question type for a question to format display"  >
        <!-- pass arguments -->
        <cfargument name="question_code" type="string" required="yes"  >
        <cfset queryGetQTByQuestion = QueryNew("question_code")>
        <cfquery name="queryGetQTByQuestion" datasource="#application.dbSrc#">
	   select q.question_id, q.question_code, qt.`code` as questiontype_code
           from question q, questiontype qt
           where q.question_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#question_code#" maxlength="50">
       and q.questiontype_id = qt.questiontype_id
           order by q.sort

				</cfquery>
        <cfreturn  queryGetQTByQuestion>
    </cffunction>

    <!-- getValidationDetails -->
    <cffunction access="remote" name="getValidationByID" output="false" returntype="query"  hint="returns Validation Rule by Validation ID"  >
        <!-- pass arguments -->
        <cfargument name="validation_id" type="numeric" required="yes"  >
        <cfset getValidationByID = QueryNew("validation_id, validation_code, formula, display_id, validation_desc")>
        <cfquery name="getValidationByID" datasource="#application.dbSrc#">
	select validation_id, validation_code, formula, display_id, validation_desc from validation
	where validation_id = #validation_id#
	</cfquery>
        <cfreturn  getValidationByID>
    </cffunction>

    <!-- getAFByQuestion -->
    <cffunction access="remote" name="getAFByQuestion" output="false" returntype="query"  hint="returns a list of answerfields per question"  >
        <!-- pass arguments -->
        <cfargument name="question_code" type="string" required="yes"  >
	<cfargument name="state_zip" type="string" required="yes" default=""  >
	<cfset state_id = state_zip >
	<cfif len(state_zip) lt 2>
            <cfset state_id = 'FD'>
        </cfif>
        <cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
                <cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery">
                        <cfinvokeargument name="zipcode" value="#state_zip#"/>
                </cfinvoke>
            <cfset state_id = statequery.state_id>
        </cfif>
        <cfset queryGetAFByQuestion = QueryNew("question_code")>
        <cfquery name="queryGetAFByQuestion" datasource="#application.dbSrc#">
		select a.answerfield_id , a.answerfield, a.answerfieldtype_id , aa.code, a.display_id, a.validation_id, a.default_value, a.max_length, qa.sort,
		a.required_flag as required
		FROM
           	 question q, question_answerfield qa, answerfield a, answerfieldtype aa
           	where q.question_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#question_code#" maxlength="50">
                   and q.question_id=qa.question_id
                   and qa.answerfield_id=a.answerfield_id
       		and a.answerfieldtype_id = aa.answerfieldtype_id
		<cfif state_id neq 'FD'>
		and (a.state_id is null or a.state_id = '#state_id#')
		</cfif> 
           	order by qa.sort
	</cfquery>
        <cfreturn  queryGetAFByQuestion>
    </cffunction>

       <!-- getQuestionAnswerfieldDetails -->
    <cffunction access="remote" name="getQuestionAnswerfieldDetails" output="false" returntype="query"  hint="returns a list of answerfields per question and details about each field"  >
        <!-- pass arguments -->
        <cfargument name="question_code" type="string" required="yes"  >
	<cfargument name="state_zip" type="string" required="yes" default=""  >
	<cfset state_id = state_zip >
	<cfif len(state_zip) lt 2>
            <cfset state_id = 'FD'>
        </cfif>
        <cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
                <cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery">
                        <cfinvokeargument name="zipcode" value="#state_zip#"/>
                </cfinvoke>
            <cfset state_id = statequery.state_id>
        </cfif>
        <cfset querygetQuestionAnswerfieldDetails = QueryNew("question_code")>
        <cfquery name="querygetQuestionAnswerfieldDetails" datasource="#application.dbSrc#">
		SELECT
		a.answerfield_id,
		a.answerfield,
		a.answerfieldtype_id,
		a.state_id,
		dl.display_text as 'answerfield_text',
		aa.`code`,
		a.display_id,
		a.default_value,
		a.max_length,
		1 AS required,
		v.validation_code,
		v.formula,
		v.validation_desc
		FROM
		question AS q ,
		question_answerfield AS qa ,
		answerfieldtype AS aa,
		answerfield AS a 
		LEFT OUTER JOIN validation AS v ON a.validation_id = v.validation_id
	        LEFT OUTER JOIN display_language dl on a.display_id = dl.display_id
           	where q.question_code = '#question_code#'
                   and q.question_id=qa.question_id
                   and qa.answerfield_id=a.answerfield_id
       		and a.answerfieldtype_id = aa.answerfieldtype_id
and dl.language_id = 'EN'
		<cfif state_id neq 'FD'>
		and (a.state_id is null or a.state_id = '#state_id#')
		</cfif> 
           	order by qa.sort
	</cfquery>
        <cfreturn  querygetQuestionAnswerfieldDetails>
    </cffunction>

    <!-- getAnswerfieldOption -->
    <cffunction access="remote" name="getAnswerfieldOption" output="false" returntype="query"  hint="returns a list of answerfield options associated with a field"  >
        <!-- pass arguments -->
        <cfargument name="answerfield_id" type="numeric" required="yes"  >
        <cfset queryAnswerfieldOption = QueryNew("answerfield_id")>
        <cfquery name="queryAnswerfieldOption" datasource="#application.dbSrc#">
		SELECT
   		answerfield_option.answerfield_id,
   		answerfield_option.option_id,
   		answerfield_option.sort,
   		`option`.option_id,
   		`option`.display_id,
   		`option`.option_code as code,
 		 `option`.include_flag
  		FROM
  		answerfield_option
  		INNER JOIN `option` ON answerfield_option.option_id = `option`.option_id
  		WHERE answerfield_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#answerfield_id#" maxlength="4">
  		order by answerfield_option.sort

	</cfquery>
        <cfreturn  queryAnswerfieldOption>
    </cffunction>

    <!-- getIconTextByCode -->
    <cffunction access="remote" name="getIconTextByCode" output="false" returntype="query"  hint="Gets the icon text to display associated with a section"  >
        <!-- pass arguments -->
        <cfargument name="section_code" type="string" required="yes"  >
        <cfset queryGetIconTextByCode = QueryNew("section_code")>
        <cfquery name="queryGetIconTextByCode" datasource="#application.dbSrc#">

	select icon_code from section where section_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#section_code#" maxlength="50">

        </cfquery>
        <cfreturn  queryGetIconTextByCode>
    </cffunction>

    <!-- getHelpDisplayTextbyCode -->
    <cffunction access="remote" name="getHelpDisplayTextbyCode" output="false" returntype="query"  hint="Get Help Text to Display by help code"  >
        <!-- pass arguments -->
        <cfargument name="help_code" type="string" required="yes"  >
        <cfset queryGetHelpDisplayTextbyCode = QueryNew("help_code")>
        <cfquery name="queryGetHelpDisplayTextbyCode" datasource="#application.dbSrc#">
	SELECT
	display_language.display_id,
	display_language.display_text,
	display_language.language_id
	FROM
	`help`
	INNER JOIN display_language ON `help`.display_id = display_language.display_id
	WHERE `help`.keyword  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#help_code#" maxlength="50">

	and display_language.language_id = 'EN'



				</cfquery>
        <cfreturn  queryGetHelpDisplayTextbyCode>
    </cffunction>

    <!-- getHelpTitlebyCode -->
    <cffunction access="remote" name="getHelpTitlebyCode" output="false" returntype="query"  hint="Get Help Title to Display by help code"  >
        <!-- pass arguments -->
        <cfargument name="help_code" type="string" required="yes"  >
        <cfset queryGetHelpTitlebyCode = QueryNew("help_code")>
        <cfquery name="queryGetHelpTitlebyCode" datasource="#application.dbSrc#">
	SELECT
	display_language.display_id,
	display_language.display_text,
	display_language.language_id
	FROM
	`help`
	INNER JOIN display_language ON `help`.title_display_id = display_language.display_id
	WHERE `help`.keyword  = <cfqueryparam cfsqltype="cf_sql_varchar" value="#help_code#" maxlength="50">

	and display_language.language_id = 'EN'


				</cfquery>
        <cfreturn  queryGetHelpTitlebyCode>
    </cffunction>

    <!-- getScreeningAnswerfield -->
    <cffunction access="remote" name="getScreeningAnswerfield1" output="false" returntype="query"  hint="Get Screening Answerfield Data"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="answerfield_id" type="numeric" required="yes"  >
        <cfset queryGSA = QueryNew("answerfield_id,screening_id,responsetype,response,option_id,validation_response")>
        <cfquery name="queryGSA" datasource="#application.dbSrc#">
SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.response,
		screening_answerfield.option_id,
		screening_answerfield.validation_response
		FROM
		screening_answerfield
		WHERE
		screening_answerfield.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="4"> AND
		screening_answerfield.answerfield_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#answerfield_id#" maxlength="4">

        </cfquery>
        <cfreturn  queryGSA>
    </cffunction>

    <!-- getScreeningAnswerfield -->
    <cffunction access="remote" name="getScreeningAnswerfield2" output="false" returntype="query"  hint="Get Screening Answerfield Data"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="answerfield_id" type="numeric" required="yes"  >
        <cfset queryGSA = QueryNew("answerfield_id,screening_id,responsetype,response,validation_response, option_id, response, display_id, include_flag")>
        <cfquery name="queryGSA" datasource="#application.dbSrc#">
SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.validation_response,
		`option`.option_id,
		`option`.option_code as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id
		WHERE
		screening_answerfield.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="4"> AND
		screening_answerfield.answerfield_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#answerfield_id#" maxlength="4">


        </cfquery>
        <cfreturn  queryGSA>
    </cffunction>

    <!-- getScreeningAnswerfield -->
    <cffunction access="remote" name="getScreeningAnswerfield3" output="false" returntype="query"  hint="Get Screening Answerfield data"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="answerfield_id" type="numeric" required="yes"  >
        <cfset queryGSA = QueryNew("answerfield_id,screening_id,responsetype,response,validation_response, option_id, response, display_id, include_flag")>
        <cfquery name="queryGSA" datasource="#application.dbSrc#">
	SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.validation_response,
		screening_answerfield.option_id,
		'checked' as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id
			WHERE
		screening_answerfield.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="4"> AND
		screening_answerfield.answerfield_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#answerfield_id#" maxlength="4">

        </cfquery>
        <cfreturn  queryGSA>
    </cffunction>

    <!-- getScreeningAnswerfieldValidation -->
    <cffunction access="remote" name="getScreeningAnswerfieldValidation1" output="false" returntype="query"  hint="Get Screening Answerfield Data"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="answerfield_id" type="numeric" required="yes"  >
        <cfset queryGSA = QueryNew("answerfield_id,screening_id,responsetype,response,validation_response, option_id, response, display_id, include_flag")>
        <cfquery name="queryGSA" datasource="#application.dbSrc#">
SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.response,
		screening_answerfield.option_id,
		screening_answerfield.validation_response
		FROM
		screening_answerfield

		WHERE
		screening_answerfield.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="4"> AND
		screening_answerfield.answerfield_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#answerfield_id#" maxlength="4">

        </cfquery>
        <cfreturn  queryGSA>
    </cffunction>

    <!-- getScreeningAnswerfieldValidation -->
    <cffunction access="remote" name="getScreeningAnswerfieldValidation2" output="false" returntype="query"  hint="Get Screening Answerfield Data"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="answerfield_id" type="numeric" required="yes"  >
        <cfset queryGSA = QueryNew("answerfield_id,screening_id,responsetype,response,validation_response, option_id, response, display_id, include_flag")>
        <cfquery name="queryGSA" datasource="#application.dbSrc#">
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.validation_response,
		`option`.option_id,
		`option`.option_code as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id

		WHERE
		screening_answerfield.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="4"> AND
		screening_answerfield.answerfield_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#answerfield_id#" maxlength="4">


        </cfquery>
        <cfreturn  queryGSA>
    </cffunction>

    <!-- getScreeningAnswerfieldValidaton -->
    <cffunction access="remote" name="getScreeningAnswerfieldValidation3" output="false" returntype="query"  hint="Get Answerfield Data"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="answerfield_id" type="numeric" required="yes"  >
        <cfset queryGSA = QueryNew("answerfield_id,screening_id,responsetype,response,validation_response, option_id, response, display_id, include_flag")>
        <cfquery name="queryGSA" datasource="#application.dbSrc#">
		SELECT
		screening_answerfield.answerfield_id,
		screening_answerfield.screening_id,
		screening_answerfield.responsetype,
		screening_answerfield.response,
		screening_answerfield.validation_response,
		`option`.option_id,
		'checked' as response,
		`option`.display_id,
		`option`.include_flag
		FROM
		screening_answerfield
		INNER JOIN `option` ON screening_answerfield.option_id = `option`.option_id

			WHERE
		screening_answerfield.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="4"> AND
		screening_answerfield.answerfield_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#answerfield_id#" maxlength="4">

        </cfquery>
        <cfreturn  queryGSA>
    </cffunction>

    <!-- getValidationMessage -->
    <cffunction access="remote" name="getValidationMessage" output="false" returntype="query"  hint="Get Display Text for Validation Messages"  >
        <!-- pass arguments -->
        <cfargument name="display_code" type="string" required="yes"  >
        <cfset queryVM = QueryNew("display_id,displaygroup_id,display_code,display_name,display_text")>
        <cfquery name="queryVM" datasource="#application.dbSrc#">
		SELECT
		display.display_id,
		display.displaygroup_id,
		display.display_code,
		display.display_name,
		display_language.display_text
		FROM
		display
		INNER JOIN displaygroup ON display.displaygroup_id = displaygroup.displaygroup_id
		INNER JOIN display_language ON display_language.display_id = display.display_id
		WHERE
		display.displaygroup_id = 15
		and display_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#display_code#" maxlength="50">

		and language_id = 'EN'"

						</cfquery>
        <cfreturn  queryVM>
    </cffunction>


    <!-- getAFValidationShort -->
    <cffunction access="remote" name="getAFValidationShort" output="false" returntype="query"  hint="Get Validation Text for Field Validations"  >
        <!-- pass arguments -->
        <cfargument name="display_code" type="string" required="yes"  >
        <cfset queryAFS = QueryNew("display_id,displaygroup_id,display_code,display_name,display_text")>
        <cfquery name="queryAFS" datasource="#application.dbSrc#">
SELECT
		display.display_id,
		display.displaygroup_id,
		display.display_code,
		display.display_name,
		display_language.display_text
		FROM
		display
		INNER JOIN displaygroup ON display.displaygroup_id = displaygroup.displaygroup_id
		INNER JOIN display_language ON display_language.display_id = display.display_id
		WHERE
		display.displaygroup_id = 14
		and display_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#display_code#" maxlength="50">
		and language_id = 'EN'

		</cfquery>
        <cfreturn  queryAFS>
    </cffunction>

<!--- Lynna Cekova: for the report --->

    <cffunction access="remote" name="getSAF" output="false" returntype="query"  hint="Get field response list by screening_id for report data processing"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfset queryAFS = QueryNew("screening_id")>
        <cfquery name="querySAF" datasource="#application.dbSrc#">
SELECT a.answerfield, o.option_id, o.option_code, sa.response
FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id
LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id WHERE sa.screening_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="20">
 ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime


		</cfquery>
        <cfreturn  querySAF>
    </cffunction>

    <cffunction access="remote" name="getAFShadow" output="false" returntype="query"  hint="Get field List by screening_id For report data processing - shadow programs"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfset queryAFS = QueryNew("screening_id")>
        <cfquery name="querySAFS" datasource="#application.dbSrc#">

SELECT a.answerfield, o.option_id, o.option_code, sa.response
FROM answerfield a INNER JOIN screening_answerfield sa ON sa.answerfield_id = a.answerfield_id LEFT OUTER JOIN `option` o ON sa.option_id = o.option_id WHERE sa.screening_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="20">
 ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime

		</cfquery>
        <cfreturn  querySAFS>
    </cffunction>

    <cffunction access="remote" name="getPrograms" output="false" returntype="query"  hint="returns program data for eligibility by screening id"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfset queryP = QueryNew("screening_id")>
        <cfquery name="queryP" datasource="#application.dbSrc#">

select distinct sp.program_id, p.programcategory_id, p.program_code, p.name_display_id from program p INNER JOIN screening_program sp ON sp.program_id = p.program_id where screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="20">

        </cfquery>
        <cfreturn  queryP>
    </cffunction>

    <cffunction access="remote" name="getCounty" output="false" returntype="query"  hint="Get the county associated with a zip code"  >
        <!-- pass arguments -->
        <cfargument name="string_zip" type="string" required="yes"  >
        <cfset queryC = QueryNew("zip_code")>
        <cfquery name="queryC" datasource="#application.dbSrc#">
SELECT
z.zipcode,
z.county_id,
c.county_id,
c.state_id,
c.county_name,
c.valid,
c.map_id,
c.update_valid,
s.state_name
FROM
county AS c
INNER JOIN zip AS z ON z.county_id = c.county_id
INNER JOIN state as s ON s.state_id = c.state_id
and z.zipcode = <cfqueryparam cfsqltype="cf_sql_varchar" value="#string_zip#" maxlength="100">
and s.statetype_id = 1
        </cfquery>
        <cfreturn  queryC>
    </cffunction>

    <cffunction access="remote" name="getShip" output="false" returntype="query"  hint="Get Ship program data by state"  >
        <!-- pass arguments -->
        <cfargument name="state_id" type="string" required="yes"  >
        <cfset querySHIP = QueryNew("zip_code")>
        <cfquery name="querySHIP" datasource="#application.dbSrc#">
select program_id from program where program_code like 'counseling%_ship' and active_flag = 1 and state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="30">

        </cfquery>
        <cfreturn  querySHIP>
    </cffunction>

    <cffunction access="remote" name="getRecContentBySection" output="false" returntype="query"  hint="Get Sorted Recommendations Content for a screening by section"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfargument name="section_code" type="string" required="yes"  >
        <cfset queryContent = QueryNew("post_id, content_code, screening_id,sort_order, category_id")>
        <cfquery name="queryContent" datasource="#application.dbSrc#">
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id,
subset_content.sort_order,
1 as programcategory_id,
'' as program_id,
'' as programgroup_id,
0 as bcu_link_flag
FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
where
screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="30">
 and subset_content.subset_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
 and subset_content.section_code = <cfqueryparam cfsqltype="cf_sql_varchar" value="#section_code#" maxlength="30">

order by sort_order

	</cfquery>
        <cfreturn  queryContent>
    </cffunction>

    <cffunction access="remote" name="getRecommendations" output="false" returntype="query"  hint="Get Sorted Recommendations Content for a screening"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset queryContent = QueryNew("post_id, content_code, screening_id,sort_order, section_code,programcategory_id,program_id,programgroup_id,bcu_link_flag")>
        <cfquery name="queryContent" datasource="#application.dbSrc#">
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id,
subset_content.sort_order,
subset_content.section_code,
1 as programcategory_id,
'' as program_id,
'' as programgroup_id,
0 as bcu_link_flag

FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
where
screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="30">
 and subset_content.subset_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">

order by section_code, sort_order

	</cfquery>
        <cfreturn  queryContent>
    </cffunction>

	<cffunction access="remote" name="getPersonalReport" output="false" returntype="query"  hint="Get Sorted Personalized Report Content for a screening"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset queryContent = QueryNew("post_id, content_code, screening_id,sort_order, section_code,programcategory_id,program_id,programgroup_id,bcu_link_flag,report_conten,post_titlet")>
        <cfquery name="queryContent" datasource="#application.dbSrc#">
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
screening_content.screening_id,
subset_content.sort_order,
subset_content.section_code,
screening.preset_state_id as state_id,
1 as programcategory_id,
'' as program_id,
'' as programgroup_id,
0 as bcu_link_flag,
'' as report_content,
'' as post_title,
subset_content.is_image,
subset_content.parent_id,
subset_content.sub_section
FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
INNER JOIN screening ON screening.screening_id = screening_content.screening_id
where
screening.screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#screening_id#" maxlength="30">
and subset_content.subset_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
order by section_code, sort_order

	</cfquery>
	<cfset x = 0>
	<cfset wp_db_version = 'wp_posts_v3_1' >
	<cfif screening_id lt 5 >
		<cfset wp_db_version = 'wp_posts_v2_0' >
	</cfif>
	<cfloop query="queryContent">
    		<cfset x = x + 1>
		<cfquery name="querySAFS" datasource="wp_benefitscheckup">
		select post_title, post_content from <cfoutput>wp_benefitscheckup.#wp_db_version#</cfoutput>
		where ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#post_id#" maxlength="4">
        	</cfquery>
		<cfif queryContent.state_id eq 'ak'>
			<cfset spap_text = "Alaska Senior Benefits">
		<cfelseif queryContent.state_id eq 'de'>
			<cfset spap_text = "Delaware Prescription Assistance Program (DPAP)">
		<cfelseif queryContent.state_id eq 'in'>
			<cfset spap_text = "HoosierRx (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'ma'>
			<cfset spap_text = "Prescription Advantage Plan (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'md'>
			<cfset spap_text = "Maryland Senior Prescription Drug Assistance Program (SPDAP)">
		<cfelseif queryContent.state_id eq 'me'>
			<cfset spap_text = "Maine Low Cost Drugs for the Elderly or Disabled (DEL) or Maine Rx Plus">
		<cfelseif queryContent.state_id eq 'mo'>
			<cfset spap_text = "Missouri Rx Plan (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'mt'>
			<cfset spap_text = "Montana Big Sky Rx Program (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'nj'>
			<cfset spap_text = "Pharmaceutical Assistance to the Aged & Disabled (PAAD)">
		<cfelseif queryContent.state_id eq 'nv'>
			<cfset spap_text = "Nevada Senior Rx (State Pharmacy Assistance Program)">
		<cfelseif queryContent.state_id eq 'ny'>
			<cfset spap_text = "Elderly Pharmaceutical Insurance Coverage (EPIC)">
		<cfelseif queryContent.state_id eq 'or'>
			<cfset spap_text = "Oregon Prescription Drug Assistance">
		<cfelseif queryContent.state_id eq 'pa'>
			<cfset spap_text = "PACE or PACENET (Pharmaceutical Assistance Contract for the Elderly)">
		<cfelseif queryContent.state_id eq 'ri'>
			<cfset spap_text = "Rhode Island Pharmaceutical Assistance to the Elderly (RIPAE)">
		<cfelseif queryContent.state_id eq 'vt'>
			<cfset spap_text = "VPharm or Healthy Vermonters">
		<cfelseif queryContent.state_id eq 'wa'>
			<cfset spap_text = "Washington Prescription Drug Program">
		<cfelseif queryContent.state_id eq 'wi'>
			<cfset spap_text = "Wisconsin SeniorCare (State Pharmacy Assistance Program)">
		<cfelse>
			<cfset spap_text = "SPAP">
		</cfif>

		<cfif queryContent.state_id eq 'ma'>
			<cfset med_text = "MassHealth">
		<cfelseif queryContent.state_id eq 'me'>
			<cfset med_text = "MaineCare">
		<cfelseif queryContent.state_id eq 'ky'>
			<cfset med_text = "KyHealth Choices">
		<cfelseif queryContent.state_id eq 'ct'>
			<cfset med_text = "Husky C">
		<cfelseif queryContent.state_id eq 'mo'>
			<cfset med_text = "HealthNet">
		<cfelseif queryContent.state_id eq 'wi'>
			<cfset med_text = "ForwardHealth Plan">
		<cfelseif queryContent.state_id eq 'wy'>
			<cfset med_text = "EqualityCare">
		<cfelseif queryContent.state_id eq 'az'>
			<cfset med_text = "AHCCCS">
		<cfelseif queryContent.state_id eq 'tn'>
			<cfset med_text = "TennCare">
		<cfelseif queryContent.state_id eq 'il'>
			<cfset med_text = "Medical Assistance">
		<cfelseif queryContent.state_id eq 'pa'>
			<cfset med_text = "Medical Assistance">
		<cfelseif queryContent.state_id eq 'ca'>
			<cfset med_text = "Medi-Cal">
		<cfelse>
			<cfset med_text = "Medicaid">
		</cfif>


		<cfset post_content = querySAFS.post_content>	
		<cfset post_content = ReplaceNoCase(post_content, '{medicaid_nm}', med_text, "ALL")>
		<cfset post_content = ReplaceNoCase(post_content, '{spap_nm}', spap_text, "ALL")>
		<cfset Temp = QuerySetCell(queryContent, "post_title", "#querySAFS.post_title#",x)>
    		<cfset Temp = QuerySetCell(queryContent, "report_content", "#post_content#",x)>
	</cfloop>


        <cfreturn  queryContent>
    </cffunction>

       <cffunction access="remote" name="getRecommendationsV2" output="false" returntype="query"  hint="Get Sorted Recommendations Content for a screening"  >
        <!-- pass arguments 5042755-->
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset queryContent = QueryNew("post_id, content_code, screening_id,sort_order, section_code,programcategory_id,program_id,programgroup_id,bcu_link_flag")>
        <cfquery name="queryContent" datasource="#application.dbSrc#">
SELECT Distinct
screening_content.post_id,
screening_content.content_code,
'#screening_id#' as screening_id,
subset_content.sort_order,
subset_content.section_code,
1 as programcategory_id,
'' as program_id,
'' as programgroup_id,
0 as bcu_link_flag

FROM
screening_content
INNER JOIN subset_content ON subset_content.post_code = screening_content.content_code
where
screening_id = <cfqueryparam cfsqltype="cf_sql_integer" value="5042755" maxlength="30">
 and subset_content.subset_id= <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
and screening_content.post_id <> 12569
order by section_code, sort_order

	</cfquery>
        <cfreturn  queryContent>
    </cffunction>
	

    <cffunction access="remote" name="getProgramContent" output="false" returntype="query"  hint="Get Content Associated with a program"  >
        <!-- pass arguments -->
        <cfargument name="program_id" type="numeric" required="yes"  >
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfset queryAFS = QueryNew("program_id")>
        <cfquery name="querySAFS" datasource="#application.dbSrc#">
SELECT
program.program_id,
program.programcategory_id,
program.programgroup_id,
program.state_id,
program.program_code,
program.name_display_id,
program.desc_display_id,
program.url,
dl2.language_id,
dl2.display_text as program_name,
dl1.display_text as program_desc
FROM
program
INNER JOIN display_language dl1 ON program.desc_display_id = dl1.display_id
INNER JOIN display_language dl2 ON program.name_display_id = dl2.display_id
and program.program_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#program_id#" maxlength="4">

and dl2.language_id = 'EN'
limit 1

		</cfquery>
        <cfreturn  querySAFS>
    </cffunction>

    <cffunction access="remote" name="getForms" output="false" returntype="query"  hint="get forms by state and program id"  >
        <!-- pass arguments -->
        <cfargument name="program_id" type="numeric" required="yes"  >
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfargument name="state_id" type="numeric" required="yes"  >
        <cfset queryAFS = QueryNew("program_id, state_id")>
        <cfquery name="querySAFS" datasource="#application.dbSrc#">

SELECT ft.string, t.tag_name,f.form_id,ft.formtype_id
			FROM program_form pf, form f, form_formtype ft, formtag t
			WHERE pf.program_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#program_id#" maxlength="4">

				AND pf.form_id=f.form_id
				and (f.state_id is null or f.state_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#state_id#" maxlength="4">
)
				AND f.form_id=ft.form_id
				AND ft.formtype_id
				 in (1,3,4)
				AND ft.active=1
				AND f.formtag_id=t.formtag_id
			ORDER BY pf.sort

		</cfquery>
        <cfreturn  querySAFS>
    </cffunction>

    <cffunction access="remote" name="getReqs" output="false" returntype="query"  hint="Get Program Required Materials by program_id"  >
        <!-- pass arguments -->
        <cfargument name="program_id" type="numeric" required="yes"  >
        <cfargument name="screening_id" type="numeric" required="yes"  >
        <cfset queryAFS = QueryNew("program_id")>
        <cfquery name="querySAFS" datasource="#application.dbSrc#">

SELECT
rq.`code`,
rq.requisite_id,
prq.sort,
p.program_id,
dl1.display_text as requiredmaterial,
dl2.display_text as reqtitle
FROM
program AS p ,
program_requisite AS prq ,
requisite AS rq
INNER JOIN display AS d ON rq.display_id = d.display_id
LEFT OUTER JOIN display AS dd ON rq.def_display_id = dd.display_id
INNER JOIN display_language dl1 ON dl1.display_id = dd.display_id
INNER JOIN display_language dl2 ON dl2.display_id = d.display_id
where p.program_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#program_id#" maxlength="4">

			and p.program_id=prq.program_id
			and prq.requisite_id=rq.requisite_id
		  and dl1.language_id = 'EN'
      and dl2.language_id = 'EN'
order by prq.sort

		</cfquery>
        <cfreturn  querySAFS>
    </cffunction>

    <cffunction access="remote" name="getOffice" output="false" returntype="query"  hint="Get Office details per entrypoint_id"  >
        <!-- pass arguments -->
        <cfargument name="entrypoint_id" type="numeric" required="yes"  >
        <cfset queryAFS = QueryNew("entrypoint_id")>
        <cfquery name="querySAFS" datasource="#application.dbSrc#">
		select e.code, e.name, e.subname, e.address1, e.address2, e.address3,
		e.city, e.state_id, e.zipcode, e.zipcode_plus4, e.email, e.url,
		e.contact_title, e.contact_first, e.contact_middle, e.contact_last,
		e.contact_suffix, dh.display_code hours_code, di.display_code info_code
	from entrypoint e left outer join display dh
			on e.hours_display_id=dh.display_id
		left outer join display di
			on e.info_display_id=di.display_id
	where e.entrypoint_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#entrypoint_id#" maxlength="4">
		and e.active_flag=1

		</cfquery>
        <cfreturn  querySAFS>
    </cffunction>

    <cffunction access="remote" name="getWPPost" output="false" returntype="query"  hint="Gets Post Content from the NCOA WP DB"  >
        <!-- pass arguments -->
        <cfargument name="post_id" type="numeric" required="yes"  >
        <cfset queryAFS = QueryNew("post_title, post_content")>
        <cfquery name="querySAFS" datasource="wp_benefitscheckup">
		select post_title, post_content from wp_benefitscheckup.wp_posts_v3_1
		where ID=<cfqueryparam cfsqltype="cf_sql_integer" value="#post_id#" maxlength="4">

        </cfquery>
        <cfreturn  querySAFS>
    </cffunction>
    <cffunction access="remote" name="getWPPostByCode" output="false" returntype="query"  hint="Gets Post Content from the NCOA WP DB by content code"  >
        <!-- pass arguments  -->
        <cfargument name="post_code" type="string" required="yes"  >
        <cfset queryAFS = QueryNew("post_title, post_content")>
        <cfquery name="querySAFS" datasource="wp_benefitscheckup">
		select post_title, post_content from wp_benefitscheckup.wp_posts_v3_1
		where post_code like '#post_code#'
		</cfquery>
        <cfreturn  querySAFS>
    </cffunction>

    <cffunction access="remote" name="getStateCarrier" output="false" returntype="query"  hint="Get Carriers by State"  >
        <!-- pass arguments -->
        <cfargument name="screening_id" type="numeric" required="yes"   >
        <cfargument name="state_zip" type="string" required="yes" default="" >
        <cfargument name="star_rating" type="string" required="yes"  >
        <cfargument name="partner_id" type="numeric" required="no"  default="0">
        <cfset state_id = state_zip>
<!--- check state and zip data --->
        <cfif len(state_zip) lt 2>
            <cfset state_id = 'FD'>
        </cfif>
        <cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
                <cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery">
                        <cfinvokeargument name="zipcode" value="#state_zip#"/>
                </cfinvoke>
            <cfset state_id = statequery.state_id>
        </cfif>
        <cfif not isnumeric(star_rating)>
            <cfset star_rating = 1 >
        </cfif>
        <cfset querySC = QueryNew("state_id,state_name,name,phone_existing,phone_new,website, star_rating,havePDP,haveMSP,haveMA,isAHN")>
        <cfquery name="querySC" datasource="#application.dbSrc#">
		select name, website, sc.state_id, s.state_name, phone_existing,phone_new, star_rating, havePDP,haveMSP,haveMA,isAHN
		from statecarrier sc
		left join state s on sc.state_id = s.state_id
		where s.state_id = '#state_id#' and sc.star_rating >= #star_rating#
        </cfquery>
        <cfreturn  querySC>
    </cffunction>



       <cffunction access="remote" name="getStateDetails" output="false" returntype="query"  hint="Get State Name by state or zip"  >
        <!-- pass arguments -->
        <cfargument name="state_zip" type="string" required="yes" default="" >
	<cfargument name="statetype_id" type="numeric" required="yes" default="1" >
        <cfset queryState = QueryNew("statetype_id,statetype_name,state_id,statetype_id,state_name,state_map_code,state_map_code2")>
        <cfset state_id = state_zip>
	<!--- check state and zip data --->
        <cfif len(state_zip) lt 2>
            <cfset state_id = 'FD'>
        </cfif>
        <cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
                <cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery">
                        <cfinvokeargument name="zipcode" value="#state_zip#"/>
                </cfinvoke>
            <cfset state_id = statequery.state_id>
        </cfif>
        <cfquery name="queryState" datasource="#application.dbSrc#">
		SELECT
		statetype.statetype_id,
		statetype.statetype_name,
		state.state_id,
		state.statetype_id,
		state.state_name,
		state.state_map_code,
		state.state_map_code2
		FROM
		statetype
		INNER JOIN state ON state.statetype_id = statetype.statetype_id
		WHERE state.state_id = '#state_id#'
		and statetype.statetype_id = #statetype_id#
	</cfquery>
        <cfreturn  queryState>
    </cffunction>

       <cffunction access="remote" name="getStateDetailsV2" output="false" returntype="query"  hint="Get State Name by state or zip"  >
        <!-- pass arguments -->
        <cfargument name="state_zip" type="string" required="yes" default="" >
	<cfargument name="statetype_id" type="numeric" required="yes" default="1" >
        <cfset queryState = QueryNew("statetype_id,statetype_name,state_id,statetype_id,state_name,state_map_code,state_map_code2")>
        <cfset state_id = state_zip>
	<!--- check state and zip data --->
        <cfif len(state_zip) lt 2>
            <cfset state_id = 'FD'>
        </cfif>
        <cfif (isnumeric(state_zip)) and (len(state_zip) eq 5)>
                <cfinvoke  component="util" method="getStateCountyFromZip" returnVariable="statequery">
                        <cfinvokeargument name="zipcode" value="#state_zip#"/>
                </cfinvoke>
            <cfset state_id = statequery.state_id>
        </cfif>
        <cfquery name="queryState" datasource="#application.dbSrc#">
		SELECT
		statetype.statetype_id,
		statetype.statetype_name,
		state.state_id,
		state.statetype_id,
		state.state_name,
		state.state_map_code,
		state.state_map_code2
		FROM
		statetype
		INNER JOIN state ON state.statetype_id = statetype.statetype_id
		WHERE state.state_id = '#state_id#'
		and statetype.statetype_id = #statetype_id#
	</cfquery>
        <cfreturn  queryState>
    </cffunction>

    <cffunction access="remote" name="getQuestionDependencies1" output="false" returntype="query"  hint="return all programs in subset"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset querySubsetProgram = QueryNew("question_id,dep_question_id,question_code,subset_id,rule_id,code,rule_text,rule_id")>
        <cfquery name="querySubsetProgram" datasource="#application.dbSrc#">
            SELECT
            q.question_id,
            q.dep_question_id,
            q.question_code,
            sq.subset_id,
            q.rule_id,
            r.code,
            r.rule_text,
            r.rule_id
            FROM
            subset_question sq
            INNER JOIN question q ON q.question_id = sq.question_id
            INNER JOIN rule r ON r.rule_id = q.rule_id
            WHERE
            q.rule_id is not null
            and sq.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		</cfquery>
        <cfreturn  querySubsetProgram>
    </cffunction>

<cffunction access="remote" name="getQuestionRules" output="false" returntype="query"  hint="return all programs in subset"  >
        <!-- pass arguments -->
        <cfargument name="subset_id" type="numeric" required="yes"  >
        <cfset querySubsetProgram = QueryNew("question_id,dep_question_id,question_code,subset_id,rule_id,code,rule_text,rule_id,rule_text_mqc, rule_type,rule_answerfield_type,ruling_question_code")>
        <cfquery name="querySubsetProgram" datasource="#application.dbSrc#">
SELECT

            q.question_id,

            q.dep_question_id,

            q.question_code,

            sq.subset_id,

            q.rule_id,

            r.code,

            r.rule_text,

            r.rule_id,

            r.rule_text_mqc,

            r.rule_type,

            r.rule_answerfield_type,

            r.ruling_question_code

            FROM

            question_rule qr

            INNER JOIN question q ON q.question_id = qr.question_id

            INNER JOIN rule r ON r.rule_id = qr.rule_id

            INNER JOIN subset_question sq on qr.question_id = sq.question_id

            and sq.subset_id = <cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		</cfquery>
        	<cfreturn  querySubsetProgram>
   	 </cffunction>
	<cffunction access="remote" name="getSummaryContent" output="false" returntype="string"  hint="Get Report Summary HTML"  >
        	<!-- pass arguments -->
        	<cfargument name="screening_id" type="numeric" required="yes"   >
		<cfset htmlDoc = "">
		<!--- Set the URL address. --->
		<cfset urlAddress="https://www.benefitscheckup.org/show_summary.php?screeningID=#screening_id#">
		<cfhttp url="#urladdress#" method="GET" resolveurl="Yes" throwOnError="No"/>

		<cfset htmlDoc = "<ul>" & CFHTTP.FileContent & "</ul>">
		<cfreturn htmlDoc >
	</cffunction>
	<cffunction access="remote" name="getShipContent" output="false" returntype="string"  hint="Get Ship HTML"  >
        	<!-- pass arguments -->
        	<cfargument name="zipcode" type="numeric" required="yes"   >
		<cfif len(zipcode) lt 5></cfif>
		<cfset htmlDoc = "">
		<cfparam name="zip" type="numeric" default="0">
		<cfparam name="p_id" type="numeric" default="0">
		<cfquery name="getStateCountyData" datasource="#application.dbSrc#">
			select c.county_id, c.county_name, z.state_id, z.latitude, z.longitude, z.zipcode
			from zip z, county c
			where z.zipcode=<cfqueryparam cfsqltype="cf_sql_integer" value="#zipcode#" maxlength="5">
				and z.valid=1
				and z.county_id=c.county_id
		</cfquery>
		<cfif getStateCountyData.recordcount gt 0>
		<cfquery name="querySHIP" datasource="#application.dbSrc#">
			select program_id from program 
			where program_code like 'counseling%_ship' and active_flag = 1 and state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getStateCountyData.state_id#" maxlength="30">
		 </cfquery>
			<cfset p_id = querySHIP.program_id>
		</cfif>
		<!--- Set the URL address. --->
		<cfset urlAddress="https://www.benefitscheckup.org/cf/util/showep.cfm?program_id=#p_id#&zip=#getStateCountyData.zipcode#">
		<cfhttp url="#urladdress#" method="GET" resolveurl="Yes" throwOnError="No"/>

		<cfset htmlDoc = CFHTTP.FileContent & "</div>">
		<cfreturn #ReplaceNoCase(htmlDoc, "class='factSheetH2'>", "")# >
	</cffunction>

	<cffunction access="remote" name="getShipContentObject" output="false" returntype="struct"  hint="Get Ship Name, details and URL"  >
        	<!-- pass arguments -->
        	<cfargument name="zipcode" type="numeric" required="yes"   >
		<cfif len(zipcode) lt 5></cfif>
		<cfset theResult = structNew()>
		<cfparam name="zip" type="numeric" default="0">
		<cfparam name="p_id" type="numeric" default="0">
		<cfquery name="getStateCountyData" datasource="#application.dbSrc#">
			select c.county_id, c.county_name, z.state_id, z.latitude, z.longitude, z.zipcode
			from zip z, county c
			where z.zipcode=<cfqueryparam cfsqltype="cf_sql_integer" value="#zipcode#" maxlength="5">
				and z.valid=1
				and z.county_id=c.county_id
		</cfquery>
		<cfif getStateCountyData.recordcount gt 0>
		<cfquery name="querySHIP" datasource="#application.dbSrc#">
			select program_id from program 
			where program_code like 'counseling%_ship' and active_flag = 1 and state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getStateCountyData.state_id#" maxlength="30">
		 </cfquery>
<cfquery name="querySHIP_EP" datasource="#application.dbSrc#">
 select eg.entrypoint_id
        from program_entrypointgroup pe, entrypointgroup g, entrypoint_entrypointgroup eg, entrypoint e
       where pe.program_id= <cfqueryparam cfsqltype="cf_sql_varchar" value="#querySHIP.program_id#" maxlength="30">
                 and pe.entrypointgroup_id=g.entrypointgroup_id
               and g.active_flag=1
                 and g.entrypointgroup_id=eg.entrypointgroup_id
                 and eg.entrypoint_id=e.entrypoint_id
                 and e.state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#getStateCountyData.state_id#" maxlength="30">
               and e.active_flag=1
		 </cfquery>

<cfquery name="querySHIP_NURL" datasource="#application.dbSrc#">
select e.name, e.subname, e.address1, e.address2, e.address3, 
  e.city, e.state_id, e.zipcode, e.zipcode_plus4, e.email, e.url,
                  e.contact_title, e.contact_first, e.contact_middle, e.contact_last,
                 e.contact_suffix, dh.display_code hours_text, di.display_text info_text
         from entrypoint e left outer join display dh 
                         on e.hours_display_id=dh.display_id
                 left outer join display_language di
                         on e.info_display_id=di.display_id
         where e.entrypoint_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#querySHIP_EP.entrypoint_id#" maxlength="30"> and di.language_id='EN'
                  and e.active_flag=1

</cfquery>

<cfquery name="querySHIP_HOURS" datasource="#application.dbSrc#">
select e.name, di.display_text hours_text
         from entrypoint e left outer join display dh 
                         on e.hours_display_id=dh.display_id
                 left outer join display_language di
                         on e.hours_display_id=di.display_id
         where e.entrypoint_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#querySHIP_EP.entrypoint_id#" maxlength="30"> and di.language_id='EN'
                  and e.active_flag=1

</cfquery>

<cfquery name="querySHIP_PHONE" datasource="#application.dbSrc#">

 select distinct p.number as phone_number, dl.display_text as phone_text
         from phone p, phonetype pt, display_language dl
         where p.entrypoint_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#querySHIP_EP.entrypoint_id#" maxlength="30"> 
                and p.phonetype_id=pt.phonetype_id
                 and pt.display_id=dl.display_id and dl.language_id='EN'
                order by p.sort

</cfquery>
		</cfif>

<!---		<cfset theResult["program_id"] = querySHIP.program_id> --->
<!---		<cfset theResult["entrypoint_id"] = querySHIP_EP.entrypoint_id> --->
		<cfset theResult["state_id"] = getStatecountyData.state_id>
		<cfset theResult["program_name"] = querySHIP_NURL.name>
		<cfset theResult["url"] = querySHIP_NURL.url>
		<cfset theResult["program_info"] = querySHIP_NURL.info_text>
		<cfset theResult["hours_info"] = querySHIP_HOURS.hours_text>
		<cfset theResult["phone_count"] = querySHIP_PHONE.recordcount>

		<cfset rownum = 0>
<cfloop query="querySHIP_PHONE">
		<cfset rownum = rownum + 1>
		<cfset theResult["phone_text" & rownum] = querySHIP_PHONE.phone_text>
		<cfset theResult["phone_number" & rownum] = querySHIP_PHONE.phone_number>
</cfloop>


		<cfreturn theResult >
	</cffunction>



	<cffunction name="getStateCountyFromZip" access="public"  output="false" returntype="query"  hint="returns a valid state,county, lat,lon if exists for a zipcode" >
		<cfargument name="zipcode" type="numeric" required="yes" >
		<cfquery name="getStateCountyData" datasource="#application.dbSrc#">
			select c.county_id, c.county_name, z.state_id, z.latitude, z.longitude
			from zip z, county c, state s
			where z.zipcode='#zipcode#'
				and z.valid=1
				and z.county_id=c.county_id
        			and s.state_id = z.state_id 		
				and s.statetype_id = 1
		</cfquery>
		<cfreturn getStateCountyData>
	</cffunction>
</cfcomponent>

