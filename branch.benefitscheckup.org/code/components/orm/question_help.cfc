<cfcomponent persistent="true" entityname="question_help" table="question_help">
    <cfproperty name="question_id" fieldtype="id">
    <cfproperty name="help" fieldtype="id,many-to-one" fkcolumn="help_id" cfc="help">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="rule" fieldtype="many-to-one" fkcolumn="rule_id" cfc="rule">
    <cfproperty name="sort">
</cfcomponent>