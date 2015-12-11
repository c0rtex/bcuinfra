<!---
	Template Name: FunderEntity
	Component Purpose: Component mapped to database table funder via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: funder

--->

<cfcomponent persistent="true" entityname="funder" table="funder">
	<cfproperty name="id" fieldtype="id" column="funder_id">
	<cfproperty name="name">
	<cfproperty name="legacy_code">
</cfcomponent>