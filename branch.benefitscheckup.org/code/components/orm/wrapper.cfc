<!---
	Template Name: WrapperEntity
	Component Purpose: Component mapped to database table address via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: wrapper

--->

<cfcomponent persistent="true" entityname="wrapper" table="wrapper" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="wrapper_id">
    <cfproperty name="partner" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="wrapper_partner_id" cfc="partner">
    <cfproperty name="wrapper_partner_category">
    <cfproperty name="wrapper_partner_subcategory">
    <cfproperty name="wrapper_type">
    <cfproperty name="wrapper_code">
    <cfproperty name="wrapper_description">
    <cfproperty name="wrapper_index">
    <cfproperty name="wrapper_template">
    <cfproperty name="wrapper_css">
    <cfproperty name="wrapper_menu_css">
    <cfproperty name="wrapper_header">
    <cfproperty name="wrapper_footer">
    <cfproperty name="wrapper_left_col">
    <cfproperty name="wrapper_right_col">
    <cfproperty name="wrapper_cover_image">
    <cfproperty name="wrapper_logo">
    <cfproperty name="wrapper_logo_alt_text">
    <cfproperty name="wrapper_logo_link">
    <cfproperty name="wrapper_title">
    <cfproperty name="wrapper_link">
    <cfproperty name="wrapper_custom_subset">
    <cfproperty name="wrapper_custom_title">
    <cfproperty name="wrapper_custom_time">
    <cfproperty name="wrapper_custom_whatithelps">
    <cfproperty name="wrapper_custom_subset2">
    <cfproperty name="wrapper_custom_title2">
    <cfproperty name="wrapper_custom_time2">
    <cfproperty name="wrapper_comprehensive">
    <cfproperty name="wrapper_pda">
    <cfproperty name="wrapper_rx">
    <cfproperty name="wrapper_disaster">
    <cfproperty name="wrapper_pap_custom_name">
    <cfproperty name="wrapper_pap">
    <cfproperty name="wrapper_more_programs">
    <cfproperty name="wrapper_moreprograms_template">
    <cfproperty name="wrapper_afc">
    <cfproperty name="wrapper_external">
    <cfproperty name="wrapper_external_title">
    <cfproperty name="wrapper_external_title_graphic">
    <cfproperty name="wrapper_external_text">
    <cfproperty name="wrapper_external_time">
    <cfproperty name="wrapper_external_link">
    <cfproperty name="wrapper_optional_box_text">
    <cfproperty name="wrapper_status">
    <cfproperty name="wrapper_deployment_status">
    <cfproperty name="wrapper_get_started_now">
    <cfproperty name="wrapper_bcu_logo">
    <cfproperty name="wrapper_bcu_logo_alt_text">
    <cfproperty name="wrapper_bcu_link">
    <cfproperty name="wrapper_checksum">
    <cfproperty name="wrapper_changes">
    <cfproperty name="wrapper_logo_margin_top">
    <cfproperty name="wrapper_logo_margin_right">
    <cfproperty name="wrapper_menu">
    <cfproperty name="wrapper_top_menu">
    <cfproperty name="wrapper_footer_custom">
    <cfproperty name="wrapper_printed_text">
    <cfproperty name="wrapper_menu_ie_css">
    <cfproperty name="wrapper_additional_css">
    <cfproperty name="wrapper_special_link">
    <cfproperty name="wrapper_special_text">
    <cfproperty name="wrapper_special">
    <cfproperty name="wrapper_tag1">
    <cfproperty name="wrapper_tag2">
    <cfproperty name="wrapper_tag3">
    <cfproperty name="wrapper_custom_js">
    <cfproperty name="wrapper_lis_link_direct">
    <cfproperty name="wrapper_pap_whatithelps">
    <cfproperty name="wrapper_cover_image_alt_text">
    <cfproperty name="TEST5">
    <cfproperty name="wrapper_risk_calculator">
    <cfproperty name="wrapper_show_header">
    <cfproperty name="wrapper_show_footer">
    <cfproperty name="wrapper_left_col_ad">
    <cfproperty name="wrapper_menu_ad">
    <cfproperty name="wrapper_as_of">
    <cfproperty name="wrapper_bcu_text_logo">
    <cfproperty name="wrapper_menu_ad_html">
    <cfproperty name="wrapper_left_col_ad_html">
    <cfproperty name="wrapper_iframe">
    <cfproperty name="wrapper_afc_popup">
    <cfproperty name="wrapper_needed_title">
    <cfproperty name="wrapper_screening_order">
    <cfproperty name="wrapper_whatithelps">
</cfcomponent>