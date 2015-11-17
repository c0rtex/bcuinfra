<cfparam name="attributes.name" type="string" default="bcuOptionPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.id" type="numeric" default="0">
<cfparam name="attributes.var" type="string" default="bcuOption">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.o" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<cfquery name="ovars" datasource="#application.dbSrc#">
		select o.option_id, o.option_code, o.include_flag
		from `option` o
		order by o.option_id
	</cfquery>
	<cfloop query="ovars">
		<cfif Not IsDefined("application.#attributes.name#.o.#option_code#")>
			<cfset "application.#attributes.name#.o.#option_code#" = StructNew()>
			<cfset "application.#attributes.name#.o.#option_code#.id" = option_id>
			<cfset "application.#attributes.name#.o.#option_code#.inc" = include_flag>
			<cfset "application.#attributes.name#.o.#option_code#.sp" = StructNew()>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), option_id, option_code)>
		</cfif>
	</cfloop>
	<cfquery name="ospvars" datasource="#application.dbSrc#">
		select o.option_code, osp.subset_id, osp.partner_id, osp.include_flag
		from `option_subset_partner` osp, `option` o
		where osp.option_id=o.option_id
		order by osp.option_id, osp.subset_id, osp.partner_id
	</cfquery>
	<cfloop query="ospvars">
		<cfset "application.#attributes.name#.o.#option_code#.sp.s#subset_id#p#partner_id#" = include_flag>
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
				<td><strong>option</strong></td>
				<td><strong>include</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="o">
				<tr>
					<td align="right" valign="top">#Evaluate("application.#attributes.name#.o.#o#.id")#</td>
					<td valign="top">#o#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.o.#o#.inc")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.o"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.o.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = false>
		</cfif>
	</cfcase>
	<cfcase value="getCodeByID">
		<cfif attributes.id gt 0 and StructKeyExists(Evaluate("application.#attributes.name#.sort"), attributes.id)>
			<cfset "caller.#attributes.var#" = StructFind(Evaluate("application.#attributes.name#.sort"), attributes.id)>
		<cfelse>
			<cfset "caller.#attributes.var#" = ''>
		</cfif>
	</cfcase>
</cfswitch>