<cfcomponent extends="cacheSingletonComponent" displayname="bcuGridColumnPoolComponent">

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.gc = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfquery name="gcvars" datasource="#application.dbSrc#">
		select g.code, h.help_code, g.sort
		from gridcolumn g left outer join help h
			on g.help_id=h.help_id
		order by g.sort
	</cfquery>
	<cfloop query="gcvars">
		<cfif Not StructKeyExists(this.internalContent.gc,code)>
			<cfset this.internalContent.gc[code] = StructNew()>
			<cfset this.internalContent.gc[code].help = help_code>
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
			<td><strong>gridcolumn</strong></td>
			<td><strong>help</strong></td>
		</tr>
		<cfset gcCount = 0>
		<cfloop collection="#this.internalContent.sort#" item="x">
			<cfset gcCount = gcCount + 1>
			<cfset help = this.actionGet(x)>
			<tr>
				<td align="right" valign="top">#gcCount#</td>
				<td valign="top">#x#</td>
				<td valign="top">#help#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<cffunction name="actionGet" output="no">
	<cfargument name="code" type="string" default="">>
	<cfif code neq '' and StructKeyExists(this.internalContent.gc, code)>
		<cfreturn StructCopy(this.internalContent.gc[code])>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>

</cfcomponent>