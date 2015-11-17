<cfparam name="by" type="string" default="st">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="51">

<cf_checkAccess level="5">
<cf_buildPage title="MSP Assets Administration" section="lookup">

<cf_buildList title="MSP Assets Administration" table="tbl_mx_asset" code="msp" by="#by#" dir="#dir#" page="#page#" rows="#rows#" selflink="true" viewlink="mxassetview.cfm?id=[[id]]" editlink="mxassetview.cfm?id=[[id]]&action=edit">

</cf_buildpage>