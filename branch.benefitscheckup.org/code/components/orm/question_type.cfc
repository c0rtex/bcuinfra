<!---
	Template Name: QuestionTypeEntity
	Component Purpose: Component mapped to database table questiontype via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: questiontype

--->

<cfcomponent persistent="true" entityname="question_type" table="questiontype">
	<cfproperty name="id" fieldtype="id" column="questiontype_id">
	<cfproperty name="code">
	<cfproperty name="name">
	<cfproperty name="description">
</cfcomponent>