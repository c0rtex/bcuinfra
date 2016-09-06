<!---
	Template Name: ViewZipDistanceEntity
	Component Purpose: Component mapped to database table entrypoint via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: view_zip_distance

--->

<cfcomponent persistent="true" entityname="view_zip_distance" table="view_zip_distance" extends="ToStructConverter">
    <cfproperty name="start_zipcode" fieldtype="id">
    <cfproperty name="start_state_id" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="start_state_id" cfc="state">
    <cfproperty name="end_zipcode">
    <cfproperty name="end_state_id" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="end_state_id" cfc="state">
	<cfproperty name="distance">
</cfcomponent>