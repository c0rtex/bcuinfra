<!---
	Template Name: QuestionSet3
	Component Purpose: Implementation of abstract root component for web services, component returns second question set of questionnaire via web service.

	Data Tables: component doesn't use database tables directly

--->

<cfcomponent extends="customQuestionSet">

<!---
  Method returns list of questions id's comma separated.
  This method is used by method geQuestionSet, implemented in parent component
--->

    <cffunction name="getQuestionsId">
        <cfargument name="state_id" type="string" required="no" default="">
        <cfargument name="subset_id" type="numeric" required="no" default="0">
        <cfargument name="partner_id" type="numeric" required="no" default="0">
        <cfargument name="org_id" type="numeric" required="no" default="0">

        <cfquery name="build_array" datasource="#application.dbSrc#">
		SELECT q.question_id
		FROM (
			SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
			FROM (
				SELECT q.question_id, NULL AS page_id
				FROM (
					SELECT pa.answerfield_id
					FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
					WHERE sp.subset_id=#subset_id#

						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#state_id#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#subset_id#
								AND (partner_id is null or partner_id=#partner_id#)
								AND background_flag=1
						)

						AND pa.answerfield_id=a.answerfield_id

						AND (a.state_id IS NULL or a.state_id='#state_id#')

					UNION
					SELECT ar.right_answerfield_id as answerfield_id
					FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
					WHERE sp.subset_id=#subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#state_id#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#subset_id#
								AND (partner_id is null or partner_id=#partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=ar.left_answerfield_id
						AND ar.relationship_id=2
						AND ar.right_answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#state_id#')

					UNION
					SELECT pa.answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
					WHERE sp.subset_id=#subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#state_id#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#subset_id#
								AND (partner_id is null or partner_id=#partner_id#)
								AND background_flag=1
						)

						AND pa.answerfield_id=a.answerfield_id

						AND (a.state_id IS NULL or a.state_id='#state_id#')
						AND pa.program_id in
						(	select  pp.parent_program_id
							from program_parent pp, program p, subset_program_base spb
							where
							spb.program_id = pp.program_id
							and pp.program_id = p.program_id
							and spb.subset_id = #subset_id#
							and ( p.state_id = '#state_id#' or p.state_id is NULL )
						)

					UNION
					SELECT ar.right_answerfield_id as answerfield_id
					FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
					WHERE sp.subset_id=#subset_id#
						AND sp.program_id=p.program_id
						AND (p.state_id IS NULL or p.state_id='#state_id#')
						AND p.active_flag=1
						AND p.program_id=pa.program_id
						AND pa.answerfield_id NOT IN (
							SELECT answerfield_id
							FROM answerfield_subset_partner
							WHERE subset_id=#subset_id#
								AND (partner_id is null or partner_id=#partner_id#)
								AND background_flag=1
						)
						AND pa.answerfield_id=ar.left_answerfield_id
						AND ar.relationship_id=2
						AND ar.right_answerfield_id=a.answerfield_id
						AND (a.state_id IS NULL or a.state_id='#state_id#')
						and pa.program_id in
						(	select  pp.parent_program_id
							from program_parent pp, program p, subset_program_base spb
							where
							spb.program_id = pp.program_id
							and pp.program_id = p.program_id
							and spb.subset_id = #subset_id#
							and ( p.state_id = '#state_id#' or p.state_id is NULL )
						)

				) AS a, question_answerfield qa, question q
				WHERE a.answerfield_id=qa.answerfield_id
						AND <cfif subset_id neq 27 Or partner_id neq 8>qa.question_id NOT IN (
        SELECT question_id
        FROM subset_question
        WHERE subset_id=#subset_id#
            AND exclude_flag=1
            )
            AND </cfif>qa.question_id=q.question_id
        AND q.exclude_flag=0
            <cfif subset_id neq 27 Or partner_id neq 8>UNION
            SELECT q.question_id, sq.page_id
            FROM subset_question sq, question q
            WHERE sq.subset_id=#subset_id#
                AND sq.exclude_flag=0
                AND sq.question_id=q.question_id
            </cfif>UNION
        SELECT q.question_id, NULL AS page_id
        FROM question q
        WHERE q.include_flag=1
        AND q.question_id NOT IN (
        SELECT question_id
        FROM subset_question
        WHERE subset_id=#subset_id#
            AND exclude_flag=1
            )
            ) AS a, question q, questioncategory qc
            WHERE a.question_id=q.question_id
            AND q.questioncategory_id=qc.questioncategory_id
            ) sq, tbl_questions_new q, question qq, questioncategory qc
            WHERE sq.question_id=q.question_id
            AND q.client='self'
            AND q.pri_sec='secdep'
            AND q.type is not null
            AND q.question_id=qq.question_id
            AND qq.questioncategory_id=qc.questioncategory_id
            <cfif partner_id neq 0 or org_id gt 0>
                AND q.question_id <> 645
                AND q.question_id <> 646
            </cfif>

        </cfquery>

        <cfset retVal="-100000">

        <cfloop query="build_array">
            <cfset retVal="#retVal#,#build_array.question_id#">
        </cfloop>

        <cfreturn retVal>

    </cffunction>

</cfcomponent>
