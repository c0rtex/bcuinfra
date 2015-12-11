<!---
	Template Name: EventEntity
	Component Purpose: Component mapped to database table event via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: event

--->

<cfcomponent persistent="true" entityname="event" table="event">
  <cfproperty name="id" fieldtype="id" column="event_id">
  <cfproperty name="code" column="event_code">
</cfcomponent>
