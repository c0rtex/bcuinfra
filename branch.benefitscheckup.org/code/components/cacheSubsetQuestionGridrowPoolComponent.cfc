<!---
	Template Name: SubsetQuestionGridrowPoolCache
	Component Purpose: Component manages local cache of grid row codes included to subsets and it's questions

	Data Tables: Question, Question_gridrow, Gridrow, Subset_gridrow,

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuSubsetQuestionGridrowPoolComponent">

<!---
	Methods initializes and recreates cache container
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.sqg = StructNew()>
</cffunction>

<!---
	Methods adds or refresh particular grids questions included to particular subset
--->

<cffunction name="actionRefreshSubsetQuestionGridrow" output="no">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfset sqghash = 'subset' & subset_id & '_' & question>

	<cfset this.internalContent.sqg[sqghash] = StructNew()>
	<cfset this.internalContent.sqg[sqghash].lastRefresh = Now()>
	<cfset this.internalContent.sqg[sqghash].sort = StructNew()>

	<cfquery name="sqgvars" datasource="#application.dbSrc#">
		select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='#question#'
			and q.question_id=qg.question_id
			and qg.gridrow_id=g.gridrow_id
			and g.exclude_flag=0
			and g.gridrow_id not in (
				select gridrow_id
				from subset_gridrow
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					and exclude_flag=1
			)
		union
		select g.code as gcode, g.sort as gsort
		from question q, question_gridrow qg, gridrow g
		where q.question_code='#question#'
			and q.question_id=qg.question_id
			and qg.gridrow_id=g.gridrow_id
			and g.exclude_flag=1
			and g.gridrow_id in (
				select gridrow_id
				from subset_gridrow
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					and exclude_flag=0
			)
		order by gsort
	</cfquery>
	<cfset gCount = 0>
	<cfloop query="sqgvars">
		<cfset gCount = gCount + 1>
		<cfset StructInsert(this.internalContent.sqg[sqghash].sort, gCount, gcode)>
	</cfloop>
</cffunction>

<!---
	Method returns html table with dump of cache content
--->

<cffunction name="actionDump" output="yes">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfset doAll = subset_id eq '' or question eq ''>

	<cfset sqghash = 'subset' & subset_id & '_' & question>

	<cfif not doAll and not StructKeyExists(this.internalContent.sqg, sqghash)>
		<cfinvoke component="#this#" method="actionRefreshSubsetQuestionGridrow">
			<cfinvokeargument name="subset_id" value="#subset_id#">
			<cfinvokeargument name="question" value="#question#">
		</cfinvoke>
	</cfif>

	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="7" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>

		<cfloop list="#ListSort(StructKeyList(this.internalContent.sqg), 'textnocase')#" index="x">
			<cfif subset_id eq '' or question eq '' or x eq sqghash>
			<tr>
				<td colspan="7" align="center"><strong>#x#</strong> last refresh #this.internalContent.sqg[x].lastRefresh#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td><strong>gridrow</strong></td>
			</tr>
			<cfset gridrowCount = 0>
			<cfloop list="#ListSort(StructKeyList(this.internalContent.sqg[x].sort), 'numeric')#" index="y">
				<cfset gridrowCount = gridrowCount + 1>
				<tr>
					<td align="right" valign="top">#gridrowCount#</td>
					<td valign="top">#y#</td>
				</tr>
			</cfloop>
			</cfif>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns struct contained grid row code for passed subset id and  question code
--->

<cffunction name="actionGet" output="no">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="question" type="any" default="">

	<cfif subset_id eq '' or question eq ''>
		<cfreturn false>
	<cfelse>
		<cfset sqghash = 'subset' & subset_id & '_' & question>

		<cfif not StructKeyExists(this.internalContent.sqg,sqghash)>
			<cfinvoke component="#this#" method="actionRefreshSubsetQuestionGridrow">
				<cfinvokeargument name="subset_id" value="#subset_id#">
				<cfinvokeargument name="question" value="#question#">
			</cfinvoke>
		</cfif>

		<cfreturn StructCopy(this.internalContent.sqg[sqghash])>
	</cfif>
</cffunction>

</cfcomponent>