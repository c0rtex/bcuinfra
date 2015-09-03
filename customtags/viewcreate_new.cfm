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
		CREATE VIEW `view_city_county` AS select `c`.`city_id` AS `city_id`,`z`.`county_id` AS `county_id` from ((`city` `c` join `city_zip` `cz`) join `zip` `z`) where ((`c`.`valid` = 1) and (`c`.`city_id` = `cz`.`city_id`) and (`cz`.`valid` = 1) and (`cz`.`zipcode` = `z`.`zipcode`) and (`z`.`valid` = 1)) group by `c`.`city_id`,`z`.`county_id`;
	</cfquery>
</cfcase>

<cfcase value="view_city_zip_preferred">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_city_zip_preferred` AS select `c`.`pref_city_id` AS `city_id`,`cz`.`zipcode` AS `zipcode` from ((`city` `c` join `city_zip` `cz`) join `zip` `z`) where ((`c`.`pref_city_id` is not null) and (`c`.`exclude_flag` = 0) and (`c`.`valid` = 1) and (`c`.`city_id` = `cz`.`city_id`) and (`cz`.`valid` = 1) and (`cz`.`zipcode` = `z`.`zipcode`) and (`z`.`valid` = 1)) union select `c`.`city_id` AS `city_id`,`z`.`zipcode` AS `zipcode` from ((`city` `c` join `city_zip` `cz`) join `zip` `z`) where (ifnull(`c`.`pref_city_id`) and (`c`.`exclude_flag` = 0) and (`c`.`valid` = 1) and (`c`.`city_id` = `cz`.`city_id`) and (`cz`.`valid` = 1) and (`cz`.`zipcode` = `z`.`zipcode`) and (`z`.`valid` = 1));
	</cfquery>
</cfcase>

<cfcase value="view_opt">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_opt` AS select `dl`.`display_text` AS `option_nm`,_utf8'drugnm' AS `field_nm`,`a`.`answerfield` AS `fieldtext`,NULL AS `validation`,_utf8'chk' AS `opt_type`,`a`.`answerfield_id` AS `opt_id`,`a`.`answerfield_id` AS `sort_id` from (`answerfield` `a` join `display_language` `dl` on((`a`.`display_id` = `dl`.`display_id`))) where ((`a`.`answerfieldtype_id` in (13,14)) and (`dl`.`language_id` = _latin1'EN'));
	</cfquery>
</cfcase>

<cfcase value="view_program_answerfield">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_program_answerfield` AS select `pr`.`program_id` AS `program_id`,`ra`.`answerfield_id` AS `answerfield_id`,1 AS `rule_flag` from (`rule_answerfield` `ra` join `program_rule` `pr`) where (`ra`.`rule_id` = `pr`.`rule_id`) group by `pr`.`program_id`,`ra`.`answerfield_id`;
	</cfquery>
</cfcase>

<cfcase value="view_subset_program_diff">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_subset_program_diff` AS select `sps`.`subset_id` AS `subset_id`,`sps`.`program_id` AS `program_id` from (`subset_program_sum` `sps` left join `subset_program_base` `spb` on(((`sps`.`subset_id` = `spb`.`subset_id`) and (`sps`.`program_id` = `spb`.`program_id`)))) where ifnull(`spb`.`subset_id`);
	</cfquery>
</cfcase>

<cfcase value="view_subset_question">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_subset_question` AS select `sq`.`subset_id` AS `subset_id`,`sq`.`question_id` AS `question_id`,`q`.`display_id` AS `display_id`,`sq`.`page_id` AS `page_id`,`pg`.`sort` AS `pgsort`,`q`.`sort` AS `qsort` from ((`subset_question` `sq` join `page` `pg`) join `question` `q`) where ((`sq`.`required_flag` = 0) and (`sq`.`exclude_flag` = 0) and (`sq`.`options_flag` = 0) and (`sq`.`page_id` = `pg`.`page_id`) and (`sq`.`question_id` = `q`.`question_id`));
	</cfquery>
</cfcase>

<cfcase value="view_tbl_req_mat_list">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_req_mat_list` AS select `r`.`code` AS `code`,`da`.`display_text` AS `req_mat`,_utf8'marlene' AS `added_by`,cast(_utf8'2003-05-08' as datetime) AS `added_dt`,_utf8'marlene' AS `mod_by`,cast(_utf8'2004-12-16' as datetime) AS `mod_dt`,`r`.`requisite_id` AS `mat_id`,`db`.`display_text` AS `definition` from ((`requisite` `r` join `display_language` `da` on(((`r`.`display_id` = `da`.`display_id`) and (`da`.`language_id` = _latin1'EN')))) left join `display_language` `db` on(((`r`.`def_display_id` = `db`.`display_id`) and (`db`.`language_id` = _latin1'EN'))));
	</cfquery>
</cfcase>

