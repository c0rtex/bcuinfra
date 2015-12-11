<!---
	Template Name: HelpEntity
	Component Purpose: Component mapped to database table help via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: help

--->

<cfcomponent persistent="true" entityname="help" table="help">
    <cfproperty name="id" fieldtype="id" column="help_id">
    <cfproperty name="type" fieldtype="many-to-one" fkcolumn="helptype_id" cfc="help_type">
    <cfproperty name="code" column="help_code">
    <cfproperty name="keyword">
    <cfproperty name="title_display" fieldtype="many-to-one" fkcolumn="title_display_id" cfc="display">
    <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
</cfcomponent>