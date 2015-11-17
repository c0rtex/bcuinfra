<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>
<cf_buildPage title="Partner Administration" section="partner">

<cf_buildView table="tbl_partner" code="partner" key="#id#" action="#action#" saving="#saving#" title="Partner Data">
	<cf_buildViewProperty column="partner_name" limit="64">
	<cf_buildViewProperty column="partner_code" limit="16" case="lower" restriction="alphanumeric" visible="disableonedit">
	<cf_buildViewProperty column="partner_url" limit="255" prefix="http://">
	<cf_buildViewProperty column="partnertype_id" input="select" references="partnertype">
	<cf_buildViewProperty column="bcu_display_id" input="display" rows="1" group="partnersite" namefrom="partner_code" codefrom="partner_code">
	<cf_buildViewProperty column="partner_wrapper" visible="false">
	<cf_buildViewProperty column="partner_header" visible="false">
	<cf_buildViewProperty column="partner_footer" visible="false">
	<cf_buildViewProperty column="partner_css" visible="false">
	<cf_buildViewProperty column="wrapper_id" input="select" references="wrapper">
	<cf_buildViewProperty column="cms_doc_no" input="textarea" cols="60" rows="2" limit="255">
	<cf_buildViewProperty column="login_only_flag" input="flag" default="no">
	<cf_buildViewProperty column="report_flag" input="flag" default="no">
	<cf_buildViewProperty column="learn_flag" input="flag">
	<cf_buildViewProperty column="race_flag" input="flag">
	<cf_buildViewProperty column="hispanic_flag" input="flag" default="no">
	<cf_buildViewProperty column="links_flag" input="flag" default="no">
	<cf_buildViewProperty column="pdf_logo_flag" input="flag">
	<cf_buildViewProperty column="demo" input="flag">
	<cf_buildViewProperty column="parent">
	<cf_buildViewProperty column="notes" input="textarea" cols="60" rows="6">
</cf_buildView>

</cf_buildpage>