<!---
	Template Name: PhoneEntity
	Component Purpose: Component mapped to database table help via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: phone

--->

<cfcomponent persistent="true" entityname="phone" table="phone" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="phone_id">
    <cfproperty name="entry_point" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="entrypoint_id" cfc="entry_point">
    <cfproperty name="phone_type" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="phonetype_id" cfc="phone_type">
    <cfproperty name="number">
    <cfproperty name="sort">
</cfcomponent>