<!---
	Template Name: GridRowGridColumnPoolCache
	Component Purpose: Component manages local cache of grid cells(couples of grid rows and grid columns) and answer fields associated with cells

	Data Tables: Gridrow_gridcolumn_answerfield, Gridrow, Gridcolumn, Answerfield

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuGridrowGridcolumnPoolComponent">

<!---
	Method initializes local cache and refreshes them
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.gg = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfquery name="ggvars" datasource="#application.dbSrc#">
		select gr.code grcode, gc.code gccode, a.answerfield
		from gridrow_gridcolumn_answerfield gga, gridrow gr, gridcolumn gc, answerfield a
		where gga.gridrow_id=gr.gridrow_id
			and gga.gridcolumn_id=gc.gridcolumn_id
			and gga.answerfield_id=a.answerfield_id
		order by gr.sort, gc.sort
	</cfquery>
	<cfset ggCount = 0>
	<cfloop query="ggvars">
		<cfset ggCount = ggCount + 1>
		<cfset code = "#grcode#_#gccode#">
		<cfif Not StructKeyExists(this.internalContent.gg, code)>
			<cfset this.internalContent.gg[code] = StructNew()>
			<cfset this.internalContent.gg[code].af = answerfield>
			<cfset StructInsert(this.internalContent.sort, ggCount, code)>
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
			<td align="right"><strong>sort</strong></td>
			<td><strong>gg</strong></td>
			<td><strong>answerfield</strong></td>
		</tr>
		<cfset ggCount = 0>
		<cfloop list="#Listsort(StructKeyList(this.internalContent.sort),'numeric')#" index="g">
			<cfset ggCount = ggCount + 1>
			<cfset gg=this.internalContent.sort[g]>
			<tr>
				<td align="right" valign="top">#ggCount#</td>
				<td valign="top">#gg#</td>
				<td valign="top">#this.internalContent.gg[gg].af#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns grid cell item (struct) with passed cell code
--->

<cffunction name="actionGet" output="no">
	<cfargument name="code" type="string" default="">
	<cfif code neq '' and StructKeyExists(this.internalContent.gg, code)>
		<cfreturn StructCopy(this.internalContent.gg[code])>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>

</cfcomponent>