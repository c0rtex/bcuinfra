<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_answerfield_id" type="string" default="">
<cfparam name="new_subset_id" type="string" default="">
<cfparam name="name" type="string" default="">

<cfif new_subset_id eq ''>
	<cfset subsetWhere = " is null">
<cfelse>
	<cfset subsetWhere = "=#new_subset_id#">
</cfif>

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

<cf_buildPage title="Screening-Specific Default Value" section="answerfield">

<cf_buildView title="Screening-Specific Default Value" name="#name#" table="answerfield_subset_partner" code="answerfield" key="#id#" action="#action#" saving="#saving#" actionurl="answerfielddefaultview.cfm?new_answerfield_id=#new_answerfield_id#" redirect="answerfieldview.cfm?id=#new_answerfield_id####name#">
	<cf_buildViewProperty column="answerfield_id" input="select" references="answerfield" skipon="edit" link="answerfieldview.cfm?id=[[id]]#anchorname#" valueonadd="#new_answerfield_id#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="../subset/subsetview.cfm?id=[[id]]" valueonadd="#new_subset_id#">
	<cf_buildViewProperty column="partner_id" input="select" references="tbl_partner" condition="partner_id not in (select partner_id from answerfield_subset_partner where answerfield_id=#new_answerfield_id# and subset_id#subsetWhere# and partner_id is not null)" selectrequiredwhen="select count(*) c from answerfield_subset_partner where answerfield_id=#new_answerfield_id# and subset_id#subsetWhere# and partner_id is null">
	<cf_buildViewProperty column="default_value" input="default" bindto="answerfieldtype_id" bindoptionskey="answerfield_id" bindid="#new_answerfield_id#" limit="64">
	<cf_buildViewProperty column="background_flag" input="flag" default="no">
</cf_buildView>

</cf_buildPage>