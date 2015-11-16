<cfparam name="id" type="numeric" default="0">
<cfparam name="action" type="string" default="view">
<cfparam name="saving" type="numeric" default="0">
<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cfif action eq 'view'>
	<cf_checkAccess level="5">
<cfelse>
	<cf_checkAccess level="3">
</cfif>

<cf_buildPage title="Partner Type" section="partner">

<cf_buildView table="partnertype" code="partnertype" key="#id#" action="#action#" saving="#saving#" title="Partner Type Data" editlevel="1">
	<cf_buildViewProperty column="code" limit="16" case="lower" restriction="alphanumeric">
	<cf_buildViewProperty column="name" limit="64">
	<cf_buildViewProperty column="description" input="textarea" limit="255">
</cf_buildView>

<cfif action eq 'view' or hasSaved>
	
	<br />
	<cf_buildList title="Partners of This Type" table="tbl_partner" code="partner" condition="partnertype_id=#id#" order="partner_code" by="#by#" dir="#dir#" page="#page#" rows="#rows#" selflink="true" selflinkid="#id#">
		<cf_buildListProperty column="alt_name" visible="false">
		<cf_buildListProperty column="partner_url" visible="false">
		<cf_buildListProperty column="partnertype_id" visible="false">
		<cf_buildListProperty column="bcu_display_id" visible="false">
		<cf_buildListProperty column="partner_wrapper" visible="false">
		<cf_buildListProperty column="partner_header" visible="false">
		<cf_buildListProperty column="partner_footer" visible="false">
		<cf_buildListProperty column="partner_css" visible="false">
		<cf_buildListProperty column="wrapper_id" input="select" references="wrapper">
		<cf_buildListProperty column="cms_doc_no" visible="false">
		<cf_buildListProperty column="login_only_flag" display="yesno">
		<cf_buildListProperty column="report_flag" display="yesno">
		<cf_buildListProperty column="learn_flag" display="yesno">
		<cf_buildListProperty column="race_flag" display="yesno">
		<cf_buildListProperty column="hispanic_flag" visible="false">
		<cf_buildListProperty column="links_flag" display="yesno">
		<cf_buildListProperty column="pdf_logo_flag" visible="false">
	</cf_buildList>
	
</cfif>

</cf_buildPage>