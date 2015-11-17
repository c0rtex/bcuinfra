<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">

<cf_buildPage title="Help Type Administration" section="help"><cfoutput>

<cf_buildList table="helptype" code="helptype" editlevel="1" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
</cf_buildList>

</cfoutput></cf_buildPage>