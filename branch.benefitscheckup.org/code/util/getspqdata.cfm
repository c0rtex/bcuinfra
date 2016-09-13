<cfprocessingdirective pageencoding="UTF-8">

	

<!---cfquery name="results"  datasource="#session.datasrc#"  >

SELECT     a.answerfield, sa.responsetype, sa.response, sa.option_id, o.option_code, sa.encryption_flag, sa.encrypted_response
FROM         answerfield AS a INNER JOIN
                      screening_answerfield AS sa ON a.answerfield_id = sa.answerfield_id LEFT OUTER JOIN
                      `option` AS o ON sa.option_id = o.option_id
WHERE     (sa.screening_id = 805360)
ORDER BY a.answerfield

</cfquery --->

<cfset attributes.partner_id = 0>
<cfset attributes.state_id = "AK">
<cfset attributes.subset_id = "0">
<cfset partnerDiff = "false">
<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="NY" subset_id="0" partner_id="0" question="hh_expenses" var="fieldlist">
<cfif isdefined('fieldlist.sort') and structcount(fieldlist.sort) gt 0>
<cfoutput>GOT IT</cfoutput>
</cfif>
<cfdump var="#fieldlist.sort#">
<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="#attributes.state_id#" subset_id="#attributes.subset_id#" partner_id="0" question="interested" var="checkboxes">
<cfdump var="#checkboxes#">

<!--- Display results count - comment out when executing batch --->
<cfquery name="results3"  datasource="bcu_qa"  >

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
		WHERE q.question_code=<cfqueryparam cfsqltype="cf_sql_varchar" value="hh_expenses" maxlength="100">
				AND q.question_id=qa.question_id
				AND qa.answerfield_id=a.answerfield_id
		ORDER BY qa.sort
</cfquery> 


<cfset session.SCREENING.PREPOPULATE = false>
<cf_displayAnswerfieldCurrency type="income" code="rent">
<cf_cacheAnswerfieldPool action="get" code="rent">
<cf_cacheSubsetQuestionAnswerfieldPool action="get" state_id="AK" subset_id="0" partner_id="0" question="hh_expenses">
<cfdump var="#bcuAnswerfield#">
<cfdump var="#application.bcuSubsetQuestionAnswerfieldPool#">
<cfdump var="#application.bcuAnswerfieldPool.a.rent#">
<cfoutput>stateid:#application.bcuAnswerfieldPool.a.rent.state_id#</cfoutput>
<cfabort>
<cfquery name="results3"  datasource="bcu"  >

select * from  answerfield where answerfield = 'fit_marital_stus' limit 0,5
</cfquery> 

<cfdump var="#results3#"><cfabort>
<cfset q2 = "">
<cfset a2 = "">
<cfset s1 = "">
<cfloop query="results3">
<cfset q1 = results3.question_id >
<cfset a1 = results3.answerfield_id>
<cfset s1 = results3.sort>
<cfif (q1 eq q2) and (a1 eq a2)>
<cfoutput>duplicate #q1#,#a1#, #s1# ....#q2#,#a2#, #s2# <br></cfoutput>
</cfif>
<cfset q2 = results3.question_id >
<cfset a2 = results3.answerfield_id>
<cfset s2 = results3.sort>
</cfloop>
<cfdump var="#results3#">
<cfquery name="results3"  datasource="BCU_qa" >
select * from tbl_questions_new where question_id = 715
</cfquery>
<cfdump var="#results3#"><cfabort>
<cfquery name="results3"  datasource="BCU_stage" >
select * from tbl_questions_new where question_id = 715


</cfquery>

<cfdump var="#results3#"><cfabort>
<cfquery name="results3"  datasource="BCU_QA" >

select w.wrapper_logo, w.wrapper_logo_alt_text
FROM wrapper w
JOIN tbl_partner p ON p.wrapper_id = w.wrapper_id
JOIN partnertype pt ON p.partnertype_id = pt.partnertype_id
WHERE p.partner_id = 76
</cfquery>

<cfdump var="#results3#">
<cfquery name="results4"  datasource="BCU_stage"  >
SELECT q.question_id, q.pri_sec, q.answerfield, q.type, q.textlength, q.validation, q.dep_formula, q.category, q.order_num, 0 AS options_flag FROM ( 
SELECT q.question_id, q.question_code, qc.questioncategory_code, a.page_id FROM (SELECT q.question_id, sq.page_id FROM subset_question sq, question q WHERE sq.subset_id=0 AND sq.exclude_flag=0 AND sq.question_id=q.question_id 
UNION SELECT q.question_id, NULL AS page_id FROM question q 
WHERE q.include_flag=1 AND q.question_id NOT IN ( SELECT question_id FROM subset_question WHERE subset_id=0 AND exclude_flag=1 ) ) AS a, question q, questioncategory qc 
WHERE a.question_id=q.question_id AND q.questioncategory_id=qc.questioncategory_id ) sq, tbl_questions_new q, question qq, questioncategory qc 
WHERE 
 sq.question_id=q.question_id AND q.answerfield not in ('zip') 
 AND q.question_id=qq.question_id AND qq.questioncategory_id=qc.questioncategory_id AND q.question_id <> 644 AND q.question_id <> 713 AND q.question_id <> 714 

