<!---
	Template Name: FormClassEntity
	Component Purpose: Component mapped to database table formclass via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: formclass

--->

<cfcomponent persistent="true" entityname="form_class" table="formclass" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="formclass_id">
    <cfproperty name="code" column="class_code">
    <cfproperty name="name" column="class_name">
</cfcomponent>