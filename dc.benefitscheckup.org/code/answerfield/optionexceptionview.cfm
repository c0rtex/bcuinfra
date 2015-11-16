<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_option_id" type="string" default="">
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

<cf_buildPage title="Option Exception Administration" section="answerfield">

<cf_buildView title="Option Exception" name="#name#" table="option_subset_partner" code="option" key="#id#" action="#action#" saving="#saving#" actionurl="optionexceptionview.cfm?new_option_id=#new_option_id#" redirect="optionview.cfm?id=#new_option_id####name#">
	<cf_buildViewProperty column="option_id" input="select" references="option" skipon="edit" link="optionview.cfm?id=[[id]]#anchorname#" valueonadd="#new_option_id#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset">
	<cf_buildViewProperty column="partner_id" input="select" references="tbl_partner">
	<cf_buildViewProperty column="include_flag" input="flag" default="no">
</cf_buildView>

</cf_buildPage>