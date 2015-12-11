<!---
	Template Name: EntrypointEntrypointgroupEntity
	Component Purpose: Component mapped to database table entrypoint_entrypointgroup via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: entrypoint_entrypointgroup

--->

<cfcomponent persistent="true" entityname="entry_point_entry_point_group" table="entrypoint_entrypointgroup">
    <cfproperty name="entry_point" fieldtype="id,many-to-one" fkcolumn="entrypoint_id" cfc="entry_point">
    <cfproperty name="entry_point_group" fieldtype="id,many-to-one" fkcolumn="entrypointgroup_id" cfc="entry_point_group">
</cfcomponent>