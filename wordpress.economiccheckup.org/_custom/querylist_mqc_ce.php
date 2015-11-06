<?PHP 

/*
List of data queries for bcu
 */
/* Set DB String for bcu  */ 
$bcudb = new wpdb(DB_USER_BCU,DB_PASSWORD_BCU,DB_NAME_BCU,DB_HOST_BCU);
$bcudb->show_errors();

/* subsetInfo query */
$query_subsetInfo = "
SELECT subsettype_id, subset_name, subset_longname, subset_description, subset_text, all_flag,
					state_flag, grid_flag, schip_flag, drug_flag, optional_flag, rec_flag, eform_flag
				FROM xsubset
				WHERE subset_id=74 
";


/* subsetPartnerInfo query */
$query_subsetPartnerInfo = "
SELECT resultpage_id
				FROM subset_partner
				WHERE subset_id=74
					AND partner_id=77
					AND resultpage_id IS NOT NULL
";

/* subsetQuestionInfo query */
$query_subsetQuestionInfo = "
select x.question_code, max(x.include) as include
			from (
				select q.question_code, 1 as include
				from question q
				where q.question_code in ('learn', 'race', 'hispanic')
					and (
						q.include_flag=1
						or (
							q.exclude_flag=0
							and q.question_id in (
								select question_id
								from subset_question
								where subset_id=74
								and exclude_flag=0
							)
						)
					)
				union
				select q.question_code, 0 as include
				from question q
				where q.question_code in ('learn', 'race', 'hispanic')
			) x
			group by x.question_code
";

/* getExplicitAnswerfields query */
$query_getExplicitAnswerfields = "
select a.answerfield, asp.default_value
			from answerfield_subset_partner asp, (
					select answerfield_id, subset_id, max(partner_id) partner_id
					from answerfield_subset_partner
					where subset_id=74
						and (partner_id is null or partner_id=77)
						and background_flag=1
					group by answerfield_id, subset_id
				) q, answerfield a
			where asp.answerfield_id=q.answerfield_id
				and asp.subset_id=q.subset_id
				and (asp.partner_id=q.partner_id or (asp.partner_id is null and q.partner_id is null))
				and asp.background_flag=1
				and q.answerfield_id=a.answerfield_id
			order by a.answerfield
";


/* getRequiredAFs query */
$subset_id ="74";
$query_getRequiredAFs = "
select qa.answerfield_id, a.answerfield, sa.required, qa.sort, r.recap_code
			from subset_question sq
				inner join question_answerfield qa
					on sq.subset_id=".$subset_id." and sq.question_id=qa.question_id
				inner join answerfield a
					on qa.answerfield_id=a.answerfield_id
				left outer join subset_answerfield sa
					 on sa.subset_id=".$subset_id." and qa.answerfield_id=sa.answerfield_id
				left outer join recap r
					 on sa.recap_id=r.recap_id
			group by a.answerfield, qa.answerfield_id, sa.required, qa.sort, r.recap_code
			order by a.answerfield
";

/* getAF query */
$answerfield="esi_client";
$query_getAF = "
select q.question_id, a.answerfield_id , a.answerfield, a.answerfieldtype_id , aa.code, a.display_id, a.validation_id, a.default_value, a.max_length
	from question q, question_answerfield qa, answerfield a, answerfieldtype aa
	where q.question_code like 'esi_%'
		and q.question_id=qa.question_id
		and qa.answerfield_id=a.answerfield_id
    and a.answerfieldtype_id = aa.answerfieldtype_id
	order by qa.sort
";

/* getQuestionsbySubsetPartnerState query */
$query_getQuestionsbySubsetPartnerState = "
SELECT q.question_id, q.display_id, q.question_code, qc.questioncategory_code FROM ( SELECT q.question_id, NULL AS page_id FROM ( SELECT pa.answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield a WHERE sp.subset_id=74 AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=74 AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=a.answerfield_id AND ( a.state_id IS NULL or a.state_id='MN') UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=74 AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=74 AND (partner_id is null OR partner_id=77) AND background_flag=1 ) AND pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') UNION SELECT pa.answerfield_id FROM subset_program_sum sps, program_answerfield pa, answerfield a WHERE sps.subset_id=74 and pa.program_id = sps.program_id and a.answerfield_id = pa.answerfield_id and sps.program_id in ( select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = 74 and (p.state_id = 'MN' or p.state_id IS NULL) ) UNION SELECT ar.right_answerfield_id as answerfield_id FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a WHERE sp.subset_id=74 AND sp.program_id=p.program_id AND (p.state_id IS NULL or p.state_id='MN') AND p.active_flag=1 AND p.program_id=pa.program_id AND pa.answerfield_id NOT IN ( SELECT answerfield_id FROM answerfield_subset_partner WHERE subset_id=74 AND (partner_id is null OR partner_id=77) AND background_flag=1 ) and sp.program_id in (	select pp.parent_program_id from program_parent pp, program p, subset_program_base spb where spb.program_id = pp.program_id and pp.program_id = p.program_id and spb.subset_id = 74 and ( p.state_id = 'NY' or p.state_id is NULL ) ) AND pa.answerfield_id=ar.left_answerfield_id AND ar.relationship_id=2 AND ar.right_answerfield_id=a.answerfield_id AND (a.state_id IS NULL or a.state_id='MN') ) AS a, question_answerfield qa, question q WHERE a.answerfield_id=qa.answerfield_id AND qa.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=74 AND exclude_flag=1 ) AND qa.question_id=q.question_id AND q.exclude_flag=0 UNION SELECT q.question_id, sq.page_id FROM subset_question sq, question q WHERE sq.subset_id=74 AND sq.exclude_flag=0 AND sq.question_id=q.question_id UNION SELECT q.question_id, NULL AS page_id FROM question q WHERE q.include_flag=1 AND q.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=74 AND exclude_flag=1 ) ) AS a, question q, questioncategory qc WHERE a.question_id=q.question_id AND q.questioncategory_id=qc.questioncategory_id AND qc.questioncategory_code <> 'basics'
 ORDER BY qc.sort, q.sort
 ";

/* getSections query */
$query_getSections = "
SELECT
questioncategory.questioncategory_id,
questioncategory.questioncategory_code,
questionheader.questionheader_id,
questionheader.display_id,
questionheader.`code`,
questioncategory.sort,
questionheader.questioncategory_id,
subset_questioncategory.sort
FROM
questioncategory
INNER JOIN questionheader ON questioncategory.questioncategory_id = questionheader.questioncategory_id
INNER JOIN subset_questioncategory ON questionheader.questioncategory_id = subset_questioncategory.questioncategory_id
WHERE
subset_questioncategory.subset_id = 74
and questionheader_id <> 11
order by subset_questioncategory.sort
";

/* getDisplayIDByCode query */
$query_getDisplayIDByCode = "
select d.display_id, dg.displaygroup_code
		from display d, displaygroup dg
		where d.display_code='question_esi_client'
			and d.displaygroup_id=dg.displaygroup_id
"; 

/* getDisplayTextByID query */
$query_getDisplayTextByID = "
select dl.display_text
					from display_language dl, language l
					where dl.display_id=86528
						and dl.language_id in ('EN')
						and dl.language_id=l.language_id
						and l.active = 1
					order by l.default_flag
";


//$load_query = $bcudb->get_results($query_getRequiredAFs);
//foreach ($load_query  as $obj) :
//   echo $obj->subset_name;
//endforeach;
//var_dump($load_query );

?>