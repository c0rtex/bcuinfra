<!---
	Template Name: AnswerFieldSubsetPartnerEntity
	Component Purpose: Component mapped to database table entrypoint via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: answerfield_subset_partner

--->

<cfcomponent persistent="true" entityname="answer_field_subset_partner" table="answerfield_subset_partner" extends="ToStructConverter">
  <cfproperty name="answer_field" fieldtype="id,many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
  <cfproperty name="subset" fieldtype="id,many-to-one" fkcolumn="subset_id" cfc="subset">
  <cfproperty name="partner" fieldtype="id,many-to-one" fkcolumn="partner_id" cfc="partner">
  <cfproperty name="default_value">
  <cfproperty name="background_flag">

  <cffunction name="isDifferent">
    <cfargument name="subset_id">
    <cfargument name="partner_id">
    <cfset afsp=ormExecuteQuery("from answer_field_subset_partner afsp where afsp.subset.id=#subset_id# and afsp.partner.id<>#partner_id#")>
    <cfreturn arraylen(afsp) neq 0>
  </cffunction>
</cfcomponent>