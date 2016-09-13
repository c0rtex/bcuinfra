<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="3">
<cf_buildPage title="User Type Administration" section="user">

<cf_buildList table="usertype" code="usertype" viewlevel="3" editlevel="1" by="#by#" dir="#dir#" page="#page#" rows="#rows#">

</cf_buildPage>