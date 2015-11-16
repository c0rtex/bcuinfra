<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Screening Page Administration" section="subset">

<cf_buildList table="page" code="page" order="sort" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="subset_id" visible="false">
	<cf_buildListProperty column="title_display_id" display="display">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="page_desc" visible="false">
</cf_buildList>

</cf_buildPage>