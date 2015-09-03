<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>

<!--- Set guts --->

<cf_cacheWrapperQuery query="wrapper" partner_id="#session.partner_id#">

<cfif trim(wrapper.wrapper_afc) IS NOT "">
	<cfset guts = wrapper.wrapper_afc>
<cfelse>
	<cfset guts = "economic_stimulus_cf.cfm">
</cfif>

<cfif session.org_id GT 0>
	<cf_tagHeader>
	<cfinclude template="economic_stimulus_cf.cfm">
	<cf_tagFooter>
<cfelse>
	<cf_tagHeader guts="#guts#" show_left_col="y" rightcol="rightcol_partners.cfm" header="header_normal.cfm">
		<cfinclude template="#guts#">
	<cf_tagFooter footer="footer_normal.cfm">
</cfif>