<cfcase value="view_xsubset_category">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_xsubset_category` AS select `subset_programcategory`.`subset_id` AS `subset_id`,`subset_programcategory`.`programcategory_id` AS `category_id`,`subset_programcategory`.`exclude_flag` AS `exclude_flag` from `subset_programcategory`;
	</cfquery>
</cfcase>

<cfcase value="view_xsubset_program">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_xsubset_program` AS select `subset_program`.`subset_id` AS `subset_id`,`subset_program`.`program_id` AS `program_id`,`subset_program`.`exclude_flag` AS `exclude_flag` from `subset_program`;
	</cfquery>
</cfcase>

<cfcase value="view_zip_distance">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_zip_distance` AS select `z1`.`zipcode` AS `start_zipcode`,`z1`.`state_id` AS `start_state_id`,`z2`.`zipcode` AS `end_zipcode`,`z2`.`state_id` AS `end_state_id`,(case when (`z1`.`zipcode` = `z2`.`zipcode`) then 0 when ((`z1`.`latitude` = `z2`.`latitude`) and (`z1`.`longitude` = `z2`.`longitude`)) then 0 when (((sin(`z2`.`latitude`) * sin(`z1`.`latitude`)) + ((cos(`z2`.`latitude`) * cos(`z1`.`latitude`)) * cos((`z1`.`longitude` - `z2`.`longitude`)))) = 1) then 0 else (3963 * (atan((-(((sin(`z2`.`latitude`) * sin(`z1`.`latitude`)) + ((cos(`z2`.`latitude`) * cos(`z1`.`latitude`)) * cos((`z1`.`longitude` - `z2`.`longitude`))))) / sqrt(((-(((sin(`z2`.`latitude`) * sin(`z1`.`latitude`)) + ((cos(`z2`.`latitude`) * cos(`z1`.`latitude`)) * cos((`z1`.`longitude` - `z2`.`longitude`))))) * ((sin(`z2`.`latitude`) * sin(`z1`.`latitude`)) + ((cos(`z2`.`latitude`) * cos(`z1`.`latitude`)) * cos((`z1`.`longitude` - `z2`.`longitude`))))) + 1)))) + (2 * atan(1)))) end) AS `distance` from (`zip` `z1` join `zip` `z2`);
	</cfquery>
</cfcase>

<cfcase value="view_zip_prox">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_zip_prox` AS select `z`.`Zip` AS `userzip`,`z`.`CityStName` AS `usercity`,`z`.`State` AS `userstate`,`z`.`Lat` AS `userlat`,`z`.`Lon` AS `userlon`,`zz`.`Zip` AS `zip`,`zz`.`CityStName` AS `city`,`zz`.`State` AS `state`,`zz`.`Lat` AS `lat`,`zz`.`Lon` AS `lon`,(case when (`z`.`Zip` = `zz`.`Zip`) then 0.001 when ((`z`.`Lat` = `zz`.`Lat`) and (`z`.`Lon` = `zz`.`Lon`)) then 0.001 when (((sin(`zz`.`Lat`) * sin(`z`.`Lat`)) + ((cos(`zz`.`Lat`) * cos(`z`.`Lat`)) * cos((`z`.`Lon` - `zz`.`Lon`)))) = 1) then 0.001 else (3963 * (atan((-(((sin(`zz`.`Lat`) * sin(`z`.`Lat`)) + ((cos(`zz`.`Lat`) * cos(`z`.`Lat`)) * cos((`z`.`Lon` - `zz`.`Lon`))))) / sqrt(((-(((sin(`zz`.`Lat`) * sin(`z`.`Lat`)) + ((cos(`zz`.`Lat`) * cos(`z`.`Lat`)) * cos((`z`.`Lon` - `zz`.`Lon`))))) * ((sin(`zz`.`Lat`) * sin(`z`.`Lat`)) + ((cos(`zz`.`Lat`) * cos(`z`.`Lat`)) * cos((`z`.`Lon` - `zz`.`Lon`))))) + 1)))) + (2 * atan(1)))) end) AS `miles` from (`tbl_zip` `z` join `tbl_zip` `zz`);
	</cfquery>
</cfcase>


<cfcase value="view_program_parent_1">
	<cfquery name="createview" datasource="#attributes.source#">
		create view view_program_parent_1 AS
SELECT p.recid AS program_id, pp.recid AS parent_program_id
FROM tbl_prg_all pp, tbl_rules r, tbl_prg_all p
WHERE r.prg_id=p.prg_id and 
      r.elig_rule LIKE '%prg%' and
      LOCATE(pp.prg_id, r.elig_rule) > 0; /*simple test OK but runs VEEERY slow */
	</cfquery>
</cfcase>



<cfcase value="view_program_parent_2">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_program_parent_2 AS
SELECT p.recid as program_id, ppp.recid as parent_program_id
FROM tbl_prg_all ppp, tbl_rules rr, tbl_prg_all pp, tbl_rules r, tbl_prg_all p
WHERE rr.prg_id=pp.prg_id AND r.prg_id=p.prg_id AND 
      rr.elig_rule LIKE '%prg%' AND r.elig_rule LIKE '%prg%'
      AND LOCATE(ppp.prg_id, rr.elig_rule) > 0
      AND LOCATE(pp.prg_id, r.elig_rule) > 0;  /*simple test OK but runs VEEERY slow */
	</cfquery>
