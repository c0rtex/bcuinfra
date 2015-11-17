<cf_checkAccess level="5">
<cf_buildPage title="Answerfield Search" section="answerfield"><cfoutput>

<cf_buildSearch table="answerfield" code="answerfield" title="Answerfield Search">
	<cf_buildSearchProperty column="answerfieldtype_id" input="select" references="answerfieldtype" condition="answerfieldtype_id not in (13, 14, 15)">
	<cf_buildSearchProperty column="display_id" input="display">
	<cf_buildSearchProperty column="short_display_id" input="display">
	<cf_buildSearchProperty column="spq_display_id" input="display">
	<cf_buildSearchProperty column="print_display_id" input="display">
	<cf_buildSearchProperty column="default_value" input="default">
	<cf_buildSearchProperty column="spq_default_value" input="default">
	<cf_buildSearchProperty column="oe_default_value" input="default">
	<cf_buildSearchProperty column="required_flag" input="flag">
	<cf_buildSearchProperty column="rx_required_flag" input="flag">
	<cf_buildSearchProperty column="rule_id" input="select" references="rule">
	<cf_buildSearchProperty column="validation_id" input="select" references="validation">
	<cf_buildSearchProperty column="state_id" input="select" references="state" condition="statetype_id=1  or state_id = 'VI'">
	<cf_buildSearchProperty column="create_user_id" visible="false">
	<cf_buildSearchProperty column="create_date" visible="false">
	<cf_buildSearchProperty column="modify_user_id" visible="false">
	<cf_buildSearchProperty column="modify_date" visible="false">
</cf_buildSearch>

</cfoutput></cf_buildPage>