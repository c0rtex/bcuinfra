<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>

<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">

<cfset tag = partnerQuery.wrapper_tag1>

<!--- Set guts --->
<cfset guts = "moreprograms_cf.cfm">

<cfif session.org_id GT 0>
	<cf_tagHeader>
	<cfinclude template="moreprograms2_cf.cfm">
	<cf_tagFooter tag="#tag#">
<cfelseif trim(partnerQuery.wrapper_moreprograms_template) IS NOT "">
	<cfset guts = partnerQuery.wrapper_moreprograms_template>
	<cf_tagHeader guts="#guts#">
	<cfinclude template="#guts#">
	<cf_tagFooter tag="#tag#">
<cfelse>
	<cf_tagHeader guts="#guts#" show_left_col="y" rightcol="rightcol_partners.cfm" header="header_normal.cfm">
	<cfinclude template="#guts#">
	<cf_tagFooter footer="footer_normal.cfm" tag="#tag#">
</cfif>