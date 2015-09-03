<cfsilent>
<cfparam name="attributes.name" type="string" default="bcuAnswerfieldPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.code" type="string" default="">
<cfparam name="attributes.var" type="string" default="bcuAnswerfield">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif Not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.a" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>

	<!--- save a null template obj with blank elements to return when rule code not found --->
	<cfset "application.#attributes.name#.null" = StructNew()>
	<cfset "application.#attributes.name#.null.exists" = false>
	<cfset "application.#attributes.name#.null.id" = ''>
	<cfset "application.#attributes.name#.null.type" = ''>
	<cfset "application.#attributes.name#.null.rx" = ''>
	<cfset "application.#attributes.name#.null.length" = ''>
	<cfset "application.#attributes.name#.null.req" = ''>
	<cfset "application.#attributes.name#.null.def" = ''>
	<cfset "application.#attributes.name#.null.spqdef" = ''>
	<cfset "application.#attributes.name#.null.oedef" = ''>
	<cfset "application.#attributes.name#.null.state_id" = ''>
	<cfset "application.#attributes.name#.null.rule" = ''>
	<cfset "application.#attributes.name#.null.valid" = ''>
	<cfset "application.#attributes.name#.null.sort" = ''>

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
		<cfif Not IsDefined("application.#attributes.name#.a.#answerfield#")>
			<cfset asort = asort + 1>
			<cfset "application.#attributes.name#.a.#answerfield#" = StructNew()>
			<cfset "application.#attributes.name#.a.#answerfield#.exists" = true>
			<cfset "application.#attributes.name#.a.#answerfield#.id" = answerfield_id>
			<cfset "application.#attributes.name#.a.#answerfield#.type" = code>
			<cfif ListFind('drug,generic,rxco', code)>
				<cfset "application.#attributes.name#.a.#answerfield#.rx" = true>
			<cfelse>
				<cfset "application.#attributes.name#.a.#answerfield#.rx" = false>
			</cfif>
			<cfset "application.#attributes.name#.a.#answerfield#.length" = max_length>
			<cfset "application.#attributes.name#.a.#answerfield#.req" = required_flag>
			<cfset "application.#attributes.name#.a.#answerfield#.def" = default_value>
			<cfset "application.#attributes.name#.a.#answerfield#.spqdef" = spq_default_value>
			<cfset "application.#attributes.name#.a.#answerfield#.oedef" = oe_default_value>
			<cfset "application.#attributes.name#.a.#answerfield#.state_id" = state_id>
			<cfset "application.#attributes.name#.a.#answerfield#.rule" = rule_code>
			<cfset "application.#attributes.name#.a.#answerfield#.valid" = validation_code>
			<cfset "application.#attributes.name#.a.#answerfield#.sp" = StructNew()>
			<cfset "application.#attributes.name#.a.#answerfield#.sort" = StructNew()>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), asort, answerfield)>
		</cfif>
		<cfif option_code neq ''>
			<cfset StructInsert(Evaluate("application.#attributes.name#.a.#answerfield#.sort"), sort, option_code)>
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
		<cfset "application.#attributes.name#.a.#answerfield#.sp.s#subset_id#p#partner_id#" = default_value>
	</cfloop>

</cfif>

</cfsilent><cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="5" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td align="right"><strong>id</strong></td>
				<td><strong>answerfield</strong></td>
				<td><strong><em>option</em></strong></td>
				<td align="right"><strong>length</strong></td>
				<td><strong>type</strong></td>
			</tr>
			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.a")), 'text')#" index="a">
				<tr>
					<td align="right" valign="top">#Evaluate("application.#attributes.name#.a.#a#.id")#</td>
					<td colspan="2" valign="top">#a#</td>
					<td align="right" valign="top"><cfif Evaluate("application.#attributes.name#.a.#a#.length") eq ''>&nbsp;<cfelse>#Evaluate("application.#attributes.name#.a.#a#.length")#</cfif></td>
					<td valign="top">#Evaluate("application.#attributes.name#.a.#a#.type")#</td>
				</tr>
				<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.a.#a#.sort")), 'numeric')#" index="x">
					<cfset o = StructFind(Evaluate("application.#attributes.name#.a.#a#.sort"), x)>
					<tr>
						<td></td>
						<td align="right" valign="top"><em>#x#</em></td>
						<td colspan="3" valign="top"><em>#o#</em></td>
					</tr>
				</cfloop>
			</cfloop>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get"><cfsilent>
		<cfif attributes.code eq ''>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#"))>
		<cfelseif attributes.code neq '' and StructKeyExists(Evaluate("application.#attributes.name#.a"), attributes.code)>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.a.#attributes.code#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.null"))>
		</cfif>
	</cfsilent></cfcase>
</cfswitch>