<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Snap Table" section="snap">

<cf_buildList table="tbl_snap" code="snap" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="snap_state" visible="true">
	<cf_buildListProperty column="snap_url" visible="false">
	<cf_buildListProperty column="snap_online_app" visible="true">
	<cf_buildListProperty column="snap_program_names" visible="false">
</cf_buildlist>

</cf_buildpage>