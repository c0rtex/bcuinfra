<!---
	Template Name: ProximityEntity
	Component Purpose: Component mapped to database table proximity via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: proximity

--->

<cfcomponent persistent="true" entityname="proximity" table="proximity" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="proximity_id">
    <cfproperty name="code">
    <cfproperty name="description">
</cfcomponent>