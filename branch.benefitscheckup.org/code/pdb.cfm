<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>

<cf_cachePartnerQuery query="partnerQuery" partner_id="#session.partner_id#">

<cfset tag = partnerQuery.wrapper_tag1>

<!--- Set guts --->
<cfset guts = "pdb_cf.cfm">

<cf_tagHeader guts="#guts#" show_left_col="y" rightcol="rightcol_partners.cfm" header="header_normal.cfm">
<cfinclude template="#guts#">
<cf_tagFooter footer="footer_normal.cfm" tag="#tag#">