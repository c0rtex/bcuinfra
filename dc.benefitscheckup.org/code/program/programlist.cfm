<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Program List" section="program">

<cf_buildList table="program" code="program" order="sort" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Program List">
	<cf_buildListProperty column="programcategory_id" references="programcategory">
	<cf_buildListProperty column="programgroup_id" visible="false">
	<cf_buildListProperty column="name_display_id" display="display">
	<cf_buildListProperty column="desc_display_id" display="display" visible="searchonly">
	<cf_buildListProperty column="url" visible="false">
	<cf_buildListProperty column="exclude_flag" visible="false">
	<cf_buildListProperty column="significant_flag" visible="false">
	<cf_buildListProperty column="active_flag" visible="false">
	<cf_buildListProperty column="funder_id" visible="false">
	<cf_buildListProperty column="reference_id" visible="false">
	<cf_buildListProperty column="last_update" visible="false">
	<cf_buildListProperty column="notes" visible="false">
	<cf_buildListProperty column="legacy_prg_id" visible="false">
	<cf_buildListProperty column="legacy_pri_sec" visible="false">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>