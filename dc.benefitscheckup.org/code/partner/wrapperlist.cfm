<cfparam name="by" type="string" default="">
<cfparam name="dir" type="string" default="asc">
<cfparam name="page" type="numeric" default="1">
<cfparam name="rows" type="numeric" default="50">

<cf_checkAccess level="5">
<cf_buildPage title="Wrapper Administration" section="partner">

<cf_buildList table="wrapper" code="wrapper" by="#by#" dir="#dir#" page="#page#" rows="#rows#">
	<cf_buildListProperty column="wrapper_partner_id" references="tbl_partner">
	<cf_buildListProperty column="wrapper_menu_css" visible="false">
	<cf_buildListProperty column="wrapper_header" visible="false">
	<cf_buildListProperty column="wrapper_footer" visible="false">
	<cf_buildListProperty column="wrapper_left_col" visible="false">
	<cf_buildListProperty column="wrapper_right_col" visible="false">
	<cf_buildListProperty column="wrapper_cover_image" visible="false">
	<cf_buildListProperty column="wrapper_logo" visible="false">
	<cf_buildListProperty column="wrapper_logo_alt_text" visible="false">
	<cf_buildListProperty column="wrapper_logo_link" visible="false">
	<cf_buildListProperty column="wrapper_title" visible="false">
	<cf_buildListProperty column="wrapper_link" visible="false">
	<cf_buildListProperty column="wrapper_custom_subset" visible="false">
	<cf_buildListProperty column="wrapper_custom_title" visible="false">
	<cf_buildListProperty column="wrapper_custom_time" visible="false">
	<cf_buildListProperty column="wrapper_comprehensive" visible="false">
	<cf_buildListProperty column="wrapper_pda" visible="false">
	<cf_buildListProperty column="wrapper_rx" visible="false">
	<cf_buildListProperty column="wrapper_disaster" visible="false">
	<cf_buildListProperty column="wrapper_pap" visible="false">
	<cf_buildListProperty column="wrapper_more_programs" visible="false">
	<cf_buildListProperty column="wrapper_moreprograms_template" visible="false">
	<cf_buildListProperty column="wrapper_afc" visible="false">
	<cf_buildListProperty column="wrapper_external" visible="false">
	<cf_buildListProperty column="wrapper_external_title" visible="false">
	<cf_buildListProperty column="wrapper_external_title_graphic" visible="false">
	<cf_buildListProperty column="wrapper_external_text" visible="false">
	<cf_buildListProperty column="wrapper_external_time" visible="false">
	<cf_buildListProperty column="wrapper_external_link" visible="false">
	<cf_buildListProperty column="wrapper_optional_box_text" visible="false">
	<cf_buildListProperty column="wrapper_status" visible="false">
	<cf_buildListProperty column="wrapper_deployment_status" visible="false">
	<cf_buildListProperty column="wrapper_get_started_now" visible="false">
	<cf_buildListProperty column="wrapper_bcu_logo" visible="false">
	<cf_buildListProperty column="wrapper_bcu_logo_alt_text" visible="false">
	<cf_buildListProperty column="wrapper_bcu_link" visible="false">
	<cf_buildListProperty column="wrapper_checksum" visible="false">
	<cf_buildListProperty column="wrapper_changes" visible="false">
	<cf_buildListProperty column="wrapper_logo_margin_top" visible="false">
	<cf_buildListProperty column="wrapper_logo_margin_right" visible="false">
	<cf_buildListProperty column="wrapper_menu" visible="false">
	<cf_buildListProperty column="wrapper_top_menu" visible="false">
	<cf_buildListProperty column="wrapper_footer_custom" visible="false">
	<cf_buildListProperty column="wrapper_printed_text" visible="false">
	<cf_buildListProperty column="wrapper_menu_ie_css" visible="false">
	<cf_buildListProperty column="wrapper_additional_css" visible="false">
	<cf_buildListProperty column="wrapper_special_link" visible="false">
	<cf_buildListProperty column="wrapper_special_text" visible="false">
	<cf_buildListProperty column="wrapper_special" visible="false">
	<cf_buildListProperty column="wrapper_tag1" visible="false">
	<cf_buildListProperty column="wrapper_tag2" visible="false">
	<cf_buildListProperty column="wrapper_tag3" visible="false">
	<cf_buildListProperty column="wrapper_custom_js" visible="false">
	<cf_buildListProperty column="wrapper_lis_link_direct" visible="false">
</cf_buildList>

</cf_buildpage>