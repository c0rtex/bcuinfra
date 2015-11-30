<cfparam name="attributes.name" type="string" default="bcuTemplatePool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.filename" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuTemplate">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.t" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null template obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.canonical" = ''>
	<cfset "application.#attributes.name#.null.source" = ''>
	<cfset "application.#attributes.name#.null.prev" = ''>
	<cfset "application.#attributes.name#.null.org" = ''>
	<cfset "application.#attributes.name#.null.partner" = ''>
	<cfset "application.#attributes.name#.null.subset" = ''>
	<cfset "application.#attributes.name#.null.language" = ''>
	<cfset "application.#attributes.name#.null.access" = ''>
	<cfset "application.#attributes.name#.null.client" = ''>
	<cfset "application.#attributes.name#.null.user" = ''>
	<cfset "application.#attributes.name#.null.state" = ''>
	<cfset "application.#attributes.name#.null.test" = ''>

	<cfquery name="tvars" datasource="#application.dbSrc#">
		select template_id, filename, canonical_flag, source_flag, prev_flag, org_flag, partner_flag, subset_flag, language_flag, access_flag, client_flag, user_flag, state_flag, test_flag
		from template
		order by filename
	</cfquery>
	<cfloop query="tvars">
		<cfset thash = "t#template_id#">
		<cfif Not IsDefined("application.#attributes.name#.t.#thash#")>
			<cfset "application.#attributes.name#.t.#thash#" = StructNew()>
			<cfset "application.#attributes.name#.t.#thash#.exists" = true>
			<cfset "application.#attributes.name#.t.#thash#.canonical" = canonical_flag>
			<cfset "application.#attributes.name#.t.#thash#.source" = source_flag>
			<cfset "application.#attributes.name#.t.#thash#.prev" = prev_flag>
			<cfset "application.#attributes.name#.t.#thash#.org" = org_flag>
			<cfset "application.#attributes.name#.t.#thash#.partner" = partner_flag>
			<cfset "application.#attributes.name#.t.#thash#.subset" = subset_flag>
			<cfset "application.#attributes.name#.t.#thash#.language" = language_flag>
			<cfset "application.#attributes.name#.t.#thash#.access" = access_flag>
			<cfset "application.#attributes.name#.t.#thash#.client" = client_flag>
			<cfset "application.#attributes.name#.t.#thash#.user" = user_flag>
			<cfset "application.#attributes.name#.t.#thash#.state" = state_flag>
			<cfset "application.#attributes.name#.t.#thash#.test" = test_flag>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), filename, template_id)>
		</cfif>
	</cfloop>

</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="14" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>filename</strong></td>
				<td><strong>canonical</strong></td>
				<td><strong>source</strong></td>
				<td><strong>prev</strong></td>
				<td><strong>org</strong></td>
				<td><strong>partner</strong></td>
				<td><strong>subset</strong></td>
				<td><strong>language</strong></td>
				<td><strong>access</strong></td>
				<td><strong>client</strong></td>
				<td><strong>user</strong></td>
				<td><strong>state</strong></td>
				<td><strong>test</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="t">
				<cfset thash = "t#StructFind(Evaluate("application.#attributes.name#.sort"), t)#">
				<tr>
					<td align="right" valign="top">#StructFind(Evaluate("application.#attributes.name#.sort"), t)#</td>
					<td valign="top">#t#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.canonical")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.source")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.prev")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.org")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.partner")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.subset")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.language")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.access")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.client")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.user")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.state")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.t.#thash#.test")#</td>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif attributes.filename neq '' and StructKeyExists(Evaluate("application.#attributes.name#.sort"), attributes.filename)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.t.t#StructFind(Evaluate("application.#attributes.name#.sort"), attributes.filename)#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
		</cfif>
	</cfcase>
</cfswitch>