<cfcomponent extends="cacheSingletonComponent" displayname="bcuAnswerfieldPoolComponent">

	<cffunction name="actionRefresh" output="no">
		<cfset this.internalContent = StructNew()>
		<cfset this.internalContent.lastRefresh = Now()>
		<cfset this.internalContent.a = StructNew()>
		<cfset this.internalContent.sort = StructNew()>

		<cfset this.internalContent.null = StructNew()>
		<cfset this.internalContent.null.exists = false>
		<cfset this.internalContent.null.id = ''>
		<cfset this.internalContent.null.type = ''>
		<cfset this.internalContent.null.rx = ''>
		<cfset this.internalContent.null.length = ''>
		<cfset this.internalContent.null.req = ''>
		<cfset this.internalContent.null.def = ''>
		<cfset this.internalContent.null.spqdef = ''>
		<cfset this.internalContent.null.oedef = ''>
		<cfset this.internalContent.null.state_id = ''>
		<cfset this.internalContent.null.rule = ''>
		<cfset this.internalContent.null.valid = ''>
		<cfset this.internalContent.null.sort = ''>

		<cfquery name="avars" datasource="#application.dbSrc#">
			select a.answerfield_id, a.answerfield, a.max_length, a.required_flag, a.default_value,
				a.spq_default_value, a.oe_default_value, a.state_id, at.code, r.code as rule_code,
				v.validation_code, o.option_id, o.option_code, ao.sort
			from answerfield a inner join answerfieldtype at
					on a.answerfieldtype_id=at.answerfieldtype_id
				left outer join rule r
					on a.rule_id=r.rule_id
				left outer join validation v
					on a.validation_id=v.validation_id
				left outer join answerfield_option ao
					on a.answerfield_id=ao.answerfield_id
				left outer join `option` o
					on ao.option_id=o.option_id
			order by a.answerfield, ao.sort
		</cfquery>
		<cfset asort = 0>
		<cfloop query="avars">
			<cfif Not IsDefined("this.internalContent.a.#answerfield#")>
				<cfset asort = asort + 1>
				<cfset this.internalContent.a[answerfield] = StructNew()>
				<cfset this.internalContent.a[answerfield].exists = true>
				<cfset this.internalContent.a[answerfield].id = answerfield_id>
				<cfset this.internalContent.a[answerfield].type = code>
				<cfif ListFind('drug,generic,rxco', code)>
					<cfset this.internalContent.a[answerfield].rx = true>
				<cfelse>
					<cfset this.internalContent.a[answerfield].rx = false>
				</cfif>
				<cfset this.internalContent.a[answerfield].length = max_length>
				<cfset this.internalContent.a[answerfield].req = required_flag>
				<cfset this.internalContent.a[answerfield].def = default_value>
				<cfset this.internalContent.a[answerfield].spqdef = spq_default_value>
				<cfset this.internalContent.a[answerfield].oedef = oe_default_value>
				<cfset this.internalContent.a[answerfield].state_id = state_id>
				<cfset this.internalContent.a[answerfield].rule = rule_code>
				<cfset this.internalContent.a[answerfield].valid = validation_code>
				<cfset this.internalContent.a[answerfield].sp = StructNew()>
				<cfset this.internalContent.a[answerfield].sort = StructNew()>
				<cfset StructInsert(this.internalContent.sort, asort, answerfield)>
			</cfif>
			<cfif option_code neq ''>
				<cfset StructInsert(this.internalContent.a[answerfield].sort, sort, option_code)>
			</cfif>
		</cfloop>
		<cfquery name="aspvars" datasource="#application.dbSrc#">
			select a.answerfield, asp.subset_id, asp.partner_id, asp.default_value
			from answerfield_subset_partner asp, answerfield a
			where asp.background_flag=0
				and asp.answerfield_id=a.answerfield_id
			order by asp.answerfield_id, asp.subset_id, asp.partner_id
		</cfquery>
		<cfloop query="aspvars">
			<cfset this.internalContent.a[answerfield].sp["s#subset_id#p#partner_id#"] = default_value>
		</cfloop>

	</cffunction>

	<cffunction name="actionDump" access="public" output="yes">

		<cfset var displayname = getMetaData(this).displayname>

		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="5" align="center"><strong>#displayname#</strong> last refresh #Evaluate("this.internalContent.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>answerfield</strong></td>
				<td><strong><em>option</em></strong></td>
				<td align="right"><strong>length</strong></td>
				<td><strong>type</strong></td>
			</tr>
			<cfloop list="#ListSort(StructKeyList(this.internalContent.a),'text')#" index="answerfield">
				<tr>
					<td align="right" valign="top">#this.internalContent.a[answerfield].id#</td>
					<td colspan="2" valign="top">#answerfield#</td>
					<td align="right" valign="top"><cfif this.internalContent.a[answerfield].length eq ''>&nbsp;<cfelse>#this.internalContent.a[answerfield].length#</cfif></td>
					<td valign="top">#this.internalContent.a[answerfield].type#</td>
				</tr>
				<cfset sortKeyList = ListSort(StructKeyList(this.internalContent.a[answerfield].sort), "numeric")>
				<cfloop list="#sortKeyList#" index="x">
					<cfset o = StructFind(this.internalContent.a[answerfield].sort, x)>
					<tr>
						<td></td>
						<td align="right" valign="top"><em>#x#</em></td>
						<td colspan="3" valign="top"><em>#o#</em></td>
					</tr>
				</cfloop>
			</cfloop>
			</table>
		</cfoutput>
	</cffunction>

	<cffunction name="actionGet" access="public" output="no">
		<cfargument name="code" type="string" required="true">
		<cfif code eq ''>
			<cfreturn StructCopy(this.internalContent)>
		<cfelseif code neq '' and StructKeyExists(this.internalContent.a, code)>
			<cfreturn StructCopy(this.internalContent.a[code])>
		<cfelse>
			<cfreturn StructCopy(this.internalContent.null)>
		</cfif>
	</cffunction>

</cfcomponent>