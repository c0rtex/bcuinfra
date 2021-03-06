<cfparam name="attributes.name" type="string" default="bcuGridrowPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuGridrow">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.gr" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<cfquery name="grvars" datasource="#application.dbSrc#">
		select g.code, h.help_code, g.sort
		from gridrow g left outer join help h
			on g.help_id=h.help_id
		order by g.sort
	</cfquery>
	<cfloop query="grvars">
		<cfif Not IsDefined("application.#attributes.name#.gr.#code#")>
			<cfset "application.#attributes.name#.gr.#code#" = StructNew()>
			<cfset "application.#attributes.name#.gr.#code#.help" = help_code>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), sort, code)>
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
				<td><strong>gridrow</strong></td>
				<td><strong>help</strong></td>
			</tr>
			<cfset grCount = 0>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="x">
				<cfset grCount = grCount + 1>
				<cf_cacheGridrowPool action="get" code="#x#">
				<tr>
					<td align="right" valign="top">#grCount#</td>
					<td valign="top">#x#</td>
					<td valign="top">#bcuGridrow.help#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.gr"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.gr.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = false>
		</cfif>
	</cfcase>
</cfswitch>