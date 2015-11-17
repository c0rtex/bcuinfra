<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="new_url_id" type="string" default="">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Alternate Partner URL Administration" section="url">

<cf_buildView table="alt_url_partner" code="alturlpartner" key="#id#" action="#action#" saving="#saving#" title="Alternate Partner URL Data">
	<cf_buildViewProperty column="url_id" input="select" references="url" skipon="edit" link="urlview.cfm?id=[[id]]##alturl" valueonadd="#new_url_id#">
	<cf_buildViewProperty column="partner_id" input="select" references="tbl_partner" link="../partner/partnerview.cfm?id=[[id]]">
	<cf_buildViewProperty column="alt_url_id" input="select" references="url" condition="url_id <> #new_url_id#" link="urlview.cfm?id=[[id]]##alturl">
</cf_buildView>

</cf_buildPage>