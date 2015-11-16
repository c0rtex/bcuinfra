<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_subset_id" type="string" default="">
<cfparam name="new_partner_id" type="string" default="">
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

<cf_buildPage title="Alternate Partner Shadow Subset" section="subset">

<cf_buildView title="Alternate Partner Shadow Subset" name="#name#" table="subset_partner_shadow" code="partner" key="#id#" action="#action#" saving="#saving#" actionurl="partnershadowview.cfm?new_subset_id=#new_subset_id#" redirect="subsetview.cfm?id=#new_subset_id####name#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="subsetview.cfm?id=[[id]]#anchorname#" valueonadd="#new_subset_id#">
	<cf_buildViewProperty column="partner_id" input="select" references="tbl_partner" skipon="edit" link="../partner/partnerview.cfm?id=[[id]]" valueonadd="#new_partner_id#">
	<cf_buildViewProperty column="shadow_subset_id" input="select" references="subset" condition="subset_id != #new_subset_id#">
</cf_buildView>

</cf_buildPage>