</cfcase>


<cfcase value="view_program_parent_3">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_program_parent_3 AS
SELECT p.recid AS program_id, pppp.recid AS parent_program_id
FROM tbl_prg_all pppp, tbl_rules rrr, tbl_prg_all ppp, tbl_rules rr, tbl_prg_all pp, tbl_rules r, tbl_prg_all p
WHERE rrr.elig_rule LIKE '%prg%'
      AND LOCATE(pppp.prg_id, rrr.elig_rule) > 0
      AND rrr.prg_id=ppp.prg_id
      AND rr.elig_rule LIKE '%prg%'
      AND LOCATE(ppp.prg_id, rr.elig_rule) > 0
      AND rr.prg_id=pp.prg_id
      AND r.elig_rule LIKE '%prg%'
      AND LOCATE(pp.prg_id, r.elig_rule) > 0
      AND r.prg_id=p.prg_id;
	</cfquery>
</cfcase>



<cfcase value="view_program_parent_4">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_program_parent_4 AS
SELECT p.recid AS program_id, ppppp.recid AS parent_program_id
FROM tbl_prg_all ppppp, tbl_rules rrrr, tbl_prg_all pppp, tbl_rules rrr, tbl_prg_all ppp, tbl_rules rr, tbl_prg_all pp, tbl_rules r, tbl_prg_all p
WHERE rrrr.elig_rule LIKE '%prg%'
      AND LOCATE(ppppp.prg_id, rrrr.elig_rule) > 0
      AND rrrr.prg_id=pppp.prg_id
      AND rrr.elig_rule LIKE '%prg%'
      AND LOCATE(pppp.prg_id, rrr.elig_rule) > 0
      AND rrr.prg_id=ppp.prg_id
      AND rr.elig_rule LIKE '%prg%'
      AND LOCATE(ppp.prg_id, rr.elig_rule) > 0
      AND rr.prg_id=pp.prg_id
      AND r.elig_rule LIKE '%prg%'
      AND LOCATE(pp.prg_id, r.elig_rule) > 0
      AND r.prg_id=p.prg_id;
	</cfquery>
</cfcase>


CREATE VIEW view_program_parent
AS
SELECT program_id, parent_program_id
FROM      view_program_parent_1
UNION
SELECT program_id, parent_program_id
FROM     view_program_parent_2
UNION
SELECT program_id, parent_program_id
FROM     view_program_parent_3
UNION
SELECT program_id, parent_program_id
FROM     view_program_parent_4 q;
	</cfquery>
</cfcase>





<cfcase value="view_rule_answerfield">
	<cfquery name="createview" datasource="#attributes.source#">
		create view view_rule_answerfield AS
select r.rule_id, a.answerfield_id
from answerfield a, rule r
where r.rule_text like CONCAT('%[^a-z0-9_]session.', a.answerfield, '[^a-z0-9_]%')
	or r.rule_text like CONCAT('session.' , a.answerfield , '[^a-z0-9_]%')
	or r.rule_text like CONCAT('%[^a-z0-9_]session.' , a.answerfield)
	or r.rule_text like CONCAT('session.' , a.answerfield)
union
select r.rule_id, ha.answerfield_id
from hardrule hr, rule r, hardrule_answerfield ha
where (r.rule_text like CONCAT('%[^a-z0-9_]' , hr.code , '[^a-z0-9_]%')
		or r.rule_text like CONCAT(hr.code , '[^a-z0-9_]%')
		or r.rule_text like CONCAT('%[^a-z0-9_]' , hr.code)
		or r.rule_text like hr.code)
	and hr.hardrule_id=ha.hardrule_id;
	</cfquery>
</cfcase>





CREATE  VIEW view_subset_program_base_p1 AS 
select s.subset_id AS subset_id,p.RecID AS program_id from 
(subset s join tbl_prg_all p) where ((s.subsettype_id = 6) and (p.exclude_flag = 0)) 
union 
select s.subset_id AS subset_id,p.RecID AS program_id from (((subset s join subset_programcategory sc on((s.subset_id = sc.subset_id))) 
join programcategory c on((sc.programcategory_id = c.programcategory_id))) join tbl_prg_all p on((c.legacy_code = p.Cat_ID))) 
where ((ifnull(sc.exclude_flag) or (sc.exclude_flag = 0)) 
and (p.exclude_flag = 0)) union select s.subset_id AS subset_id,sp.program_id AS program_id 
from (subset s join subset_program sp on((s.subset_id = sp.subset_id))) where (ifnull(sp.exclude_flag) or (sp.exclude_flag = 0));
	</cfquery>
</cfcase>




<cfcase value="view_subset_program_base_p2">
	<cfquery name="createview" datasource="#attributes.source#">
		create view view_subset_program_base_p2 AS 
