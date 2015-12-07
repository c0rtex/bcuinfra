<!---
	Template Name: TemplatePoolCache
	Component Purpose: Component manages local cache of templates

	Data Tables: Template

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuTemplatePoolComponent">

<!---
	Method initializes local cache and refresh them
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.t = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfset this.internalContent.null = StructNew()>
	<cfset this.internalContent.null.exists = false>
	<cfset this.internalContent.null.canonical = ''>
	<cfset this.internalContent.null.source = ''>
	<cfset this.internalContent.null.prev = ''>
	<cfset this.internalContent.null.org = ''>
	<cfset this.internalContent.null.partner = ''>
	<cfset this.internalContent.null.subset = ''>
	<cfset this.internalContent.null.language = ''>
	<cfset this.internalContent.null.access = ''>
	<cfset this.internalContent.null.client = ''>
	<cfset this.internalContent.null.user = ''>
	<cfset this.internalContent.null.state = ''>
	<cfset this.internalContent.null.test = ''>

	<cfquery name="tvars" datasource="#application.dbSrc#">
		select template_id, filename, canonical_flag, source_flag, prev_flag, org_flag, partner_flag, subset_flag, language_flag, access_flag, client_flag, user_flag, state_flag, test_flag
		from template
		order by filename
	</cfquery>
	<cfloop query="tvars">
		<cfset thash = "t#template_id#">
		<cfif Not StructKeyExists(this.internalContent.t, thash)>
			<cfset this.internalContent.t[thash] = StructNew()>
			<cfset this.internalContent.t[thash].exists = true>
			<cfset this.internalContent.t[thash].canonical = canonical_flag>
			<cfset this.internalContent.t[thash].source = source_flag>
			<cfset this.internalContent.t[thash].prev = prev_flag>
			<cfset this.internalContent.t[thash].org = org_flag>
			<cfset this.internalContent.t[thash].partner = partner_flag>
			<cfset this.internalContent.t[thash].subset = subset_flag>
			<cfset this.internalContent.t[thash].language = language_flag>
			<cfset this.internalContent.t[thash].access = access_flag>
			<cfset this.internalContent.t[thash].client = client_flag>
			<cfset this.internalContent.t[thash].user = user_flag>
			<cfset this.internalContent.t[thash].state = state_flag>
			<cfset this.internalContent.t[thash].test = test_flag>
			<cfset StructInsert(this.internalContent.sort, filename, template_id)>
		</cfif>
	</cfloop>
</cffunction>

<!---
	Method returns html table with dump of cache content
--->

<cffunction name="actionDump" output="yes">
	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="14" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
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
		<cfloop list="#ListSort(StructKeyList(this.internalContent.sort), 'textnocase')#" index="t">
			<cfset thash = "t"& this.internalContent.sort[t]>
			<tr>
				<td align="right" valign="top">#this.internalContent.sort[t]#</td>
				<td valign="top">#t#</td>
				<td valign="top">#this.internalContent.t[thash].canonical#</td>
				<td valign="top">#this.internalContent.t[thash].source#</td>
				<td valign="top">#this.internalContent.t[thash].prev#</td>
				<td valign="top">#this.internalContent.t[thash].org#</td>
				<td valign="top">#this.internalContent.t[thash].partner#</td>
				<td valign="top">#this.internalContent.t[thash].subset#</td>
				<td valign="top">#this.internalContent.t[thash].language#</td>
				<td valign="top">#this.internalContent.t[thash].access#</td>
				<td valign="top">#this.internalContent.t[thash].client#</td>
				<td valign="top">#this.internalContent.t[thash].user#</td>
				<td valign="top">#this.internalContent.t[thash].state#</td>
				<td valign="top">#this.internalContent.t[thash].test#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns struct contained template info for passed filename
--->

<cffunction name="actionGet" output="no">
	<cfargument name="filename" type="string" default="">

	<cfif filename neq '' and StructKeyExists(this.internalContent.sort, filename)>
		<cfreturn StructCopy(this.internalContent.t["t"&this.internalContent.sort[filename]])>
	<cfelse>
		<cfreturn StructCopy(this.internalContent.null)>
	</cfif>
</cffunction>

</cfcomponent>