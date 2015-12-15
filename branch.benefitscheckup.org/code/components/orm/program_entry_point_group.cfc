<cfcomponent persistent="true" entityname="program_entry_point_group" table="program_entrypointgroup">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="entry_point_group" fieldtype="id,many-to-one" fkcolumn="entrypointgroup_id" cfc="entry_point_group">
    <cfproperty name="sort">
</cfcomponent>