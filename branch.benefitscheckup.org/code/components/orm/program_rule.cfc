<cfcomponent persistent="true" entityname="program_rule" table="program_rule">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="rule" fieldtype="id,many-to-one" fkcolumn="rule_id" cfc="rule">
    <cfproperty name="sort">
</cfcomponent>