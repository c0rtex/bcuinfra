<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Hardcoded Rules List" section="rule">

<cf_buildList table="hardrule" code="hardrule" order="code" editlevel="1" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Hardcoded Rules List">

</cf_buildPage>