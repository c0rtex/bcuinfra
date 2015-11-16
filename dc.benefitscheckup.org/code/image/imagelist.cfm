<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Image Administration" section="image">

<cf_buildList table="image" code="image" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="width" visible="false">
	<cf_buildListProperty column="height" visible="false">
	<cf_buildListProperty column="alt_display_id" display="display">
	<cf_buildListProperty column="description" visible="false">
</cf_buildList>

</cf_buildPage>