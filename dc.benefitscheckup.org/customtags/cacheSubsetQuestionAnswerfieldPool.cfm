<cfsilent>
<cfparam name="attributes.name" type="string" default="bcuSubsetQuestionAnswerfieldPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.question" type="any" default="">
<cfparam name="attributes.var" type="string" default="bcuSubsetQuestionAnswerfield">

<cfif attributes.state_id eq '' or attributes.subset_id eq '' or attributes.question eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
	<cfset phash = ''>
	<cfset partnerDiff = false>
	<cfif attributes.partner_id neq ''>
		<cf_cacheAnswerfieldSubsetPartnerPool action="isDifferent" subset_id="#attributes.subset_id#" partner_id="#attributes.partner_id#" var="partnerDiff">
		<cfif partnerDiff>
			<cfset phash = "p#attributes.partner_id#">
		</cfif>
	</cfif>
	<cfset sqahash = attributes.state_id & attributes.subset_id & phash & '_' & attributes.question>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sqa" = StructNew()>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.sqa.#sqahash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.sqa.#sqahash#" = StructNew()>
	<cfset "application.#attributes.name#.sqa.#sqahash#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sqa.#sqahash#.sort" = StructNew()>

	<cfquery name="sqavars" datasource="#application.dbSrc#">
		SELECT a.answerfield
		FROM question q, question_answerfield qa, (
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)				                        </cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=ar.left_answerfield_id
				AND ar.relationship_id=2
				AND ar.right_answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)				                        </cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )

					)

			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=ar.left_answerfield_id
				AND ar.relationship_id=2
				AND ar.right_answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )

					)

			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM (
				select question_id
				from subset_question sq
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					and exclude_flag=0
				union
				select question_id
				from question q
				where include_flag=1
					and question_id not in (
						select question_id
						from subset_question sq
						where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							and exclude_flag=1
					)
				) sq, question_answerfield qa, answerfield a
			WHERE sq.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
		) AS a
		WHERE q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.question#" maxlength="100">
				AND q.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
		ORDER BY qa.sort
	</cfquery>
	<cfset aCount = 0>
	<cfloop query="sqavars">
		<cfset aCount = aCount + 1>
		<cfset StructInsert(Evaluate("application.#attributes.name#.sqa.#sqahash#.sort"), aCount, answerfield)>
	</cfloop>
</cfif>

</cfsilent><cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="7" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			
			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.sqa")), 'textnocase')#" index="x">
				<cfif doAll or x eq sqahash>
				<tr>
					<td colspan="7" align="center"><strong>#x#</strong> last refresh #Evaluate("application.#attributes.name#.sqa.#x#.lastRefresh")#</td>
				</tr>
				<tr>
					<td align="right"><strong>sort</strong></td>
					<td><strong>answerfield</strong></td>
				</tr>
				<cfset answerfieldCount = 0>
				<cf_loopPoolStruct scope="application" struct="#attributes.name#.sqa.#x#" index="y">
					<cfset answerfieldCount = answerfieldCount + 1>
					<tr>
						<td align="right" valign="top">#answerfieldCount#</td>
						<td valign="top">#y#</td>
					</tr>
				</cf_loopPoolStruct>
				</cfif>
			</cfloop>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get"><cfsilent>
		<cfif doAll>
			<cfset "caller.#attributes.var#" = false>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.sqa.#sqahash#"))>
		</cfif>
	</cfsilent></cfcase>
</cfswitch>