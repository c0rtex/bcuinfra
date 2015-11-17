<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="100">

<cf_checkAccess level="5">
<cf_buildPage title="Program Value Administration" section="tote">

<cf_buildList table="programvalue" code="programvalue" order="dollarvalue" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="program_id" references="program">
	<cf_buildListProperty column="dollarvalue" display="dollar">
	<cf_buildListProperty column="start_date" display="date">
	<cf_buildListProperty column="end_date" display="date">
	<cf_buildListProperty column="rule_text" visible="false">
</cf_buildList>

</cf_buildPage>