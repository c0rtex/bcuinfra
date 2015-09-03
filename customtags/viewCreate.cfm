<cfsilent>
<cfparam name="attributes.view" type="string">
<cfparam name="attributes.source" type="string">
<cfparam name="attributes.drop" type="boolean" default="false">

<cfif attributes.drop>
	<cfquery name="dropview" datasource="#attributes.source#">
		DROP VIEW #attributes.view#
	</cfquery>
</cfif>

<cfswitch expression="#attributes.view#">
	<cfcase value="view_city_county">
		<cfquery name="createview" datasource="#attributes.source#">
			create view view_city_county as
			select c.city_id, z.county_id
			from city c, city_zip cz, zip z
			where c.valid=1
				and c.city_id=cz.city_id
				and cz.valid=1
				and cz.zipcode=z.zipcode
				and z.valid=1
			group by c.city_id, z.county_id
		</cfquery>
	</cfcase>

	<cfcase value="view_city_zip_preferred">
		<cfquery name="createview" datasource="#attributes.source#">
			create view [dbo].[view_city_zip_preferred] as
			select c.pref_city_id city_id, cz.zipcode
			from city c, city_zip cz, zip z
			where c.pref_city_id is not null
				and c.exclude_flag=0
				and c.valid=1
				and c.city_id=cz.city_id
				and cz.valid=1
				and cz.zipcode=z.zipcode
				and z.valid=1
			union
			select c.city_id, z.zipcode
			from city c, city_zip cz, zip z
			where c.pref_city_id is null
				and c.exclude_flag=0
				and c.valid=1
				and c.city_id=cz.city_id
				and cz.valid=1
				and cz.zipcode=z.zipcode
				and z.valid=1
		</cfquery>
	</cfcase>

	<cfcase value="view_program_answerfield">
		<cfquery name="createview" datasource="#attributes.source#">
			create view [dbo].[view_program_answerfield] as
			select pr.program_id, ra.answerfield_id, 1 as rule_flag
			from rule_answerfield ra, program_rule pr
			where ra.rule_id=pr.rule_id
			group by pr.program_id, ra.answerfield_id
		</cfquery>
	</cfcase>

	<cfcase value="view_program_parent">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_program_parent] AS
SELECT     program_id, parent_program_id
FROM         (SELECT     program_id, parent_program_id
                       FROM          dbo.view_program_parent_1
                       UNION
                       SELECT     program_id, parent_program_id
                       FROM         dbo.view_program_parent_2
                       UNION
                       SELECT     program_id, parent_program_id
                       FROM         dbo.view_program_parent_3
                       UNION
                       SELECT     program_id, parent_program_id
                       FROM         dbo.view_program_parent_4) AS q
		</cfquery>
	</cfcase>

	<cfcase value="view_program_parent_1">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_program_parent_1] AS
SELECT     p.RecID AS program_id, pp.RecID AS parent_program_id
FROM         dbo.tbl_prg_all AS p INNER JOIN
                      dbo.tbl_rules AS r ON p.prg_id = r.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS pp
WHERE     (r.elig_rule LIKE '%prg%') AND (CHARINDEX(pp.prg_id, r.elig_rule) > 0)
		</cfquery>
	</cfcase>

	<cfcase value="view_program_parent_2">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_program_parent_2] AS
SELECT     p.RecID AS program_id, ppp.RecID AS parent_program_id
FROM         dbo.tbl_prg_all AS p INNER JOIN
                      dbo.tbl_rules AS r ON p.prg_id = r.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS pp INNER JOIN
                      dbo.tbl_rules AS rr ON pp.prg_id = rr.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS ppp
WHERE     (rr.elig_rule LIKE '%prg%') AND (CHARINDEX(ppp.prg_id, rr.elig_rule) > 0) AND (r.elig_rule LIKE '%prg%') AND (CHARINDEX(pp.prg_id, r.elig_rule) > 0)
		</cfquery>
	</cfcase>

	<cfcase value="view_program_parent_3">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_program_parent_3] AS
SELECT     p.RecID AS program_id, pppp.RecID AS parent_program_id
FROM         dbo.tbl_prg_all AS p INNER JOIN
                      dbo.tbl_rules AS r ON p.prg_id = r.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS pp INNER JOIN
                      dbo.tbl_rules AS rr ON pp.prg_id = rr.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS ppp INNER JOIN
                      dbo.tbl_rules AS rrr ON ppp.prg_id = rrr.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS pppp
