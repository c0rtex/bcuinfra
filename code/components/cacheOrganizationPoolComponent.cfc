<!---
	Template Name: OrganizationPoolCache
	Component Purpose: Component manages local cache of organizations and there contacts

	Data Tables: Organization, Address, Phone, Report

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuOrganizationPoolComponent">

<!---
	Method initializes local cache and clear them
--->

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.o = StructNew()>
</cffunction>

<!---
	Method retrieves particular organization from database by id and puts them to local cache
--->

<cffunction name="actionRefreshOrganization" output="no">
	<cfargument name="org_id" type="any" default="">
	<cfset ohash = 'org' & org_id>
	<cfset this.internalContent.o[ohash] = StructNew()>
	<cfset this.internalContent.o[ohash].lastRefresh = Now()>
	<cfquery name="ovars" datasource="#application.dbSrcOE#">
		select o.site_name, o.slogan, o.site_bg_color, o.logo_path, o.url, p.site_name parent, a.line_1, a.line_2,
			a.city, a.state, a.zip, op.number, tp.number tdd, r.intro, r.contact_name, r.cover_comments
		from ORGANIZATION o left outer join ORGANIZATION p
				on o.parent_org_id = p.id
					and p.org_name != 'NCOA'
			left outer join ADDRESS a
		    	on a.org_id=o.id
			left outer join PHONE op
		    	on op.org_id=o.id
					and op.phonetype_id=1
			left outer join PHONE tp
				on tp.org_id=o.id
					and tp.phonetype_id=6
			left outer join REPORT r
		    	on r.org_id=o.id
		where o.id=<cfqueryparam cfsqltype="cf_sql_integer" value="#org_id#" maxlength="4">
	</cfquery>
	<cfloop query="ovars">
		<cfset StructInsert(this.internalContent.o[ohash], 'name', site_name)>
		<cfset StructInsert(this.internalContent.o[ohash], 'slogan', slogan)>
		<cfset StructInsert(this.internalContent.o[ohash], 'bg', site_bg_color)>
		<cfset StructInsert(this.internalContent.o[ohash], 'logo', logo_path)>
		<cfset StructInsert(this.internalContent.o[ohash], 'url', url)>
		<cfset StructInsert(this.internalContent.o[ohash], 'parent', parent)>
		<cfset StructInsert(this.internalContent.o[ohash], 'address1', line_1)>
		<cfset StructInsert(this.internalContent.o[ohash], 'address2', line_2)>
		<cfset StructInsert(this.internalContent.o[ohash], 'city', city)>
		<cfset StructInsert(this.internalContent.o[ohash], 'state', state)>
		<cfset StructInsert(this.internalContent.o[ohash], 'zip', zip)>
		<cfset StructInsert(this.internalContent.o[ohash], 'phone', number)>
		<cfset StructInsert(this.internalContent.o[ohash], 'tdd', tdd)>
		<cfset StructInsert(this.internalContent.o[ohash], 'intro', intro)>
		<cfset StructInsert(this.internalContent.o[ohash], 'contact', contact_name)>
		<cfset StructInsert(this.internalContent.o[ohash], 'comment', cover_comments)>
	</cfloop>
</cffunction>

<!---
	Method returns html table with dump of cache content
--->

<cffunction name="actionDump" output="yes">
	<cfargument name="org_id" type="any" default="">
	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="18" align="center"><strong>this.getDisplayName()</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>

		<tr>
			<td align="right"><strong>id</strong></td>
			<td><strong>name</strong></td>
			<td><strong>slogan</strong></td>
			<td><strong>bg</strong></td>
			<td><strong>logo</strong></td>
			<td><strong>url</strong></td>
			<td><strong>parent</strong></td>
			<td><strong>address1</strong></td>
			<td><strong>address2</strong></td>
			<td><strong>city</strong></td>
			<td><strong>state</strong></td>
			<td><strong>zip</strong></td>
			<td><strong>phone</strong></td>
			<td><strong>tdd</strong></td>
			<td><strong>intro</strong></td>
			<td><strong>contact</strong></td>
			<td><strong>comment</strong></td>
			<td><strong>refresh</strong></td>
		</tr>

		<cfloop list="#ListSort(StructKeyList(this.internalContent.o), 'text')#" index="x">
			<cfif org_id eq '' or x eq ('org' & org_id)>
				<cfset oid = Right(x, Len(x) - 3)>
				<tr>
					<td align="right" valign="top">#oid#</td>
					<cfif IsDefined("this.internalContent.o.#x#")>
					<td valign="top">#this.internalContent.o[x].name#</td>
					<td valign="top">#this.internalContent.o[x].slogan#</td>
					<td valign="top">#this.internalContent.o[x].bg#</td>
					<td valign="top">#this.internalContent.o[x].logo#</td>
					<td valign="top">#this.internalContent.o[x].url#</td>
					<td valign="top">#this.internalContent.o[x].parent#</td>
					<td valign="top">#this.internalContent.o[x].address1#</td>
					<td valign="top">#this.internalContent.o[x].address2#</td>
					<td valign="top">#this.internalContent.o[x].city#</td>
					<td valign="top">#this.internalContent.o[x].state#</td>
					<td valign="top">#this.internalContent.o[x].zip#</td>
					<td valign="top">#this.internalContent.o[x].phone#</td>
					<td valign="top">#this.internalContent.o[x].tdd#</td>
					<td valign="top">#this.internalContent.o[x].intro#</td>
					<td valign="top">#this.internalContent.o[x].contact#</td>
					<td valign="top">#this.internalContent.o[x].comment#</td>
					<td valign="top">#this.internalContent.o[x].lastRefresh#</td>
					</cfif>
				</tr>
			</cfif>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<!---
	Method returns struct contained organization info and contacts with passed organization id
--->

<cffunction name="actionGet" output="no">
	<cfargument name="org_id" type="any" default="">

	<cfif org_id eq ''>
		<cfset doAll = true>
	<cfelse>
		<cfset doAll = false>
		<cfset ohash = 'org' & org_id>
	</cfif>

	<cfif doAll>
		<cfreturn StructCopy(this.internalContent)>
	<cfelse>
		<cfif not IsDefined("this.internalContent.o.#ohash#")>
			<cfinvoke component="#this#" method="actionRefreshOrganization">
				<cfinvokeargument name="org_id" value="#org_id#">
			</cfinvoke>
		</cfif>
		<cfreturn StructCopy(this.internalContent.o[ohash])>
	</cfif>
</cffunction>

</cfcomponent>