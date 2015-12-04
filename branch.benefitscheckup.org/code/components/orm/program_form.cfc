<cfcomponent persistent="true" entityname="program_form" table="program_form">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="form" fieldtype="id,many-to-one" fkcolumn="form_id" cfc="form">
    <cfproperty name="sort">
    <cfproperty name="formula">
</cfcomponent>