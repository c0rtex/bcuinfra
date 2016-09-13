

<!---cfquery name="results"  datasource="#session.;datasrc#"  >

SELECT     a.answerfield, sa.responsetype, sa.response, sa.option_id, o.option_code, sa.encryption_flag, sa.encrypted_response
FROM         answerfield AS a INNER JOIN
                      screening_answerfield AS sa ON a.answerfield_id = sa.answerfield_id LEFT OUTER JOIN
                      `option` AS o ON sa.option_id = o.option_id
WHERE     (sa.screening_id = 805360)
ORDER BY a.answerfield

select * from program where legacy_prg_id is null or legacy_prg_id = '';

update program set legacy_prg_id = 'XXX-XXX-' + cast(program_id as char) +
'-XX-XX' where legacy_prg_id is null or legacy_prg_id = '';
</cfquery --->
<cfset attributes.subset_id = 58>
<cfset attributes.state_id = "CA">
<cfset attributes.partner_id = 0>
<cfset  includePartner = "false">
<cfset  attributes.app = "false">
<cfset  attributes.basics = "false">
<cfset partnerDiff = "false">
<cfset attributes.question = "receive">
<!--- Display results count - comment out when executing batch --->
<cfquery name="results3"  datasource="#session.datasrc#"  >
		SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id
		FROM (
			SELECT q.question_id, NULL AS page_id
			FROM (
				SELECT pa.answerfield_id, a.answerfield
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics> 
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif> a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND sp.program_id in
					(
					select  pp.parent_program_id 
					from program_parent pp, program p
					where 
					pp.program_id = p.program_id
					and (p.state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2"> or p.state_id IS NULL)
					)
				UNION
				SELECT ar.right_answerfield_id as answerfield_id, a.answerfield
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=ar.left_answerfield_id
					
					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif>a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
				UNION
				select  pa.answerfield_id , a.answerfield
				 from subset_program_sum sps, program_answerfield pa, answerfield a
					where 
					sps.subset_id =<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4"> 
					and pa.program_id = sps.program_id
					and a.answerfield_id = pa.answerfield_id
					and sps.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )

					)


				UNION
				SELECT ar.right_answerfield_id as answerfield_id, a.answerfield
				FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )

					)

					AND pa.answerfield_id=ar.left_answerfield_id
					
					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif>a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>


			) AS a, question_answerfield qa, question q
			WHERE a.answerfield_id=qa.answerfield_id
				AND qa.question_id NOT IN (
					SELECT question_id
					FROM subset_question
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND exclude_flag=1
				)
				AND qa.question_id=q.question_id
				AND q.exclude_flag=0
			UNION
			SELECT q.question_id, sq.page_id
			FROM subset_question sq, question q
			WHERE sq.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sq.exclude_flag=0
				AND sq.question_id=q.question_id
			UNION
			SELECT q.question_id, NULL AS page_id
			FROM question q
			WHERE q.include_flag=1
				AND q.question_id NOT IN (
					SELECT question_id
					FROM subset_question
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND exclude_flag=1
				)
		) AS a, question q, questioncategory qc<cfif attributes.app>, page pg</cfif>
		WHERE a.question_id=q.question_id
			AND q.questioncategory_id=qc.questioncategory_id
			<cfif attributes.basics>AND qc.questioncategory_code='basics'</cfif>
			<cfif attributes.app>AND a.page_id=pg.page_id</cfif>
		ORDER BY <cfif attributes.app>pg.sort, </cfif>qc.sort, q.sort



</cfquery>
<cfdump var="#results3#"  >


