<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Recommendations Administration" section="program">

<cf_buildList table="programtext" code="programtext" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="program_id" visible="false">
	<cf_buildListProperty column="rec" display="text">
	<cf_buildListProperty column="summary" visible="false">
	<cf_buildListProperty column="actions" visible="false">
	<cf_buildListProperty column="sortorder" visible="false">
	<cf_buildListProperty column="Active" display="yesno">
	<cf_buildListProperty column="alt_rec" visible="false">
	<cf_buildListProperty column="alt_summary" visible="false">
</cf_buildList>

</cf_buildPage>