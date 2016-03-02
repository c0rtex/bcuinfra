<!---
	Template Name: QuestionCategoryEntity
	Component Purpose: Component mapped to database table questioncategory via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: questioncategory

--->

<cfcomponent persistent="true" entityname="question_category" table="questioncategory" extends="ToStructConverter">
	<cfproperty name="id" fieldtype="id" column="questioncategory_id">
	<cfproperty name="display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="display_id" cfc="display">
	<cfproperty name="code" tostruct="category" column="questioncategory_code">
	<cfproperty name="description" column="questioncategory_desc">
	<cfproperty name="sort">
	<cfproperty name="alt" column="alt_title">
</cfcomponent>