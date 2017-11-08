<cfparam name="url.subset_id" type="numeric">

<cfset subset_id = url.subset_id>
<cfset new_subset_id = url.subset_id>
<cfquery name="statequery" datasource="dbSrc">
select state_id from state where statetype_id = 1
</cfquery>
<cfquery name="deletesubsetquestions" datasource="dbSrc">
delete from subset_question_tmp where subset_id = #url.subset_id#
</cfquery>



<cfloop query="#statequery#" >
<hr>
<cfoutput>#statequery.state_id#</cfoutput>
<hr>
<cfflush>
<cfquery name="questionsbystate" datasource="dbSrc">
SELECT q.question_id
FROM (
SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
FROM (
SELECT q.question_id, NULL AS page_id
FROM (
SELECT pa.answerfield_id
FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
WHERE sp.subset_id=#url.subset_id#

AND sp.program_id=p.program_id
AND (p.state_id IS NULL or p.state_id='#statequery.state_id#')
AND p.active_flag=1
AND p.program_id=pa.program_id
AND pa.answerfield_id NOT IN (
SELECT answerfield_id
FROM answerfield_subset_partner
WHERE subset_id=#url.subset_id#
AND (partner_id is null or partner_id=58)
AND background_flag=1
)

AND pa.answerfield_id=a.answerfield_id

AND (a.state_id IS NULL or a.state_id='#statequery.state_id#')

UNION
SELECT ar.right_answerfield_id as answerfield_id
FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
WHERE sp.subset_id=#url.subset_id#
AND sp.program_id=p.program_id
AND (p.state_id IS NULL or p.state_id='#statequery.state_id#')
AND p.active_flag=1
AND p.program_id=pa.program_id
AND pa.answerfield_id NOT IN (
SELECT answerfield_id
FROM answerfield_subset_partner
WHERE subset_id=#url.subset_id#
AND (partner_id is null or partner_id=58)
AND background_flag=1
)
AND pa.answerfield_id=ar.left_answerfield_id
AND ar.relationship_id=2
AND ar.right_answerfield_id=a.answerfield_id
AND (a.state_id IS NULL or a.state_id='#statequery.state_id#')

UNION
SELECT pa.answerfield_id
FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
WHERE sp.subset_id=#url.subset_id#
AND sp.program_id=p.program_id
AND (p.state_id IS NULL or p.state_id='#statequery.state_id#')
AND p.active_flag=1
AND p.program_id=pa.program_id
AND pa.answerfield_id NOT IN (
SELECT answerfield_id
FROM answerfield_subset_partner
WHERE subset_id=#url.subset_id#
AND (partner_id is null or partner_id=58)
AND background_flag=1
)

AND pa.answerfield_id=a.answerfield_id

AND (a.state_id IS NULL or a.state_id='#statequery.state_id#')
AND pa.program_id in
(select pp.parent_program_id
from program_parent pp, program p, subset_program_base spb
where
spb.program_id = pp.program_id
and pp.program_id = p.program_id
and spb.subset_id = 0
and ( p.state_id = '#statequery.state_id#' or p.state_id is NULL )
)

UNION
SELECT ar.right_answerfield_id as answerfield_id
FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
WHERE sp.subset_id=#url.subset_id#
AND sp.program_id=p.program_id
AND (p.state_id IS NULL or p.state_id='#statequery.state_id#')
AND p.active_flag=1
AND p.program_id=pa.program_id
AND pa.answerfield_id NOT IN (
SELECT answerfield_id
FROM answerfield_subset_partner
WHERE subset_id=#url.subset_id#
AND (partner_id is null or partner_id=58)
AND background_flag=1
)
AND pa.answerfield_id=ar.left_answerfield_id
AND ar.relationship_id=2
AND ar.right_answerfield_id=a.answerfield_id
AND (a.state_id IS NULL or a.state_id='#statequery.state_id#')
and pa.program_id in
(select pp.parent_program_id
from program_parent pp, program p, subset_program_base spb
where
spb.program_id = pp.program_id
and pp.program_id = p.program_id
and spb.subset_id =0
and ( p.state_id = '#statequery.state_id#' or p.state_id is NULL )
)

) AS a, question_answerfield qa, question q
WHERE a.answerfield_id=qa.answerfield_id
AND qa.question_id=q.question_id
AND q.exclude_flag=0
UNION
SELECT q.question_id, sq.page_id
FROM subset_question sq, question q
WHERE sq.subset_id=#url.subset_id#
AND sq.exclude_flag=0
AND sq.question_id=q.question_id
UNION
SELECT q.question_id, NULL AS page_id
FROM question q
WHERE q.include_flag=1
AND q.question_id NOT IN (
SELECT question_id
FROM subset_question
WHERE subset_id=#url.subset_id#
AND exclude_flag=1
)
) AS a, question q, questioncategory qc
WHERE a.question_id=q.question_id
AND q.questioncategory_id=qc.questioncategory_id
) sq, tbl_questions_new q, question qq, questioncategory qc
WHERE sq.question_id=q.question_id
AND q.type is not null
AND q.question_id=qq.question_id
AND qq.questioncategory_id=qc.questioncategory_id
;
</cfquery>

<cfloop query="#questionsbystate#">
<cfquery name="questiondetails" datasource="dbSrc">
select question_id, sort, exclude_flag from question where question_id =  #questionsbystate.question_id#	
</cfquery>
<hr>
<cfquery name="insertquestions" datasource="dbSrc">
INSERT INTO subset_question_tmp (question_id, subset_id, state_id, required_flag, exclude_flag,options_flag, sort )
VALUES (#questiondetails.question_id#,57, '#statequery.state_id#',0,#questiondetails.exclude_flag#,0,#questiondetails.sort#);
</cfquery>

<cfoutput><h1>question_id: #questiondetails.question_id#  inserted for state: #statequery.state_id#</h1><hr></cfoutput>
<cfflush>

</cfloop>
</cfloop>
<cfoutput><h1>DONE</h1></cfoutput>


