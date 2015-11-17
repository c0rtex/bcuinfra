<cfparam name="by" type="string" default="st">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="51">

<cf_checkAccess level="5">
<cf_buildPage title="MSP Income Administration" section="lookup">

<cf_buildList title="MSP Income Administration" table="tbl_mx_income" code="msp" by="#by#" dir="#dir#" page="#page#" rows="#rows#" selflink="true" viewlink="mxincomeview.cfm?id=[[id]]" editlink="mxincomeview.cfm?id=[[id]]&action=edit">

</cf_buildpage>