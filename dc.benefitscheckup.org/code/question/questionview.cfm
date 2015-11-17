<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="linkname" type="string" default="">
<cfparam name="linktable" type="string" default="">
<cfparam name="linkcolumn" type="string" default="">
<cfparam name="linkkeycolumn" type="string" default="">
<cfparam name="linkid" type="any" default="">
<cfparam name="linkaction" type="string" default="">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Question Administration" section="question">

<cf_buildView table="question" code="question" key="#id#" action="#action#" saving="#saving#" title="Question Data">
	<cf_buildViewProperty column="dep_question_id" input="select" references="question">
	<cf_buildViewProperty column="question_code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="questioncategory_id" input="select" references="questioncategory">
	<cf_buildViewProperty column="questionheader_id" input="select" references="questionheader">
	<cf_buildViewProperty column="questiontype_id" input="select" references="questiontype">
	<cf_buildViewProperty column="display_id" input="display" rows="6" group="question" namefrom="question_code" codefrom="question_code">
	<cf_buildViewProperty column="short_display_id" input="display" group="quesshort" namefrom="question_code" codefrom="question_code">
	<cf_buildViewProperty column="spq_display_id" input="display" group="quesspq" namefrom="question_code" codefrom="question_code">
	<cf_buildViewProperty column="print_display_id" input="display" group="quesprint" namefrom="question_code" codefrom="question_code">
	<cf_buildViewProperty column="format_id" input="select" references="format">
	<cf_buildViewProperty column="rule_id" input="select" references="rule" link="../rule/ruleview.cfm?id=[[id]]">
	<cf_buildViewProperty column="include_flag" input="flag" default="no">
	<cf_buildViewProperty column="exclude_flag" input="flag" default="no">
	<cf_buildViewProperty column="suppress_qno_flag" input="flag" default="no">
	<cf_buildViewProperty column="spq_exclude_flag" input="flag" default="no">
	<cf_buildViewProperty column="sort" visible="false" increment="1">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

<cfif action eq 'view' or hasSaved>

	<cf_buildList name="answerfieldAssociate" table="answerfield" code="answerfield" title="Associated Answerfields" key="#id#" crosstable="question_answerfield" crosscolumn="question_id" crossvalue="#id#" crossorder="sort" crossaddcondition="a.answerfieldtype_id not in (13, 14, 15)" crossreorderlink="questionanswerfieldorder.cfm?id=#id#" linkname="#linkname#" linksection="answerfield" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
		<cf_buildListProperty column="answerfieldtype_id" references="answerfieldtype">
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="short_display_id" visible="false">
		<cf_buildListProperty column="spq_display_id" visible="false">
		<cf_buildListProperty column="print_display_id" visible="false">
		<cf_buildListProperty column="max_length" visible="false">
		<cf_buildListProperty column="default_value" visible="false">
		<cf_buildListProperty column="spq_default_value" visible="false">
		<cf_buildListProperty column="oe_default_value" visible="false">
		<cf_buildListProperty column="required_flag" display="yesno">
		<cf_buildListProperty column="rx_required_flag" visible="false">
		<cf_buildListProperty column="rule_id" visible="false">
		<cf_buildListProperty column="validation_id" visible="false">
		<cf_buildListProperty column="answerfield_desc" visible="false">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>

	<cf_buildList name="helpAssociate" table="help" code="help" title="Associated Help Text" key="#id#" crosstable="question_help" crosscolumn="question_id" crossvalue="#id#" crossorder="sort" linkname="#linkname#" linksection="help" linktable="#linktable#" linkcolumn="#linkcolumn#" linkkeycolumn="#linkkeycolumn#" linkid="#linkid#" linkaction="#linkaction#">
		<cf_buildListProperty column="keyword" visible="false">
		<cf_buildListProperty column="title_display_id" visible="false">
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>

</cfif>

</cf_buildPage>