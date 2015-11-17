<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Option Administration" section="answerfield"><cfoutput>

<cf_buildView table="option" code="option" key="#id#" action="#action#" saving="#saving#" title="Option Data">
	<cf_buildViewProperty column="option_code" limit="32" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="display_id" input="display" rows="1" group="option" namefrom="option_code" codefrom="option_code">
	<cf_buildViewProperty column="include_flag" input="flag">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

<cfif action eq 'view' or hasSaved>

	<cf_buildList name="exceptionAssociate" title="Option Exceptions" table="option_subset_partner" code="option" condition="osp.option_id=#id#" order="subset_id, partner_id" orderlinks="false" by="#by#" dir="#dir#" view="false" edit="false" delete="true" deletelink="optionexceptiondelete.cfm?option_id=[[option_id]]&subset_id=[[subset_id]]&partner_id=[[partner_id]]" selflink="true" addlink="optionexceptionview.cfm?new_option_id=#id#&action=new&name=exceptionAssociate">
		<cf_buildListProperty column="option_id" visible="false">
		<cf_buildListProperty column="subset_id" references="subset">
		<cf_buildListProperty column="partner_id" references="tbl_partner">
		<cf_buildListProperty column="include_flag" display="yesno">
	</cf_buildList>

</cfif>

</cfoutput></cf_buildPage>