SELECT     s.subset_id as subset_id, p.RecID AS program_id
                            FROM          subset AS s INNER JOIN
                                                   subset_programcategory AS sc ON s.subset_id = sc.subset_id INNER JOIN
                                                   programcategory AS c ON sc.programcategory_id = c.programcategory_id INNER JOIN
                                                   tbl_prg_all AS p ON c.legacy_code = p.Cat_ID
                            WHERE      (sc.exclude_flag = 1)
                            UNION
                            SELECT     s.subset_id, sp.program_id
                            FROM         subset AS s INNER JOIN
                                                  subset_program AS sp ON s.subset_id = sp.subset_id
                            WHERE     (sp.exclude_flag = 1);
	</cfquery>
</cfcase>



<cfcase value="view_subset_program_base">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_subset_program_base AS
SELECT     si.subset_id, si.program_id from
view_subset_program_base_p1 AS si LEFT OUTER JOIN
view_subset_program_base_p2 as so ON si.subset_id = so.subset_id AND si.program_id = so.program_id
WHERE     (so.subset_id IS NULL);
	</cfquery>
</cfcase>


<cfcase value="view_subset_program_sum">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_subset_program_sum AS
SELECT  subset_id, program_id
FROM  view_subset_program_base
UNION
SELECT     spb.subset_id, pp.parent_program_id AS program_id
FROM       view_subset_program_base AS spb INNER JOIN
view_program_parent AS pp ON spb.program_id = pp.program_id;  /* very slow */
	</cfquery>
</cfcase>

                            
<cfcase value="view_tbl_rules">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_rules AS
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
from rule r, program_rule pr, program p
where r.rule_id=pr.rule_id
		and pr.program_id=p.program_id
		and p.legacy_prg_id is not null;
</cfquery>
</cfcase>



<cfcase value="view_tbl_major_cat_list">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_major_cat_list AS 
select substring(dl.display_text, 1, 30) as  major_cat, pc.code,
	ifnull(pc.legacy_code, pc.programcategory_id + 297) id_number,
	NULL added_by, NULL added_dt, NULL mod_by, NULL mod_dt,
	pc.programcategory_id RecID, pc.sort Sort_order
from programcategory pc inner join display_language dl
	on pc.display_id=dl.display_id and dl.language_id='EN';
</cfquery>
</cfcase>




/*---------following 7 views are parts of view_tbl_prg_all -------------------*/
<cfcase value="view_tbl_prg_all_p1">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_prg_all_p1` AS select `program_proximity`.`program_id` AS `program_id`,sum(`program_proximity`.`sort`) AS `s` from `program_proximity` group by `program_proximity`.`program_id`;
</cfquery>
</cfcase>

<cfcase value="view_tbl_prg_all_p2">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_prg_all_p2` AS select `px`.`program_id` AS `program_id`,`x`.`code` AS `code` from (`program_proximity` `px` join `proximity` `x`) where ((`px`.`sort` = 1) and (`px`.`proximity_id` = `x`.`proximity_id`));
</cfquery>
</cfcase>

<cfcase value="view_tbl_prg_all_p3">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_prg_all_p3` AS select `program_proximity`.`program_id` AS `program_id`,sum(`program_proximity`.`sort`) AS `s` from `program_proximity` group by `program_proximity`.`program_id`;
</cfquery>
</cfcase>

<cfcase value="view_tbl_prg_all_p4">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_prg_all_p4` AS select `px`.`program_id` AS `program_id`,`x`.`code` AS `code` from (`program_proximity` `px` join `proximity` `x`) where ((`px`.`sort` = 1) and (`px`.`proximity_id` = `x`.`proximity_id`));
</cfquery>
</cfcase>

<cfcase value="view_tbl_prg_all_p5">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_prg_all_p5` AS select `px`.`program_id` AS `program_id`,`x`.`code` AS `code` from (`program_proximity` `px` join `proximity` `x`) where ((`px`.`sort` = 2) and (`px`.`proximity_id` = `x`.`proximity_id`));
</cfquery>
</cfcase>

<cfcase value="view_tbl_prg_all_p6">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_prg_all_p6` AS select `x`.`program_id` AS `program_id`,`y`.`code` AS `proximity`,NULL AS `firstproximity` from (`view_tbl_prg_all_p1` `x` join `view_tbl_prg_all_p2` `y`) where ((`x`.`s` = 1) and (`x`.`program_id` = `y`.`program_id`)) union select `x`.`program_id` AS `program_id`,`z`.`code` AS `proximity`,`y`.`code` AS `firstproximity` from ((`view_tbl_prg_all_p3` `x` join `view_tbl_prg_all_p4` `y`) join `view_tbl_prg_all_p5` `z`) where ((`x`.`s` = 3) and (`x`.`program_id` = `y`.`program_id`) and (`y`.`program_id` = `z`.`program_id`));
</cfquery>
</cfcase>

<cfcase value="view_tbl_programgroup_id_eq1">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW `view_tbl_programgroup_id_eq1` AS select `program`.`program_id` AS `program_id` from `program` where (`program`.`programgroup_id` = 1);
</cfquery>
</cfcase>
/*----------------------------------------------------------------------------*/


