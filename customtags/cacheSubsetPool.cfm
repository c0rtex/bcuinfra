<cfparam name="attributes.name" type="string" default="bcuSubsetPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.subset_id" type="any" default="">
<cfparam name="attributes.partner_id" type="any" default="">
<cfparam name="attributes.var" type="string" default="bcuSubset">

<cfif attributes.subset_id eq ''>
	<cfset doAll = true>
<cfelse>
	<cfset doAll = false>
	<cfset shash = 'subset' & attributes.subset_id>
</cfif>
<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or (doAll and attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.id" = StructNew()>
	<cfset "application.#attributes.name#.sort" = StructNew()>
	<cfset "application.#attributes.name#.s" = StructNew()>
	<cfquery name="svars" datasource="#application.dbSrc#">
		SELECT subset_id, code
		FROM subset
		ORDER BY code
	</cfquery>
	<cfset sCount = 0>
	<cfloop query="svars">
		<cfset sCount = sCount + 1>
		<cfset StructInsert(Evaluate("application.#attributes.name#.id"), subset_id, code)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), sCount, code)>
	</cfloop>
</cfif>
<cfif not doAll and (not IsDefined("application.#attributes.name#.s.#shash#") or attributes.action eq 'refresh')>
	<cfset "application.#attributes.name#.s.#shash#" = StructNew()>
	<cfset "application.#attributes.name#.s.#shash#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.s.#shash#.sort" = StructNew()><!--- unused yet, but reserved for something good --->
	<cfset "application.#attributes.name#.s.#shash#.pshadow" = StructNew()>
	<cfset "application.#attributes.name#.s.#shash#.req" = StructNew()>

	<cfquery name="svars" datasource="#application.dbSrc#">
		select s.subset_id, st.subsettype_name as stype, s.code, s.alt_display_id,
			s.spq_display_id, s.intro_display_id, r.code as rpage, s.shadow_subset_id,
			s.branding_partner_id, s.active_flag, s.test_flag, s.eform_flag
		from subset s inner join subsettype st
				on s.subsettype_id=st.subsettype_id
			left outer join resultpage r
				on s.resultpage_id=r.resultpage_id
		where s.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
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
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'id', subset_id)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'type', stype)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'alt', alt)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'spq', spq)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'intro', intro)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'rpage', rpage)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'shadow', shadow_subset_id)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'brand', branding_partner_id)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'active', active_flag)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'test', test_flag)>
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#"), 'eform', eform_flag)>
	</cfloop>
	<cfquery name="psvars" datasource="#application.dbSrc#">
		select partner_id, shadow_subset_id
		from subset_partner_shadow
		where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
		order by partner_id
	</cfquery>
	<cfloop query="psvars">
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#.pshadow"), "p#partner_id#", shadow_subset_id)>
	</cfloop>
	<cfquery name="rqvars" datasource="#application.dbSrc#">
		select rq.code, srq.sort
		from subset_requisite srq, requisite rq
		where srq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
			and srq.requisite_id=rq.requisite_id
		order by srq.sort
	</cfquery>
	<cfloop query="rqvars">
		<cfset StructInsert(Evaluate("application.#attributes.name#.s.#shash#.req"), sort, code)>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="13" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
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

			<cfloop list="#ListSort(StructKeyList(Evaluate("application.#attributes.name#.id")), 'numeric')#" index="s">
				<cfset x = "subset#s#">
				<cfif doAll or x eq shash>
					<cfset sid = Right(x, Len(x) - 6)>
					<tr>
						<td align="right" valign="top">#s#</td>
						<td valign="top">#StructFind(Evaluate("application.#attributes.name#.id"), sid)#</td>
						<cfif IsDefined("application.#attributes.name#.s.#x#")>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.type")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.alt")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.spq")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.intro")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.rpage")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.shadow")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.brand")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.active")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.test")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.eform")#</td>
						<td valign="top">#Evaluate("application.#attributes.name#.s.#x#.lastRefresh")#</td>
						</cfif>
					</tr>
				</cfif>
			</cfloop>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="get">
		<cfif doAll>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#"))>
		<cfelse>
			<cfset "caller.#attributes.var#" = StructCopy(Evaluate("application.#attributes.name#.s.#shash#"))>
		</cfif>
	</cfcase>
	<cfcase value="getShadow">
		<cfif doAll>
			<cfset "caller.#attributes.var#" = ''>
		<cfelse>
			<cfif StructKeyExists(Evaluate("application.#attributes.name#.s.#shash#.pshadow"), "p#attributes.partner_id#")>
				<cfset "caller.#attributes.var#" = StructFind(Evaluate("application.#attributes.name#.s.#shash#.pshadow"), "p#attributes.partner_id#")>
			<cfelse>
				<cfset "caller.#attributes.var#" = Evaluate("application.#attributes.name#.s.#shash#.shadow")>
			</cfif>
		</cfif>
	</cfcase>
</cfswitch>