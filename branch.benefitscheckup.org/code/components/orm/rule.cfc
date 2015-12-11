<!---
	Template Name: RuleEntity
	Component Purpose: Component mapped to database table rule via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.

	Data Tables: rule

--->

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