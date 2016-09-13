<cf_checkAccess level="5">
<cf_buildPage title="Zip Code Search" section="zip">

<cf_buildSearch title="Zip Code Search" table="zip" code="zip">
	<cf_buildSearchProperty column="zipcode" maxlength="5">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
    <!--- Original Property
    <cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id != 4">
    --->
	<cf_buildSearchProperty column="county_id" visible="false">
	<cf_buildSearchProperty column="valid" input="flag" default="1">
</cf_buildSearch>

</cf_buildPage>