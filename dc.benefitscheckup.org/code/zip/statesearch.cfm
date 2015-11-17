<cf_checkAccess level="5">
<cf_buildPage title="State Search" section="zip">

<cf_buildSearch title="State Search" table="state" code="state">
	<cf_buildSearchProperty column="state_id" maxlength="2">
	<cf_buildSearchProperty column="statetype_id" input="select" references="statetype" condition="statetype_id < 3">
    <!--- original property 
	<cf_buildSearchProperty column="statetype_id" input="select" references="statetype" condition="statetype_id != 4">
	--->
</cf_buildSearch>

</cf_buildPage>