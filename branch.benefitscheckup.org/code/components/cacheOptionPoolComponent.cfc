<!---
	Template Name: OptionPoolCache
	Component Purpose: Component manages local cache of answer field options, i.e. set of possible answers

	Data Tables: Option

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuOptionPoolComponent">

<!---
	Method initializes local cache and refreshes them
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.o = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfquery name="ovars" datasource="#application.dbSrc#">
		select o.option_id, o.option_code, o.include_flag
		from `option` o
		order by o.option_id
	</cfquery>
	<cfloop query="ovars">
		<cfif Not IsDefined("this.internalContent.o.#option_code#")>
			<cfset this.internalContent.o[option_code] = StructNew()>
			<cfset this.internalContent.o[option_code].id = option_id>
			<cfset this.internalContent.o[option_code].inc = include_flag>
			<cfset this.internalContent.o[option_code].sp = StructNew()>
			<cfset StructInsert(this.internalContent.sort, option_id, option_code)>
		</cfif>
	</cfloop>
	<cfquery name="ospvars" datasource="#application.dbSrc#">
		select o.option_code, osp.subset_id, osp.partner_id, osp.include_flag
		from `option_subset_partner` osp, `option` o
		where osp.option_id=o.option_id
		order by osp.option_id, osp.subset_id, osp.partner_id
	</cfquery>
	<cfloop query="ospvars">
		<cfset this.internalContent.o["#option_code#"].sp["s#subset_id#p#partner_id#"] = include_flag>
	</cfloop>
</cffunction>

<!---
	Method returns html table with dump of cache content
--->

<cffunction name="actionDump" output="yes">
	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="3" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>
		<tr>
			<td align="right"><strong>id</strong></td>
			<td><strong>option</strong></td>
			<td><strong>include</strong></td>
		</tr>
		<cfloop list="#Listsort(StructKeyList(this.internalContent.sort),'numeric')#" index="ind">
			<cfset o = this.internalContent.o[this.internalContent.sort[ind]]>
			<tr>
				<td align="right" valign="top">#o.id#</td>
				<td valign="top">#this.internalContent.sort[ind]#</td>
				<td valign="top">#o.inc#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns struct contained option attributes with passed option code
--->

<cffunction name="actionGet" output="no">
	<cfargument name="code" type="string" default="">
	<cfif code neq '' and StructKeyExists(this.internalContent.o, code)>
		<cfreturn StructCopy(this.internalContent.o[code])>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>

<!---
	Method returns option code by passed option id
--->

<cffunction name="actionGetCodeById" output="no">
	<cfargument name="id" type="numeric" default="0">
	<cfif id gt 0 and StructKeyExists(this.internalContent.sort, id)>
		<cfreturn StructFind(this.internalContent.sort, id)>
	<cfelse>
		<cfreturn ''>
	</cfif>
</cffunction>


</cfcomponent>
