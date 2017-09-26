<!---
	Template Name: SubsetEntity
	Component Purpose: Component mapped to database table address via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: Subset

--->

<cfcomponent persistent="true" entityname="subset" table="subset" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" tostruct="id" column="subset_id">
    <cfproperty name="type" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="subsettype_id" cfc="subset_type">
    <cfproperty name="code">
    <cfproperty name="description">
    <cfproperty name="display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="display_id" cfc="display">
    <cfproperty name="alt_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="alt_display_id" cfc="display">
    <cfproperty name="spq_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="spq_display_id" cfc="display">
    <cfproperty name="oe_name">
    <cfproperty name="intro_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="intro_display_id" cfc="display">
    <cfproperty name="result_page" tostructcomponent="resultpage" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="resultpage_id" cfc="result_page">
    <cfproperty name="shadow_subset" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="shadow_subset_id" cfc="subset">
    <cfproperty name="branding_partner" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="branding_partner_id" cfc="partner">
    <cfproperty name="active_flag">
    <cfproperty name="test_flag">
    <cfproperty name="eform_flag">
    <cfproperty name="report_flag">
    <cfproperty name="create_user" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="create_user_id" cfc="user">
    <cfproperty name="create_date">
    <cfproperty name="modify_user" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="modify_user_id" cfc="user">
    <cfproperty name="modify_date">
</cfcomponent>