<cfparam name="attributes.name" type="string" default="bcuRulePool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuRule">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.r" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null rule obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.id" = ''>
	<cfset "application.#attributes.name#.null.text" = ''>

	<cfquery name="rvars" datasource="#application.dbSrc#">
		select rule_id, code, rule_text
		from rule
		order by code
	</cfquery>
	<cfset rCount = 0>
	<cfloop query="rvars">
		<cfset rCount = rCount + 1>
		<cfif Not IsDefined("application.#attributes.name#.r.#code#")>
			<cfset "application.#attributes.name#.r.#code#" = StructNew()>
			<cfset "application.#attributes.name#.r.#code#.exists" = true>
			<cfset "application.#attributes.name#.r.#code#.id" = rule_id>
			<cfset "application.#attributes.name#.r.#code#.text" = rule_text>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), rCount, code)>
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
				<td align="right"><strong>id</strong></td>
				<td><strong>code</strong></td>
				<td><strong>rule</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="x">
				<cf_cacheRulePool action="get" code="#x#">
				<tr>
					<td align="right" valign="top">#Evaluate("#attributes.var#.id")#</td>
					<td valign="top">#x#</td>
					<td valign="top">#Evaluate("#attributes.var#.text")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<!--- copy structures by reference to save memory --->
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.r"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.r.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
		</cfif>
	</cfcase>
</cfswitch>