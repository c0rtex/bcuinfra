<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Proximity Methods" section="zip">

<cf_buildList title="Proximity Methods" table="proximity" code="proximity" editlevel="1" by="#by#" dir="#dir#" page="#page#" rows="#rows#">

</cf_buildPage>