<cfcase value="view_tbl_prg_all">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_prg_all AS
select p.program_id as RecID, p.program_code as code,
	ifnull(p.legacy_prg_id, concat('XXX-XXX-' , p.program_id  , '-XX-XX')) as prg_id,
	p.sort as order_num, ifnull(p.legacy_pri_sec, 1) as pri_sec, substring(da.display_text, 1, 255) as prg_nm,
	substring(db.display_text, 1, 255) as prg_desc, ifnull(nullif(p.state_id, NULL), 'FD') as st,
	z.proximity, z.firstproximity, p.url as comment, p.create_date as added_dt,
	u.username as added_by, uu.username as mod_by, p.modify_date as mod_dt,
	substring(p.legacy_prg_id, 9, 4) as id, 0 as include, ifnull(r.name, 'unknown') as source,
	0 as dollar_amount, pc.id_number as Cat_ID, ifnull(exclude_flag, 0) as exclude_flag,
	(1 - ifnull(active_flag, 0)) as inactive_flag, ifnull(significant_flag, 0) as significant_flag,
	sign(ifnull(pp.program_id, 0)) as childrens_flag
from program p inner join view_tbl_major_cat_list pc
		on p.programcategory_id=pc.RecID
	left outer join view_tbl_prg_all_p6 as z
		on p.program_id=z.program_id
	left outer join `user` u
		on p.create_user_id=u.user_id
	left outer join `user` uu
		on p.modify_user_id=uu.user_id
	left outer join reference r
		on p.reference_id=r.reference_id
	left outer join display_language da
		on p.name_display_id=da.display_id
			and da.language_id='EN'
	left outer join display_language db
		on p.desc_display_id=db.display_id
			and db.language_id='EN'
	left outer join view_tbl_programgroup_id_eq1 pp
		on p.program_id=pp.program_id;
        </cfquery>
</cfcase>



create view view_tbl_questions_new_p1
as
select '0' + substring(cast(`sort` as char), 1, 1) + '-' + questioncategory_code as category, questioncategory_id
from questioncategory
where sort < 10
union
select substring(cast(`sort` as char), 1, 2) + '-' + questioncategory_code as category, questioncategory_id
from questioncategory
where sort > 9;
	</cfquery>
</cfcase>



<cfcase value="view_tbl_questions_new_p2">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p2 AS
select q.question_id, q.question_code, 0 as depth
from question q
union
select q.question_id, q.question_code, 1 as depth
from question q, rule r, answerfield a
where q.questioncategory_id not in (13)
	and q.rule_id=r.rule_id
	and r.rule_text like concat('%#session.' , a.answerfield , '#%')
union
select q.question_id, q.question_code, 2 as depth
from question q, rule r, answerfield a, question_answerfield qa,
	question qq, rule rr, answerfield aa
where q.questioncategory_id not in (13)
	and q.rule_id=r.rule_id
	and r.rule_text like concat('%#session.' , a.answerfield , '#%')
	and a.answerfield_id=qa.answerfield_id
	and qa.question_id=qq.question_id
	and qq.questioncategory_id not in (13)
	and qq.rule_id=rr.rule_id
	and rr.rule_text like concat('%#session.' , aa.answerfield , '#%')
union
select q.question_id, q.question_code, 3 as depth
from question q, rule r, answerfield a, question_answerfield qa,
	question qq, rule rr, answerfield aa, question_answerfield qqaa,
	question qqq, rule rrr, answerfield aaa
where q.questioncategory_id not in (13)
	and q.rule_id=r.rule_id
	and r.rule_text like concat('%#session.' , a.answerfield , '#%')
	and a.answerfield_id=qa.answerfield_id
	and qa.question_id=qq.question_id
	and qq.questioncategory_id not in (13)
	and qq.rule_id=rr.rule_id
	and rr.rule_text like concat('%#session.' , aa.answerfield , '#%')
	and aa.answerfield_id=qqaa.answerfield_id
	and qqaa.question_id=qqq.question_id
	and qqq.questioncategory_id not in (13)
	and qqq.rule_id=rrr.rule_id
	and rrr.rule_text like concat('%#session.' , aaa.answerfield , '#%')
union
select q.question_id, q.question_code, 4 as depth
from question q, rule r, answerfield a, question_answerfield qa,
	question qq, rule rr, answerfield aa, question_answerfield qqaa,
	question qqq, rule rrr, answerfield aaa, question_answerfield qqqaaa,
	question qqqq, rule rrrr, answerfield aaaa
