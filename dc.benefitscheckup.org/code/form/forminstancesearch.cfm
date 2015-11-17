<cf_checkAccess level="5">
<cf_buildPage title="Form Instance Search" section="form">

<cf_buildSearch title="Form Instance Search" table="form_formtype" code="forminstance">
	<cf_buildSearchProperty column="form_id" input="select" references="form">
	<cf_buildSearchProperty column="formtype_id" input="select" references="formtype">
	<cf_buildSearchProperty column="active" input="flag">
	<cf_buildSearchProperty column="form_date" input="date">
	<cf_buildSearchProperty column="form_day_ignore_flag" visible="false">
	<cf_buildSearchProperty column="entry_date" input="date">
	<cf_buildSearchProperty column="entry_day_ignore_flag" visible="false">
</cf_buildSearch>

</cf_buildPage>