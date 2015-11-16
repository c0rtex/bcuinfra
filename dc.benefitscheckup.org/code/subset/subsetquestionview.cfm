<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_subset_id" type="string" default="">
<cfparam name="new_question_id" type="string" default="">
<cfparam name="name" type="string" default="">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cfset nextSortOrder="989">
<cfoutput>
#nextSortOrder#
</cfoutput>

<cf_buildPage title="Application Question" section="subset">

<cf_buildView title="Application Question" name="#name#" table="subset_question" code="question" key="#id#" action="#action#" saving="#saving#" actionurl="subsetquestionview.cfm?new_subset_id=#new_subset_id#" redirect="subsetquestions.cfm?id=#new_subset_id####name#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="subsetquestions.cfm?id=[[id]]#anchorname#" valueonadd="#new_subset_id#">
	<cf_buildViewProperty column="question_id" input="select" references="question" link="../question/questionview.cfm?id=[[id]]" valueonadd="#new_question_id#">
	<cf_buildViewProperty column="sort" input="select" default="#nextSortOrder#">
	<cf_buildViewProperty column="page_id" input="select" references="page" selectrequiredwhen="select 1 c">
	<cf_buildViewProperty column="required_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="exclude_flag" visible="false" valueonadd="0">
	<cf_buildViewProperty column="options_flag" visible="false" valueonadd="0">
</cf_buildView>

</cf_buildPage>
