<!---
	Template Name: StatePoolCache
	Component Purpose: Component manages local cache of states

	Data Tables: State, Statetype

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuStatePoolComponent">

<!---
	Method initializes local cache and refresh them
--->

	<cffunction name="actionRefresh" output="false">
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.st = StructNew()>
		<cfset this.internalContent.sort = StructNew()>

		<!--- save a null rule obj with blank elements to return when rule code not found --->
		<cfset this.internalContent.null = StructNew()>
		<cfset this.internalContent.null.exists = false>
		<cfset this.internalContent.null.name = ''>
		<cfset this.internalContent.null.type = ''>

		<cfquery name="stvars" datasource="#application.dbSrc#">
			select s.state_id, s.state_name, st.statetype_name
			from state s, statetype st
			where s.statetype_id=st.statetype_id
			order by s.state_name
		</cfquery>
		<cfset stCount = 0>
		<cfloop query="stvars">
			<cfset stCount = stCount + 1>
			<cfif Not IsDefined("this.internalContent.st.#state_id#")>
				<cfset this.internalContent.st[state_id] = StructNew()>
				<cfset this.internalContent.st[state_id].exists = true>
				<cfset this.internalContent.st[state_id].name = state_name>
				<cfset this.internalContent.st[state_id].type = statetype_name>
				<cfset StructInsert(this.internalContent.sort, stCount, state_id)>
			</cfif>
		</cfloop>
	</cffunction>

<!---
	Method returns html table with dump of cache content
--->

	<cffunction name="actionDump" output="true">

		<cfset var displayname = getMetaData(this).displayname>

		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
				<tr>
					<td colspan="3" align="center"><strong>#displayname#</strong> last refresh #Evaluate("this.internalContent.lastRefresh")#</td>
				</tr>
				<tr>
					<td align="right"><strong>id</strong></td>
					<td><strong>name</strong></td>
					<td><strong>type</strong></td>
				</tr>
				<cfloop collection="#This.internalContent.st#" item="state_id">
					<tr>
						<td align="right" valign="top">#state_id#</td>
						<td valign="top">#This.internalContent.st[state_id].name#</td>
						<td valign="top">#This.internalContent.st[state_id].type#</td>
					</tr>
				</cfloop>
			</table>
		</cfoutput>
	</cffunction>

<!---
	Method returns struct contained state info for passed state id
--->

	<cffunction name="actionGet" output="false">
		<cfargument name="state_id" type="string">
		<cfif state_id eq ''>
			<cfreturn StructCopy(this.internalContent)>
		<cfelseif state_id neq '' and StructKeyExists(this.internalContent.st, state_id)>
			<cfreturn StructCopy(this.internalContent.st[state_id])>
		<cfelse>
			<cfreturn StructCopy(this.internalContent.null)>
		</cfif>
	</cffunction>

</cfcomponent>