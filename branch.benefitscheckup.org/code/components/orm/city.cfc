<!---
	Template Name: CityEntity
	Component Purpose: Component mapped to database table state via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: city
--->
<cfcomponent persistent="true" entityname="city" table="city" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="city_id">
    <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="State">
    <cfproperty name="pref_city_id">
    <cfproperty name="city_name">
    <cfproperty name="exclude_flag">
    <cfproperty name="valid">
    <cfproperty name="county" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="county_id" cfc="County">
    <cfproperty name="update_valid">
</cfcomponent>
