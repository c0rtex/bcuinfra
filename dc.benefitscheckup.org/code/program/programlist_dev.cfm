<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Program List" section="program">

<cf_buildList_dev table="program" code="program" order="sort" by="#by#" dir="#dir#" page="#page#" rows="#rows#" title="Program List">
	<cf_buildListProperty_dev column="programcategory_id" references="programcategory">
	<cf_buildListProperty_dev column="programgroup_id" visible="false">
	<cf_buildListProperty_dev column="name_display_id" display="display">
	<cf_buildListProperty_dev column="desc_display_id" display="display" visible="searchonly">
	<cf_buildListProperty_dev column="url" visible="false">
	<cf_buildListProperty_dev column="exclude_flag" visible="false">
	<cf_buildListProperty_dev column="significant_flag" visible="false">
	<cf_buildListProperty_dev column="active_flag" visible="false">
	<cf_buildListProperty_dev column="funder_id" visible="false">
	<cf_buildListProperty_dev column="reference_id" visible="false">
	<cf_buildListProperty_dev column="last_update" visible="false">
	<cf_buildListProperty_dev column="notes" visible="false">
	<cf_buildListProperty_dev column="legacy_prg_id" visible="false">
	<cf_buildListProperty_dev column="legacy_pri_sec" visible="false">
	<cf_buildListProperty_dev column="create_user_id" visible="false">
	<cf_buildListProperty_dev column="create_date" visible="false">
	<cf_buildListProperty_dev column="modify_user_id" visible="false">
	<cf_buildListProperty_dev column="modify_date" visible="false">
</cf_buildList_dev>

</cf_buildPage>