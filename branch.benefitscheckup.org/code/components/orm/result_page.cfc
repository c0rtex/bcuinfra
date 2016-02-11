<!---
	Template Name: ResultPageEntity
	Component Purpose: Component mapped to database table address via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: Resultpage

--->

<cfcomponent persistent="true" entityname="result_page" table="resultpage" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="resultpage_id">
    <cfproperty name="code">
    <cfproperty name="file_name" column="filename">
    <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
    <cfproperty name="result_page_name" column="resultpage_desc">
</cfcomponent>