<!---
	Template Name: FormTagEntity
	Component Purpose: Component mapped to database table formtag via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: formtag

--->

<cfcomponent persistent="true" entityname="form_tag" table="formtag">
    <cfproperty name="id" fieldtype="id" column="formtag_id">
    <cfproperty name="form_class" fieldtype="many-to-one" fkcolumn="formclass_id" cfc="form_class">
    <cfproperty name="name" column="tag_name">
</cfcomponent>