<cfcomponent persistent="true" entityname="answer_field_option" table="answerfield_option">
    <cfproperty name="answerfield_id" fieldtype="id">
    <cfproperty name="option" fieldtype="id,many-to-one" fkcolumn="option_id" cfc="option">
    <cfproperty name="sort">
</cfcomponent>