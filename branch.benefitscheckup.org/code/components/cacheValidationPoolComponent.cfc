<cfcomponent extends="cacheSingletonComponent" displayname="bcuValidationPoolComponent">

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.v = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfset this.internalContent.null = StructNew()>
	<cfset this.internalContent.null.exists = false>
	<cfset this.intrenalContent.null.id = ''>
	<cfset this.intrenalContent.null.formula = ''>
	<cfset this.intrenalContent.null.msg = ''>

	<cfquery name="vvars" datasource="#application.dbSrc#">
		select v.validation_id, v.validation_code, v.formula, d.display_code
		from validation v, display d
		where v.display_id=d.display_id
		order by validation_code
	</cfquery>
	<cfset vCount = 0>
	<cfloop query="vvars">
		<cfset vCount = vCount + 1>
		<cfif Not StructKeyExists(this.internalContent.v, validation_code)>
			<cfset this.internalContent.v[validation_code] = StructNew()>
			<cfset this.internalContent.v[validation_code].exists = true>
			<cfset this.internalContent.v[validation_code].id = validation_id>
			<cfset this.internalContent.v[validation_code].formula = formula>
			<cfset this.internalContent.v[validation_code].msg = display_code>
			<cfset StructInsert(this.internalContent.sort, vCount, validation_code)>
		</cfif>
	</cfloop>
</cffunction>

<cffunction name="actionDump" output="yes">
	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="4" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>
		<tr>
			<td align="right"><strong>id</strong></td>
			<td><strong>code</strong></td>
			<td><strong>formula</strong></td>
			<td><strong>message</strong></td>
		</tr>
		<cfloop list="#ListSort(StructKeyList(this.internalContent.sort), 'numeric')#" index="x">
			<cfset var = this.actionGet(this.internalContent.sort[x])>
			<tr>
				<td align="right" valign="top">#var.id#</td>
				<td valign="top">#x#</td>
				<td valign="top">#var.formula#</td>
				<td valign="top">#var.msg#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<cffunction name="actionGet" output="no">
	<cfargument name="code" type="string" default="">

	<cfif code neq '' and StructKeyExists(this.internalContent.v, code)>
		<cfreturn StructCopy(this.internalContent.v[code])>
	<cfelse>
		<cfreturn StructCopy(this.internalContent.null)>
	</cfif>
</cffunction>

</cfcomponent>