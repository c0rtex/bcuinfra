<!---
	Template Name: AnswerFieldOptionEntity
	Component Purpose: Component mapped to database table answerfield_option via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: answerfield_option

--->

<cfcomponent persistent="true" entityname="answer_field_option" table="answerfield_option">
    <cfproperty name="answerfield_id" fieldtype="id">
    <cfproperty name="option" fieldtype="id,many-to-one" fkcolumn="option_id" cfc="option">
    <cfproperty name="sort">
</cfcomponent>