<cfquery name="anslistquery" datasource="#application.dbSrc#">
	select a.answerfield
	from program_answerfield pa, answerfield a
	where pa.program_id=#program_id#
		and pa.answerfield_id=a.answerfield_id
		and a.answerfieldtype_id in (13, 14, 15)
	order by a.answerfield
</cfquery>
<cfset rulelist=ValueList(anslistquery.answerfield)>