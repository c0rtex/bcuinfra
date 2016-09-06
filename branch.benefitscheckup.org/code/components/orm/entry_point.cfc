<!---
	Template Name: EntrypointEntity
	Component Purpose: Component mapped to database table entrypoint via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: entrypoint

--->

<cfcomponent persistent="true" entityname="entry_point" table="entrypoint" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id" column="entrypoint_id">
    <cfproperty name="code">
    <cfproperty name="name">
    <cfproperty name="sub_name" column="subname">
    <cfproperty name="address1">
    <cfproperty name="address2">
    <cfproperty name="address3">
    <cfproperty name="city">
    <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="state">
    <cfproperty name="zipcode">
    <cfproperty name="zipcode_plus4">
    <cfproperty name="email">
    <cfproperty name="url">
    <cfproperty name="hours_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="hours_display_id" cfc="display">
    <cfproperty name="info_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="info_display_id" cfc="display">
    <cfproperty name="contact_title">
    <cfproperty name="contact_first">
    <cfproperty name="contact_middle">
    <cfproperty name="contact_last">
    <cfproperty name="contact_suffix">
    <cfproperty name="privatephone">
    <cfproperty name="active_flag">
    <cfproperty name="notes">
    <cfproperty name="view_zip_distance" fieldtype="many-to-one" update="false" insert="false" fkcolumn="zipcode" inversejoincolumn="start_zipcode" cfc="view_zip_distance">
    <cfproperty name="counties" fieldtype="many-to-many" linktable="entrypoint_county" fkcolumn="entrypoint_id" inversejoincolumn="county_id" cfc="county">
    <cfproperty name="cities" fieldtype="many-to-many" linktable="entrypoint_city" fkcolumn="entrypoint_id" inversejoincolumn="city_id" cfc="city">
    <cfproperty name="zips" fieldtype="many-to-many" linktable="entrypoint_zip" fkcolumn="entrypoint_id" inversejoincolumn="zipcode" cfc="zip">
    <cfproperty name="phones" fieldtype="one-to-many" fkcolumn="entrypoint_id" cfc="phone">
</cfcomponent>