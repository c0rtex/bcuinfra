<!--- Initialize and load any session variable value passed into this page --->
<!---<cf_sessionLoadVars>--->
<!--- Set guts --->

<cfoutput>
WDFWE
</cfoutput> 
<!---<cf_sessionLoadVars>--->
<cfset guts = "extrahelp_cf.cfm">
<cfparam name="session.partner_id" default="0">
<cfparam name="session.org_id" default="0">
<cf_cacheWrapperQuery query="wrapper" partner_id="#session.partner_id#">

<cfif trim(wrapper.wrapper_afc) IS NOT "">
	<cfset guts = "extrahelp_pl.cfm">
<cfelse>
	<cfset guts = "extrahelp_cf.cfm">
</cfif>

<cfif session.org_id GT 0>
	<cf_tagHeader>
	<cfinclude template="extrahelp2_cf.cfm">
	<cf_tagFooter>
<cfelse>
    <cf_tagHeader header="header_normal.cfm" showmenu="1">
	<cfinclude template="#guts#">
	<cf_tagFooter footer="footer_normal.cfm" showmenu="1">
</cfif>
