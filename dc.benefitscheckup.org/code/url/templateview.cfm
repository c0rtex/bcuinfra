<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="2">
</cfif>

<cf_buildPage title="Template Data" section="url">

<cf_buildView table="template" code="template" key="#id#" action="#action#" saving="#saving#" title="Template Data">
	<cf_buildViewProperty column="filename" input="text" size="79" limit="255" prefix="/">
	<cf_buildViewProperty column="name" input="text" size="60" limit="64">
	<cf_buildViewProperty column="canonical_flag" input="flag" default="no">
	<cf_buildViewProperty column="source_flag" input="flag" default="no">
	<cf_buildViewProperty column="prev_flag" input="flag" default="no">
	<cf_buildViewProperty column="org_flag" input="flag" default="no">
	<cf_buildViewProperty column="partner_flag" input="flag" default="no">
	<cf_buildViewProperty column="subset_flag" input="flag" default="no">
	<cf_buildViewProperty column="language_flag" input="flag" default="no">
	<cf_buildViewProperty column="access_flag" input="flag" default="no">
	<cf_buildViewProperty column="client_flag" input="flag" default="no">
	<cf_buildViewProperty column="user_flag" input="flag" default="no">
	<cf_buildViewProperty column="state_flag" input="flag" default="no">
	<cf_buildViewProperty column="test_flag" input="flag" default="no">
	<cf_buildViewProperty column="description" input="textarea" cols="60" rows="4" limit="255">
</cf_buildView>

</cf_buildPage>