WHERE     (rrr.elig_rule LIKE '%prg%') AND (CHARINDEX(pppp.prg_id, rrr.elig_rule) > 0) AND (rr.elig_rule LIKE '%prg%') AND (CHARINDEX(ppp.prg_id, rr.elig_rule) 
                      > 0) AND (r.elig_rule LIKE '%prg%') AND (CHARINDEX(pp.prg_id, r.elig_rule) > 0)
		</cfquery>
	</cfcase>

	<cfcase value="view_program_parent_4">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_program_parent_4] AS
SELECT     p.RecID AS program_id, ppppp.RecID AS parent_program_id
FROM         dbo.tbl_prg_all AS p INNER JOIN
                      dbo.tbl_rules AS r ON p.prg_id = r.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS pp INNER JOIN
                      dbo.tbl_rules AS rr ON pp.prg_id = rr.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS ppp INNER JOIN
                      dbo.tbl_rules AS rrr ON ppp.prg_id = rrr.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS pppp INNER JOIN
                      dbo.tbl_rules AS rrrr ON pppp.prg_id = rrrr.prg_id CROSS JOIN
                      dbo.tbl_prg_all AS ppppp
WHERE     (rrrr.elig_rule LIKE '%prg%') AND (CHARINDEX(ppppp.prg_id, rrrr.elig_rule) > 0) AND (rrr.elig_rule LIKE '%prg%') AND (CHARINDEX(pppp.prg_id, 
                      rrr.elig_rule) > 0) AND (rr.elig_rule LIKE '%prg%') AND (CHARINDEX(ppp.prg_id, rr.elig_rule) > 0) AND (r.elig_rule LIKE '%prg%') AND 
                      (CHARINDEX(pp.prg_id, r.elig_rule) > 0)
		</cfquery>
	</cfcase>

	<!--- MH: 5/12/10 Removed reference to view_program_sort since it is being archived on BCUQA 
	<cfcase value="view_program_sort">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_program_sort] AS
			select p.program_id, ifnull(p.supersort, 999999999) sort1, pc.sort sort2, p.sort sort3
			from program p, programcategory pc
			where p.programcategory_id=pc.programcategory_id
		</cfquery>
	</cfcase>--->

	<cfcase value="view_rule_answerfield">
		<cfquery name="createview" datasource="#attributes.source#">
			create view [dbo].[view_rule_answerfield] as
			select r.rule_id, a.answerfield_id
			from [answerfield] a, [rule] r
			where r.rule_text like '%[^a-z0-9_]session.' + a.answerfield + '[^a-z0-9_]%'
				or r.rule_text like 'session.' + a.answerfield + '[^a-z0-9_]%'
				or r.rule_text like '%[^a-z0-9_]session.' + a.answerfield
				or r.rule_text like 'session.' + a.answerfield
			union
			select r.rule_id, ha.answerfield_id
			from hardrule hr, [rule] r, hardrule_answerfield ha
			where (r.rule_text like '%[^a-z0-9_]' + hr.code + '[^a-z0-9_]%'
					or r.rule_text like hr.code + '[^a-z0-9_]%'
					or r.rule_text like '%[^a-z0-9_]' + hr.code
					or r.rule_text like hr.code)
				and hr.hardrule_id=ha.hardrule_id
		</cfquery>
	</cfcase>

	<cfcase value="view_subset_program_base">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_subset_program_base] AS
