<cf_checkAccess level="5">
<cf_buildPage title="Question Search" section="question">

<cf_buildSearch table="question" code="question" title="Question Search">
	<cf_buildSearchProperty column="dep_question_id" input="select" references="question">
	<cf_buildSearchProperty column="questiontype_id" input="select" references="questiontype">
	<cf_buildSearchProperty column="questionheader_id" input="select" references="questionheader">
	<cf_buildSearchProperty column="questioncategory_id" input="select" references="questioncategory">
	<cf_buildSearchProperty column="display_id" input="display">
	<cf_buildSearchProperty column="short_display_id" input="display">
	<cf_buildSearchProperty column="spq_display_id" input="display">
	<cf_buildSearchProperty column="print_display_id" input="display">
	<cf_buildSearchProperty column="format_id" input="select" references="format">
	<cf_buildSearchProperty column="rule_id" input="select" references="rule">
	<cf_buildSearchProperty column="include_flag" input="flag">
	<cf_buildSearchProperty column="exclude_flag" input="flag">
	<cf_buildSearchProperty column="suppress_qno_flag" input="flag">
	<cf_buildSearchProperty column="spq_exclude_flag" input="flag">
	<cf_buildSearchProperty column="create_user_id" visible="false">
	<cf_buildSearchProperty column="create_date" visible="false">
	<cf_buildSearchProperty column="modify_user_id" visible="false">
	<cf_buildSearchProperty column="modify_date" visible="false">
</cf_buildSearch>

</cf_buildPage>