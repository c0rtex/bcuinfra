
<cfset nullStr = '[zzz[null]zzz]'>
<cfparam name="attributes.action" type="string" default="start">
<cfparam name="attributes.mode" type="string" default="#nullStr#">
<cfparam name="attributes.id" type="string" default="#nullStr#">
<cfparam name="attributes.qno" type="string" default="#nullStr#">
<cfparam name="attributes.cat" type="string" default="#nullStr#">
<cfparam name="attributes.pgno" type="string" default="#nullStr#">
<cfparam name="attributes.pglist" type="string" default="#nullStr#">
<cfparam name="attributes.dview" type="string" default="#nullStr#">
<cfparam name="attributes.cont" type="string" default="#nullStr#">
<cfparam name="attributes.recap" type="string" default="#nullStr#">
<cfparam name="attributes.closed" type="string" default="#nullStr#">
<cfparam name="attributes.element" type="string" default="">
<cfparam name="attributes.var" type="string" default="">
<cfparam name="attributes.basics" type="boolean" default="false">
<cfparam name="attributes.screening_id" type="numeric" default="0">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.initvarname" type="string" default="">
<cfparam name="attributes.aflistvarname" type="string" default="">
<cfparam name="attributes.loadsession" type="boolean" default="false">
<cfparam name="attributes.debug" type="boolean" default="false">

<cfif attributes.action eq 'reload' and attributes.state_id neq ''>
	<cfset session.state_id = attributes.state_id>
	<cfset session.prev_id = session.screening.id>
	<cfset attributes.action = 'start'>
</cfif>

<cfif attributes.action eq 'kill'>
<!--- KILL action:  utterly delete the screening from memory --->

	<cfset StructDelete(session, 'screening')>

<cfelseif attributes.action eq 'end'>
<!--- END action:  log the end of a screening and close the screening --->

	<!--- Use attributes.screening_id if passed in, else use session.screening.id from session --->
	<cfset screening_id = 0>
	<cfif attributes.screening_id gt 0>
		<cfset screening_id = attributes.screening_id>
	<cfelseif IsDefined('session.screening.id') and session.screening.id gt 0>
		<cfset screening_id = session.screening.id>
	</cfif>
	<cfif screening_id gt 0>
		<!--- UPDATE screening.end_datetime in database --->
		<cfquery name="logScreeningEnd" datasource="#application.dbSrc#">
			UPDATE screening 
			SET end_datetime=#CreateODBCDateTime(Now())#
			WHERE screening_id=#screening_id#
		</cfquery>
	</cfif>
	<!--- MARK screening session object as closed --->
	<cfset session.screening.closed = 1>

