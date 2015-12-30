<!---
	Template Name: DisplayGroupEntity
	Component Purpose: Component mapped to database table displaygroup via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: displaygroup

--->

<cfcomponent persistent="true" entityname="display_group" table="displaygroup" extends="ToStructConverter">
	<cfproperty name="id" fieldtype="id" column="displaygroup_id">
	<cfproperty name="code" column="displaygroup_code">
	<cfproperty name="name" column="displaygroup_name">
	<cfproperty name="description" column="displaygroup_desc">
</cfcomponent>