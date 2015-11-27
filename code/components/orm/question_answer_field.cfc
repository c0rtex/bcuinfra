<cfcomponent persistent="true" entityname="question_answer_field" table="question_answerfield">
    <cfproperty name="id" fieldtype="id">
    <cfproperty name="answer" fieldtype="many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="rule" fieldtype="many-to-one" fkcolumn="rule_id" cfc="rule">
    <cfproperty name="sort">

</cfcomponent>