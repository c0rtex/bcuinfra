<!---
	Template Name: AnswerFieldEntity
	Component Purpose: Component mapped to database table answerfield via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: answerfield

--->

<cfcomponent persistent="true" entityname="answer_field" table="answerfield" extends="ToStructConverter">
  <cfproperty name="id" tostruct="id" fieldtype="id" column="answerfield_id" generator="identity">
  <cfproperty name="answer_field_type" tostructcomponent="" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="answerfieldtype_id" cfc="answer_field_type">
  <cfproperty name="code" tostruct="code" column="answerfield">
  <cfproperty name="display" tostructdisplay="display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="display_id" cfc="display">
  <cfproperty name="short_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="short_display_id" cfc="display">
  <cfproperty name="spq_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="spq_display_id" cfc="display">
  <cfproperty name="print_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="print_display_id" cfc="display">
  <cfproperty name="max_length">
  <cfproperty name="default_value">
  <cfproperty name="spq_default_value">
  <cfproperty name="oe_default_value">
  <cfproperty name="required_flag" tostruct="required">
  <cfproperty name="rule" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="rule_id" cfc="rule">
  <cfproperty name="validation" tostructcomponent="" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="validation_id" cfc="validation">
  <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="state">
  <cfproperty name="description" column="answerfield_desc">
  <cfproperty name="options" tostructarray="options" fieldtype="one-to-many" cfc="answer_field_option" fkcolumn="answerfield_id" lazy="extra" cascade="all" orderby="sort">
  <cfproperty name="programs" fieldtype="many-to-many" cfc="program" linktable="program_answerfield" inversejoincolumn="program_id" fkcolumn="answerfield_id">

  <cffunction name="toStructure">
    <cfset var retVal = super.toStructure()>
    <cfset var options = this.getOptions()>
    <cfset retVal["options"] = arrayNew(1)>
    <cfloop array="#options#" index="op">
      <cfif op.getOption().getInclude_flag() neq 0>
        <cfset arrayAppend(retVal["options"],op.toStructure())>
      </cfif>
    </cfloop>
    <cfreturn retVal>
  </cffunction>

</cfcomponent>