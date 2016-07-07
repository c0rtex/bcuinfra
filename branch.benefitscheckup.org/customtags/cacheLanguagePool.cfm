<cfparam name="attributes.name" type="string" default="bcuLanguagePool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.language_id" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuLanguage">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.default" = ''>
	<cfset "application.#attributes.name#.l" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null rule obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.default" = ''>
	<cfset "application.#attributes.name#.null.active" = ''>
	<cfset "application.#attributes.name#.null.code" = ''>

	<cfquery name="lvars" datasource="#application.dbSrc#">
		select l.language_id, l.default_flag, l.active, d.display_code
		from language l, display d
		where l.display_id=d.display_id
		order by l.default_flag desc, l.active desc, l.language_id
	</cfquery>
	<cfset lCount = 0>
	
	<cfloop query="lvars">
		<cfset lCount = lCount + 1>
		<cfif default_flag eq 1 and Evaluate("application.#attributes.name#.default") eq ''>
			<cfset "application.#attributes.name#.default" = language_id>
		</cfif>
		<cfif Not IsDefined("application.#attributes.name#.l.#language_id#")>
			<cfset "application.#attributes.name#.l.#language_id#" = StructNew()>
			<cfset "application.#attributes.name#.l.#language_id#.exists" = true>
			<cfset "application.#attributes.name#.l.#language_id#.default" = default_flag>
			<cfset "application.#attributes.name#.l.#language_id#.active" = active>
			<cfset "application.#attributes.name#.l.#language_id#.code" = display_code>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), lCount, language_id)>
		</cfif>
	</cfloop>

</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="default">
		<cfset "caller.#attributes.var#" = Evaluate("application.#attributes.name#.default")>
	</cfcase>
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="4" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td colspan="4" align="center"><strong>default language</strong> #Evaluate("application.#attributes.name#.default")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>default</strong></td>
				<td><strong>active</strong></td>
				<td><strong>code</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="l">
				<tr>
					<td align="right" valign="top">#l#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.l.#l#.default")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.l.#l#.active")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.l.#l#.code")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.language_id eq ''>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#"))>
		<cfelseif attributes.language_id neq '' and StructKeyExists(Evaluate("application.#attributes.name#.l"), attributes.language_id)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.l.#attributes.language_id#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
		</cfif>
	</cfcase>
</cfswitch>