SELECT     si.subset_id, si.program_id
FROM         (SELECT     s.subset_id, p.RecID AS program_id
                       FROM          dbo.subset AS s CROSS JOIN
                                              dbo.tbl_prg_all AS p
                       WHERE      (s.subsettype_id = 6) AND (p.exclude_flag = 0)
                       UNION
                       SELECT     s.subset_id, p.RecID AS program_id
                       FROM         dbo.subset AS s INNER JOIN
                                             dbo.subset_programcategory AS sc ON s.subset_id = sc.subset_id INNER JOIN
                                             dbo.programcategory AS c ON sc.programcategory_id = c.programcategory_id INNER JOIN
                                             dbo.tbl_prg_all AS p ON c.legacy_code = p.Cat_ID
                       WHERE     (sc.exclude_flag IS NULL OR
                                             sc.exclude_flag = 0) AND (p.exclude_flag = 0)
                       UNION
                       SELECT     s.subset_id, sp.program_id
                       FROM         dbo.subset AS s INNER JOIN
                                             dbo.subset_program AS sp ON s.subset_id = sp.subset_id
                       WHERE     (sp.exclude_flag IS NULL) OR
                                             (sp.exclude_flag = 0)) AS si LEFT OUTER JOIN
                          (SELECT     s.subset_id, p.RecID AS program_id
                            FROM          dbo.subset AS s INNER JOIN
                                                   dbo.subset_programcategory AS sc ON s.subset_id = sc.subset_id INNER JOIN
                                                   dbo.programcategory AS c ON sc.programcategory_id = c.programcategory_id INNER JOIN
                                                   dbo.tbl_prg_all AS p ON c.legacy_code = p.Cat_ID
                            WHERE      (sc.exclude_flag = 1)
                            UNION
                            SELECT     s.subset_id, sp.program_id
                            FROM         dbo.subset AS s INNER JOIN
                                                  dbo.subset_program AS sp ON s.subset_id = sp.subset_id
                            WHERE     (sp.exclude_flag = 1)) AS so ON si.subset_id = so.subset_id AND si.program_id = so.program_id
WHERE     (so.subset_id IS NULL)
		</cfquery>
	</cfcase>
	
    <!--- MH: 5/12/10 Removed reference to view_subset_program_derived since it is being archived on BCUQA 
	<cfcase value="view_subset_program_derived">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_subset_program_derived] AS
			select s.subset_id, s.program_id, 1 - sign(ifnull(b.program_id, 0)) as derived_flag
			from view_subset_program_base b right outer join view_subset_program_sum s
				on b.subset_id=s.subset_id and b.program_id=s.program_id
		</cfquery>
	</cfcase>--->

	<cfcase value="view_subset_program_diff">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_subset_program_diff] AS
			select sps.subset_id, sps.program_id
			from subset_program_sum sps left outer join subset_program_base spb
				on sps.subset_id=spb.subset_id and sps.program_id=spb.program_id
			where spb.subset_id is null
		</cfquery>
	</cfcase>

	<cfcase value="view_subset_program_sum">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_subset_program_sum] AS
