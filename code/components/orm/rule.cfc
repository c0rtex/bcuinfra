<cfcomponent persistent="true" entityname="rule" table="rule">
	<cfproperty name="id" fieldtype="id" column="rule_id">
	<cfproperty name="code">
	<cfproperty name="description">
	<cfproperty name="rule_text">
	<cfproperty name="rx_program" fieldtype="many-to-one" fkcolumn="rx_program_id" cfc="program">
	<cfproperty name="legacy_pri_sec">
	<cfproperty name="rule_text_mqc">
	<cfproperty name="rule_type">
	<cfproperty name="rule_answerfield_type">
	<cfproperty name="ruling_question_code">
	<cfproperty name="ruled_fields">
</cfcomponent>