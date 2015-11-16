<cf_checkAccess level="5">
<cf_buildPage title="Entry Point Search" section="entrypoint">

<cf_buildSearch table="entrypoint" code="entrypoint" title="Entry Point Search">
	<cf_buildSearchProperty column="code" visible="false">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id in (1, 2)">
	<cf_buildSearchProperty column="zipcode" maxlength="5">
	<cf_buildSearchProperty column="zipcode_plus4" maxlength="4">
	<cf_buildSearchProperty column="hours_display_id" input="display">
	<cf_buildSearchProperty column="info_display_id" input="display">
	<cf_buildSearchProperty column="last_update" input="date">
	<cf_buildSearchProperty column="active_flag" input="flag">
	<cf_buildSearchProperty column="notes" input="text">
	<cf_buildSearchProperty column="create_user_id" visible="false">
	<cf_buildSearchProperty column="create_date" visible="false">
	<cf_buildSearchProperty column="modify_user_id" visible="false">
	<cf_buildSearchProperty column="modify_date" visible="false">
</cf_buildSearch>

</cf_buildPage>