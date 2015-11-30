<cfcomponent persistent="true" entityname="validation" table="validation">
  <cfproperty name="id" fieldtype="id" column="validation_id">
  <cfproperty name="code" column="validation_code">
  <cfproperty name="formula">
  <cfproperty name="display" fieldtype="many-to-one" fkcolumn="display_id" cfc="display">
  <cfproperty name="description" column="validation_desc">
</cfcomponent>