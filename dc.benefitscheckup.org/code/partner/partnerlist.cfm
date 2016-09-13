<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Partner Administration" section="partner">

<cf_buildList table="tbl_partner" code="partner" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="alt_name" visible="false">
	<cf_buildListProperty column="partner_url" visible="false">
	<cf_buildListProperty column="partnertype_id" input="select" references="partnertype">
	<cf_buildListProperty column="bcu_display_id" visible="false">
	<cf_buildListProperty column="partner_wrapper" visible="false">
	<cf_buildListProperty column="partner_header" visible="false">
	<cf_buildListProperty column="partner_footer" visible="false">
	<cf_buildListProperty column="partner_css" visible="false">
	<cf_buildListProperty column="wrapper_id" input="select" references="wrapper">
	<cf_buildListProperty column="cms_doc_no" visible="false">
	<cf_buildListProperty column="login_only_flag" display="yesno">
	<cf_buildListProperty column="report_flag" visible="false">
	<cf_buildListProperty column="learn_flag" visible="false">
	<cf_buildListProperty column="race_flag" visible="false">
	<cf_buildListProperty column="hispanic_flag" visible="false">
	<cf_buildListProperty column="links_flag" visible="false">
	<cf_buildListProperty column="pdf_logo_flag" visible="false">
	<cf_buildListProperty column="demo" visible="false">
	<cf_buildListProperty column="parent" visible="false">		
	<cf_buildListProperty column="notes" visible="false">
</cf_buildlist>

</cf_buildpage>