where q.questioncategory_id not in (13)
	and q.rule_id=r.rule_id
	and r.rule_text like concat('%#session.' , a.answerfield , '#%')
	and a.answerfield_id=qa.answerfield_id
	and qa.question_id=qq.question_id
	and qq.questioncategory_id not in (13)
	and qq.rule_id=rr.rule_id
	and rr.rule_text like concat('%#session.' , aa.answerfield , '#%')
	and aa.answerfield_id=qqaa.answerfield_id
	and qqaa.question_id=qqq.question_id
	and qqq.questioncategory_id not in (13)
	and qqq.rule_id=rrr.rule_id
	and rrr.rule_text like concat('%#session.' , aaa.answerfield , '#%')
	and aaa.answerfield_id=qqqaaa.answerfield_id
	and qqqaaa.question_id=qqqq.question_id
	and qqqq.questioncategory_id not in (13)
	and qqqq.rule_id=rrrr.rule_id
	and rrrr.rule_text like concat('%#session.' , aaaa.answerfield , '#%');
	</cfquery>
</cfcase>



<cfcase value="view_tbl_questions_new_p3">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p3 AS                        
select 0 as depth, 'pri' as pri_sec
union
select 1 as depth, 'sec' as pri_sec
union
select 2 as depth, 'secdep' as pri_sec
union
select 3 as depth, 'secdep' as pri_sec
union
select 4 as depth, 'secthird' as pri_sec;
	</cfquery>
</cfcase>


<cfcase value="view_tbl_questions_new_p4">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p4 AS                        
select question_id, question_code, max(depth) as maxdepth
						from view_tbl_questions_new_p2 q
						group by question_id, question_code;
	</cfquery>
</cfcase>
                        
                        
<cfcase value="view_tbl_questions_new_p5">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p5 AS                                                
select q.question_id, r.pri_sec
					from view_tbl_questions_new_p4 q,
          view_tbl_questions_new_p3 r
					where q.maxdepth=r.depth;
	</cfquery>
</cfcase>
                    

<cfcase value="view_tbl_questions_new_p6">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p6 AS                                                
select q.question_id, q.question_code, min(qa.sort) minsort
from question q, question_answerfield qa
where q.question_id not in (351, 429, 432, 433, 434, 435, 633, 634, 637, 638, 639, 640)
	and q.questioncategory_id not in (11, 13)
	and q.question_id=qa.question_id
group by q.question_id, q.question_code;
	</cfquery>
</cfcase>


<cfcase value="view_tbl_questions_new_p7">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p7 AS                                                                        
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
							select 100 as type_id, 'opt' as type, 'integer' as validation, 2 as textlength;
	</cfquery>
</cfcase>



<cfcase value="view_tbl_questions_new_p8">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p8 AS                                                                        
select answerfield_id, answerfieldtype_id
from answerfield
where answerfield_id not in (102)
union
select 102 as answerfield_id, 100 as answerfieldtype_id;
	</cfquery>
</cfcase>


<cfcase value="view_tbl_questions_new_p9">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p9 AS                                                                                                    
select answerfieldtype_id
from answerfieldtype
union
select 100 as answerfieldtype_id;
	</cfquery>
</cfcase>


<cfcase value="view_tbl_questions_new_p10">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new_p10 AS                            
select q.question_id, t.type, t.validation, t.textlength
from view_tbl_questions_new_p6 q 
inner join question_answerfield qa
on q.question_id=qa.question_id and q.minsort=qa.sort
inner join view_tbl_questions_new_p8 a
	on qa.answerfield_id=a.answerfield_id
inner join view_tbl_questions_new_p9 ay
	on a.answerfieldtype_id=ay.answerfieldtype_id
left outer join view_tbl_questions_new_p7 t
on ay.answerfieldtype_id=t.type_id; 
	</cfquery>
</cfcase>


<cfcase value="view_tbl_questions_new">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_tbl_questions_new AS
			select q.question_id, q.question_code as answerfield, qc.category, q.sort as order_num,
				ps.pri_sec, dl.display_text as question, tv.type, tv.validation,
				'self' as client, tv.textlength, null as dep_field, null as dep_op,
				null as dep_criteria, r.rule_text as dep_formula
			from question q inner join view_tbl_questions_new_p1 qc
					on q.questioncategory_id=qc.questioncategory_id
      inner join  view_tbl_questions_new_p5 ps
					on q.question_id=ps.question_id
				inner join display_language dl
					on q.display_id=dl.display_id
				left outer join view_tbl_questions_new_p10 tv
					on q.question_id=tv.question_id
				left outer join rule r
					on q.rule_id=r.rule_id
			where dl.language_id='EN';
	</cfquery>
</cfcase>




<cfcase value="view_xsubset_p1">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p1 AS
select subset_id, code, description as subset_description, oe_name as alt_name,
		(resultpage_id - 1) as rec_flag, (1 - eform_flag) as eform_flag, report_flag,
		display_id, alt_display_id, spq_display_id, intro_display_id
	from subset;
	</cfquery>
</cfcase>


<cfcase value="view_xsubset_p2">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p2 AS
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
			and subsettype_id <> 6;
	</cfquery>
</cfcase>


<cfcase value="view_xsubset_p3">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p3 AS
	select q.subset_id, max(q.subsettype_id) as subsettype_id, max(q.all_flag) as all_flag
	from view_xsubset_p2 as q
	group by q.subset_id;
	</cfquery>
</cfcase>


