<!---
	Template Name: QuestionHelpEntity
	Component Purpose: Component mapped to database table question_help via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: question_help

--->

<cfcomponent persistent="true" entityname="question_help" table="question_help">
    <cfproperty name="question_id" fieldtype="id">
    <cfproperty name="help" fieldtype="id,many-to-one" fkcolumn="help_id" cfc="help">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="rule" fieldtype="many-to-one" fkcolumn="rule_id" cfc="rule">
    <cfproperty name="sort">
</cfcomponent>