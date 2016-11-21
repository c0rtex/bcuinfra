<!---
	Template Name: AnswerFieldRelationship
	Component Purpose: Component mapped to database table answerfield via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: answerfield_relationship

--->

<cfcomponent persistent="true" entityname="answer_field_relationship" table="answerfield_relationship" extends="ToStructConverter">
    <cfproperty name="left_answerfield" fieldtype="many-to-one,id" fkcolumn="left_answerfield_id" cfc="answer_field">
    <cfproperty name="right_answerfield" fieldtype="many-to-one,id" fkcolumn="right_answerfield_id" cfc="answer_field">
    <cfproperty name="relationship_id">
</cfcomponent>