<cfcomponent extends="cacheSingletonComponent" displayname="bcuImagePoolComponent">

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.i = StructNew()>
	<cfset this.internalContent.sort = StructNew()>

	<cfquery name="ivars" datasource="#application.dbSrc#">
		select image_id, code, filename, width, height
		from image
		order by filename
	</cfquery>
	<cfset iCount = 0>
	<cfloop query="ivars">
		<cfset iCount = iCount + 1>
		<cfif Not IsDefined("this.internalContent.i.#code#")>
			<cfset this.internalContent.i[code] = StructNew()>
			<cfset this.internalContent.i[code].id = image_id>
			<cfset this.internalContent.i[code].file = filename>
			<cfset this.internalContent.i[code].w = width>
			<cfset this.internalContent.i[code].h = height>
			<cfset StructInsert(this.internalContent.sort, iCount, code)>
		</cfif>
	</cfloop>
</cffunction>

<cffunction name="actionDump" output="yes">
	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="6" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>
		<tr>
			<td align="right"><strong>id</strong></td>
			<td><strong>code</strong></td>
			<td><strong>file</strong></td>
			<td><strong>w</strong></td>
			<td><strong>h</strong></td>
		</tr>
		<cfloop list="#Listsort(StructKeyList(this.internalContent.sort),'numeric')#" index="x">
			<cfset bcuImage = this.actionGet(this.internalContent.sort[x])>
			<tr>
				<td align="right" valign="top">#bcuImage.id#</td>
				<td valign="top">#x#</td>
				<td valign="top">#bcuImage.file#</td>
				<td align="right" valign="top">#bcuImage.w#</td>
				<td align="right" valign="top">#bcuImage.h#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<cffunction name="actionGet" output="no">
	<cfargument name="code" type="string" default="">
	<cfif code neq '' and StructKeyExists(this.internalContent.i, code)>
		<cfreturn StructCopy(this.internalContent.i[code])>
	<cfelse>
		<cfreturn false>
	</cfif>
</cffunction>


</cfcomponent>