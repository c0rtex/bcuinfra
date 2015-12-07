<!---
	Template Name: RequisitePoolCache
	Component Purpose: Component manages local cache of requisites

	Data Tables: Requisite, Display

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuRequisitePoolComponent">

<!---
	Method initializes local cache and refresh them
--->

	<cffunction name="actionRefresh" output="no">
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.rq = StructNew()>
		<cfset this.internalContent.id = StructNew()>

		<cfquery name="rqvars" datasource="#application.dbSrc#">
			select r.requisite_id, r.code, d.display_code name, dd.display_code def
			from requisite r inner join display d
					on r.display_id=d.display_id
				left outer join display dd
					on r.def_display_id=dd.display_id
			order by r.requisite_id
		</cfquery>
		<cfloop query="rqvars">
			<cfif Not StructKeyExists(this.internalContent.rq, code)>
				<cfset this.internalContent.rq[code] = StructNew()>
				<cfset this.internalContent.rq[code].id = requisite_id>
				<cfset this.internalContent.rq[code].name = name>
				<cfset this.internalContent.rq[code].def = def>
				<cfset StructInsert(this.internalContent.id, requisite_id, code)>
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
				<td colspan="4" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>code</strong></td>
				<td><strong>name</strong></td>
				<td><strong>def</strong></td>
			</tr>
			<cfloop list="#Listsort(StructKeyList(this.internalContent.id),'numeric')#" index="rq">
				<cfset rqs = this.internalContent.rq[this.internalContent.id[rq]]>
				<tr>
					<td align="right" valign="top">#rqs.id#</td>
					<td valign="top">#this.internalContent.id[rq]#</td>
					<td valign="top">#rqs.name#</td>
					<td valign="top">#rqs.def#</td>
			</cfloop>
			</table>
		</cfoutput>
	</cffunction>

<!---
	Method returns struct contained requisite info for passed code
--->

	<cffunction name="actionGet" output="no">
		<cfargument name="code" type="string" default="">
		<cfif code neq '' and StructKeyExists(this.internalContent.rq, code)>
			<cfreturn StructCopy(this.internalContent.rq[code])>
		<cfelse>
			<cfreturn StructCopy(this.internalContent)>
		</cfif>
	</cffunction>

</cfcomponent>