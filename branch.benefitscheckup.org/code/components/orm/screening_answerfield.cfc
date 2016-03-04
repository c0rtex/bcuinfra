<!---
	Template Name: ScreeningAnswerfieldEntity
	Component Purpose: Component mapped to database table address via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: Screening_answerfield

--->

<cfcomponent persistent="true" entityname="screening_answerfield" table="screening_answerfield" extends="ToStructConverter">
    <cfproperty name="screening" fieldtype="id,many-to-one" fkcolumn="screening_id" cfc="screening">
    <cfproperty name="answer" fieldtype="id,many-to-one" fkcolumn="answerfield_id" cfc="answer_field">
    <cfproperty name="response_type" column="responsetype">
    <cfproperty name="response" tostruct="response">
    <cfproperty name="option" tostructcomponent="option" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="option_id" cfc="Option">
    <cfproperty name="page_num" column="pagenum">
    <cfproperty name="retained_flag">
    <cfproperty name="derived_flag">
    <cfproperty name="approximation_flag">
    <cfproperty name="submit_datetime">
    <cfproperty name="encryption_flag">
    <cfproperty name="encrypted_response">
    <cfproperty name="validation_response">
</cfcomponent>