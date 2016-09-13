<!--- Set guts --->
<cfset guts = "index_cf.cfm">
<!--- Initialize and load any session variable value passed into this page --->
<cf_sessionLoadVars>

<cfset showmenu = 0>

<cf_tagHeader guts="#guts#" show_left_col="n" showmenu="#showmenu#">
<cfinclude template="#guts#">
<cf_tagFooter>
