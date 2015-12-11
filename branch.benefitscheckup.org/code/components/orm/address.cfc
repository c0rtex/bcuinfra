<!---
	Template Name: AddressEntity
	Component Purpose: Component mapped to database table address via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: Address

--->

<cfcomponent persistent="true" entityname="address" table="address">
	<cfproperty name="id" fieldtype="id">
	<cfproperty name="street">
	<cfproperty name="city">
	<cfproperty name="state">
	<cfproperty name="zip">
</cfcomponent>