<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="2">
</cfif>

<cf_buildPage title="Question Category" section="question"><cfoutput>

<cf_buildView title="Question Category Data" table="questioncategory" code="questioncategory" key="#id#" action="#action#" saving="#saving#" extraurllist="questioncategoryquestionorder.cfm?id=#id#" extranamelist="question order">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="quescat" namefrom="display_id" codefrom="questioncategory_code">
	<cf_buildViewProperty column="questioncategory_code" limit="16" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="questioncategory_desc" input="textarea" limit="255">
	<cf_buildViewProperty column="sort" visible="false" increment="1">
</cf_buildView>

<cfif action eq 'view' or hasSaved>
	
	<br />
	<cf_buildList name="questionAssoc" title="Questions in Category" table="question" code="question" condition="q.questioncategory_id=#id#" linksection="question" order="sort" orderlinks="false">
		<cf_buildListProperty column="dep_question_id" visible="false">
		<cf_buildListProperty column="questioncategory_id" references="questioncategory">
		<cf_buildListProperty column="questionheader_id" visible="false">
		<cf_buildListProperty column="questiontype_id" visible="false">
		<cf_buildListProperty column="display_id" display="display">
		<cf_buildListProperty column="short_display_id" visible="false">
		<cf_buildListProperty column="spq_display_id" visible="false">
		<cf_buildListProperty column="print_display_id" visible="false">
		<cf_buildListProperty column="format_id" visible="false">
		<cf_buildListProperty column="rule_id" visible="false">
		<cf_buildListProperty column="include_flag" visible="false">
		<cf_buildListProperty column="exclude_flag" visible="false">
		<cf_buildListProperty column="suppress_qno_flag" visible="false">
		<cf_buildListProperty column="spq_exclude_flag" visible="false">
		<cf_buildListProperty column="sort" visible="false">
		<cf_buildListProperty column="create_user_id" visible="false">
		<cf_buildListProperty column="create_date" visible="false">
		<cf_buildListProperty column="modify_user_id" visible="false">
		<cf_buildListProperty column="modify_date" visible="false">
	</cf_buildList>

</cfif>

</cfoutput></cf_buildPage>