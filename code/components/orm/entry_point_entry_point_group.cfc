<cfcomponent persistent="true" entityname="entry_point_entry_point_group" table="entrypoint_entrypointgroup">
    <cfproperty name="entry_point" fieldtype="id,many-to-one" fkcolumn="entrypoint_id" cfc="entry_point">
    <cfproperty name="entry_point_group" fieldtype="id,many-to-one" fkcolumn="entrypointgroup_id" cfc="entry_point_group">
</cfcomponent>