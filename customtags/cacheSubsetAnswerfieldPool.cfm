<cfsilent>
<cfparam name="attributes.name" type="string" default="bcuSubsetAnswerfieldPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.var" type="string" default="bcuSubsetAnswerfield">

<cfif attributes.subset_id eq ''>
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
	<cfset sahash = "s#attributes.subset_id##phash#">
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sa" = StructNew()>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.sa.#sahash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.sa.#sahash#" = StructNew()>
	<cfset "application.#attributes.name#.sa.#sahash#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sa.#sahash#.sort" = StructNew()>

	<cfquery name="savars" datasource="#application.dbSrc#">
		SELECT a.answerfield_id, a.answerfield
		FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
		WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
			AND sp.program_id=p.program_id
			AND p.active_flag=1
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
			AND pa.answerfield_id=a.answerfield_id
		UNION
		SELECT a.answerfield_id, a.answerfield
		FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
		WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
			AND sp.program_id=p.program_id
			AND p.active_flag=1
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
		ORDER BY answerfield
	</cfquery>
	<cfloop query="savars">
		<cfset StructInsert(Evaluate("application.#attributes.name#.sa.#sahash#.sort"), answerfield, answerfield_id)>
	</cfloop>
</cfif>

</cfsilent><cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="7" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			
			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.sa")), 'textnocase')#" index="x">
				<cfif doAll or x eq sahash>
				<tr>
					<td colspan="3" align="center"><strong>#x#</strong> last refresh #Evaluate("application.#attributes.name#.sa.#x#.lastRefresh")#</td>
				</tr>
				<tr>
					<td align="right"><strong>id</strong></td>
					<td><strong>answerfield</strong></td>
				</tr>
				<cfset afCount = 0>
				<cf_loopPoolStruct scope="application" struct="#attributes.name#.sa.#x#" index="y">
					<cfset afCount = afCount + 1>
					<tr>
						<td align="right" valign="top">#Evaluate("application.#attributes.name#.sa.#x#.sort.#y#")#</td>
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
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.sa.#sahash#"))>
		</cfif>
	</cfsilent></cfcase>
</cfswitch>