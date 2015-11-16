<cfparam name="subset_id" type="numeric">
<cfparam name="partner_id" type="numeric">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="name" type="string" default="">

<cfif name eq ''>
	<cfset anchorname = ''>
<cfelse>
	<cfset anchorname = "###name#">
</cfif>

<cf_checkAccess level="3">

<cf_buildPage title="Alternate Partner Shadow Subset" section="subset">

<cf_buildView title="Alternate Partner Shadow Subset" name="#name#" table="subset_partner_shadow" code="partner" key="#subset_id#,#partner_id#" action="edit" viewlevel="0" saving="#saving#" actionurl="partnershadowedit.cfm?subset_id=#subset_id#&partner_id=#partner_id#" redirect="subsetview.cfm?id=#subset_id####name#">
	<cf_buildViewProperty column="subset_id" input="select" references="subset" skipon="edit" link="subsetview.cfm?id=[[id]]#anchorname#">
	<cf_buildViewProperty column="partner_id" input="select" references="tbl_partner" skipon="edit" link="../partner/partnerview.cfm?id=[[id]]">
	<cf_buildViewProperty column="shadow_subset_id" input="select" references="subset" condition="subset_id != #subset_id#">
</cf_buildView>

</cf_buildPage>