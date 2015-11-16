<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Form Instance List" section="form">

<cf_buildList title="Form Instance List" table="form_formtype" code="forminstance" hviewlink="typeview.cfm?form_id=[[form_id]]&type_id=[[formtype_id]]" editlink="typeedit.cfm?form_id=[[form_id]]&type_id=[[formtype_id]]" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="form_id" references="form">
	<cf_buildListProperty column="formtype_id" references="formtype">
	<cf_buildListProperty column="active" display="yesno">
	<cf_buildListProperty column="form_date" display="date">
	<cf_buildListProperty column="form_day_ignore_flag" visible="false">
	<cf_buildListProperty column="entry_date" display="date">
	<cf_buildListProperty column="entry_day_ignore_flag" visible="false">
</cf_buildList>

</cf_buildPage>