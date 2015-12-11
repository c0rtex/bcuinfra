<!---
	Template Name: QuestionAnswerfieldEntity
	Component Purpose: Component mapped to database table question_answerfield via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: question_answerfield

--->

<cfcomponent persistent="true" entityname="question_answer_field" table="question_answerfield">
    <cfproperty name="id" fieldtype="id">
    <cfproperty name="answer" fieldtype="many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="rule" fieldtype="many-to-one" fkcolumn="rule_id" cfc="rule">
    <cfproperty name="sort">

</cfcomponent>