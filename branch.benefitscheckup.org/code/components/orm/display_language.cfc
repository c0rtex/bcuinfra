<!---
	Template Name: DisplayLanguageEntity
	Component Purpose: Component mapped to database table display_language via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: display_language

--->

<cfcomponent persistent="true" entityname="display_language" table="display_language">
    <cfproperty name="display_id" fieldtype="id">
    <cfproperty name="language_id" fieldtype="id">
    <cfproperty name="display_text">
</cfcomponent>