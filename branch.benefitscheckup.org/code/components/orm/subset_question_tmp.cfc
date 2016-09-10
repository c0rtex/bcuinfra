<!---
	Template Name: SubsetQuestionTmpEntity
	Component Purpose: Component mapped to database table subset_program via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: subset_question_tmp

!--->

<cfcomponent persistent="true" entityname="subset_question_tmp" table="subset_question_tmp" extends="ToStructConverter">
  <cfproperty name="id" fieldtype="id">
  <cfproperty name="subset" fieldtype="many-to-one" fkcolumn="subset_id" cfc="subset">
  <cfproperty name="question" fieldtype="many-to-one" fkcolumn="question_id" cfc="question">
  <cfproperty name="page_id">
  <cfproperty name="required_flag">
  <cfproperty name="exclude_flag">
  <cfproperty name="options_flag">
  <cfproperty name="sort">
  <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state" missingRowIgnored="true">
</cfcomponent>
