<!--- Set guts --->
<cfset guts = "/podcasts/index_cf.cfm">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>

<cf_tagHeader guts="#guts#" show_left_col="y" rightcol="rightcol_partners.cfm" header="header_normal.cfm" showmenu="1">
<cfinclude template="#guts#">
<cf_tagFooter footer="footer_normal.cfm" showmenu="1">