ORDER BY qc.sort, qq.sort


</cfquery>

<cfdump var="#results4#"><cfabort>



<!--- Display results count - comment out when executing batch --->
<cfquery name="getPovertyIndex"  datasource="BCU_stage"  >
SELECT   s.screening_id, sa.answerfield_id, sa.response, s.start_datetime
from screening s, screening_answerfield sa
where s.screening_id = sa.screening_id and
(sa.answerfield_id = 101 or sa.answerfield_id = 5232)
and start_datetime > '20091116' 
and start_datetime < '20091126'	
and s.screening_id not in 
(
SELECT  s.screening_id
from screening s, screening_answerfield sa
where s.screening_id = sa.screening_id and
sa.answerfield_id = 5262 
and start_datetime > '20091116' 
and start_datetime < '20091126'	

)
order by s.start_datetime, s.screening_id	, sa.answerfield_id	desc
</cfquery> 



<cfset lsiincome = 0>
<cfset new_screening_id = 0>

<cfloop query="getPovertyIndex">
<cfset old_screening_id = new_screening_id>
<cfset new_screening_id = getPovertyIndex.screening_id>
<cfif getPovertyIndex.answerfield_id eq 101><cfoutput>old #old_screening_id# new #new_screening_id#</cfoutput></cfif>
<cfif old_screening_id neq new_screening_id>
	<cfset lsiincome = 0>
</cfif>
<cfif getPovertyIndex.answerfield_id eq 5232>
	<cfset lsiincome = getPovertyIndex.Response><cfoutput>lisincome from db #lsiincome#</cfoutput>
</cfif>
<cfif getPovertyIndex.answerfield_id eq 101>
<cfset  local_screening_id = getPovertyIndex.screening_id >
<cfset  local_start_datetime = getPovertyIndex.start_datetime >
<cfset  no_hh_members = getPovertyIndex.Response >

<cfoutput>screening_id: #local_screening_id# no_hh_members: #no_hh_members#  datetime: #local_start_datetime# income: #lsiincome#<br></cfoutput>
<cfset povMem = #rtrim(ltrim(no_hh_members))#>
		<cfif povMem eq '' or not IsNumeric(povMem)>
				<cfset povMem = 1>
		</cfif>
		<cfif povMem eq 0>
			<cfset povMem = 1>
		<cfelseif povMem gt 8>
			<cfset povMem = 8>
		</cfif>
		<!-- POVERTYINDEX=HH_INCOME_TOTAL_COMPLETE/poverylevel -->
		<!-- povertylevel is retrieved from db, by using session.NO_HH_MEMBERS and tbl_id of 330 (HARDCODED !) -->
		<!-- for now, hardcode it; otherwise retrieve from table (based on state, family members, etc.? ) -->
		<cfquery datasource="bcu_stage" name="getPoverty">
			SELECT mem#povMem# AS povLevel
			FROM tbl_inc_new 
			WHERE proc_id = 484
		</cfquery>

<cfif getPoverty.RecordCount>
			<cfset povVal = getPoverty.povLevel>
			<cfif povVal neq 0>
				<cfset povVal = #lsiincome# / povVal>
			
<cfoutput>
		INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
		VALUES
			(#local_screening_id#, 5262, 1,
			 '#povVal#',, 9, 
			 ,1,,,, #local_start_datetime#)
<br>
</cfoutput>
<cfquery datasource="bcu" name="insertPoverty">

	INSERT INTO screening_answerfield 
			(screening_id, answerfield_id, responsetype, response, option_id, pagenum,
			 retained_flag, derived_flag, approximation_flag, encryption_flag, encrypted_response, submit_datetime)
		VALUES
			(#local_screening_id#, 5262, 1,'#povVal#',null,9,null,1,null,null,null,'#local_start_datetime#')

</cfquery>
</cfif>
</cfif>
<cfflush>
</cfif>
</cfloop>
<cfabort>
<!--- Display results count - comment out when executing batch --->
<cfquery name="results4"  datasource="BCU"  >



select * from screening_answerfield where screening_id = 2085181



</cfquery>


<cfdump var=#results4#>

<cfabort>
<!--- Display results count - comment out when executing batch --->
<cfquery name="results4"  datasource="BCU_STAGE"  >

SELECT     qa.question_id, qa.answerfield_id, qa.state_id, qa.rule_id, qa.sort, a.answerfield_id AS Expr1, a.answerfieldtype_id, a.answerfield, a.display_id, a.short_display_id, 
                      a.spq_display_id, a.print_display_id, a.max_length, a.default_value, a.spq_default_value, a.oe_default_value, a.required_flag, a.rule_id AS Expr2, a.validation_id, 
                      a.state_id AS Expr3, a.answerfield_desc, a.create_user_id, a.create_date, a.modify_user_id, a.modify_date
FROM         question_answerfield AS qa INNER JOIN
                      answerfield AS a ON qa.answerfield_id = a.answerfield_id
WHERE     (a.answerfield LIKE '%mort%')

</cfquery>


<cfdump var=#results4#>

<!--- Display results count - comment out when executing batch --->
<cfquery name="results4"  datasource="#session.datasrc#"  >

select * from tbl_zip limit 0,20

</cfquery>


<cfdump var=#results4#>

<cfabort >




