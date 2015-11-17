<cfparam name="answerfield_id" type="numeric">
<cfparam name="subset_id" type="numeric">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="name" type="string" default="">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cf_checkAccess level="3">

<cf_buildPage title="Other Answerfield Attributes" section="subset">

<cf_buildView title="Other Answerfield Attributes" name="#name#" table="subset_answerfield" code="answerfield" key="#subset_id#,#answerfield_id#" action="edit" viewlevel="0" saving="#saving#" actionurl="subsetanswerfieldedit.cfm?subset_id=#subset_id#&answerfield_id=#answerfield_id#" redirect="subsetview.cfm?id=#subset_id####name#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="subsetview.cfm?id=[[id]]#anchorname#">
	<cf_buildViewProperty column="answerfield_id" input="select" references="answerfield" skipon="edit" link="../answerfield/answerfieldview.cfm?id=[[id]]">
	<cf_buildViewProperty column="required" input="flag" default="yes">
	<cf_buildViewProperty column="recap_id" input="flag" default="no">
	<cf_buildViewProperty column="preset_value" visible="false">
</cf_buildView>

</cf_buildPage>