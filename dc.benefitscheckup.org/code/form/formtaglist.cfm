<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Form Tag List" section="form">

<cf_buildList title="Form Tag List" table="formtag" code="formtag" by="#by#" dir="#dir#" page="#page#" rows="#rows#" delete="true" deletelevel="3">
	<cf_buildListProperty column="formclass_id" references="formclass">
</cf_buildList>

</cf_buildPage>