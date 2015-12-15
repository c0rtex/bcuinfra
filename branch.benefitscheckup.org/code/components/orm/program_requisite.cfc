<cfcomponent persistent="true" entityname="program_requisite" table="program_requisite">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="requisite" fieldtype="id,many-to-one" fkcolumn="requisite_id" cfc="requisite">
    <cfproperty name="sort">
</cfcomponent>