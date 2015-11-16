<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Partner Type Administration" section="partner">

<cf_buildList table="partnertype" code="partnertype" by="#by#" dir="#dir#" page="#page#" rows="#rows#">

</cf_buildPage>