<cfparam name="attributes.name" type="string" default="bcuAnswerfieldSubsetPartnerPool">
<cfparam name="attributes.action" type="string" default="refresh">
<cfparam name="attributes.subset_id" type="numeric" default="0">
<cfparam name="attributes.partner_id" type="numeric" default="0">
<cfparam name="attributes.var" type="string" default="bcuAnswerfieldSubsetPartner">

<!--- If var doesn't exist, or action is REFRESH, initialize structure --->
<cfif not IsDefined("application.#attributes.name#") Or attributes.action eq 'refresh'>
	<cfset "application.#attributes.name#" = StructNew()>
	<cfset "application.#attributes.name#.lastRefresh" = Now()>
	<cfset "application.#attributes.name#.sort" = StructNew()>
	<cfset "application.#attributes.name#.asp" = StructNew()>
	<cfset "application.#attributes.name#.comp" = StructNew()>

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
		<cfif not StructKeyExists(Evaluate("application.#attributes.name#.asp"), asphash)>
			<cfset aspCount = aspCount + 1>
			<cfset "application.#attributes.name#.asp.#asphash#" = StructNew()>
			<cfset "application.#attributes.name#.asp.#asphash#.val" = default_value>
			<cfset "application.#attributes.name#.asp.#asphash#.bg" = background_flag>
			<cfset StructInsert(Evaluate("application.#attributes.name#.sort"), aspCount, asphash)>
			<cfif background_flag>
				<cfif StructKeyExists(Evaluate("application.#attributes.name#.comp"), sphash)>
					<cfset "application.#attributes.name#.comp.#sphash#" = ListAppend(Evaluate("application.#attributes.name#.comp.#sphash#"), answerfield)>
				<cfelse>
					<cfset "application.#attributes.name#.comp.#sphash#" = answerfield>
				</cfif>
			</cfif>
		</cfif>
	</cfloop>
</cfif>

<cfswitch expression="#attributes.action#">
	<cfcase value="dump">
		<cfoutput>
			<table border="1" cellpadding="3" cellspacing="1">
			<tr>
				<td colspan="3" align="center"><strong>#attributes.name#</strong> last refresh #Evaluate("application.#attributes.name#.lastRefresh")#</td>
			</tr>
			<tr>
				<td><strong>hash</strong></td>
				<td><strong>val</strong></td>
				<td><strong>bg</strong></td>
			</tr>
			<cf_loopPoolStruct scope="application" struct="#attributes.name#" index="x">
				<tr>
					<td valign="top">#x#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.asp.#x#.val")#</td>
					<td valign="top">#Evaluate("application.#attributes.name#.asp.#x#.bg")#</td>
				</tr>
			</cf_loopPoolStruct>
			</table>
		</cfoutput>
	</cfcase>
	<cfcase value="isDifferent">
		<cfset outval = false>
		<cfif attributes.partner_id gt 0>
			<cfset subsetHash = "s#attributes.subset_id#">
			<cfset subsetPartnerHash = "s#attributes.subset_id#p#attributes.partner_id#">
			<cfif StructKeyExists(Evaluate("application.#attributes.name#.comp"), subsetHash) and StructKeyExists(Evaluate("application.#attributes.name#.comp"), subsetPartnerHash)>
				<cfset sList = Evaluate("application.#attributes.name#.comp.#subsetHash#")>
				<cfset spList = Evaluate("application.#attributes.name#.comp.#subsetPartnerHash#")>
				<cfloop list="#spList#" index="x">
					<cfif not ListFind(sList, x)>
						<cfset outval = true>
					</cfif>
				</cfloop>
			</cfif>
		</cfif>
		<cfset "caller.#attributes.var#" = outval>
	</cfcase>
</cfswitch>