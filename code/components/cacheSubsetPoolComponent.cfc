<cfcomponent extends="cacheSingletonComponent" displayname="bcuSubsetPoolComponent">

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.id = StructNew()>
	<cfset this.internalContent.sort = StructNew()>
	<cfset this.internalContent.s = StructNew()>
	<cfquery name="svars" datasource="#application.dbSrc#">
		SELECT subset_id, code
		FROM subset
		ORDER BY code
	</cfquery>
	<cfset sCount = 0>
	<cfloop query="svars">
		<cfset sCount = sCount + 1>
		<cfset StructInsert(this.internalContent.id, subset_id, code)>
		<cfset StructInsert(this.internalContent.sort, sCount, code)>
	</cfloop>
</cffunction>

<cffunction name="actionRefreshSubset" output="no">
	<cfargument name="subset_id" type="any" default="">

	<cfset shash = 'subset' & subset_id>

	<cfset this.internalContent.s[shash] = StructNew()>
	<cfset this.internalContent.s[shash].lastRefresh = Now()>
	<cfset this.internalContent.s[shash].sort = StructNew()>
	<cfset this.internalContent.s[shash].pshadow = StructNew()>
	<cfset this.internalContent.s[shash].req = StructNew()>

	<cfquery name="svars" datasource="#application.dbSrc#">
		select s.subset_id, st.subsettype_name as stype, s.code, s.alt_display_id,
			s.spq_display_id, s.intro_display_id, r.code as rpage, s.shadow_subset_id,
			s.branding_partner_id, s.active_flag, s.test_flag, s.eform_flag
		from subset s inner join subsettype st
				on s.subsettype_id=st.subsettype_id
			left outer join resultpage r
				on s.resultpage_id=r.resultpage_id
		where s.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
	</cfquery>
	<cfloop query="svars">
		<cfif alt_display_id eq ''>
			<cfset alt = ''>
		<cfelse>
			<cfset alt = "subalt_#code#">
		</cfif>
		<cfif spq_display_id eq ''>
			<cfset spq = ''>
		<cfelse>
			<cfset spq = "subspq_#code#">
		</cfif>
		<cfif intro_display_id eq ''>
			<cfset intro = ''>
		<cfelse>
			<cfset intro = "subintro_#code#">
		</cfif>
		<cfset StructInsert(this.internalContent.s[shash], 'id', subset_id)>
		<cfset StructInsert(this.internalContent.s[shash], 'type', stype)>
		<cfset StructInsert(this.internalContent.s[shash], 'alt', alt)>
		<cfset StructInsert(this.internalContent.s[shash], 'spq', spq)>
		<cfset StructInsert(this.internalContent.s[shash], 'intro', intro)>
		<cfset StructInsert(this.internalContent.s[shash], 'rpage', rpage)>
		<cfset StructInsert(this.internalContent.s[shash], 'shadow', shadow_subset_id)>
		<cfset StructInsert(this.internalContent.s[shash], 'brand', branding_partner_id)>
		<cfset StructInsert(this.internalContent.s[shash], 'active', active_flag)>
		<cfset StructInsert(this.internalContent.s[shash], 'test', test_flag)>
		<cfset StructInsert(this.internalContent.s[shash], 'eform', eform_flag)>
	</cfloop>
	<cfquery name="psvars" datasource="#application.dbSrc#">
		select partner_id, shadow_subset_id
		from subset_partner_shadow
		where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
		order by partner_id
	</cfquery>
	<cfloop query="psvars">
		<cfset StructInsert(this.internalContent.s[shash].pshadow, "p#partner_id#", shadow_subset_id)>
	</cfloop>
	<cfquery name="rqvars" datasource="#application.dbSrc#">
		select rq.code, srq.sort
		from subset_requisite srq, requisite rq
		where srq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
			and srq.requisite_id=rq.requisite_id
		order by srq.sort
	</cfquery>
	<cfloop query="rqvars">
		<cfset StructInsert(this.internalContent.s[shash].req, sort, code)>
	</cfloop>
</cffunction>

