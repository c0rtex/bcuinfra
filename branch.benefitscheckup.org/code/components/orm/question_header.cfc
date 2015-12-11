<!---
	Template Name: QuestionHeaderEntity
	Component Purpose: Component mapped to database table questionheader via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: questionheader

--->

<cfcomponent persistent="true" entityname="question_header" table="questionheader">
	<cfproperty name="id" fieldtype="id" column="questionheader_id">
	<cfproperty name="code">
	<cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
	<cfproperty name="question_category" fieldtype="many-to-one" fkcolumn="questioncategory_id" cfc="question_category">
	<cfproperty name="description">
</cfcomponent>