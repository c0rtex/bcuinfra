<cfparam name="attributes.name" type="string" default="bcuQuestionPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuQuestion">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.q" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<cfquery name="qvars" datasource="#application.dbSrc#">
		select q.question_id, q.question_code, q.suppress_qno_flag suppress, q.spq_exclude_flag spx,
			q.sort qsort, qt.code, qc.questioncategory_code cat, qd.code head, f.format_code format,
			d.display_code short, d2.display_code spq, d3.display_code help, r.code rule,
			a.answerfield_id, a.answerfield, qa.sort asort
		from question q inner join questiontype qt
				on q.questiontype_id=qt.questiontype_id
			inner join questioncategory qc
				on q.questioncategory_id=qc.questioncategory_id
			left outer join questionheader qd
				on q.questionheader_id=qd.questionheader_id
			left outer join format f
				on q.format_id=f.format_id
			left outer join display d
				on q.short_display_id=d.display_id
			left outer join display d2
				on q.spq_display_id=d2.display_id
			left outer join question_help qh
				on q.question_id=qh.question_id
			left outer join help h
				on qh.help_id=h.help_id
			left outer join display d3
				on h.display_id=d3.display_id
			left outer join rule r
				on q.rule_id=r.rule_id
			left outer join question_answerfield qa
				on q.question_id=qa.question_id
			left outer join answerfield a
				on qa.answerfield_id=a.answerfield_id
		order by q.sort, qa.sort
	</cfquery>
	<cfset qCount = 0>
	<cfloop query="qvars">
		<cfif IsDefined("application.#attributes.name#.q.#question_code#")>
			<cfset qCount = qCount + 1>
		<cfelse>
			<cfset qCount = 1>
			<cfset "application.#attributes.name#.q.#question_code#" = StructNew()>
			<cfset "application.#attributes.name#.q.#question_code#.id" = question_id>
			<cfset "application.#attributes.name#.q.#question_code#.type" = code>
			<cfset "application.#attributes.name#.q.#question_code#.spx" = spx>
			<cfset "application.#attributes.name#.q.#question_code#.sup" = suppress>
			<cfset "application.#attributes.name#.q.#question_code#.cat" = cat>
			<cfset "application.#attributes.name#.q.#question_code#.head" = head>
			<cfset "application.#attributes.name#.q.#question_code#.format" = format>
			<cfset "application.#attributes.name#.q.#question_code#.rule" = rule>
			<cfset "application.#attributes.name#.q.#question_code#.help" = help>
			<cfset "application.#attributes.name#.q.#question_code#.sort" = StructNew()>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), qsort, question_code)>
		</cfif>
		<cfif answerfield neq ''>
			<cfset StructInsert(Evaluate("application.#attributes.name#.q.#question_code#.sort"), qCount, answerfield)>
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
			<cfset "application.#attributes.name#.q.#qcode#.gsort" = StructNew()>
			<cfloop query="gcvars">
				<cfset gcCount = gcCount + 1>
				<cfset StructInsert(Evaluate("application.#attributes.name#.q.#qcode#.gsort"), gcCount, gccode)>
			</cfloop>
		</cfif>
	</cfloop>

</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="8" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td align="right"><strong>id</strong></td>
				<td><strong>question</strong></td>
				<td><strong><em>answerfield</em></strong></td>
				<td align="right"><strong>type</strong></td>
				<td align="right"><strong>cat</strong></td>
				<td align="right"><strong>format</strong></td>
				<td align="right"><strong>rule</strong></td>
			</tr>
			<cfset qCount = 0>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="x">
				<cfset qCount = qCount + 1>
				<cf_cacheQuestionPool action="get" code="#x#">
				<tr>
					<td align="right" valign="top">#qCount#</td>
					<td align="right" valign="top">#bcuQuestion.id#</td>
					<td colspan="2" valign="top">#x#</td>
					<td align="right" valign="top">#bcuQuestion.type#</td>
					<td align="right" valign="top">#bcuQuestion.cat#</td>
					<td align="right" valign="top">#bcuQuestion.format#</td>
					<td align="right" valign="top">#bcuQuestion.rule#</td>
				</tr>
				<cfset afCount = 0>
				<cf_loopPoolStruct struct="bcuQuestion" index="y">
					<cfset afCount = afCount + 1>
					<tr>
						<td colspan="2"></td>
						<td align="right" valign="top"><em>#afCount#</em></td>
						<td colspan="5" valign="top"><em>#y#</em></td>
					</tr>
				</cf_loopPoolStruct>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.q"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.q.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = false>
		</cfif>
	</cfcase>
</cfswitch>