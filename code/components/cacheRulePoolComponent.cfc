<!---
	Template Name: RulePoolCache
	Component Purpose: Component manages local cache of rules

	Data Tables: Rule

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuRulePoolComponent">

<!---
	Method initializes local cache and refresh them
--->

	<cffunction name="actionRefresh" output="no" >
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.r = StructNew()>
		<cfset this.internalContent.sort = StructNew()>

		<cfset this.internalContent.null = StructNew()>
		<cfset this.internalContent.null.exists = false>
		<cfset this.internalContent.null.id = ''>
		<cfset this.internalContent.null.text = ''>

		<cfquery name="rvars" datasource="#application.dbSrc#">
			select rule_id, code, rule_text
			from rule
			order by code
		</cfquery>
		<cfset rCount = 0>
		<cfloop query="rvars">
			<cfset rCount = rCount + 1>
			<cfif Not StructKeyExists(this.internalContent.r, code)>
				<cfset this.internalContent.r[code] = StructNew()>
				<cfset this.internalContent.r[code].exists = true>
				<cfset this.internalContent.r[code].id = rule_id>
				<cfset this.internalContent.r[code].text = rule_text>
				<cfset StructInsert(this.internalContent.sort, rCount, code)>
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
				<td colspan="3" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>code</strong></td>
				<td><strong>rule</strong></td>
			</tr>
			<cfloop list="#Listsort(StructKeyList(this.internalContent.sort),'numeric')#" index="x">
				<cfset r = this.actionGet(this.internalContent.sort[x])>
				<tr>
					<td align="right" valign="top">#r.id#</td>
					<td valign="top">#this.internalContent.sort[x]#</td>
					<td valign="top">#r.text#</td>
				</tr>
			</cfloop>
			</table>
		</cfoutput>
	</cffunction>

<!---
	Method returns struct contained rule info for passed code
--->

	<cffunction name="actionGet" output="no">
		<cfargument name="code" type="string" default="">
		<cfif code neq '' and StructKeyExists(this.internalContent.r, code)>
			<cfreturn StructCopy(this.internalContent.r[code])>
		<cfelse>
			<cfreturn StructCopy(this.internalContent.null)>
		</cfif>
	</cffunction>

</cfcomponent>