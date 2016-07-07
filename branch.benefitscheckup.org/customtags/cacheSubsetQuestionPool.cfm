<cfparam name="attributes.name" type="string" default="bcuSubsetQuestionPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.basics" type="boolean" default="false">
<cfparam name="attributes.app" type="boolean" default="false">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.partner_id" type="numeric" default="0">
<cfparam name="attributes.var" type="string" default="bcuSubsetQuestion">

<cfif (attributes.state_id eq '' and not attributes.basics and not attributes.app) or attributes.subset_id eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
	<cfif attributes.basics or attributes.app>
		<!--- special case for loading only the basic questions for a subset --->
		<cfset attributes.state_id = 'US'>
	</cfif>
	<cfset sqhash = attributes.state_id & attributes.subset_id>
	<cfset includePartner = false>
	<cfif attributes.partner_id eq 8>
		<cfset sqhash = "#sqhash#p#attributes.partner_id#">
		<cfset includePartner = true>
	</cfif>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sq" = StructNew()>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.sq.#sqhash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.sq.#sqhash#" = StructNew()>
	<cfset "application.#attributes.name#.sq.#sqhash#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sq.#sqhash#.sort" = StructNew()>
	<cfset "application.#attributes.name#.sq.#sqhash#.q" = StructNew()>

	<cfquery name="sqvars" datasource="#application.dbSrc#">
		SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
		FROM (
			SELECT q.question_id, NULL AS page_id
			FROM (
				SELECT pa.answerfield_id
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics> 
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif> a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
				UNION
				SELECT ar.right_answerfield_id as answerfield_id
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=ar.left_answerfield_id
					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif>a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
				UNION
				SELECT  pa.answerfield_id
				FROM subset_program_sum sps, program_answerfield pa, answerfield a
				WHERE 
					sps.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4"> 
					and pa.program_id = sps.program_id
					and a.answerfield_id = pa.answerfield_id
					and sps.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and (p.state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2"> or p.state_id IS NULL)
					)
				UNION
				SELECT ar.right_answerfield_id as answerfield_id
				FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					and sp.program_id in
					(	select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )
					)

					AND pa.answerfield_id=ar.left_answerfield_id
					
					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif>a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
	
			
			) AS a, question_answerfield qa, question q
			WHERE a.answerfield_id=qa.answerfield_id
				AND qa.question_id NOT IN (
					SELECT question_id
					FROM subset_question
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND exclude_flag=1
				)
				AND qa.question_id=q.question_id
				AND q.exclude_flag=0
			UNION
			SELECT q.question_id, sq.page_id
			FROM subset_question sq, question q
			WHERE sq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sq.exclude_flag=0
				AND sq.question_id=q.question_id
			UNION
			SELECT q.question_id, NULL AS page_id
			FROM question q
			WHERE q.include_flag=1
				AND q.question_id NOT IN (
					SELECT question_id
					FROM subset_question
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND exclude_flag=1
				)
		) AS a, question q, questioncategory qc<cfif attributes.app>, page pg</cfif>
		WHERE a.question_id=q.question_id
			AND q.questioncategory_id=qc.questioncategory_id
			<cfif attributes.basics>AND qc.questioncategory_code='basics'</cfif>
			<cfif attributes.app>AND a.page_id=pg.page_id</cfif>
		ORDER BY <cfif attributes.app>pg.sort, </cfif>qc.sort, q.sort
	</cfquery>
	<cfset qCount = 0>
	<cfloop query="sqvars">
		<cfset qCount = qCount + 1>
		<cfset "application.#attributes.name#.sq.#sqhash#.q.#question_code#" = StructNew()>
		<cfset "application.#attributes.name#.sq.#sqhash#.q.#question_code#.pg" = page_id>
		<cfset StructInsert(Evaluate("application.#attributes.name#.sq.#sqhash#.sort"), qCount, question_code)>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="7" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			
			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.sq")), 'textnocase')#" index="x">
				<cfif doAll or x eq sqhash>
				<tr>
					<td colspan="7" align="center"><strong>#x#</strong> last refresh #Evaluate("application.#attributes.name#.sq.#x#.lastRefresh")#</td>
				</tr>
				<tr>
					<td align="right"><strong>sort</strong></td>
					<td><strong>question</strong></td>
				</tr>
				<cfset questionCount = 0>
				<cf_loopPoolStruct scope="application" struct="#attributes.name#.sq.#x#" index="y">
					<cfset questionCount = questionCount + 1>
					<tr>
						<td align="right" valign="top">#questionCount#</td>
						<td valign="top">#y#</td>
					</tr>
				</cf_loopPoolStruct>
				</cfif>
			</cfloop>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif doAll>
			<cfset "caller.#attributes.var#" = false>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.sq.#sqhash#"))>
		</cfif>
	</cfcase>
</cfswitch>