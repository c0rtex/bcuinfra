<cfparam name="answerfield_id" type="numeric">
<cfparam name="subset_id" type="any" default="">
<cfparam name="partner_id" type="any" default="">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="name" type="string" default="">

<cfif subset_id eq ''>
	<cfset pass_subset_id = 'NULL'>
<cfelse>
	<cfset pass_subset_id = subset_id>
</cfif>
<cfif partner_id eq ''>
	<cfset pass_partner_id = 'NULL'>
<cfelse>
	<cfset pass_partner_id = partner_id>
</cfif>

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cf_checkAccess level="3">

<cf_buildPage title="Answerfield Default Value" section="subset">

<cf_buildView title="Answerfield Default Value" name="#name#" table="answerfield_subset_partner" code="answerfield" key="#answerfield_id#,#pass_subset_id#,#pass_partner_id#" action="edit" viewlevel="0" saving="#saving#" actionurl="answerfielddefaultedit.cfm?answerfield_id=#answerfield_id#&subset_id=#subset_id#&partner_id=#partner_id#" redirect="answerfieldview.cfm?id=#answerfield_id####name#">
	<cf_buildViewProperty column="answerfield_id" input="select" references="answerfield" skipon="edit" link="answerfieldview.cfm?id=[[id]]#anchorname#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="../subset/subsetview.cfm?id=[[id]]">
	<cf_buildViewProperty column="partner_id" input="select" references="tbl_partner" skipon="edit" link="../partner/partnerview.cfm?id=[[id]]">
	<cf_buildViewProperty column="default_value" input="default" bindto="answerfieldtype_id" bindoptionskey="answerfield_id" bindid="#answerfield_id#" limit="64">
	<cf_buildViewProperty column="background_flag" input="flag" default="no">
</cf_buildView>

</cf_buildPage>