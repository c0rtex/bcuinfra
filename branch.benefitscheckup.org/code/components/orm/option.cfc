<!---
	Template Name: OptionEntity
	Component Purpose: Component mapped to database table option via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: option

--->

<cfcomponent persistent="true" entityname="option" table="option"  extends="ToStructConverter">
    <cfproperty name="id" tostruct="id" fieldtype="id" column="option_id">
    <cfproperty name="code" tostruct="code" column="option_code">
    <cfproperty name="display" tostructdisplay="display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="display_id" cfc="display">
    <cfproperty name="include_flag">
</cfcomponent>