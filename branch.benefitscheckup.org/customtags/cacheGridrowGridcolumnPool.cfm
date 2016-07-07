<cfparam name="attributes.name" type="string" default="bcuGridrowGridcolumnPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuGridrowGridcolumn">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.gg" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<cfquery name="ggvars" datasource="#application.dbSrc#">
		select gr.code grcode, gc.code gccode, a.answerfield
		from gridrow_gridcolumn_answerfield gga, gridrow gr, gridcolumn gc, answerfield a
		where gga.gridrow_id=gr.gridrow_id
			and gga.gridcolumn_id=gc.gridcolumn_id
			and gga.answerfield_id=a.answerfield_id
		order by gr.sort, gc.sort
	</cfquery>
	<cfset ggCount = 0>
	<cfloop query="ggvars">
		<cfset ggCount = ggCount + 1>
		<cfset code = "#grcode#_#gccode#">
		<cfif Not IsDefined("application.#attributes.name#.gg.#code#")>
			<cfset "application.#attributes.name#.gg.#code#" = StructNew()>
			<cfset "application.#attributes.name#.gg.#code#.af" = answerfield>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), ggCount, code)>
		</cfif>
	</cfloop>

</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="3" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td><strong>gg</strong></td>
				<td><strong>answerfield</strong></td>
			</tr>
			<cfset ggCount = 0>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="gg">
				<cfset ggCount = ggCount + 1>
				<tr>
					<td align="right" valign="top">#ggCount#</td>
					<td valign="top">#gg#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.gg.#gg#.af")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.gg"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.gg.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = false>
		</cfif>
	</cfcase>
</cfswitch>