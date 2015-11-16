<cf_checkAccess level="5">
<cf_buildPage title="Entry Point Group Search" section="entrypoint">

<cf_buildSearch table="entrypointgroup" code="entrypointgroup" title="Entry Point Group Search">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id < 3">
	<cf_buildSearchProperty column="active_flag" input="flag">
	<cf_buildSearchProperty column="notes" input="text">
</cf_buildSearch>

</cf_buildPage>