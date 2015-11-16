<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Answerfield Type Administration" section="answerfield">

<cf_buildList table="answerfieldtype" code="answerfieldtype" editlevel="1" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
<!---
	<cf_buildListProperty column="answerfieldtype_id" references="answerfieldtype">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="questioncategory_id" references="questioncategory">
	<cf_buildListProperty column="format_id" references="format">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>
--->

</cf_buildPage>