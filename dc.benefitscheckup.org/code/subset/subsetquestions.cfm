<cfparam name="id" type="numeric" default="0">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">
<cf_checkAccess level="5">

<cf_buildPage title="Subset Administration" section="subset">

<cf_buildView title="Abbreviated Subset Data" table="subset" code="subset" key="#id#" action="view" extraurllist="subsetverbose.cfm?id=#id#,subsetdiff.cfm?id=#id#,null" extranamelist="programs,helpers,app&nbsp;questions" linkallactions="true">
	<cf_buildViewProperty column="subsettype_id" input="select" references="subsettype" condition="subsettype_id not in (2, 4)" valuetovar="subsetTypeID">
	<cf_buildViewProperty column="code" limit="32" case="lower" visible="disableonedit">
	<cf_buildViewProperty column="description" visible="false">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="subset" namefrom="code" codefrom="code">
	<cf_buildViewProperty column="alt_display_id" visible="false">
	<cf_buildViewProperty column="spq_display_id" visible="false">
	<cf_buildViewProperty column="intro_display_id" visible="false">
	<cf_buildViewProperty column="oe_name" visible="false">
	<cf_buildViewProperty column="resultpage_id" visible="false">
	<cf_buildViewProperty column="shadow_subset_id" visible="false">
	<cf_buildViewProperty column="branding_partner_id" visible="false">
	<cf_buildViewProperty column="active_flag" visible="false">
	<cf_buildViewProperty column="test_flag" visible="false">
	<cf_buildViewProperty column="eform_flag" visible="false">
	<cf_buildViewProperty column="report_flag" visible="false">
	<cf_buildViewProperty column="create_user_id" visible="false">
	<cf_buildViewProperty column="create_date" visible="false">
	<cf_buildViewProperty column="modify_user_id" visible="false">
	<cf_buildViewProperty column="modify_date" visible="false">
</cf_buildView>

	<cfif subsetTypeID neq 5>
		<h3>This tab is only applicable to subsets of type "application"</h3>
	<cfelse>
		<cf_buildList name="questionAssociate" title="Application Questions" table="view_subset_question" code="question" condition="vsq.subset_id=#id#" order="sqsort" orderlink="subsetquestionorder.cfm?id=#id#&name=subsetQuestionSorting" key="#id#" page="#page#" rows="#rows#" view="false" editlink="subsetquestionedit.cfm?subset_id=#id#&question_id=[[question_id]]&action=edit&name=questionAssociate" delete="true" deletelink="subsetquestiondelete.cfm?subset_id=#id#&question_id=[[question_id]]" selflink="true" selflinkid="#id#" reverseadd="true" reverseaddtable="question" reverseaddcolumn="subset_id" reverseaddvalue="#id#" reverseaddcondition="q.question_id not in (select question_id from subset_question where subset_id=#id# and required_flag=0 and exclude_flag=0 and options_flag=0)" reverseaddlink="subsetquestionview.cfm?action=new">
			<cf_buildListProperty column="subset_id" visible="false">
			<cf_buildListProperty column="question_id" references="question">
			<cf_buildListProperty column="display_id" display="display">
			<cf_buildListProperty column="page_id" references="page">
		</cf_buildList>
	</cfif>

</cf_buildPage>
