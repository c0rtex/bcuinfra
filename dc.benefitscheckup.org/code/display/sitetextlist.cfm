<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Site Text Administration" section="display">

<cf_buildList table="sitetext" code="sitetext" editlevel="3" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>