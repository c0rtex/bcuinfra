<!---
	Template Name: CountyEntity
	Component Purpose: Component mapped to database table state via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: county
--->
<cfcomponent persistent="true" entityname="county" table="county" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="county_id">
    <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="State">
    <cfproperty name="name" column="county_name">
    <cfproperty name="valid">
    <cfproperty name="map_id">
    <cfproperty name="update_valid">
</cfcomponent>
