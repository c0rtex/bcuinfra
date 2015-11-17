<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Eligibility Rules List" section="rule">

<cf_buildList table="rule" code="rule" order="code" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Eligibility Rules List">
	<cf_buildListProperty column="rule_text" display="text">
	<cf_buildListProperty column="description" visible="false">
	<cf_buildListProperty column="rx_program_id" visible="false">
	<cf_buildListProperty column="legacy_pri_sec" visible="false">
</cf_buildList>

</cf_buildPage>