<cfquery name="results4"  datasource="#session.datasrc#"  >

				SELECT pa.answerfield_id, a.answerfield
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics> 
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif> a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
				UNION
				SELECT ar.right_answerfield_id as answerfield_id, a.answerfield
				FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND <cfif not attributes.basics>(</cfif>p.state_id IS NULL
					<cfif not attributes.basics>
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=ar.left_answerfield_id
					
					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif>a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>
				UNION
				select  pa.answerfield_id , a.answerfield
				 from subset_program_sum sps, program_answerfield pa, answerfield a
					where 
					sps.subset_id = 3 
					and pa.program_id = sps.program_id
					and a.answerfield_id = pa.answerfield_id
					and sps.program_id in
					(select  pp.parent_program_id 
					from program_parent pp, program p
					where 
					pp.program_id = p.program_id
					and (p.state_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2"> or p.state_id IS NULL)


				)

								  order by answerfield_id
			
</cfquery>
<cfdump var="#results4#">


<cfquery name="results5"  datasource="#session.datasrc#"  >
select  pp.parent_program_id, pp.program_id, p.state_id , spb.subset_id, p.LEGACY_PRG_ID, pa.prg_nm, p.PROGRAM_CODE
from program_parent pp, program p, subset_program_base spb, tbl_prg_all pa
where 
spb.program_id = pp.program_id
and pp.program_id = p.program_id
and spb.subset_id = #attributes.subset_id#
and pa.recid = pp.parent_program_id
order by pp.parent_program_id

</cfquery>

<cfdump var="#results5#" label="progs 5">

<cfquery name="results6"  datasource="#session.datasrc#"  >
select  pa.answerfield_id , a.answerfield
 from subset_program_sum sps, program_answerfield pa, answerfield a
where 
sps.subset_id = 3 
and pa.program_id = sps.program_id
and a.answerfield_id = pa.answerfield_id
and sps.program_id in
(
select  pp.parent_program_id
from program_parent pp, program p, subset_program_base spb
where 
spb.program_id = pp.program_id
and pp.program_id = p.program_id
and spb.subset_id = #attributes.subset_id#
and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )

)

</cfquery>

<cfdump var="#results6#" label="answerfields 6">


<cfquery name="results6"  datasource="#session.datasrc#"  >
				SELECT ar.right_answerfield_id as answerfield_id, a.answerfield
				FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a, program_parent pp
				WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					AND sp.program_id=p.program_id
					AND pp.parent_program_id=p.program_id
					AND (p.state_id IS NULL
					or p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					AND p.active_flag=1
					AND p.program_id=pa.program_id
					AND pa.answerfield_id NOT IN (
						SELECT answerfield_id
						FROM answerfield_subset_partner
						WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							AND <cfif includePartner>(</cfif>partner_id is null
							<cfif includePartner> 
							OR partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
							</cfif>
							AND background_flag=1
					)
					AND pa.answerfield_id=ar.left_answerfield_id
					
					AND ar.relationship_id=2
					AND ar.right_answerfield_id=a.answerfield_id
					AND <cfif not attributes.basics>(</cfif>a.state_id IS NULL
					<cfif not attributes.basics>
					or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
					</cfif>

</cfquery>

<cfdump var="#results6#" label="answerfields 6">
<cfset attributes.subset_id = 58>
<cfset attributes.state_id = "CA">
<cfset attributes.partner_id = 0>
<cfset  includePartner = "false">
<cfset  attributes.app = "false">
<cfset  attributes.basics = "false">
<cfset partnerDiff = "false">
<cfset attributes.question = "receive">
<cfquery name="results7"  datasource="#session.datasrc#"  >

SELECT a.answerfield
		FROM question q, question_answerfield qa, (
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)				                        </cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_base sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=ar.left_answerfield_id
				AND ar.relationship_id=2
				AND ar.right_answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)				                        </cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )

					)

			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM subset_program_sum sp, program p, program_answerfield pa, answerfield_relationship ar, answerfield a
			WHERE sp.subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
				AND sp.program_id=p.program_id
				AND p.active_flag=1
				AND (p.state_id IS NULL OR p.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				AND p.program_id=pa.program_id
				AND pa.answerfield_id NOT IN (
					SELECT answerfield_id
					FROM answerfield_subset_partner
					WHERE subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
						AND <cfif partnerDiff>(</cfif>partner_id is null
						<cfif partnerDiff> 
						or partner_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.partner_id#" maxlength="4">)
						</cfif>
						AND background_flag=1
				)
				AND pa.answerfield_id=ar.left_answerfield_id
				AND ar.relationship_id=2
				AND ar.right_answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
				and sp.program_id in
					(
						select  pp.parent_program_id
						from program_parent pp, program p, subset_program_base spb
						where 
						spb.program_id = pp.program_id
						and pp.program_id = p.program_id
						and spb.subset_id = #attributes.subset_id#
						and ( p.state_id = '#attributes.state_id#' or p.state_id is NULL )

					)

			UNION
			SELECT a.answerfield_id, a.answerfield
			FROM (
				select question_id
				from subset_question sq
				where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
					and exclude_flag=0
				union
				select question_id
				from question q
				where include_flag=1
					and question_id not in (
						select question_id
						from subset_question sq
						where subset_id=<cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.subset_id#" maxlength="4">
							and exclude_flag=1
					)
				) sq, question_answerfield qa, answerfield a
			WHERE sq.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
				AND (a.state_id IS NULL or a.state_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.state_id#" maxlength="2">)
		) AS a
		WHERE q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="#attributes.question#" maxlength="100">
				AND q.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
		ORDER BY qa.sort


</cfquery>

<cfdump var="#results7#" label="answerfields 7">

<cfabort>

<!--- Display results count - comment out when executing batch --->
<cfquery name="results4"  datasource="#session.datasrc#"  >
SELECT     p.RecID AS program_id, pp.RecID AS parent_program_id, pp.st as parent_state_id , p.st as state_id
FROM         
tbl_prg_all AS p 
INNER JOIN
tbl_rules AS r 
ON p.prg_id = r.prg_id 
CROSS JOIN
tbl_prg_all AS pp
WHERE     
(r.elig_rule LIKE '%prg%') AND (locate(pp.prg_id, r.elig_rule) > 0)


UNION

SELECT     p.RecID AS program_id, ppp.RecID AS parent_program_id,ppp.st as parent_state_id , p.st as state_id
FROM         tbl_prg_all AS p INNER JOIN
                      tbl_rules AS r ON p.prg_id = r.prg_id CROSS JOIN
                      tbl_prg_all AS pp INNER JOIN
                      tbl_rules AS rr ON pp.prg_id = rr.prg_id CROSS JOIN
                      tbl_prg_all AS ppp
WHERE     (rr.elig_rule LIKE '%prg%') AND (locate(ppp.prg_id, rr.elig_rule) > 0) AND (r.elig_rule LIKE '%prg%') AND (locate(pp.prg_id, r.elig_rule) > 0)

UNION

SELECT     p.RecID AS program_id, pppp.RecID AS parent_program_id,pppp.st as parent_state_id , p.st as state_id
FROM         tbl_prg_all AS p INNER JOIN
                      tbl_rules AS r ON p.prg_id = r.prg_id CROSS JOIN
                      tbl_prg_all AS pp INNER JOIN
                      tbl_rules AS rr ON pp.prg_id = rr.prg_id CROSS JOIN
                      tbl_prg_all AS ppp INNER JOIN
                      tbl_rules AS rrr ON ppp.prg_id = rrr.prg_id CROSS JOIN
                      tbl_prg_all AS pppp
WHERE     (rrr.elig_rule LIKE '%prg%') AND (locate(pppp.prg_id, rrr.elig_rule) > 0) AND (rr.elig_rule LIKE '%prg%') AND (locate(ppp.prg_id, rr.elig_rule) 
                      > 0) AND (r.elig_rule LIKE '%prg%') AND (locate(pp.prg_id, r.elig_rule) > 0)

UNION


SELECT     p.RecID AS program_id, ppppp.RecID AS parent_program_id,ppppp.st as parent_state_id , p.st as state_id
FROM         tbl_prg_all AS p INNER JOIN
                      tbl_rules AS r ON p.prg_id = r.prg_id CROSS JOIN
                      tbl_prg_all AS pp INNER JOIN
                      tbl_rules AS rr ON pp.prg_id = rr.prg_id CROSS JOIN
                      tbl_prg_all AS ppp INNER JOIN
                      tbl_rules AS rrr ON ppp.prg_id = rrr.prg_id CROSS JOIN
                      tbl_prg_all AS pppp INNER JOIN
                      tbl_rules AS rrrr ON pppp.prg_id = rrrr.prg_id CROSS JOIN
                      tbl_prg_all AS ppppp
WHERE     (rrrr.elig_rule LIKE '%prg%') AND (locate(ppppp.prg_id, rrrr.elig_rule) > 0) AND (rrr.elig_rule LIKE '%prg%') AND (locate(pppp.prg_id, 
                      rrr.elig_rule) > 0) AND (rr.elig_rule LIKE '%prg%') AND (locate(ppp.prg_id, rr.elig_rule) > 0) AND (r.elig_rule LIKE '%prg%') AND 
                      (locate(pp.prg_id, r.elig_rule) > 0)

</cfquery>


<cfdump var=#results4#>



<!--- Display results count - comment out when executing batch --->
<cfquery name="results5"  datasource="#session.datasrc#"  >

SELECT     subset_id, program_id
FROM         (SELECT     subset_id, program_id
                       FROM          view_subset_program_base where view_subset_program_base.subset_id = 3
                       UNION
                       SELECT     spb.subset_id, pp.parent_program_id AS program_id
                       FROM         view_subset_program_base AS spb INNER JOIN
                                             view_program_parent AS pp ON spb.program_id = pp.program_id where spb.subset_id = 3) 
				
AS q

</cfquery>


<cfdump var=#results5#>
<cfabort>
<!--- Display results count - comment out when executing batch --->
<cfquery name="results4"  datasource="#session.datasrc#"  >

select * from tbl_zip limit 0, 20

</cfquery>


<cfdump var=#results4#>

<cfabort >





