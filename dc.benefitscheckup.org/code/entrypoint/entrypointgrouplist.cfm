<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Entry Point Groups" section="entrypoint">

<cf_buildList title="Entry Point Groups" table="entrypointgroup" code="entrypointgroup" by="#by#" dir="#dir#" page="#page#" rows="#rows#" editlevel="4">
	<cf_buildListProperty column="active_flag" display="yesno">
	<cf_buildListProperty column="notes" visible="false">
</cf_buildlist>

</cf_buildpage>