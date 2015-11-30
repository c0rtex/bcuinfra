<cfcomponent persistent="true" entityname="event_handler" table="event_handler">
  <cfproperty name="id" fieldtype="id" column="event_handler_id">
  <cfproperty name="event" fieldtype="many-to-one" fkcolumn="event_id" cfc="event">
  <cfproperty name="answer_field" fieldtype="many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
  <cfproperty name="handler">
</cfcomponent>
