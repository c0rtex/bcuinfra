<cf_checkAccess level="5">
<cf_buildPage title="County Search" section="zip">

<cf_buildSearch title="County Search" table="county" code="county">
	<cf_buildSearchProperty column="county_id" maxlength="5">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
    <!--- Original Property
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id != 4">
	--->
	<cf_buildSearchProperty column="valid" input="flag" default="1">
</cf_buildSearch>

</cf_buildPage>