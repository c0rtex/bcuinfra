<cf_checkAccess level="5">
<cf_buildPage title="Subset Search" section="subset">

<cf_buildSearch title="Subset Search" table="subset" code="subset">
	<cf_buildSearchProperty column="subsettype_id" input="select" references="subsettype">
	<cf_buildSearchProperty column="display_id" input="display">
	<cf_buildSearchProperty column="alt_display_id" input="display">
	<cf_buildSearchProperty column="spq_display_id" input="display">
	<cf_buildSearchProperty column="intro_display_id" input="display">
	<cf_buildSearchProperty column="resultpage_id" input="select" references="resultpage">
	<cf_buildSearchProperty column="shadow_subset_id" input="select" references="subset">
	<cf_buildSearchProperty column="branding_partner_id" input="select" references="tbl_partner">
	<cf_buildSearchProperty column="active_flag" input="flag">
	<cf_buildSearchProperty column="test_flag" input="flag">
	<cf_buildSearchProperty column="eform_flag" input="flag">
	<cf_buildSearchProperty column="report_flag" input="flag">
	<cf_buildSearchProperty column="create_user_id" visible="false">
	<cf_buildSearchProperty column="create_date" visible="false">
	<cf_buildSearchProperty column="modify_user_id" visible="false">
	<cf_buildSearchProperty column="modify_date" visible="false">
</cf_buildSearch>

</cf_buildPage>