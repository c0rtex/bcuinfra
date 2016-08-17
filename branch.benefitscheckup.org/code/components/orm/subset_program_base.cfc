<!---
	Template Name: SubsetProgramBaseEntity
	Component Purpose: Component mapped to database table subset_program via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: subset_program_base

!--->

<cfcomponent persistent="true" entityname="subset_program_base" table="subset_program_base" extends="ToStructConverter">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="subset" fieldtype="id,many-to-one" fkcolumn="subset_id" cfc="subset">
	<cfproperty name="subset_program_sum" fieldtype="one-to-many" missingRowIgnored="true" fkcolumn="program_id,subset_id" inversejoincolumn="program_id,subset_id" cfc="subset_program_sum">
</cfcomponent>
