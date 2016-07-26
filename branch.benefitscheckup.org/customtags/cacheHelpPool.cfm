<cfparam name="attributes.name" type="string" default="bcuHelpPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.keyword" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuHelp">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.h" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null help obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.id" = ''>
	<cfset "application.#attributes.name#.null.type" = ''>
	<cfset "application.#attributes.name#.null.keyword" = ''>
	<cfset "application.#attributes.name#.null.title" = ''>
	<cfset "application.#attributes.name#.null.text" = ''>
	<cfoutput><b>Links Updated!</b></cfoutput>
	<cfquery name="hvars" datasource="#application.dbSrc#">
		select h.help_id, h.help_code, ht.code type_code, h.keyword, dt.display_code title_code, d.display_code text_code
		from help h inner join helptype ht
				on h.helptype_id=ht.helptype_id
			inner join display d
				on h.display_id=d.display_id
			left outer join display dt
				on h.title_display_id=dt.display_id
		order by h.help_code
	</cfquery>
	<cfloop query="hvars">
		<cfif Not IsDefined("application.#attributes.name#.h.#help_code#")>
			<cfset "application.#attributes.name#.h.#help_code#" = StructNew()>
			<cfset "application.#attributes.name#.h.#help_code#.exists" = true>
			<cfset "application.#attributes.name#.h.#help_code#.id" = help_id>
			<cfset "application.#attributes.name#.h.#help_code#.type" = type_code>
			<cfset "application.#attributes.name#.h.#help_code#.keyword" = keyword>
			<cfset "application.#attributes.name#.h.#help_code#.title" = title_code>
			<cfset "application.#attributes.name#.h.#help_code#.text" = text_code>
			<cfif keyword neq ''>
				<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), keyword, help_code)>
			</cfif>
		</cfif>
	</cfloop>

</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="6" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>code</strong></td>
				<td><strong>type</strong></td>
				<td><strong>keyword</strong></td>
				<td><strong>title</strong></td>
				<td><strong>text</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" sortBy="h" index="h">
				<tr>
					<td align="right" valign="top">#Evaluate("application.#attributes.name#.h.#h#.id")#</td>
					<td valign="top">#h#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.h.#h#.type")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.h.#h#.keyword")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.h.#h#.title")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.h.#h#.text")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.h"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.h.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
		</cfif>
	</cfcase>
	<cfcase value="getCodeByKeyword">
		<cfif attributes.keyword neq '' and StructKeyExists(Evaluate("application.#attributes.name#.sort"), attributes.keyword)>
			<cfset "caller.#attributes.var#" = StructFind(Evaluate("application.#attributes.name#.sort"), attributes.keyword)>
		<cfelse>
			<cfset "caller.#attributes.var#" = ''>
		</cfif>
	</cfcase>
</cfswitch>