<cfelseif attributes.action eq 'set' or attributes.action eq 'reset'>

	<cfif attributes.action eq 'reset'>
		<cfset StructDelete(session, 'screening')>
	</cfif>
	<cfset init = false>
	<cfif not IsDefined('session.screening') or not IsStruct(session.screening)>
		<cfset session.screening = StructNew()>
		<cfset session.screening.q = StructNew()>
		<cfset session.screening.qsort = StructNew()>
		<cfset session.screening.head = StructNew()>
		<cfset init = true>
	</cfif>

	<cfif attributes.mode eq nullStr>
		<cfif init>
			<cfset session.screening.mode = 'dynamic'>
		</cfif>
	<cfelse>
		<cfset session.screening.mode = attributes.mode>
	</cfif>
	<cfif attributes.id eq nullStr>
		<cfif init>
			<cfset session.screening.id = 0>
		</cfif>
	<cfelse>
		<cfset session.screening.id = attributes.id>
	</cfif>
	<cfif attributes.qno eq nullStr>
		<cfif init>
			<cfset session.screening.qno = 0>
		</cfif>
	<cfelse>
		<cfset session.screening.qno = attributes.qno>
	</cfif>
	<cfif attributes.cat eq nullStr>
		<cfif init>
			<cfset session.screening.cat = ''>
		</cfif>
	<cfelse>
		<cfset session.screening.cat = attributes.cat>
	</cfif>
	
	<cfif session.screening.mode neq 'print'>
		<cfif init>
			<cfset session.screening.a = StructNew()>
			<cfset session.screening.pg = StructNew()>
		</cfif>
		<cfif attributes.pgno eq nullStr>
			<cfif init>
				<cfset session.screening.pgno = 1>
			</cfif>
		<cfelse>
			<cfset session.screening.pgno = attributes.pgno>
		</cfif>
		<cfif attributes.pglist eq nullStr>
			<cfif init>
				<cfset session.screening.pglist = ''>
			</cfif>
		<cfelse>
			<cfset session.screening.pglist = attributes.pglist>
		</cfif>
		<cfif attributes.dview eq nullStr>
			<cfif init>
				<cfset session.screening.dview = 0>
			</cfif>
		<cfelse>
			<cfset session.screening.dview = attributes.dview>
		</cfif>
		<cfif attributes.cont eq nullStr>
			<cfif init>
				<cfset session.screening.cont = 0>
			</cfif>
		<cfelse>
			<cfset session.screening.cont = attributes.cont>
		</cfif>
		<cfif attributes.recap eq nullStr>
			<cfif init>
				<cfset session.screening.recap = 0>
			</cfif>
		<cfelse>
			<cfset session.screening.recap = attributes.recap>
		</cfif>
		<cfif attributes.closed eq nullStr>
			<cfif init>
				<cfset session.screening.closed = 0>
			</cfif>
		<cfelse>
			<cfset session.screening.closed = attributes.closed>
		</cfif>
	</cfif>

<cfelseif attributes.action eq 'get'>

	<cfif IsDefined('session.screening') and IsStruct(session.screening)>
		<cfif not IsDefined('session.screening.mode')>
			<cfset session.screening.mode = "">
		</cfif>
		<cfset outStr = Evaluate("session.screening.#attributes.element#")>
	<cfelse>
		<cfset outStr = ''>
	</cfif>
	<cfset "caller.#attributes.var#" = outStr>
	
<cfelse>

