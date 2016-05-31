<!---
	Template Name: FormEntity
	Component Purpose: Component mapped to database table form via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: form

--->

<cfcomponent persistent="true" entityname="form" table="form" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="form_id">
    <cfproperty name="form_tag" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="formtag_id" cfc="form_tag">
    <cfproperty name="name" column="form_name">
    <cfproperty name="description">
	<cfproperty name="form_form_types" fieldtype="one-to-many" cfc="form_form_type" fkcolumn="form_id" inversejoincolumn="form_id">
    <cfproperty name="program_forms" fieldtype="one-to-many" cfc="program_form" fkcolumn="form_id" inversejoincolumn="form_id">
	<cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="state">
</cfcomponent>