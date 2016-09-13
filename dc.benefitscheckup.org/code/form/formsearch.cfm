<cf_checkAccess level="5">
<cf_buildPage title="Form Search" section="form">

<cf_buildSearch title="Form Search" table="form" code="form">
	<cf_buildSearchProperty column="formtag_id" input="select" references="formtag">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
</cf_buildSearch>

</cf_buildPage>