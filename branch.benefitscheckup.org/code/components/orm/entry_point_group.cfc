<!---
	Template Name: EntrypointgroupEntity
	Component Purpose: Component mapped to database table entrypointgroup via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: entrypointgroup

--->

<cfcomponent persistent="true" entityname="entry_point_group" table="entrypointgroup">
    <cfproperty name="id" fieldtype="id" column="entrypointgroup_id">
    <cfproperty name="name">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="active_flag">
    <cfproperty name="notes">
</cfcomponent>