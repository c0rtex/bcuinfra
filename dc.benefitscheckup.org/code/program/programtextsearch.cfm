<cf_checkAccess level="5">
<cf_buildPage title="Recommendations Search" section="program">

<cf_buildSearch table="programtext" code="programtext" title="Recommendations Search">
	<cf_buildSearchProperty column="rec" input="text">
	<cf_buildSearchProperty column="summary" input="text">
	<cf_buildSearchProperty column="program_id" input="select" references="program">
	<cf_buildSearchProperty column="actions" input="text">
	<cf_buildSearchProperty column="Active" input="flag">
	<cf_buildSearchProperty column="alt_rec" input="text">
	<cf_buildSearchProperty column="alt_summary" input="text">
</cf_buildSearch>

</cf_buildPage>