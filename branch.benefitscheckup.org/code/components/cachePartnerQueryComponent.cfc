<cfcomponent extends="cacheSingletonComponent" displayname="bcuPartnerQueryComponent">


	<cffunction name="actionRefresh" output="no">
		<cfset This.internalContent = StructNew()>
		<cfset This.internalContent.lastRefresh = Now()>
		<cfset This.internalContent.null = StructNew()>
		<cfset This.internalContent.null.RecordCount = 0>
		<cfquery name="pvars" datasource="#application.dbSrc#">
			select *
			from tbl_partner p left join wrapper w
				on p.wrapper_id=w.wrapper_id
			order by p.partner_id
		</cfquery>
		<cfloop query="pvars">
			<cfset localhash = "p#partner_id#">
			<cfif not StructKeyExists(This.internalContent, localhash)>
				<cfset This.internalContent[localhash] = StructNew()>
				<cfset This.internalContent[localhash].RecordCount = 1>
				<cfloop list="#pvars.ColumnList#" index="x">
					<cfif not StructKeyExists(This.internalContent[localhash], LCase(x))>
						<cfset This.internalContent[localhash][LCase(x)] = "pvars.#x#">
					</cfif>
				</cfloop>
			<cfelse>
				<cfset This.internalContent[localhash].RecordCount = This.internalContent[localhash].RecordCount + 1>
			</cfif>
		</cfloop>
		<cfloop list="#pvars.ColumnList#" index="x">
			<cfif not StructKeyExists(This.internalContent.null, LCase(x))>
				<cfset This.internalContent.null[LCase(x)] = ''>
			</cfif>
		</cfloop>
	</cffunction>

	<cffunction name="getQuery" access="public" output="false">
		<cfargument name="partner_id" type="numeric">
		<cfset phash = "p#partner_id#">
		<cfif StructKeyExists(This.internalContent, phash)>
			<cfreturn StructCopy(This.internalContent[phash])>
		<cfelse>
			<cfreturn StructCopy(This.internalContent.null)>
		</cfif>
	</cffunction>

</cfcomponent>