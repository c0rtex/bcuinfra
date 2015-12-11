<!---
	Template Name: ProgramProximityEntity
	Component Purpose: Component mapped to database table program_proximity via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: program_proximity

--->

<cfcomponent persistent="true" entityname="program_proximity" table="program_proximity">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="proximity" fieldtype="id,many-to-one" fkcolumn="proximity_id" cfc="proximity">
    <cfproperty name="sort">
</cfcomponent>