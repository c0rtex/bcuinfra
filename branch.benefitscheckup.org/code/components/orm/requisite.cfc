<!---
	Template Name: RequisiteEntity
	Component Purpose: Component mapped to database table requisite via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: requisite

--->

<cfcomponent persistent="true" entityname="requisite" table="requisite">
    <cfproperty name="id" fkcolumn="id" column="requisite_id">
    <cfproperty name="code">
    <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
    <cfproperty name="def_display" fieldtype="many-to-one" fkcolumn="def_display_id" cfc="display">
    <cfproperty name="description">
</cfcomponent>