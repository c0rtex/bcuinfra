<!---
	Template Name: QuestionEntity
	Component Purpose: Component mapped to database table question via object relation mapping framework.
					   Each property of component defines mapping to database table column by using attribute column.
					   If this attribute isn't defined, than property name set in attribute name equals to database column name.
					   Fieldtype attribute defines primary (id) or foreign (many-to-one, one-to-many) key.
					   For mapped foreign key fkcolumn attribute contains database foreign key column name,
					   cfc attribute contains component entity name which mapped to master database table.
					   Component extends from ToStructConverter component for serialization purpose.

	Data Tables: question

--->

<cfcomponent persistent="true" entityname="question" table="question" extends="ToStructConverter">
    <cfproperty name="id" tostruct="id" fieldtype="id" column="question_id">
    <cfproperty name="dep_question" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="dep_question_id" cfc="Question">
    <cfproperty name="code" tostruct="code" column="question_code">
    <cfproperty name="question_category" tostructcomponent="" fieldtype="many-to-one" missingRowIgnored="true"   fkcolumn="questioncategory_id" cfc="question_category">
    <cfproperty name="question_header" tostructcomponent="" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="questionheader_id" cfc="question_header">
    <cfproperty name="question_type" tostructcomponent="" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="questiontype_id" cfc="question_type">
	<cfproperty name="display" tostructdisplay="display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="display_id" cfc="display">
	<cfproperty name="short_display" tostructdisplay="short_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="short_display_id" cfc="display">
	<cfproperty name="spq_display" tostructdisplay="spq_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="spq_display_id" cfc="display">
	<cfproperty name="print_display" tostructdisplay="print_display" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="print_display_id" cfc="display">
	<cfproperty name="format" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="format_id" cfc="format">
	<cfproperty name="rule" tostructcomponent="" fieldtype="many-to-one" missingRowIgnored="true" fkcolumn="rule_id" cfc="rule">
	<cfproperty name="include_flag">
	<cfproperty name="exclude_flag">
	<cfproperty name="suppress_qno_flag">
	<cfproperty name="spq_exclude_flag">
	<cfproperty name="sort" tostruct="sort">
	<cfproperty name="answer_fields" fieldtype="one-to-many" cfc="question_answer_field" fkcolumn="question_id" lazy="extra" cascade="all" orderby="sort">
	<cfproperty name="helps" tostructarray="helps" fieldtype="one-to-many" cfc="question_help" fkcolumn="question_id" lazy="extra" cascade="all" orderby="sort">

<!---
  Inherited toStructure method defined in parent method ToStructConverter. Filter questions answer fields based on passed state, subset and partner
--->

	<cffunction name="toStructure">
		<cfargument name="state_id" type="string" default="">
		<cfargument name="subset_id" type="any" default="0">
		<cfargument name="partner_id" type="any" default="0">

		<cfset retVal = super.toStructure()>

		<cfset retVal["answer_fields"]= arrayNew(1)>

		<cfloop array="#this.getAnswer_fields(state_id=state_id,subset_id=subset_id,partner_id=partner_id)#" index="af">
			<cfset arrayAppend(retVal["answer_fields"],af.toStructure())>
		</cfloop>
		<cfreturn retVal>
	</cffunction>

<!---
  Method returns filtered questions answer fields based on passed state, subset and partner
--->

	<cffunction name="getAnswer_fields">
		<cfargument name="state_id" type="string" default="">
		<cfargument name="subset_id" type="any" default="0">
		<cfargument name="partner_id" type="any" default="0">

		<cfset partnerDiff=CreateObject("component","answer_field_subset_partner").isDifferent(subset_id=subset_id,partner_id=partner_id)>

		<cfquery name="sqavars" datasource="#application.dbSrc#">
		SELECT a.answerfield_id
		FROM question q, question_answerfield qa, (
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
			<cfif partnerDiff>
                or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)				                        </cfif>
            AND background_flag=1
            )
            AND pa.answerfield_id=a.answerfield_id
            AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
			<cfif partnerDiff>
                or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
						</cfif>
            AND background_flag=1
            )
            AND pa.answerfield_id=ar.left_answerfield_id
            AND ar.relationship_id=2
            AND ar.right_answerfield_id=a.answerfield_id
            AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
			<cfif partnerDiff>
                or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)				                        </cfif>
            AND background_flag=1
            )
            AND pa.answerfield_id=a.answerfield_id
            AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #subset_id#
						and ( p.state_id = '#state_id#' or p.state_id is NULL )

					)

			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
			<cfif partnerDiff>
                or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#partner_id#" maxlength="4">)
						</cfif>
            AND background_flag=1
            )
            AND pa.answerfield_id=ar.left_answerfield_id
            AND ar.relationship_id=2
            AND ar.right_answerfield_id=a.answerfield_id
            AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #subset_id#
						and ( p.state_id = '#state_id#' or p.state_id is NULL )

					)

			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM (
				select question_id
				from subset_question sq
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
					and exclude_flag=0
				union
				select question_id
				from question q
				where include_flag=1
					and question_id not in (
						select question_id
						from subset_question sq
						where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#subset_id#" maxlength="4">
							and exclude_flag=1
					)
				) sq, question_answerfield qa, answerfield a
			WHERE sq.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#state_id#" maxlength="2">)
		) AS a
		WHERE q.question_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#this.getId()#" maxlength="100">
				AND q.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
	</cfquery>

	<cfset _in="-1">

	<cfloop query="sqavars">
		<cfset _in="#_in#,#answerfield_id#">
	</cfloop>

	<cfreturn ormExecuteQuery("from question_answer_field as qaf where qaf.answer.id in (#_in#) and qaf.question.id=#this.getId()#  order by sort asc")>
	</cffunction>

</cfcomponent>