<cfcomponent persistent="true" entityname="program_answer_field" table="program_answerfield">
    <cfproperty name="answer_field" fieldtype="id,many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
    <cfproperty name="program" fieldtype="id,many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="rule_flag">
</cfcomponent>