SELECT     subset_id, program_id
FROM         (SELECT     subset_id, program_id
                       FROM          dbo.view_subset_program_base
                       UNION
                       SELECT     spb.subset_id, pp.parent_program_id AS program_id
                       FROM         dbo.view_subset_program_base AS spb INNER JOIN
                                             dbo.view_program_parent AS pp ON spb.program_id = pp.program_id) AS q
		</cfquery>
	</cfcase>

	<cfcase value="view_subset_question">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_subset_question] AS
			select sq.subset_id, sq.question_id, q.display_id, sq.page_id, pg.sort pgsort, q.sort qsort
			from subset_question sq, page pg, question q
			where sq.required_flag=0
				and sq.exclude_flag=0
				and sq.options_flag=0
				and sq.page_id=pg.page_id
				and sq.question_id=q.question_id
		</cfquery>
	</cfcase>

	<cfcase value="view_tbl_major_cat_list">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_tbl_major_cat_list] AS
			select substring(dl.display_text, 1, 40) major_cat, pc.code,
				ifnull(pc.legacy_code, pc.programcategory_id + 297) id_number,
				NULL added_by, NULL added_dt, NULL mod_by, NULL mod_dt,
				pc.programcategory_id RecID, pc.sort Sort_order
			from programcategory pc inner join display_language dl
				on pc.display_id=dl.display_id and dl.language_id='EN'
		</cfquery>
	</cfcase>

	<cfcase value="view_tbl_prg_all">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_tbl_prg_all] AS
			select p.program_id as RecID, p.program_code as code,
				ifnull(p.legacy_prg_id, 'XXX-XXX-' + cast( p.program_id) + '-XX-XX' as varchar(16)) as prg_id,
				p.sort as order_num, ifnull(p.legacy_pri_sec, 1) as pri_sec, cast( da.display_text as varchar(255)) as prg_nm,
				cast( 'FD' as varchar(255), db.display_text) as prg_desc, ifnull(nullif(p.state_id, NULL)) as st,
				z.proximity, z.firstproximity, p.url as comment, p.create_date as added_dt,
				u.username as added_by, uu.username as mod_by, p.modify_date as mod_dt,
				substring(p.legacy_prg_id, 9, 4) as id, 0 as include, ifnull(r.name, 'unknown') as source,
				0 as dollar_amount, pc.id_number as Cat_ID, ifnull(exclude_flag, 0) as exclude_flag,
				(1 - ifnull(active_flag, 0)) as inactive_flag, ifnull(significant_flag, 0) as significant_flag,
				sign(ifnull(pp.program_id, 0)) as childrens_flag
			from program p inner join view_tbl_major_cat_list pc
					on p.programcategory_id=pc.RecID
				left outer join (
					select x.program_id, y.code as proximity, NULL as firstproximity
					from (
						select program_id, sum(sort) as s
						from program_proximity
						group by program_id
					) as x, (
						select px.program_id, x.code
						from program_proximity px, proximity x
						where px.sort=1
							and px.proximity_id=x.proximity_id
					) as y
					where x.s=1 and x.program_id=y.program_id
					union
					select x.program_id, z.code as proximity, y.code as firstproximity
					from (
						select program_id, sum(sort) as s
						from program_proximity
						group by program_id
					) as x, (
						select px.program_id, x.code
						from program_proximity px, proximity x
						where px.sort=1
							and px.proximity_id=x.proximity_id
					) as y, (
						select px.program_id, x.code
						from program_proximity px, proximity x
						where px.sort=2
							and px.proximity_id=x.proximity_id
					) as z
					where x.s=3
						and x.program_id=y.program_id
						and y.program_id=z.program_id
				) as z
					on p.program_id=z.program_id
				left outer join [user] u
					on p.create_user_id=u.user_id
				left outer join [user] uu
					on p.modify_user_id=uu.user_id
				left outer join reference r
					on p.reference_id=r.reference_id
				left outer join display_language da
					on p.name_display_id=da.display_id
						and da.language_id='EN'
				left outer join display_language db
					on p.desc_display_id=db.display_id
						and db.language_id='EN'
				left outer join (select program_id from program where programgroup_id=1) pp
					on p.program_id=pp.program_id
		</cfquery>
	</cfcase>
	
	<cfcase value="view_tbl_questions_new">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_tbl_questions_new] AS
			select q.question_id, q.question_code as answerfield, qc.category, q.sort as order_num,
				ps.pri_sec, dl.display_text as question, tv.type, tv.validation,
				'self' as client, tv.textlength, null as dep_field, null as dep_op,
				null as dep_criteria, r.rule_text as dep_formula
			from question q inner join (
					select '0' + cast( sort as char(1)) + '-' + questioncategory_code as category, questioncategory_id
					from questioncategory
					where sort < 10
					union
					select cast( sort as char(2)) + '-' + questioncategory_code as category, questioncategory_id
					from questioncategory
					where sort > 9
			) qc
					on q.questioncategory_id=qc.questioncategory_id
				inner join (
					select q.question_id, r.pri_sec
					from (
						select question_id, question_code, max(depth) as maxdepth
						from (
							select q.question_id, q.question_code, 0 as depth
							from question q
							union
							select q.question_id, q.question_code, 1 as depth
							from question q, [rule] r, answerfield a
							where q.questioncategory_id not in (13)
								and q.rule_id=r.rule_id
								and r.rule_text like '%##session.' + a.answerfield + '##%'
							union
							select q.question_id, q.question_code, 2 as depth
							from question q, [rule] r, answerfield a, question_answerfield qa,
								question qq, [rule] rr, answerfield aa
							where q.questioncategory_id not in (13)
								and q.rule_id=r.rule_id
								and r.rule_text like '%##session.' + a.answerfield + '##%'
								and a.answerfield_id=qa.answerfield_id
								and qa.question_id=qq.question_id
								and qq.questioncategory_id not in (13)
								and qq.rule_id=rr.rule_id
								and rr.rule_text like '%##session.' + aa.answerfield + '##%'
							union
							select q.question_id, q.question_code, 3 as depth
							from question q, [rule] r, answerfield a, question_answerfield qa,
								question qq, [rule] rr, answerfield aa, question_answerfield qqaa,
								question qqq, [rule] rrr, answerfield aaa
							where q.questioncategory_id not in (13)
								and q.rule_id=r.rule_id
								and r.rule_text like '%##session.' + a.answerfield + '##%'
								and a.answerfield_id=qa.answerfield_id
								and qa.question_id=qq.question_id
								and qq.questioncategory_id not in (13)
								and qq.rule_id=rr.rule_id
								and rr.rule_text like '%##session.' + aa.answerfield + '##%'
								and aa.answerfield_id=qqaa.answerfield_id
								and qqaa.question_id=qqq.question_id
								and qqq.questioncategory_id not in (13)
								and qqq.rule_id=rrr.rule_id
								and rrr.rule_text like '%##session.' + aaa.answerfield + '##%'
							union
							select q.question_id, q.question_code, 4 as depth
							from question q, [rule] r, answerfield a, question_answerfield qa,
								question qq, [rule] rr, answerfield aa, question_answerfield qqaa,
								question qqq, [rule] rrr, answerfield aaa, question_answerfield qqqaaa,
								question qqqq, [rule] rrrr, answerfield aaaa
							where q.questioncategory_id not in (13)
								and q.rule_id=r.rule_id
								and r.rule_text like '%##session.' + a.answerfield + '##%'
								and a.answerfield_id=qa.answerfield_id
								and qa.question_id=qq.question_id
								and qq.questioncategory_id not in (13)
								and qq.rule_id=rr.rule_id
								and rr.rule_text like '%##session.' + aa.answerfield + '##%'
								and aa.answerfield_id=qqaa.answerfield_id
								and qqaa.question_id=qqq.question_id
								and qqq.questioncategory_id not in (13)
								and qqq.rule_id=rrr.rule_id
								and rrr.rule_text like '%##session.' + aaa.answerfield + '##%'
								and aaa.answerfield_id=qqqaaa.answerfield_id
								and qqqaaa.question_id=qqqq.question_id
								and qqqq.questioncategory_id not in (13)
								and qqqq.rule_id=rrrr.rule_id
								and rrrr.rule_text like '%##session.' + aaaa.answerfield + '##%'
						) q
						group by question_id, question_code
					) q, (
						select 0 as depth, 'pri' as pri_sec
						union
						select 1 as depth, 'sec' as pri_sec
						union
						select 2 as depth, 'secdep' as pri_sec
						union
						select 3 as depth, 'secdep' as pri_sec
						union
						select 4 as depth, 'secthird' as pri_sec
					) r
					where q.maxdepth=r.depth
				) ps
					on q.question_id=ps.question_id
				inner join display_language dl
					on q.display_id=dl.display_id
				left outer join (
					select q.question_id, t.type, t.validation, t.textlength
					from (
						select q.question_id, q.question_code, min(qa.sort) minsort
						from question q, question_answerfield qa
						where q.question_id not in (351, 429, 432, 433, 434, 435, 633, 634, 637, 638, 639, 640)
							and q.questioncategory_id not in (11, 13)
							and q.question_id=qa.question_id
						group by q.question_id, q.question_code
					) q inner join question_answerfield qa
							on q.question_id=qa.question_id
								and q.minsort=qa.sort
						inner join (
							select answerfield_id, answerfieldtype_id
							from answerfield
							where answerfield_id not in (102)
							union
							select 102 as answerfield_id, 100 as answerfieldtype_id
						) a
							on qa.answerfield_id=a.answerfield_id
						inner join (
							select answerfieldtype_id
							from answerfieldtype
							union
							select 100 as answerfieldtype_id
						) ay
							on a.answerfieldtype_id=ay.answerfieldtype_id
						left outer join (
							select 1 as type_id, 'opt' as type, 'integer' as validation, 8 as textlength
							union
							select 2 as type_id, 'txt' as type, 'integer' as validation, 2 as textlength
							union
							select 4 as type_id, 'txt' as type, null as validation, null as textlength
							union
							select 5 as type_id, 'yn' as type, null as validation, null as textlength
							union
							select 8 as type_id, 'opt' as type, null as validation, null as textlength
							union
							select 11 as type_id, 'txt' as type, 'integer' as validation, null as textlength
							union
							select 16 as type_id, 'opt' as type, 'integer' as validation, 8 as textlength
							union
							select 17 as type_id, 'opt' as type, 'integer' as validation, 8 as textlength
							union
							select 18 as type_id, 'opt' as type, null as validation, null as textlength
							union
							select 21 as type_id, 'txt' as type, 'date' as validation, null as textlength
							union
                            select 27 as type_id, 'ynns' as type, null as validation, null as textlength
							union
							select 100 as type_id, 'opt' as type, 'integer' as validation, 2 as textlength
						) t
							on ay.answerfieldtype_id=t.type_id
				) tv
					on q.question_id=tv.question_id
				left outer join [rule] r
					on q.rule_id=r.rule_id
			where dl.language_id='EN'
		</cfquery>
	</cfcase>
	
	 <!--- MH: Bug 5579 7/21/10 Removed reference to tbl_req_mat, tbl_req_mat_list which are being archived
    <cfcase value="view_tbl_req_mat">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_tbl_req_mat] AS
			select p.legacy_prg_id as prg_id, dl.display_text as req_mat, 'laura' as added_by,
				cast('2005-11-19' as datetime) as added_dt, 'laura' as mod_by,
				cast('2006-07-26' as datetime) as mod_dt, r.requisite_id as mat_id,
				(
					select count(*)
					from program_requisite c
					where c.program_id < pr.program_id
						or (
							c.program_id = pr.program_id
							and c.requisite_id <= pr.requisite_id
						)
				) as req_id
			from program_requisite pr inner join program p
					on pr.program_id=p.program_id
				inner join requisite r
					on pr.requisite_id=r.requisite_id
				inner join display_language dl
					on r.display_id=dl.display_id and dl.language_id='EN'
		</cfquery>
	</cfcase>
	
	<cfcase value="view_tbl_req_mat_list">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_tbl_req_mat_list] AS
			select r.code, da.display_text as req_mat, 'marlene' as added_by,
				cast('2003-05-08' as datetime) as added_dt, 'marlene' as mod_by,
				cast('2004-12-16' as datetime) as mod_dt, r.requisite_id as mat_id,
				db.display_text as definition
			from requisite r inner join display_language da
					on r.display_id=da.display_id and da.language_id='EN'
				left outer join display_language db
					on r.def_display_id=db.display_id and db.language_id='EN'
		</cfquery>
	</cfcase>--->
	
	<cfcase value="view_tbl_rules">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_tbl_rules] AS
			select p.legacy_prg_id as prg_id, r.rule_text as elig_rule,
				(
					select count(*)
					from program_rule c
					where c.program_id < pr.program_id
						or (
							c.program_id = pr.program_id
							and c.rule_id <= pr.rule_id
						)
				)  as RecID, r.legacy_pri_sec as pri_sec
			from [rule] r, program_rule pr, program p
			where r.rule_id=pr.rule_id
					and pr.program_id=p.program_id
					and p.legacy_prg_id is not null
		</cfquery>
	</cfcase>

	<cfcase value="view_xsubset">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_xsubset] AS
			select a.subset_id, b.subsettype_id, a.code, cast( da.display_text as varchar(255)) as subset_name,
				cast( db.display_text as varchar(255)) as subset_longname, a.subset_description,
				cast( dc.display_text as varchar(255)) as subset_text,
				cast( dd.display_text as varchar(255)) as qaire_name, a.alt_name,
				b.all_flag, c.drug_flag, d.grid_flag, e.optional_flag, ifnull(a.rec_flag, 0) as rec_flag,
				a.eform_flag, f.schip_flag, g.state_flag, a.report_flag
			from (
				select subset_id, code, description as subset_description, oe_name as alt_name,
					(resultpage_id - 1) as rec_flag, (1 - eform_flag) as eform_flag, report_flag,
					display_id, alt_display_id, spq_display_id, intro_display_id
				from subset
			) as a inner join (
				select q.subset_id, max(q.subsettype_id) as subsettype_id, max(q.all_flag) as all_flag
				from (
					select subset_id, 1 as subsettype_id, 1 as all_flag
					from subset
					where subsettype_id=6
					union
					select subset_id, 2 as subsettype_id, 0 as all_flag
					from subset
					where test_flag=1
					union
					select subset_id, 4 as subsettype_id, 0 as all_flag
					from subset
					where active_flag=0
					union
					select subset_id, subsettype_id, 0 as all_flag
					from subset
					where (test_flag=0 or active_flag=1)
						and subsettype_id <> 6
				) as q
				group by q.subset_id
			) as b
				on a.subset_id=b.subset_id
			inner join (
				select s.subset_id, ifnull(drug_flag, 1) as drug_flag
				from subset s left outer join (
					select subset_id, max(drug_flag) as drug_flag
					from (
						select distinct(sp.subset_id) as subset_id, 0 as drug_flag
						from subset_program_sum sp, program_answerfield pa, answerfield a
						where sp.program_id=pa.program_id
							and pa.answerfield_id=a.answerfield_id
							and a.answerfieldtype_id in (13, 14)
						union
						select sq.subset_id, sq.exclude_flag as drug_flag
						from question q, subset_question sq
						where q.question_id=438
							and q.question_id=sq.question_id
					) as q
					group by subset_id
				) as r
					on s.subset_id=r.subset_id
			) as c
				on b.subset_id=c.subset_id
			inner join (
				select s.subset_id, ifnull(grid_flag, 3) as grid_flag
				from subset s left outer join (
					select subset_id, max(grid_flag) as grid_flag
					from (
						select distinct(sq.subset_id) as subset_id, 2 as grid_flag
						from question q, subset_question sq
						where q.question_id in (637, 638, 639, 640)
							and q.question_id=sq.question_id
						union
						select subset_id, max(grid_flag) grid_flag
						from (
							select distinct(sg.subset_id) as subset_id, 1 as grid_flag
							from subset_gridrow sg, gridrow g
							where sg.gridrow_id=g.gridrow_id
								and sg.exclude_flag <> g.exclude_flag
							union
							select subset_id, 0 as grid_flag
							from question q, subset_question sq
							where q.question_id in (436, 437)
								and q.question_id=sq.question_id
						) q
						group by subset_id
					) as q
					group by subset_id
				) as r
					on s.subset_id=r.subset_id
			) as d
				on c.subset_id=d.subset_id
			inner join (
				select subset_id, min(optional_flag) as optional_flag
				from (
					select sq.subset_id, sq.exclude_flag as optional_flag
					from question q, subset_question sq
					where q.question_id in (439, 440)
						and q.question_id=sq.question_id
					union
					select subset_id, 1 as optional_flag
					from subset
				) as q
				group by subset_id
			) as e
				on d.subset_id=e.subset_id
			inner join (
				select subset_id, min(schip_flag) as schip_flag
				from (
					select sq.subset_id, sq.exclude_flag as schip_flag
					from question q, subset_question sq
					where q.question_id=351
						and q.question_id=sq.question_id
					union
					select subset_id, 1 as schip_flag
					from subset
				) as q
				group by subset_id
			) as f
				on e.subset_id=f.subset_id
			inner join (
				select subset_id, min(state_flag) as state_flag
				from (
					select sq.subset_id, sq.exclude_flag as state_flag
					from question q, subset_question sq
					where q.question_id=430
						and q.question_id=sq.question_id
					union
					select subset_id, 1 as state_flag
					from subset
				) as q
				group by subset_id
			) as g
				on f.subset_id=g.subset_id
			left outer join display_language da
				on a.display_id=da.display_id
					and da.language_id='EN'
			left outer join display_language db
				on a.alt_display_id=db.display_id
					and db.language_id='EN'
			left outer join display_language dc
				on a.intro_display_id=dc.display_id
					and dc.language_id='EN'
			left outer join display_language dd
				on a.spq_display_id=dd.display_id
					and dd.language_id='EN'
		</cfquery>
	</cfcase>
	
    <!--- MH: 5/12/10 Removed reference to view_xsubset_category since it is being archived on BCUQA 
	<cfcase value="view_xsubset_category">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_xsubset_category] AS
			select subset_id, programcategory_id as category_id, exclude_flag
			from subset_programcategory
		</cfquery>
	</cfcase>--->
	<cfcase value="view_xsubset_program">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_xsubset_program] AS
			select subset_id, program_id, exclude_flag
			from subset_program
		</cfquery>
	</cfcase>

	<cfcase value="view_xsubset_xassettype">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_xsubset_xassettype] AS
			select b.subset_id, b.gridrow_id as assettype_id
			from (
				select sg.subset_id, sg.gridrow_id, sg.exclude_flag
				from question_gridrow qg, subset_gridrow sg
				where qg.question_id=437
					and qg.gridrow_id=sg.gridrow_id
			) as a right outer join (
				select s.subset_id, h.id, h.gridrow_id, h.exclude_flag, h.code
				from (
					select sg.subset_id
					from question_gridrow qg, subset_gridrow sg
					where qg.question_id in (436, 437)
						and qg.gridrow_id=sg.gridrow_id
					group by sg.subset_id
				) as s, (
					select qg.gridrow_id
					from question_gridrow qg
					where qg.question_id=437
				) as g, (
					select gridrow_id as id, (gridrow_id - 13) as gridrow_id, exclude_flag, code
					from gridrow
				) as h
				where g.gridrow_id=h.id
			) as b
				on a.subset_id=b.subset_id and a.gridrow_id=b.id
			where (a.subset_id is null and b.exclude_flag=0)
				or (a.exclude_flag=0 and b.exclude_flag=1)
		</cfquery>
	</cfcase>
    
	<cfcase value="view_xsubset_xincass">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_xsubset_xincass] AS
			select subset_id, 1 as incass_id
			from subset_question
			where question_id=637
				and exclude_flag=0
			union
			select subset_id, 2 as incass_id
			from subset_question
			where question_id=638
				and exclude_flag=0
			union
			select subset_id, 4 as incass_id
			from subset_question
			where question_id=639
				and exclude_flag=0
			union
			select subset_id, 3 as incass_id
			from subset_question
			where question_id=640
				and exclude_flag=0	
		</cfquery>
	</cfcase>

	<cfcase value="view_xsubset_xincometype">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_xsubset_xincometype] AS
			select b.subset_id, b.gridrow_id as incometype_id
			from (
				select sg.subset_id, sg.gridrow_id, sg.exclude_flag
				from question_gridrow qg, subset_gridrow sg
				where qg.question_id=436
					and qg.gridrow_id=sg.gridrow_id
			) as a right outer join (
				select s.subset_id, h.id, h.gridrow_id, h.exclude_flag, h.code
				from (
					select sg.subset_id
					from question_gridrow qg, subset_gridrow sg
					where qg.question_id in (436, 437)
						and qg.gridrow_id=sg.gridrow_id
					group by sg.subset_id
				) as s, (
					select qg.gridrow_id
					from question_gridrow qg
					where qg.question_id=436
				) as g, (
					select gridrow_id as id, gridrow_id, exclude_flag, code
					from gridrow
					where gridrow_id < 10
					union
					select gridrow_id as id, 13 as gridrow_id, exclude_flag, code
					from gridrow
					where gridrow_id = 10
					union
					select gridrow_id as id, (gridrow_id - 1) as gridrow_id, exclude_flag, code
					from gridrow
					where gridrow_id > 10
				) as h
				where g.gridrow_id=h.id
			) as b
				on a.subset_id=b.subset_id and a.gridrow_id=b.id
			where (a.subset_id is null and b.exclude_flag=0)
				or (a.exclude_flag=0 and b.exclude_flag=1)
		</cfquery>
	</cfcase>

	<cfcase value="view_zip_distance">
		<cfquery name="createview" datasource="#attributes.source#">
			CREATE VIEW [dbo].[view_zip_distance] AS
			select z1.zipcode start_zipcode, z1.state_id start_state_id, z2.zipcode end_zipcode, z2.state_id end_state_id,
				case
					when z1.zipcode=z2.zipcode
							then 0
					when z1.latitude=z2.latitude
						and z1.longitude=z2.longitude
							then 0
					when (sin(z2.latitude) * sin(z1.latitude) + cos(z2.latitude) * cos(z1.latitude) * cos(z1.longitude - z2.longitude))=1
							then 0
					else (3963 * (atan(-(sin(z2.latitude) * sin(z1.latitude) + cos(z2.latitude) * cos(z1.latitude) * cos(z1.longitude - z2.longitude))
						/ sqrt(-(sin(z2.latitude) * sin(z1.latitude) + cos(z2.latitude) * cos(z1.latitude) * cos(z1.longitude - z2.longitude))
						* (sin(z2.latitude) * sin(z1.latitude) + cos(z2.latitude) * cos(z1.latitude)
						* cos(z1.longitude - z2.longitude)) + 1)) + 2 * atan(1)))
				end distance
			from zip z1, zip z2
		</cfquery>
	</cfcase>
</cfswitch>
</cfsilent>