<!---
	Template Name: ProgramAnswerfieldEntity
	Component Purpose: Component mapped to database table program_answerfield via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: program_answerfield

--->

<cfcomponent persistent="true" entityname="program_answer_field" table="program_answerfield">
    <cfproperty name="answer_field" fieldtype="id,many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="rule_flag">
</cfcomponent>