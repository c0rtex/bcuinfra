<!---
	Template Name: SubsetProgramPoolCache
	Component Purpose: Component manages local cache of subsets programs

	Data Tables: Subset_program_sum, Program

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuSubsetProgramPoolComponent">

<!---
	Method initializes local cache and refresh them
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.sp = StructNew()>
</cffunction>

<!---
	Method adds or refresh particular subset programs in cache with passed subset id and state id
--->

<cffunction name="actionRefreshSubsetProgram" output="no">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">

	<cfset sphash = state_id & subset_id>

	<cfset this.internalContent.sp[sphash] = StructNew()>
	<cfset this.internalContent.sp[sphash].lastRefresh = Now()>
	<cfset this.internalContent.sp[sphash].sort = StructNew()>

	<cfquery name="spvars" datasource="#application.dbSrc#">
		select p.program_id, p.program_code
		from subset_program_sum sp, program p
		where sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
			and sp.program_id=p.program_id
			and p.active_flag=1
			and (p.state_id is null or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
		order by p.sort
	</cfquery>
	<cfset pCount = 0>
	<cfloop query="spvars">
		<cfset pCount = pCount + 1>
		<cfset StructInsert(this.internalContent.sp[sphash].sort, pCount, program_code)>
	</cfloop>
</cffunction>

<!---
	Method returns html table with dump of cache content
--->

<cffunction name="actionDump" output="yes">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">

	<cfif state_id eq '' or subset_id eq ''>
		<cfset doAll = true>
	<cfelse>
		<cfset doAll = false>
		<cfset sphash = state_id & subset_id>
		<cfif not StructKeyExists(this.internalContent.sp, sphash)>
			<cfinvoke component="#this#" method="actionRefreshsubsetprogram">
				<cfinvokeargument name="state_id" value="#state_id#">
				<cfinvokeargument name="subset_id" value="#subset_id#">
			</cfinvoke>
		</cfif>
	</cfif>

	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="7" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>

		<cfloop list="#ListSort(StructKeyList(this.internalContent.sp), 'textnocase')#" index="x">
			<cfif doAll or x eq sphash>
			<tr>
				<td colspan="7" align="center"><strong>#x#</strong> last refresh #this.internalContent.sp[x].lastRefresh#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td><strong>program</strong></td>
			</tr>
			<cfset programCount = 0>
			<cfloop list="#ListSort(StructKeyList(this.internalContent.sp[x].sort), 'numeric')#" index="y">
				<cfset programCount = programCount + 1>
				<tr>
					<td align="right" valign="top">#programCount#</td>
					<td valign="top">#y#</td>
				</tr>
			</cfloop>
			</cfif>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns struct contained subset programs info for passed subset id and state id
--->

<cffunction name="actionGet" output="no">
	<cfargument name="state_id" type="string" default="">
	<cfargument name="subset_id" type="any" default="">

	<cfif state_id eq '' or subset_id eq ''>
		<cfreturn false>
	<cfelse>
		<cfset sphash = state_id & subset_id>
		<cfif not StructKeyExists(this.internalContent.sp, sphash)>
			<cfinvoke component="#this#" method="actionRefreshSubsetProgram">
				<cfinvokeargument name="state_id" value="#state_id#">
				<cfinvokeargument name="subset_id" value="#subset_id#">
			</cfinvoke>
		</cfif>
		<cfreturn StructCopy(this.internalContent.sp[sphash])>
	</cfif>
</cffunction>



</cfcomponent>