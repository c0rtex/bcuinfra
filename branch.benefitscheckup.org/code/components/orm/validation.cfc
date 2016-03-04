<!---
	Template Name: ValidationEntity
	Component Purpose: Component mapped to database table validation via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: validation

--->

<cfcomponent persistent="true" entityname="validation" table="validation" extends="ToStructConverter">
  <cfproperty name="id" fieldtype="id" column="validation_id">
  <cfproperty name="code" column="validation_code">
  <cfproperty name="formula">
  <cfproperty name="display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="display_id" cfc="display">
  <cfproperty name="description" column="validation_desc">
</cfcomponent>