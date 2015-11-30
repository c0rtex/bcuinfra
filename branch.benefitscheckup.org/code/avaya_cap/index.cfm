<cfsilent><cfset show_left_col = "y">
<cfparam name="link" default="">
<cf_sessionPassVars>
<cfif link IS NOT "">
	<cfset guts = "moreprograms_cf.cfm">

<cfelse>

	<cfset title = "Welcome to BenefitsCheckUp - NCOA's Online Screening Service.">
	<cfset meta = '<meta name="description" content="BenefitsCheckUp is a Web-based service to screen for benefits programs available to seniors with limited income and resources.">
<meta name="keywords" content="benefit programs, prescription drug assistance, energy assistance, food stamps, tax relief, Medicare Part D, housing assistance, in-home services, nutrition, transportation, educational assistance, employment and volunteer Services.">'>
	<cfset guts = "index_cf.cfm">

<cfparam name="session.test_id" default="">
<cfparam name="session.org_id" default="">
<cf_sessionLoadVars>
<cf_tagHeader>

</cfif>


<cfset rightcol = "/#approot#/rightcol_partners.cfm">
</cfsilent>
<cfinclude template="/#approot#/guts.cfm">
