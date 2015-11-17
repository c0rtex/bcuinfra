<cfparam name="subset_id" type="numeric">
<cfparam name="question_id" type="numeric">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="name" type="string" default="">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cf_checkAccess level="3">

<cf_buildPage title="Application Question" section="subset">

<cf_buildView title="Application Question" name="#name#" table="subset_question" code="question" key="#subset_id#,#question_id#" action="edit" viewlevel="0" saving="#saving#" actionurl="subsetquestionedit.cfm?subset_id=#subset_id#&question_id=#question_id#" redirect="subsetquestions.cfm?id=#subset_id####name#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="subsetquestions.cfm?id=[[id]]#anchorname#">
	<cf_buildViewProperty column="question_id" input="select" references="question" skipon="edit" link="../question/questionview.cfm?id=[[id]]">
	<cf_buildViewProperty column="page_id" input="select" references="page" selectrequiredwhen="select 1 c">
	<cf_buildViewProperty column="required_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="exclude_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="options_flag" visible="false" valueonadd="0">
</cf_buildView>

</cf_buildPage>