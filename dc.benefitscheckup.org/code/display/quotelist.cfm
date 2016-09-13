<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Home Page Quote Administration" section="display">

<cf_buildList title="Home Page Quotes" table="quote" code="quote" order="quote_code" editlevel="2" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="active" display="yesno">
</cf_buildList>

</cf_buildPage>