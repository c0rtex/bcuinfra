<!---
	Template Name: ScreeningEntity
	Component Purpose: Component mapped to database table address via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: Screening

--->

<cfcomponent persistent="true" entityname="screening" table="screening" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="screening_id" generator="increment">
    <cfproperty name="prev_screening" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="prev_screening_id" cfc="Screening">
    <cfproperty name="cfid">
    <cfproperty name="cftoken">
    <cfproperty name="source" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="source_id" cfc="Source">
    <cfproperty name="org_id">
    <cfproperty name="partner" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="partner_id" cfc="partner">
    <cfproperty name="subset" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="subset_id" cfc="subset">
	<cfproperty name="language" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="language_id" cfc="language">
	<cfproperty name="access_id">
	<cfproperty name="client_id">
	<cfproperty name="user" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="user_id" cfc="user">
	<cfproperty name="preset_state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="preset_state_id" cfc="state">
	<cfproperty name="test_flag">
	<cfproperty name="start_datetime">
	<cfproperty name="end_datetime">
</cfcomponent>