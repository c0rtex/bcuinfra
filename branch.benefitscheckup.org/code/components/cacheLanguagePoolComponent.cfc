<!---
	Template Name: LanguagePoolCache
	Component Purpose: Component manages local cache of languages stored in database

	Data Tables: Language, Display

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuLanguagePoolComponent">

<!---
	Method initializes local cache and refreshes them
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.default = ''>
	<cfset this.internalContent.l = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfset this.internalContent.null = StructNew()>
	<cfset this.internalContent.null.exists = false>
	<cfset this.internalContent.null.default = ''>
	<cfset this.internalContent.null.active = ''>
	<cfset this.internalContent.null.code = ''>

	<cfquery name="lvars" datasource="#application.dbSrc#">
		select l.language_id, l.default_flag, l.active, d.display_code
		from language l, display d
		where l.display_id=d.display_id
		order by l.default_flag desc, l.active desc, l.language_id
	</cfquery>
	<cfset lCount = 0>

	<cfloop query="lvars">
		<cfset lCount = lCount + 1>
		<cfif default_flag eq 1 and this.internalContent.default eq ''>
			<cfset this.internalContent.default = language_id>
		</cfif>
		<cfif Not IsDefined("this.internalContent.l.#language_id#")>
			<cfset this.internalContent.l[language_id] = StructNew()>
			<cfset this.internalContent.l[language_id].exists = true>
			<cfset this.internalContent.l[language_id].default = default_flag>
			<cfset this.internalContent.l[language_id].active = active>
			<cfset this.internalContent.l[language_id].code = display_code>
			<cfset StructInsert(this.internalContent.sort, lCount, language_id)>
		</cfif>
	</cfloop>
</cffunction>

<!---
	Method returns default language
--->

<cffunction name="actionDefault" output="no">
	<cfreturn this.internalContent.default>
</cffunction>

<!---
	Method returns html table with dump of cache content
--->

<cffunction name="actionDump" output="yes">
	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="4" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>
		<tr>
			<td colspan="4" align="center"><strong>default language</strong> #this.internalContent.default#</td>
		</tr>
		<tr>
			<td align="right"><strong>id</strong></td>
			<td><strong>default</strong></td>
			<td><strong>active</strong></td>
			<td><strong>code</strong></td>
		</tr>
		<cfloop list="#Listsort(StructKeyList(this.internalContent.sort),'numeric')#" index="ind">
			<cfset l=this.internalContent.l[this.internalContent.sort[ind]]>
			<tr>
				<td align="right" valign="top">#this.internalContent.sort[ind]#</td>
				<td valign="top">#l.default#</td>
				<td valign="top">#l.active#</td>
				<td valign="top">#l.code#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns struct contained language attributes with passed language code
--->

<cffunction name="actionGet" output="no">
	<cfargument name="language_id" type="string" default="">
	<cfif language_id eq ''>
		<cfreturn StructCopy(this.internalContent)>
	<cfelseif language_id neq '' and StructKeyExists(this.internalContent.l, language_id)>
		<cfreturn StructCopy(this.internalContent.l[language_id])>
	<cfelse>
		<cfreturn StructCopy(this.internalContent.null)>
	</cfif>
</cffunction>


</cfcomponent>