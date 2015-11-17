<cf_checkAccess level="5">
<cf_buildPage title="Program Search" section="program">

<cf_buildSearch title="Program Search" table="program" code="program">
	<cf_buildSearchProperty column="programcategory_id" input="select" references="programcategory">
	<cf_buildSearchProperty column="programgroup_id" input="select" references="programgroup">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
	<cf_buildSearchProperty column="name_display_id" input="display">
	<cf_buildSearchProperty column="desc_display_id" input="display">
	<cf_buildSearchProperty column="exclude_flag" input="flag">
	<cf_buildSearchProperty column="significant_flag" input="flag">
	<cf_buildSearchProperty column="active_flag" input="flag">
	<cf_buildSearchProperty column="funder_id" input="select" references="funder">
	<cf_buildSearchProperty column="reference_id" input="select" references="reference">
	<cf_buildSearchProperty column="last_update" input="date">
	<cf_buildSearchProperty column="notes" input="text">
	<cf_buildSearchProperty column="create_user_id" visible="false">
	<cf_buildSearchProperty column="create_date" visible="false">
	<cf_buildSearchProperty column="modify_user_id" visible="false">
	<cf_buildSearchProperty column="modify_date" visible="false">
</cf_buildSearch>

</cf_buildPage>