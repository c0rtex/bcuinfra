<!---
	Template Name: StateEntity
	Component Purpose: Component mapped to database table state via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: state

--->

<cfcomponent persistent="true" entityname="state" table="state" extends="ToStructConverter">
	<cfproperty name="id" fieldtype="id" column="state_id">
	<cfproperty name="state_type" fieldtype="many-to-one" fkcolumn="statetype_id" cfc="state_type">
	<cfproperty name="name" tostruct="state" column="state_name">
	<cfproperty name="map_code" column="state_map_code">
	<cfproperty name="map_code_2" column="state_map_code2">
</cfcomponent>