<cfparam name="attributes.name" type="string" default="bcuSubsetQuestionGridrowPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.question" type="any" default="">
<cfparam name="attributes.var" type="string" default="bcuSubsetQuestionGridrow">

<cfif attributes.subset_id eq '' or attributes.question eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
	<cfset sqghash = 'subset' & attributes.subset_id & '_' & attributes.question>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sqg" = StructNew()>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.sqg.#sqghash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.sqg.#sqghash#" = StructNew()>
	<cfset "application.#attributes.name#.sqg.#sqghash#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sqg.#sqghash#.sort" = StructNew()>

	<cfquery name="sqgvars" datasource="#application.dbSrc#">
		select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='#attributes.question#'
			and q.question_id=qg.question_id
			and qg.gridrow_id=g.gridrow_id
			and g.exclude_flag=0
			and g.gridrow_id not in (
				select gridrow_id
				from subset_gridrow
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					and exclude_flag=1
			)
		union
		select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='#attributes.question#'
			and q.question_id=qg.question_id
			and qg.gridrow_id=g.gridrow_id
			and g.exclude_flag=1
			and g.gridrow_id in (
				select gridrow_id
				from subset_gridrow
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					and exclude_flag=0
			)
		order by gsort
	</cfquery>
	<cfset gCount = 0>
	<cfloop query="sqgvars">
		<cfset gCount = gCount + 1>
		<cfset StructInsert(Evaluate("application.#attributes.name#.sqg.#sqghash#.sort"), gCount, code)>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="7" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			
			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.sqg")), 'textnocase')#" index="x">
				<cfif doAll or x eq sqghash>
				<tr>
					<td colspan="7" align="center"><strong>#x#</strong> last refresh #Evaluate("application.#attributes.name#.sqg.#x#.lastRefresh")#</td>
				</tr>
				<tr>
					<td align="right"><strong>sort</strong></td>
					<td><strong>gridrow</strong></td>
				</tr>
				<cfset gridrowCount = 0>
				<cf_loopPoolStruct scope="application" struct="#attributes.name#.sqg.#x#" index="y">
					<cfset gridrowCount = gridrowCount + 1>
					<tr>
						<td align="right" valign="top">#gridrowCount#</td>
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
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.sqg.#sqghash#"))>
		</cfif>
	</cfcase>
</cfswitch>