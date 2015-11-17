<cfparam name="id" type="numeric" default="0">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="linktable" type="string" default="">
<cfparam name="linkcolumn" type="string" default="">
<cfparam name="linkkeycolumn" type="string" default="">
<cfparam name="linkid" type="any" default="">
<cfparam name="linkaction" type="string" default="">

<cfparam name="generic_id" type="numeric" default="0">
<cfif generic_id neq 0 and id eq 0>
	<cfset id=generic_id>
</cfif>

<cfset action='edit'>
<cf_checkAccess level="3">

<cf_buildPage title="Rx Administration" section="rx"><cfoutput>

<cf_buildView table="answerfield" code="generic" key="#id#" action="#action#" saving="#saving#" title="Generic Medication" actionurl="genericedit.cfm" viewurl="genericview.cfm?generic_id=#id#" redirect="genericview.cfm?generic_id=#id#">
	<cf_buildViewProperty column="answerfield" visible="disableonedit" limit="64" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="answerfieldtype_id" visible="false">
	<cf_buildViewProperty column="display_id" input="display" rows="4" group="generic" namefrom="answerfield" codefrom="answerfield">
	<cf_buildViewProperty column="short_display_id" visible="false">
	<cf_buildViewProperty column="spq_display_id" visible="false">
	<cf_buildViewProperty column="print_display_id" visible="false">
	<cf_buildViewProperty column="max_length" visible="false">
	<cf_buildViewProperty column="default_value" visible="false">
	<cf_buildViewProperty column="spq_default_value" visible="false">
	<cf_buildViewProperty column="oe_default_value" visible="false">
	<cf_buildViewProperty column="required_flag" visible="false">
	<cf_buildViewProperty column="rule_id" visible="false">
	<cf_buildViewProperty column="validation_id" visible="false">
	<cf_buildViewProperty column="state_id" visible="false">
	<cf_buildViewProperty column="answerfield_desc" visible="false">
	<cf_buildViewProperty column="create_user_id" visible="false" user="this" skipon="edit">
	<cf_buildViewProperty column="create_date" visible="false" input="date" skipon="edit">
	<cf_buildViewProperty column="modify_user_id" visible="false" user="this">
	<cf_buildViewProperty column="modify_date" visible="false" input="date">
</cf_buildView>

</cfoutput></cf_buildPage>