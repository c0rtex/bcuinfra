<cf_checkAccess level="5">
<cf_buildPage title="City Search" section="zip">

<cf_buildSearch title="City Search" table="city" code="city">
	<cf_buildSearchProperty column="city_id" maxlength="6">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
    <!--- Original Property
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id != 4">
	--->
	<cf_buildSearchProperty column="pref_city_id" input="select" references="city" condition="city_id in (select pref_city_id from city)">
	<cf_buildSearchProperty column="exclude_flag" input="flag">
	<cf_buildSearchProperty column="valid" input="flag" default="1">
</cf_buildSearch>

</cf_buildPage>