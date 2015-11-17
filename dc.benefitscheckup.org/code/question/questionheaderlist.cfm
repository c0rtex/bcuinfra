<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Question Header Administration" section="question">

<cf_buildList table="questionheader" code="questionheader" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="display_id" display="display">
</cf_buildList>

</cf_buildPage>