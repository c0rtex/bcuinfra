<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Phone Numbers" section="entrypoint">

<cf_buildList title="Phone Numbers" table="phone" code="phone" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="4">
	<cf_buildListProperty column="entrypoint_id" references="entrypoint">
	<cf_buildListProperty column="phonetype_id" references="phonetype">
</cf_buildList>

</cf_buildPage>