CREATE VIEW view_xsubset_p4
as
select distinct(sp.subset_id) as subset_id, 0 as drug_flag
from subset_program_sum sp, program_answerfield pa, answerfield a
where sp.program_id=pa.program_id
	and pa.answerfield_id=a.answerfield_id
	and a.answerfieldtype_id in (13, 14)
union
select sq.subset_id, sq.exclude_flag as drug_flag
from question q, subset_question sq
where q.question_id=438
	and q.question_id=sq.question_id;
	</cfquery>
</cfcase>

<cfcase value="view_xsubset_p5">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p5 AS
		select subset_id, max(drug_flag) as drug_flag
		from view_xsubset_p4 as q
		group by subset_id;
	</cfquery>
</cfcase>
        
<cfcase value="view_xsubset_p6">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p6 AS        
select s.subset_id, ifnull(drug_flag, 1) as drug_flag
	from subset s left outer join view_xsubset_p5 as r
		on s.subset_id=r.subset_id;
	</cfquery>
</cfcase>
        
        
<cfcase value="view_xsubset_p7">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p7 AS                
				select distinct(sg.subset_id) as subset_id, 1 as grid_flag
				from subset_gridrow sg, gridrow g
				where sg.gridrow_id=g.gridrow_id
					and sg.exclude_flag <> g.exclude_flag
				union
				select subset_id, 0 as grid_flag
				from question q, subset_question sq
				where q.question_id in (436, 437)
					and q.question_id=sq.question_id;
	</cfquery>
</cfcase>
                    
                    
<cfcase value="view_xsubset_p8">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p8 AS                                    
			select distinct(sq.subset_id) as subset_id, 2 as grid_flag
			from question q, subset_question sq
			where q.question_id in (637, 638, 639, 640)
				and q.question_id=sq.question_id
			union
			select subset_id, max(grid_flag) grid_flag
			from view_xsubset_p7 q
			group by subset_id;                    
	</cfquery>
</cfcase>

<cfcase value="view_xsubset_p9">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p9 AS
select subset_id, max(grid_flag) as grid_flag
		from view_xsubset_p8 as q
		group by subset_id;
	</cfquery>
</cfcase>
        
<cfcase value="view_xsubset_p10">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p10 AS        
select s.subset_id, ifnull(grid_flag, 3) as grid_flag
	from subset s left outer join view_xsubset_p9 as r
		on s.subset_id=r.subset_id;
	</cfquery>
</cfcase>
        
<cfcase value="view_xsubset_p11">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p11 AS                
select sq.subset_id, sq.exclude_flag as optional_flag
		from question q, subset_question sq
		where q.question_id in (439, 440)
			and q.question_id=sq.question_id
		union
		select subset_id, 1 as optional_flag
		from subset;
	</cfquery>
</cfcase>
        
        
<cfcase value="view_xsubset_p12">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p12 AS
select subset_id, min(optional_flag) as optional_flag
	from view_xsubset_p11 as q
	group by subset_id;
    
<cfcase value="view_xsubset_p13">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p13 AS    
		select sq.subset_id, sq.exclude_flag as schip_flag
		from question q, subset_question sq
		where q.question_id=351
			and q.question_id=sq.question_id
		union
		select subset_id, 1 as schip_flag
		from subset;
	</cfquery>
</cfcase>
        
        
<cfcase value="view_xsubset_p14">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p14 AS            
select subset_id, min(schip_flag) as schip_flag
	from view_xsubset_p13 as q
	group by subset_id;
        
<cfcase value="view_xsubset_p15">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p15 AS                    
select sq.subset_id, sq.exclude_flag as state_flag
		from question q, subset_question sq
		where q.question_id=430
			and q.question_id=sq.question_id
		union
		select subset_id, 1 as state_flag
		from subset;
	</cfquery>
</cfcase>
        
        
<cfcase value="view_xsubset_p16">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_p16 AS                            
select subset_id, min(state_flag) as state_flag
	from view_xsubset_p15 as q
	group by subset_id;        
	</cfquery>
</cfcase>
        

<cfcase value="view_xsubset">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset AS
select a.subset_id, b.subsettype_id, a.code, substring(da.display_text, 1, 255) as subset_name,
	substring(db.display_text, 1, 255) as subset_longname, a.subset_description,
	substring(dc.display_text, 1, 255) as subset_text,
	substring(dd.display_text, 1, 255) as qaire_name, a.alt_name,
	b.all_flag, c.drug_flag, d.grid_flag, e.optional_flag, ifnull(a.rec_flag, 0) as rec_flag,
	a.eform_flag, f.schip_flag, g.state_flag, a.report_flag
from view_xsubset_p1 as a 
inner join view_xsubset_p3 as b	on a.subset_id=b.subset_id
inner join view_xsubset_p6 as c
	on b.subset_id=c.subset_id
inner join view_xsubset_p10 as d
	on c.subset_id=d.subset_id
inner join view_xsubset_p12 as e
	on d.subset_id=e.subset_id
inner join view_xsubset_p14 as f
	on e.subset_id=f.subset_id
