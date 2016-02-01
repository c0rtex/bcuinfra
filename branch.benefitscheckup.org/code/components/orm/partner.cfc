<!---
	Template Name: PartnerEntity
	Component Purpose: Component mapped to database table address via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: tbl_partner

--->

<cfcomponent persistent="true" entityname="partner" table="tbl_partner" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="partner_id">
    <cfproperty name="code" column="partner_code">
    <cfproperty name="name" column="partner_name">
    <cfproperty name="url" column="partner_url">
    <cfproperty name="alt_name">
    <cfproperty name="type" fieldtype="many-to-one" fkcolumn="partnertype_id" cfc="partner_type">
    <cfproperty name="bcu_display" fieldtype="many-to-one" fkcolumn="bcu_display_id" cfc="display">
    <cfproperty name="partner_wrapper">
    <cfproperty name="partner_header">
    <cfproperty name="partner_footer">
    <cfproperty name="partner_css">
    <cfproperty name="partner_titlebar">
    <cfproperty name="wrapper" fieldtype="many-to-one" fkcolumn="wrapper_id" cfc="wrapper">
    <cfproperty name="cms_doc_no">
    <cfproperty name="login_only_flag">
    <cfproperty name="report_flag">
    <cfproperty name="learn_flag">
    <cfproperty name="race_flag">
    <cfproperty name="hispanic_flag">
    <cfproperty name="links_flag">
    <cfproperty name="pdf_logo_flag">
    <cfproperty name="notes">
    <cfproperty name="demo">
    <cfproperty name="parent">
</cfcomponent>