<cfcomponent extends="cacheSingletonComponent" displayname="bcuAnswerfieldSubsetPartnerPoolComponent">

<cffunction name="actionRefresh" output="no">
	<cfset this.internalContent = StructNew()>
	<cfset this.internalContent.lastRefresh = Now()>
	<cfset this.internalContent.sort = StructNew()>
	<cfset this.internalContent.asp = StructNew()>
	<cfset this.internalContent.comp = StructNew()>

	<cfquery name="aspvars" datasource="#application.dbSrc#">
		select asp.subset_id, a.answerfield, asp.partner_id, asp.default_value, asp.background_flag
		from answerfield_subset_partner asp, answerfield a
		where asp.answerfield_id=a.answerfield_id
		order by asp.subset_id, a.answerfield, asp.partner_id desc, asp.background_flag desc
	</cfquery>
	<cfset aspCount = 0>
	<cfloop query="aspvars">
		<cfif partner_id neq ''>
			<cfset sphash = "s#subset_id#p#partner_id#">
		<cfelse>
			<cfset sphash = "s#subset_id#">
		</cfif>
		<cfset asphash = "#sphash#_#answerfield#">
		<cfif not StructKeyExists(this.internalContent.asp, asphash)>
			<cfset aspCount = aspCount + 1>
			<cfset this.internalContent.asp[asphash] = StructNew()>
			<cfset this.internalContent.asp[asphash].val = default_value>
			<cfset this.internalContent.asp[asphash].bg = background_flag>
			<cfset StructInsert(this.internalContent.sort, aspCount, asphash)>
			<cfif background_flag>
				<cfif StructKeyExists(this.internalContent.comp, sphash)>
					<cfset this.internalContent.comp[sphash] = ListAppend(this.internalContent.comp[sphash], answerfield)>
				<cfelse>
					<cfset this.internalContent.comp[sphash] = answerfield>
				</cfif>
			</cfif>
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
			<td><strong>hash</strong></td>
			<td><strong>val</strong></td>
			<td><strong>bg</strong></td>
		</tr>
		<cfloop list="#ListSort(this.internalContent.sort,order)#" index="asphash">
			<tr>
				<td valign="top">#asphash#</td>
				<td valign="top">#this.internalContent.asp[asphash].val#</td>
				<td valign="top">#this.internalContent.asp[asphash].bg#</td>
			</tr>
		</cfloop>
		</table>
	</cfoutput>
</cffunction>

<cffunction name="actionIsDifferent" output="no">
	<cfargument name="partner_id" type="numeric" default="0">
	<cfargument name="subset_id" type="numeric" default="0">
	<cfset outval = false>
	<cfif partner_id gt 0>
		<cfset subsetHash = "s#subset_id#">
		<cfset subsetPartnerHash = "s#subset_id#p#partner_id#">
		<cfif StructKeyExists(this.internalContent.comp, subsetHash) and StructKeyExists(this.internalContent.comp, subsetPartnerHash)>
			<cfset sList = this.internalContent.comp[subsetHash]>
			<cfset spList = this.internalContent.comp[subsetPartnerHash]>
			<cfloop list="#spList#" index="x">
				<cfif not ListFind(sList, x)>
					<cfset outval = true>
				</cfif>
			</cfloop>
		</cfif>
	</cfif>
	<cfreturn outval>
</cffunction>

</cfcomponent>