<cfquery name="results" datasource="#application.dbSrc#">
select  chnglistargtrate, * from mp_dataelement
where dataelement_id = 200951000


</cfquery>
<cfdump var="#results#"><cfabort>
<!--- Display results  - comment out when executing batch --->  
	<cfquery name="spvars2" datasource="#application.dbSrc#">
		select *
	from zip
	where state_id='VI'
	</cfquery>
	<cfdump var="#spvars2#">
		<cfquery name="spvars2" datasource="#application.dbSrc#">
		select *
		from county where state_id = 'VI' limit 0, 10
	</cfquery>
	<cfdump var="#spvars2#">
		<cfdump var="#spvars2#">
		<cfquery name="spvars2" datasource="#application.dbSrc#">
	select q.question_id, q.question_code, q.suppress_qno_flag suppress, q.spq_exclude_flag spx,
			q.sort qsort, qt.code, qc.questioncategory_code cat, qd.code head, f.format_code format,
			d.display_code short, d2.display_code spq, d3.display_code help, r.code `rule`,r.rule_text,
			a.answerfield_id, a.answerfield, qa.sort asort
		from question q inner join questiontype qt
				on q.questiontype_id=qt.questiontype_id
			inner join questioncategory qc
				on q.questioncategory_id=qc.questioncategory_id
			left outer join questionheader qd
				on q.questionheader_id=qd.questionheader_id
			left outer join format f
				on q.format_id=f.format_id
			left outer join display d
				on q.short_display_id=d.display_id
			left outer join display d2
				on q.spq_display_id=d2.display_id
			left outer join question_help qh
				on q.question_id=qh.question_id
			left outer join help h
				on qh.help_id=h.help_id
			left outer join display d3
				on h.display_id=d3.display_id
			right join `rule` r
				on q.rule_id=r.rule_id
			left outer join question_answerfield qa
				on q.question_id=qa.question_id
			left outer join answerfield a
				on qa.answerfield_id=a.answerfield_id
		order by q.sort, qa.sort
		</cfquery>
	<cfdump var="#spvars2#">