inner join view_xsubset_p16 as g
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
		and dd.language_id='EN';
	</cfquery>
</cfcase>




<cfcase value="view_xsubset_xassettype_p1">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xassettype_p1 AS
select sg.subset_id, sg.gridrow_id, sg.exclude_flag
from question_gridrow qg, subset_gridrow sg
where qg.question_id=437
	and qg.gridrow_id=sg.gridrow_id;
	</cfquery>
</cfcase>
                    
                    
<cfcase value="view_xsubset_xassettype_p2">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xassettype_p2 AS
select sg.subset_id
from question_gridrow qg, subset_gridrow sg
where qg.question_id in (436, 437)
	and qg.gridrow_id=sg.gridrow_id
group by sg.subset_id;
                    
<cfcase value="view_xsubset_xassettype_p3">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xassettype_p3 AS                    
select qg.gridrow_id
from question_gridrow qg
where qg.question_id=437;                
	</cfquery>
</cfcase>
                    

<cfcase value="view_xsubset_xassettype_p4">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xassettype_p4 AS                    
select gridrow_id as id, (gridrow_id - 13) as gridrow_id, exclude_flag, code
from gridrow;

<cfcase value="view_xsubset_xassettype_p5">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xassettype_p5 AS
select s.subset_id, h.id, h.gridrow_id, h.exclude_flag, h.code
				from view_xsubset_xassettype_p2 as s, view_xsubset_xassettype_p3 as g, 
        view_xsubset_xassettype_p4 as h
				where g.gridrow_id=h.id;
	</cfquery>
</cfcase>


<cfcase value="view_xsubset_xassettype">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xassettype AS
select b.subset_id, b.gridrow_id as assettype_id
from view_xsubset_xassettype_p1 as a right outer join view_xsubset_xassettype_p5 as b
	on a.subset_id=b.subset_id and a.gridrow_id=b.id
where (a.subset_id is null and b.exclude_flag=0)
	or (a.exclude_flag=0 and b.exclude_flag=1);
	</cfquery>
</cfcase>



CREATE VIEW view_xsubset_xincass
AS
SELECT     subset_id, 1 AS incass_id
FROM         subset_question
WHERE     (question_id = 637) AND (exclude_flag = 0)
UNION
SELECT     subset_id, 2 AS incass_id
FROM         subset_question AS subset_question_4
WHERE     (question_id = 638) AND (exclude_flag = 0)
UNION
SELECT     subset_id, 4 AS incass_id
FROM         subset_question AS subset_question_3
WHERE     (question_id = 639) AND (exclude_flag = 0)
UNION
SELECT     subset_id, 3 AS incass_id
FROM         subset_question AS subset_question_2
WHERE     (question_id = 640) AND (exclude_flag = 0)
UNION
SELECT     subset_id, 6 AS incass_id
FROM         subset_question AS subset_question_1
WHERE     (question_id = 652) AND (exclude_flag = 0);
	</cfquery>
</cfcase>


<cfcase value="view_xsubset_xincometype_p1">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xincometype_p1 AS
				select sg.subset_id, sg.gridrow_id, sg.exclude_flag
				from question_gridrow qg, subset_gridrow sg
				where qg.question_id=436
					and qg.gridrow_id=sg.gridrow_id;
	</cfquery>
</cfcase>
                    
<cfcase value="view_xsubset_xincometype_p2">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xincometype_p2 AS                    
select sg.subset_id
					from question_gridrow qg, subset_gridrow sg
					where qg.question_id in (436, 437)
						and qg.gridrow_id=sg.gridrow_id
					group by sg.subset_id;                    
	</cfquery>
</cfcase>
                    

<cfcase value="view_xsubset_xincometype_p3">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xincometype_p3 AS                    
select qg.gridrow_id
					from question_gridrow qg
					where qg.question_id=436;
	</cfquery>
</cfcase>
                    
                    
<cfcase value="view_xsubset_xincometype_p4">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xincometype_p4 AS
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
					where gridrow_id > 10;
	</cfquery>
</cfcase>
                    
<cfcase value="view_xsubset_xincometype_p5">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xincometype_p5 AS                    
select s.subset_id, h.id, h.gridrow_id, h.exclude_flag, h.code
				from view_xsubset_xincometype_p2 as s, view_xsubset_xincometype_p3 as g, 
        view_xsubset_xincometype_p4 as h
				where g.gridrow_id=h.id;
	</cfquery>
</cfcase>


<cfcase value="view_xsubset_xincometype">
	<cfquery name="createview" datasource="#attributes.source#">
		CREATE VIEW view_xsubset_xincometype AS
			select b.subset_id, b.gridrow_id as incometype_id
			from view_xsubset_xincometype_p1 as a right outer join 
      view_xsubset_xincometype_p5 as b
				on a.subset_id=b.subset_id and a.gridrow_id=b.id
			where (a.subset_id is null and b.exclude_flag=0)
				or (a.exclude_flag=0 and b.exclude_flag=1);
	</cfquery>
</cfcase>
</cfswitch>
</cfsilent>