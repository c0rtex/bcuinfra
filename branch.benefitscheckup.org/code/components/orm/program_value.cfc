<!---
	Template Name: ProgramValueEntity
	Component Purpose: Component mapped to database table programvalue via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: programvalue

--->

<cfcomponent persistent="true" entityname="program_value" table="programvalue" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="programvalue_id">
    <cfproperty name="program" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="program_id" cfc="program">
    <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="state">
    <cfproperty name="dollar_value" column="dollarvalue">
    <cfproperty name="start_date">
    <cfproperty name="end_date">
    <cfproperty name="rule_text">
</cfcomponent>