<cffunction name="actionDump" output="yes">
	<cfargument name="subset_id" type="any" default="">

	<cfset shash = 'subset' & subset_id>

	<cfif subset_id neq '' and not StructKeyExists(this.internalContent.s,shash)>
		<cfinvoke component="#this#" method="actionRefreshSubset">
			<cfinvokeargument name="subset_id" value="#subset_id#">
		</cfinvoke>
	</cfif>

	<cfoutput>
		<table border="1" cellpadding="3" cellspacing="1">
		<tr>
			<td colspan="13" align="center"><strong>#this.getDisplayName()#</strong> last refresh #this.internalContent.lastRefresh#</td>
		</tr>

		<tr>
			<td align="right"><strong>id</strong></td>
			<td><strong>subset</strong></td>
			<td><strong>type</strong></td>
			<td><strong>alt</strong></td>
			<td><strong>spq</strong></td>
			<td><strong>intro</strong></td>
			<td><strong>rpage</strong></td>
			<td><strong>shadow</strong></td>
			<td><strong>brand</strong></td>
			<td><strong>active</strong></td>
			<td><strong>test</strong></td>
			<td><strong>eform</strong></td>
			<td><strong>refresh</strong></td>
		</tr>

		<cfloop list="#ListSort(StructKeyList(this.internalContent.id), 'numeric')#" index="s">
			<cfset x = "subset#s#">
			<cfif subset_id eq '' or x eq shash>
				<cfset sid = Right(x, Len(x) - 6)>
				<tr>
					<td align="right" valign="top">#s#</td>
					<td valign="top">#StructFind(this.internalContent.id, sid)#</td>
					<cfif StructKeyExists(this.internalContent.s,x)>
						<td valign="top">#this.internalContent.s[x].type#</td>
						<td valign="top">#this.internalContent.s[x].alt#</td>
						<td valign="top">#this.internalContent.s[x].spq#</td>
						<td valign="top">#this.internalContent.s[x].intro#</td>
						<td valign="top">#this.internalContent.s[x].rpage#</td>
						<td valign="top">#this.internalContent.s[x].shadow#</td>
						<td valign="top">#this.internalContent.s[x].brand#</td>
						<td valign="top">#this.internalContent.s[x].active#</td>
						<td valign="top">#this.internalContent.s[x].test#</td>
						<td valign="top">#this.internalContent.s[x].eform#</td>
						<td valign="top">#this.internalContent.s[x].lastRefresh#</td>
					</cfif>
				</tr>
			</cfif>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<cffunction name="actionGet" output="no">
	<cfargument name="subset_id" type="any" default="">

	<cfif subset_id eq ''>
		<cfreturn StructCopy(this.internalContent)>
	<cfelse>
		<cfset shash = 'subset' & subset_id>
		<cfif not StructKeyExists(this.internalContent.s,shash)>
			<cfinvoke component="#this#" method="actionRefreshSubset">
				<cfinvokeargument name="subset_id" value="#subset_id#">
			</cfinvoke>
		</cfif>
		<cfreturn StructCopy(this.internalContent.s[shash])>
	</cfif>
</cffunction>

<cffunction name="actionGetShadow" output="no">
	<cfargument name="subset_id" type="any" default="">
	<cfargument name="partner_id" type="any" default="">

	<cfif subset_id eq ''>
		<cfreturn ''>
	<cfelse>
		<cfset shash = 'subset' & subset_id>
		<cfif not StructKeyExists(this.internalContent.s,shash)>
			<cfinvoke component="#this#" method="actionRefreshSubset">
				<cfinvokeargument name="subset_id" value="#subset_id#">
			</cfinvoke>
		</cfif>
		<cfif StructKeyExists(this.internalContent.s[shash].pshadow, "p#partner_id#")>
			<cfreturn StructFind(this.internalContent.s[shash].pshadow, "p#partner_id#")>
		<cfelse>
			<cfreturn this.internalContent.s[shash].shadow>
		</cfif>
	</cfif>
</cffunction>

</cfcomponent>