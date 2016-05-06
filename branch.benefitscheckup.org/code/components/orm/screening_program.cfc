<!---
	Template Name: ScreeningProgramEntity
	Component Purpose: Component mapped to database table subset_program via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: screening_program

!--->

<cfcomponent persistent="true" entityname="screening_program" table="screening_program" extends="ToStructConverter">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="screening" fieldtype="id,many-to-one" fkcolumn="screening_id" cfc="screening">
    <cfproperty name="unseen_flag">
    <cfproperty name="buffer_flag">
    <cfproperty name="maybe_flag">
</cfcomponent>
