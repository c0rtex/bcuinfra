<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>
<cf_buildPage title="Wrapper Administration" section="partner">

<cf_buildView table="wrapper" code="wrapper" key="#id#" action="#action#" saving="#saving#" title="Wrapper Data">
	<cf_buildViewProperty column="wrapper_partner_id" input="select" references="tbl_partner">
	<cf_buildViewProperty column="wrapper_code" limit="32" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="wrapper_lis_link_direct" input="flag" default="no">
</cf_buildView>

</cf_buildpage>