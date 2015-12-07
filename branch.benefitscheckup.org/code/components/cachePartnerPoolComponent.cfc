<!---
	Template Name: PartnerPoolCache
	Component Purpose: Component manages local cache of partners

	Data Tables: Tbl_partner, Display, Wrapper

--->

<cfcomponent extends="cacheSingletonComponent" displayname="bcuPartnerPoolComponent">

<!---
	Method initializes local cache and refresh them
--->

	<cffunction name="actionRefresh" output="no">
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.id = StructNew()>
		<cfset this.internalContent.sort = StructNew()>
		<cfset this.internalContent.p = StructNew()>
		<cfquery name="pvars" datasource="#application.dbSrc#">
			SELECT partner_id, partner_code
			FROM tbl_partner
			ORDER BY partner_code
		</cfquery>
		<cfset pCount = 0>
		<cfloop query="pvars">
			<cfset pCount = pCount + 1>
			<cfset StructInsert(this.internalContent.id, partner_id, partner_code)>
			<cfset StructInsert(this.internalContent, pCount, partner_code)>
		</cfloop>
	</cffunction>

<!---
	Method refresh particular partner with passed id in local cache
--->

	<cffunction name="actionRefreshPartner" output="no">
		<cfargument name="partner_id" type="any" default="">
		<cfset phash = 'partner' & partner_id>
		<cfset this.internalContent.p[phash] = StructNew()>
		<cfset this.internalContent.p[phash].lastRefresh = Now()>
		<cfset this.internalContent.p[phash].sort = StructNew()>
		<cfquery name="pvars" datasource="#application.dbSrc#">
			select p.partner_id, p.partner_code, p.partner_name, p.partner_url, p.alt_name, d.display_code bcu,
				p.partner_wrapper, p.partner_header, p.partner_footer, p.partner_css, p.partner_titlebar,
				p.cms_doc_no, p.learn_flag, p.race_flag, p.hispanic_flag, p.links_flag, p.pdf_logo_flag, w.wrapper_code
			from tbl_partner p left outer join display d
					on p.bcu_display_id=d.display_id
				left outer join wrapper w
					on p.wrapper_id=w.wrapper_id
			where p.partner_id=#partner_id#
		</cfquery>
		<cfloop query="pvars">
			<cfset StructInsert(this.internalContent.p[phash], 'id', partner_id)>
			<cfset StructInsert(this.internalContent.p[phash], 'name', partner_name)>
			<cfset StructInsert(this.internalContent.p[phash], 'url', partner_url)>
			<cfset StructInsert(this.internalContent.p[phash], 'alt', alt_name)>
			<cfset StructInsert(this.internalContent.p[phash], 'bcu', bcu)>
			<cfset StructInsert(this.internalContent.p[phash], 'wrapper', partner_wrapper)>
			<cfset StructInsert(this.internalContent.p[phash], 'header', partner_header)>
			<cfset StructInsert(this.internalContent.p[phash], 'footer', partner_footer)>
			<cfset StructInsert(this.internalContent.p[phash], 'css', partner_css)>
			<cfset StructInsert(this.internalContent.p[phash], 'titlebar', partner_titlebar)>
			<cfset StructInsert(this.internalContent.p[phash], 'cms', cms_doc_no)>
			<cfset StructInsert(this.internalContent.p[phash], 'learn', learn_flag)>
			<cfset StructInsert(this.internalContent.p[phash], 'race', race_flag)>
			<cfset StructInsert(this.internalContent.p[phash], 'hispanic', hispanic_flag)>
			<cfset StructInsert(this.internalContent.p[phash], 'links', links_flag)>
			<cfset StructInsert(this.internalContent.p[phash], 'pdf', pdf_logo_flag)>
			<cfset StructInsert(this.internalContent.p[phash], 'wcode', wrapper_code)>
		</cfloop>
	</cffunction>

<!---
	Method returns html table with dump of cache content
--->

	<cffunction name="actionDump" output="yes">
		<cfargument name="partner_id" type="any" default="">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="18" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
			</tr>

			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>partner</strong></td>
				<td><strong>name</strong></td>
				<td><strong>url</strong></td>
				<td><strong>alt</strong></td>
				<td><strong>wrapper</strong></td>
				<td><strong>header</strong></td>
				<td><strong>footer</strong></td>
				<td><strong>css</strong></td>
				<td><strong>titlebar</strong></td>
				<td><strong>cms</strong></td>
				<td><strong>learn</strong></td>
				<td><strong>race</strong></td>
				<td><strong>hispanic</strong></td>
				<td><strong>links</strong></td>
				<td><strong>pdf</strong></td>
				<td><strong>wcode</strong></td>
				<td><strong>refresh</strong></td>
			</tr>

			<cfloop list="#ListSort(StructKeyList(this.internalContent.id), 'numeric')#" index="p">
				<cfset x = "partner#p#">
				<cfif partner_id eq '' or x eq ('partner' & partner_id)>
					<cfset pid = Right(x, Len(x) - 7)>
					<tr>
						<td align="right" valign="top">#p#</td>
						<td valign="top">#StructFind(this.internalContent.id, pid)#</td>
						<cfif StructKeyExists(this.internalContent.p,x)>
						<td valign="top">#this.internalContent.p[x].name#</td>
						<td valign="top">#this.internalContent.p[x].url#</td>
						<td valign="top">#this.internalContent.p[x].alt#</td>
						<td valign="top">#this.internalContent.p[x].wrapper#</td>
						<td valign="top">#this.internalContent.p[x].header#</td>
						<td valign="top">#this.internalContent.p[x].footer#</td>
						<td valign="top">#this.internalContent.p[x].css#</td>
						<td valign="top">#this.internalContent.p[x].titlebar#</td>
						<td valign="top">#this.internalContent.p[x].cms#</td>
						<td valign="top">#this.internalContent.p[x].learn#</td>
						<td valign="top">#this.internalContent.p[x].race#</td>
						<td valign="top">#this.internalContent.p[x].hispanic#</td>
						<td valign="top">#this.internalContent.p[x].links#</td>
						<td valign="top">#this.internalContent.p[x].pdf#</td>
						<td valign="top">#this.internalContent.p[x].wcode#</td>
						<td valign="top">#this.internalContent.p[x].lastRefresh#</td>
						</cfif>
					</tr>
				</cfif>
			</cfloop>
			</table>
		</cfoutput>
	</cffunction>

<!---
	Method returns struct contained partner info for passed partner id
--->

	<cffunction name="actionGet" output="no">
		<cfargument name="partner_id" type="any" default="">
		<cfif partner_id eq ''>
			<cfset doAll = true>
		<cfelse>
			<cfset doAll = false>
			<cfset phash = 'partner' & partner_id>
		</cfif>

		<cfif doAll>
			<cfreturn StructCopy(this.internalContent)>
		<cfelse>
			<cfif not IsDefined("this.internalContent.p.#phash#")>
				<cfinvoke component="#this#" method="actionRefreshPartner">
					<cfinvokeargument name="partner_id" value="#partner_id#">
				</cfinvoke>
			</cfif>
			<cfreturn StructCopy(this.internalContent.p[phash])>
		</cfif>
	</cffunction>


</cfcomponent>