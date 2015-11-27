<cfcomponent persistent="true" entityname="program_value" table="programvalue">
    <cfproperty name="id" fieldtype="id" column="programvalue_id">
    <cfproperty name="program" fieldtype="many-to-one" fkcolumn="program_id" cfc="program">
    <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
    <cfproperty name="dollar_value" column="dollarvalue">
    <cfproperty name="start_date">
    <cfproperty name="end_date">
    <cfproperty name="rule_text">
</cfcomponent>