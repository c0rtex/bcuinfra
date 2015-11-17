<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Program Category List" section="program">

<cf_buildList table="programcategory" code="programcategory" order="sort" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Program Category List">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="description" visible="false">
</cf_buildList>

</cf_buildPage>