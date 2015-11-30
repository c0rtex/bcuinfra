<cfcomponent persistent="true" entityname="program_proximity" table="program_proximity">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="proximity" fieldtype="id,many-to-one" fkcolumn="proximity_id" cfc="proximity">
    <cfproperty name="sort">
</cfcomponent>