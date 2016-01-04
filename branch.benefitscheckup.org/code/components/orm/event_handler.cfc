<!---
	Template Name: EventHandlerEntity
	Component Purpose: Component mapped to database table event_handler via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: event_handler

--->

<cfcomponent persistent="true" entityname="event_handler" table="event_handler" extends="ToStructConverter">
  <cfproperty name="id" fieldtype="id" column="event_handler_id">
  <cfproperty name="event" fieldtype="many-to-one" fkcolumn="event_id" cfc="event">
  <cfproperty name="answer_field" fieldtype="many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
  <cfproperty name="handler">
</cfcomponent>
