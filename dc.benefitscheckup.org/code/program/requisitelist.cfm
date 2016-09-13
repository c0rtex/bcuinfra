<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Requisite Items List" section="program">

<cf_buildList table="requisite" code="requisite" order="code" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Requisite Items List">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="def_display_id" display="display">
	<cf_buildListProperty column="description" visible="false">
</cf_buildList>

</cf_buildPage>