<!---
	Template Name: ProgramFormEntity
	Component Purpose: Component mapped to database table program_form via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: program_form

--->

<cfcomponent persistent="true" entityname="program_form" table="program_form" extends="ToStructConverter">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="form" fieldtype="id,many-to-one" fkcolumn="form_id" cfc="form">
    <cfproperty name="sort">
    <cfproperty name="formula">
</cfcomponent>