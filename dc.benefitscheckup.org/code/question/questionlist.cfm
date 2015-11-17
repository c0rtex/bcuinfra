<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Question Administration" section="question">

<cf_buildList table="question" code="question" order="sort" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="dep_question_id" visible="false">
	<cf_buildListProperty column="questiontype_id" references="questiontype">
	<cf_buildListProperty column="questionheader_id" references="questionheader">
	<cf_buildListProperty column="questioncategory_id" references="questioncategory">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="short_display_id" display="display" visible="searchonly">
	<cf_buildListProperty column="spq_display_id" display="display" visible="searchonly">
	<cf_buildListProperty column="print_display_id" display="display" visible="searchonly">
	<cf_buildListProperty column="format_id" references="format">
	<cf_buildListProperty column="rule_id" visible="false">
	<cf_buildListProperty column="include_flag" visible="false">
	<cf_buildListProperty column="exclude_flag" visible="false">
	<cf_buildListProperty column="suppress_qno_flag" visible="false">
	<cf_buildListProperty column="spq_exclude_flag" visible="false">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>