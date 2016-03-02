<!---
	Template Name: ProgramEntity
	Component Purpose: Component mapped to database table program via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: program

--->

<cfcomponent persistent="true" entityname="program" table="program" extends="ToStructConverter">
	<cfproperty name="id" fieldtype="id" column="program_id">
	<cfproperty name="program_category" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="programcategory_id" cfc="program_category">
	<cfproperty name="program_group" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="programgroup_id" cfc="program_group">
	<cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="state">
	<cfproperty name="code" column="program_code">
	<cfproperty name="name_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="name_display_id" cfc="display">
	<cfproperty name="desc_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="desc_display_id" cfc="display">
	<cfproperty name="url">
	<cfproperty name="exclude_flag">
	<cfproperty name="significant_flag">
	<cfproperty name="active_flag">
	<cfproperty name="funder" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="funder_id" cfc="funder">
	<cfproperty name="reference" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="reference_id" cfc="reference">
	<cfproperty name="last_update">
	<cfproperty name="notes">
	<cfproperty name="supersort">
	<cfproperty name="sort">
	<cfproperty name="legacy_prg_id">
	<cfproperty name="legacy_pri_sec">
</cfcomponent>