<!--- START action:  log the start of a screening and initialize structure --->

	<cfif attributes.mode eq nullStr>
		<cfset attributes.mode = 'dynamic'>
	</cfif>

	<cf_cacheSubsetPool action="get" subset_id="#session.subset_id#" var="subsetobj">
	<cfif subsetobj.type eq 'application'>
		<cfset isApplication = true>
		<cfset sqState = ''>
	<cfelse>
		<cfset isApplication = false>
		<cfset sqState = session.state_id>
	</cfif>
	<cfset donewith = #structclear(subsetobj)#>
	<cfif attributes.mode neq 'print'>
		<!--- Delete user responses from any previous screening --->
		<!--- START OBSOLESCENT:  This section will be obsolete when we stop putting responses directly in session --->
		<cf_loopPoolStruct struct="application.answerfieldPool.getAnswerfields()" index="af">
        	<cfset ansObj = application.answerfieldPool.getAnswerfield(af)> 
			<cfset StructDelete(session, af)>
			<cfif not isApplication>
                 <cfset rx = ansObj.rx>
				<cfif not rx>
					<cfset "session.#af#" = 0>
				</cfif>
			</cfif>
		</cf_loopPoolStruct>
		<cfset session.strclient = 'self'>
		<!--- This query is good and updated, JR - 2/22/10 Cached query per iteration for one day --->
		<cfquery name="getExplicitAnswerfields" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
			select a.answerfield, asp.default_value
			from answerfield_subset_partner asp, (
					select answerfield_id, subset_id, max(partner_id) partner_id
					from answerfield_subset_partner
					where subset_id=<cfqueryparam CFSQLType="CF_SQL_INTEGER" value="#session.subset_id#">
						and (partner_id is null or partner_id=#session.partner_id#)
						and background_flag=1
					group by answerfield_id, subset_id
				) q, answerfield a
			where asp.answerfield_id=q.answerfield_id
				and asp.subset_id=q.subset_id
				and (asp.partner_id=q.partner_id or (asp.partner_id is null and q.partner_id is null))
				and asp.background_flag=1
				and q.answerfield_id=a.answerfield_id
			order by a.answerfield
		</cfquery>
		<!--- MONEIL Bug 5820: Removed comment below; was forcing IE in to quirks mode --->
		<!--- <!-- These values need to be placed elsewhere in the screening --> --->
		<cfloop query="getExplicitAnswerfields">
			<cf_translateAnswerfieldIntoSession code="#answerfield#" value="#default_value#">
		</cfloop>
		<!--- MONEIL Bug 5820: Removed comment below; was forcing IE in to quirks mode --->
		<!--- <!-- END OBSOLESCENT --> --->
	</cfif>
	<!--- MONEIL Bug 5820: Removed comment below; was forcing IE in to quirks mode --->
	<!--- <!-- Initialize session.screening structure --> --->
	<cf_handleScreening action="reset" mode="#attributes.mode#">
	<!--- MONEIL Bug 5820: Removed comment below; was forcing IE in to quirks mode --->
	<!--- <!-- The two variables below should be phased out along with all basic session-scope answerfields --> --->
	<cfif attributes.mode neq 'print'>
		<cfset session.screening.selectedDrugs=''>
		<cfset session.selectedDrugs=''>
	</cfif>
		<cfif attributes.debug><cfoutput><br>basics: #attributes.basics# cacheSubsetQuestionPool action="get" basics="true" subset_id="#session.subset_id#" partner_id="#session.partner_id#" var="qaire"</cfoutput></cfif>
	<cfif attributes.basics >
		<cf_cacheSubsetQuestionPool action="get" basics="true" subset_id="#session.subset_id#" partner_id="#session.partner_id#" var="qaire">
	<cfelse>
		<cf_cacheSubsetQuestionPool action="get" app="#isApplication#" state_id="#sqState#" subset_id="#session.subset_id#" partner_id="#session.partner_id#" var="qaire">
	</cfif>
    <cfif attributes.debug><cfoutput><br><cfdump var="#qaire#"> </cfoutput></cfif>
    
	<cfset qCount = 0>
	<cf_loopPoolStruct struct="qaire" index="qu">
        <cfset qobj = application.QuestionPool.getQuestion(qu)>
		<cfif qobj.spx eq 0>
			<cfset qCount = qCount + 1>
			<cfif attributes.mode eq 'print'>
				<cf_handleScreeningQuestion mode="#attributes.mode#" code="#qu#">
			<cfelse>
				<cf_handleScreeningQuestion mode="#attributes.mode#" code="#qu#" spg="#Evaluate("qaire.q.#qu#.pg")#">
			</cfif>
			<cfset StructInsert(session.screening.qsort, qCount, qu)>
            <cfset qobj = application.QuestionPool.getQuestion(qu)>
			<cf_loopPoolStruct struct="qobj" index="af">
            	<cfset ansObj = application.answerfieldPool.getAnswerfield(af)>
                <cfset req = ansObj.req>
				<cfif req>
					<cf_handleScreeningAnswerfield code="#af#" req="1">
				</cfif>
			</cf_loopPoolStruct>
		</cfif>
	</cf_loopPoolStruct>
	<cfset clearqaire = #structclear(qaire)#>
	<cfif attributes.mode neq 'print'>
		<cfquery name="getRequiredAFs" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
			select qa.answerfield_id, a.answerfield, sa.required, qa.sort, r.recap_code
			from subset_question sq
				inner join question_answerfield qa
					on sq.subset_id=#session.subset_id# and sq.question_id=qa.question_id
				inner join answerfield a
					on qa.answerfield_id=a.answerfield_id
				left outer join subset_answerfield sa
					 on sa.subset_id=#session.subset_id# and qa.answerfield_id=sa.answerfield_id
				left outer join recap r
					 on sa.recap_id=r.recap_id
			group by a.answerfield, qa.answerfield_id, sa.required, qa.sort, r.recap_code
			order by a.answerfield
		</cfquery>
		<cfloop query="getRequiredAFs">
			<cf_handleScreeningAnswerfield code="#answerfield#" req="#required#" recap="#recap_code#">
		</cfloop>
		<cfif session.prev_id eq '' or not IsNumeric(session.prev_id) or session.prev_id eq 0>
			<cfset session.screening.prepopulate = 0>
		<cfelse>
			<cfquery name="getPrevScreening" datasource="#application.dbSrc#" cachedwithin="#CreateTimeSpan(0,0,0,0)#">
				SELECT a.answerfield, sa.responsetype, sa.response, o.option_id, o.option_code,
					sa.encryption_flag, sa.encrypted_response
				FROM answerfield a INNER JOIN screening_answerfield sa 
						ON sa.answerfield_id = a.answerfield_id
					LEFT OUTER JOIN `option` o 
						ON sa.option_id = o.option_id
				WHERE sa.screening_id=#session.prev_id#
				ORDER BY sa.pagenum, a.answerfield, sa.submit_datetime
			</cfquery>
			<cfif getPrevScreening.RecordCount Eq 0>
				<cfset session.screening.prepopulate = 0>
			<cfelse>
				<cfset session.screening.prepopulate = 1>
				<cfloop query="getPrevScreening">
					<cfif encryption_flag eq 1>
						<cf_decodeString text="#encrypted_response#" var="decrypted">
					</cfif>
					<cfif encryption_flag eq 1>
						<cf_handleScreeningAnswerfield code="#answerfield#" pre="#decrypted#">
					<cfelseif responsetype lt 3>
						<cf_handleScreeningAnswerfield code="#answerfield#" pre="#response#">
					<cfelse>
						<cf_handleScreeningAnswerfield code="#answerfield#" pre="#option_id#">
					</cfif>
					<cfif attributes.loadsession>
						<cfif encryption_flag eq 1>
							<cfset "session.#answerfield#" = decrypted>
							<cf_handleScreeningAnswerfield code="#answerfield#" val="#decrypted#">
							<cfif responsetype eq 1>
								<cfset part='n'>
							<cfelse>
								<cfset part='s'>
							</cfif>
						<cfelseif responsetype lt 3>
							<cfset "session.#answerfield#" = response>
							<cf_handleScreeningAnswerfield code="#answerfield#" val="#response#">
							<cfif responsetype eq 1>
								<cfset part='n'>
							<cfelse>
								<cfset part='s'>
							</cfif>
						<cfelse>
							<cfset "session.#answerfield#" = option_code>
							<cf_handleScreeningAnswerfield code="#answerfield#" val="#option_id#">
							<cfset part='o'>
						</cfif>
						<cfset caller.theList = ListAppend(caller.theList, "#part#-#answerfield#")>
					</cfif>
				</cfloop>
			</cfif>
		</cfif>
		<cfif session.partner_id eq 76>
			<cfif isdefined('session.fitpartner') and session.fitpartner neq ''>
				<cfset session.client_id = session.fitpartner>
			</cfif>
		</cfif>
		<!--- insert screening unless using existing id --->
		<cfif attributes.screening_id neq ''>
		<cf_screeningInsert prev_screening_id="#session.prev_id#" source_id="#session.source_id#" org_id="#session.org_id#" partner_id="#session.partner_id#" subset_id="#session.subset_id#" language_id="#session.language_id#" access_id="#session.access_id#" client_id="#session.client_id#" user_id="#session.user_id#" preset_state_id="#session.state_id#" test_flag="#session.test_id#" var="outvar">
		<cfelse>
			<cfset session.screening.id = attributes.screening_id>
			<cfset outvar = session.screening.id>
		</cfif>
		<cfset session.screening.id = outvar>
		<cfif attributes.var eq ''>
			<cfset session.screening_id = outvar>
		<cfelse>
			<cfset "caller.#attributes.var#" = outvar>
		</cfif>
	</cfif>
</cfif>

<cfif attributes.initvarname Neq ''>
	<cfset "caller.#attributes.initvarname#" = ''>
</cfif>
<cfif attributes.debug><cfoutput><h3>Done with handle Screening</h3></cfoutput></cfif>

