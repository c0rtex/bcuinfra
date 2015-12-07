<!---
	Template Name: WrapperPoolCache
	Component Purpose: Component manages local cache of partner wrappers

	Data Tables: Wrapper, Tbl_partner

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuWrapperQueryComponent">

<!---
	Method initializes local cache and refresh them
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.null = StructNew()>
	<cfset this.internalContent.null.RecordCount = 0>

	<cfquery name="wvars" datasource="#application.dbSrc#">
		select *
		from wrapper w left join tbl_partner p
			on w.wrapper_id=p.wrapper_id
		order by p.partner_id
	</cfquery>

	<cfloop query="wvars">
		<cfset localhash = "w#partner_id#">
		<cfif not StructKeyExists(this.internalContent, localhash)>
			<cfset this.internalContent[localhash] = StructNew()>
			<cfset StructInsert(this.internalContent[localhash], 'RecordCount', 1)>
			<cfloop list="#wvars.ColumnList#" index="x">
				<cfif not StructKeyExists(this.internalContent[localhash], LCase(x))>
					<cfset StructInsert(this.internalContent[localhash], LCase(x), Evaluate("wvars.#x#"))>
				</cfif>
			</cfloop>
		<cfelse>
			<cfset StructUpdate(this.internalContent[localhash], 'RecordCount', StructFind(this.internalContent[localhash], 'RecordCount') + 1)>
		</cfif>
	</cfloop>
</cffunction>

<!---
	Method returns struct contained wrapper info for passed partner id
--->

<cffunction name="actionGet" output="no">
	<cfargument name="partner_id" type="numeric">

	<cfset whash = "w#partner_id#">

	<cfif StructKeyExists(this.internalContent, whash)>
		<cfreturn StructCopy(this.internalContent[whash])>
	<cfelseif StructKeyExists(this.internalContent, 'w')>
		<cfreturn StructCopy(this.internalContent.w)>
	<cfelse>
		<cfreturn StructCopy(this.internalContent.null)>
	</cfif>
</cffunction>

</cfcomponent>
