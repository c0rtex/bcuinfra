<cfcomponent extends="cacheSingletonComponent" displayname="bcuHelpPoolComponent">

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.h = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfset this.internalContent.null = StructNew()>
	<cfset this.internalContent.null.exists = false>
	<cfset this.internalContent.null.id = ''>
	<cfset this.internalContent.null.type = ''>
	<cfset this.internalContent.null.keyword = ''>
	<cfset this.internalContent.null.title = ''>
	<cfset this.internalContent.null.text = ''>

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
		<cfif Not IsDefined("this.internalContent.h.#help_code#")>
			<cfset this.internalContent.h[help_code] = StructNew()>
			<cfset this.internalContent.h[help_code].exists = true>
			<cfset this.internalContent.h[help_code].id = help_id>
			<cfset this.internalContent.h[help_code].type = type_code>
			<cfset this.internalContent.h[help_code].keyword = keyword>
			<cfset this.internalContent.h[help_code].title = title_code>
			<cfset this.internalContent.h[help_code].text = text_code>
			<cfif keyword neq ''>
				<cfset StructInsert(this.internalContent.sort, keyword, help_code)>
			</cfif>
		</cfif>
	</cfloop>
</cffunction>

<cffunction name="actionDump" output="yes">
	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="6" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>
		<tr>
			<td align="right"><strong>id</strong></td>
			<td><strong>code</strong></td>
			<td><strong>type</strong></td>
			<td><strong>keyword</strong></td>
			<td><strong>title</strong></td>
			<td><strong>text</strong></td>
		</tr>
		<cfloop list="#Listsort(StructKeyList(this.internalContent.h),'textnocase')#" index="h">>
			<tr>
				<td align="right" valign="top">#this.internalContent.h[h].id#</td>
				<td valign="top">#h#</td>
				<td valign="top">#this.internalContent.h[h].type#</td>
				<td valign="top">#this.internalContent.h[h].keyword#</td>
				<td valign="top">#this.internalContent.h[h].title#</td>
				<td valign="top">#this.internalContent.h[h].text#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<cffunction name="actionGet" output="no">
	<cfargument name="code" type="string" default="">
	<cfif code neq '' and StructKeyExists(this.internalContent.h, code)>
		<cfreturn StructCopy(this.internalContent.h[code])>
	<cfelse>
		<cfreturn StructCopy(this.internalContent.null)>
	</cfif>
</cffunction>

<cffunction name="actionGetCodeByKeyword" output="no">
	<cfargument name="keyword" type="string" default="">
	<cfif keyword neq '' and StructKeyExists(this.internalContent.sort, keyword)>
		<cfreturn StructFind(this.internalContent.sort, keyword)>
	<cfelse>
		<cfreturn ''>
	</cfif>
</cffunction>

</cfcomponent>