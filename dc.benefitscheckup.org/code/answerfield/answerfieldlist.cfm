<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Answerfield Administration" section="answerfield">

<cf_buildList table="answerfield" code="answerfield" condition="a.answerfieldtype_id not in (13, 14, 15)" editlevel="3" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="answerfieldtype_id" references="answerfieldtype">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="short_display_id" display="display">
	<cf_buildListProperty column="spq_display_id" display="display" visible="searchonly">
	<cf_buildListProperty column="print_display_id" display="display" visible="searchonly">
	<cf_buildListProperty column="max_length" visible="false">
	<cf_buildListProperty column="default_value" visible="false">
	<cf_buildListProperty column="spq_default_value" visible="false">
	<cf_buildListProperty column="oe_default_value" visible="false">
	<cf_buildListProperty column="required_flag" visible="false">
	<cf_buildListProperty column="rx_required_flag" visible="false">
	<cf_buildListProperty column="rule_id" visible="false">
	<cf_buildListProperty column="validation_id" visible="false">
	<cf_buildListProperty column="answerfield_desc" visible="false">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>