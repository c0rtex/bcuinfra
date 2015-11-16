<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Phone Types" section="entrypoint">

<cf_buildList title="Phone Types" table="phonetype" code="phonetype" order="code" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="4">
	<cf_buildListProperty column="display_id" display="display">
</cf_buildList>

</cf_buildPage>