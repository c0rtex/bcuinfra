<cfcomponent persistent="true" entityname="answer_field" table="answerfield">
  <cfproperty name="id" fieldtype="id" column="answerfield_id">
  <cfproperty name="answer_field_type" fieldtype="many-to-one" fkcolumn="answerfieldtype_id" cfc="answer_field_type">
  <cfproperty name="code" column="answerfield">
  <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
  <cfproperty name="short_display" fieldtype="many-to-one" fkcolumn="short_display_id" cfc="display">
  <cfproperty name="spq_display" fieldtype="many-to-one" fkcolumn="spq_display_id" cfc="display">
  <cfproperty name="print_display" fieldtype="many-to-one" fkcolumn="print_display_id" cfc="display">
  <cfproperty name="max_length">
  <cfproperty name="default_value">
  <cfproperty name="spq_default_value">
  <cfproperty name="oe_default_value">
  <cfproperty name="required_flag">
  <cfproperty name="rule" fieldtype="many-to-one" fkcolumn="rule_id" cfc="rule">
  <cfproperty name="validation" fieldtype="many-to-one" fkcolumn="validation_id" cfc="validation">
  <cfproperty name="state" fieldtype="many-to-one" fkcolumn="state_id" cfc="state">
  <cfproperty name="description" column="answerfield_desc">
  <cfproperty name="event_handlers" fieldtype="one-to-many" cfc="event_handler" fkcolumn="answerfield_id" lazy="extra" cascade="all">
  <cfproperty name="options" fieldtype="one-to-many" cfc="answer_field_option" fkcolumn="answerfield_id" lazy="extra" cascade="all" orderby="sort">
</cfcomponent>