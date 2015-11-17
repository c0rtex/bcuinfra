<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Subset Administration" section="subset">

<cf_buildList table="subset" code="subset" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="subsettype_id" references="subsettype">
	<cf_buildListProperty column="display_id" display="display">
	<cf_buildListProperty column="alt_display_id" display="display" visible="false">
	<cf_buildListProperty column="spq_display_id" display="display" visible="false">
	<cf_buildListProperty column="oe_name" visible="false">
	<cf_buildListProperty column="description" visible="false">
	<cf_buildListProperty column="intro_display_id" display="display" visible="false">
	<cf_buildListProperty column="resultpage_id" visible="false">
	<cf_buildListProperty column="shadow_subset_id" visible="false">
	<cf_buildListProperty column="branding_partner_id" visible="false">
	<cf_buildListProperty column="active_flag" display="yesno">
	<cf_buildListProperty column="test_flag" display="yesno">
	<cf_buildListProperty column="eform_flag" display="yesno">
	<cf_buildListProperty column="report_flag" display="yesno">
	<cf_buildListProperty column="create_user_id" visible="false">
	<cf_buildListProperty column="create_date" visible="false">
	<cf_buildListProperty column="modify_user_id" visible="false">
	<cf_buildListProperty column="modify_date" visible="false">
</cf_buildList>

</cf_buildPage>