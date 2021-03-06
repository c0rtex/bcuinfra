<cfparam name="format" type="string" default="csv"><cf_exportQuery query="
	select pt.programtext_id as id, pt.rec, pt.summary, p.program_code as program, pt.`type`,
		pt.benefit, pt.answerfield, pt.template, pt.sortorder, pt.active, pt.enrollment_flag
	from programtext pt left outer join program p
		on pt.program_id=p.program_id
	order by pt.programtext_id
" columnList="id,rec,summary,program,type,benefit,answerfield,template,sortorder,active,enrollment_flag" format="#format#">