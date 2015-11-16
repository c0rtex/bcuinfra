<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Funder List" section="misc">

<cf_buildList table="funder" code="funder" order="name" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Funder List">

</cf_buildPage>