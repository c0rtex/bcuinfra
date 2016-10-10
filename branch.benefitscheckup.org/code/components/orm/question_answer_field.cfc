<!---
	Template Name: QuestionAnswerfieldEntity
	Component Purpose: Component mapped to database table question_answerfield via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: question_answerfield

--->

<cfcomponent persistent="true" entityname="question_answer_field" table="question_answerfield" extends="ToStructConverter">
    <cfproperty name="id" fieldtype="id">
    <cfproperty name="answer" tostructcomponent="" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="answerfield_id" cfc="answer_field">
	<cfproperty name="question" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="question_id" cfc="question">
    <cfproperty name="state" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="state_id" cfc="state">
    <cfproperty name="rule" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="rule_id" cfc="rule">
    <cfproperty name="sort" tostruct="sort">

	<!---<cffunction name="toStructure">
		<cfargument name="prev_id" type="numeric" default="-1">
		<cfset qaf = super.toStructure()>
		<cfif prev_id GREATER THAN -1>
			<cfset cf=ormExecuteQuery("from screening_answerfield as saf where saf.answer.id=#this.getAnswer().getId()# and saf.screening.id=#prev_id#")>
			<cfif arraylen(cf) neq 0>
				<cfset qaf["prev"]=cf[1].toStructure()>
			</cfif>
		</cfif>
		<cfreturn qaf>
	</cffunction>--->

</cfcomponent>