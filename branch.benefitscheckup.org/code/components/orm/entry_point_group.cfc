<cfcomponent persistent="true" entityname="entry_point_group" table="entrypointgroup">
    <cfproperty name="id" fieldtype="id" column="entrypointgroup_id">
    <cfproperty name="name">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="active_flag">
    <cfproperty name="notes">
</cfcomponent>