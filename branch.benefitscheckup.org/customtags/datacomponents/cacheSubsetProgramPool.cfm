<cfparam name="attributes.name" type="string" default="bcuSubsetProgramPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.state_id" type="string" default="">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.var" type="string" default="bcuSubsetProgram">

<cfif attributes.state_id eq '' or attributes.subset_id eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
	<cfset sphash = attributes.state_id & attributes.subset_id>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sp" = StructNew()>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.sp.#sphash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.sp.#sphash#" = StructNew()>
	<cfset "application.#attributes.name#.sp.#sphash#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sp.#sphash#.sort" = StructNew()>

	<cfquery name="spvars" datasource="#application.dbSrc#">
		select p.program_id, p.program_code
		from subset_program_sum sp, program p
		where sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
			and sp.program_id=p.program_id
			and p.active_flag=1
			and (p.state_id is null or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
		order by p.sort
	</cfquery>
	<cfset pCount = 0>
	<cfloop query="spvars">
		<cfset pCount = pCount + 1>
		<cfset StructInsert(Evaluate("application.#attributes.name#.sp.#sphash#.sort"), pCount, program_code)>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="7" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			
			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.sp")), 'textnocase')#" index="x">
				<cfif doAll or x eq sphash>
				<tr>
					<td colspan="7" align="center"><strong>#x#</strong> last refresh #Evaluate("application.#attributes.name#.sp.#x#.lastRefresh")#</td>
				</tr>
				<tr>
					<td align="right"><strong>sort</strong></td>
					<td><strong>program</strong></td>
				</tr>
				<cfset programCount = 0>
				<cf_loopPoolStruct scope="application" struct="#attributes.name#.sp.#x#" index="y">
					<cfset programCount = programCount + 1>
					<tr>
						<td align="right" valign="top">#programCount#</td>
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
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.sp.#sphash#"))>
		</cfif>
	</cfcase>
</cfswitch>