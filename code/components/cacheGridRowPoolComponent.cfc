<cfcomponent extends="cacheSingletonComponent" displayname="bcuGridRowPoolComponent">

	<cffunction name="actionRefresh" output="no">
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.gr = StructNew()>
		<cfset this.internalContent.sort = StructNew()>

		<cfquery name="grvars" datasource="#application.dbSrc#">
			select g.code, h.help_code, g.sort
			from gridrow g left outer join help h
				on g.help_id=h.help_id
			order by g.sort
		</cfquery>
		<cfloop query="grvars">
			<cfif Not IsDefined("this.internalContent.gr.#code#")>
				<cfset this.InternalContent.gr[code] = StructNew()>
				<cfset this.internalContent.gr[code].help = help_code>
				<cfset StructInsert(this.internalContent.sort, sort, code)>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="actionDump" output="yes">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="3" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
			</tr>
			<tr>
				<td align="right"><strong>sort</strong></td>
				<td><strong>gridrow</strong></td>
				<td><strong>help</strong></td>
			</tr>
			<cfset grCount = 0>
			<cfloop list="#Listsort(StructKeyList(this.internalContent.sort),'numeric')#" index="x">
				<cfset grCount = grCount + 1>
				<cfset bcuGridrow = this.actionGet(this.internalContent.sort[x])>
				<tr>
					<td align="right" valign="top">#grCount#</td>
					<td valign="top">#this.internalContent.sort[x]#</td>
					<td valign="top">#bcuGridrow.help#</td>
				</tr>
			</cfloop>
			</table>
		</cfoutput>
	</cffunction>

	<cffunction name="actionGet" output="no">
		<cfargument name="code" type="string" default="">
		<cfif code neq '' and StructKeyExists(this.internalContent.gr, code)>
			<cfreturn StructCopy(this.internalContent.gr[code])>
		<cfelse>
			<cfreturn false>
		</cfif>

	</cffunction>


</cfcomponent>