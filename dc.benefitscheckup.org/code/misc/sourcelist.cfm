<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Source List" section="misc">

<cf_buildList table="source" code="source" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Source List">

</cf_buildPage>