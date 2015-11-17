<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Grid Row Administration" section="question">

<cf_buildList table="gridrow" code="gridrow" order="sort" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="help_id" references="help">
	<cf_buildListProperty column="description" visible="false">
	<cf_buildListProperty column="exclude_flag" display="yesno">
</cf_buildList>

</cf_buildPage>