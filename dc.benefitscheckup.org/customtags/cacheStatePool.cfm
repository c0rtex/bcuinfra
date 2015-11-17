<cfparam name="attributes.name" type="string" default="bcuStatePool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuState">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.st" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null rule obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.name" = ''>
	<cfset "application.#attributes.name#.null.type" = ''>

	<cfquery name="stvars" datasource="#application.dbSrc#">
		select s.state_id, s.state_name, st.statetype_name
		from state s, statetype st
		where s.statetype_id=st.statetype_id
		order by s.state_name
	</cfquery>
	<cfset stCount = 0>
	<cfloop query="stvars">
		<cfset stCount = stCount + 1>
		<cfif Not IsDefined("application.#attributes.name#.st.#state_id#")>
			<cfset "application.#attributes.name#.st.#state_id#" = StructNew()>
			<cfset "application.#attributes.name#.st.#state_id#.exists" = true>
			<cfset "application.#attributes.name#.st.#state_id#.name" = state_name>
			<cfset "application.#attributes.name#.st.#state_id#.type" = statetype_name>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), stCount, state_id)>
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
				<td><strong>name</strong></td>
				<td><strong>type</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="st">
				<tr>
					<td align="right" valign="top">#st#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.st.#st#.name")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.st.#st#.type")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.state_id eq ''>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#"))>
		<cfelseif attributes.state_id neq '' and StructKeyExists(Evaluate("application.#attributes.name#.st"), attributes.state_id)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.st.#attributes.state_id#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
		</cfif>
	</cfcase>
</cfswitch>