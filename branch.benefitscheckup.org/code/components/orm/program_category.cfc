<!---
	Template Name: ProgramCategoryEntity
	Component Purpose: Component mapped to database table programcategory via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: programcategory

--->

<cfcomponent persistent="true" entityname="program_category" table="programcategory" extends="ToStructConverter">
	<cfproperty name="id" fieldtype="id" column="programcategory_id">
	<cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
	<cfproperty name="code">
	<cfproperty name="description">
	<cfproperty name="legacy_code">
	<cfproperty name="sort">
</cfcomponent>