<!---
	Template Name: ProgramRuleEntity
	Component Purpose: Component mapped to database table program_rule via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: program_rule

--->

<cfcomponent persistent="true" entityname="program_rule" table="program_rule" extends="ToStructConverter">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="rule" fieldtype="id,many-to-one" fkcolumn="rule_id" cfc="rule">
    <cfproperty name="sort">
</cfcomponent>