<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_answerfield_id" type="string" default="">
<cfparam name="new_subset_id" type="string" default="">
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

<cf_buildPage title="Other Answerfield Attributes" section="subset">

<cf_buildView title="Other Answerfield Attributes" name="#name#" table="subset_answerfield" code="answerfield" key="#id#" action="#action#" saving="#saving#" actionurl="subsetanswerfieldview.cfm?new_subset_id=#new_subset_id#" redirect="subsetview.cfm?id=#new_subset_id####name#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="subsetview.cfm?id=[[id]]#anchorname#" valueonadd="#new_subset_id#">
	<cf_buildViewProperty column="answerfield_id" input="select" references="answerfield" skipon="edit" link="../answerfield/answerfieldview.cfm?id=[[id]]" valueonadd="#new_answerfield_id#">
	<cf_buildViewProperty column="required" input="flag" default="yes">
	<cf_buildViewProperty column="recap_id" input="flag" default="no">
	<cf_buildViewProperty column="preset_value" visible="false">
</cf_buildView>

</cf_buildPage>