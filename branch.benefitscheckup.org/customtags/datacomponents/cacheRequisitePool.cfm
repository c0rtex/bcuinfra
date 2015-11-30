<cfparam name="attributes.name" type="string" default="bcuRequisitePool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuRequisite">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.rq" = StructNew()>
	<cfset "application.#attributes.name#.id" = StructNew()>

	<cfquery name="rqvars" datasource="#application.dbSrc#">
		select r.requisite_id, r.code, d.display_code name, dd.display_code def
		from requisite r inner join display d
				on r.display_id=d.display_id
			left outer join display dd
				on r.def_display_id=dd.display_id
		order by r.requisite_id
	</cfquery>
	<cfloop query="rqvars">
		<cfif Not IsDefined("application.#attributes.name#.rq.#code#")>
			<cfset "application.#attributes.name#.rq.#code#" = StructNew()>
			<cfset "application.#attributes.name#.rq.#code#.id" = requisite_id>
			<cfset "application.#attributes.name#.rq.#code#.name" = name>
			<cfset "application.#attributes.name#.rq.#code#.def" = def>
			<cfset StructInsert(Evaluate("application.#attributes.name#.id"), requisite_id, code)>
		</cfif>
	</cfloop>

</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="4" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>code</strong></td>
				<td><strong>name</strong></td>
				<td><strong>def</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" sortBy="id" index="rq">
				<tr>
					<td align="right" valign="top">#Evaluate("application.#attributes.name#.rq.#rq#.id")#</td>
					<td valign="top">#rq#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.rq.#rq#.name")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.rq.#rq#.def")#</td>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.rq"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.rq.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#"))>
		</cfif>
	</cfcase>
</cfswitch>