<cfquery name="qxfer" datasource="#session.datasrc#">
select q.question_id, qq.question_code dep_question, q.question_code, q.questioncategory_id, qc.questioncategory_code, d.display_text, q.sort
from questioncategory qc inner join question q
		on qc.questioncategory_id=q.questioncategory_id
	inner join display_language d
		on q.display_id=d.display_id
	left outer join tbl_questions_new tq
		on q.question_id=tq.question_id
	left outer join question qq
		on q.dep_question_id=qq.question_id
where q.question_id <> 429
	and d.language_id='EN'
	and tq.question_id is null
order by q.question_id desc, tq.question_id desc
</cfquery>

<cfoutput>
<table border="1">
<cfloop query="qxfer">
	<cfset cat = "#questioncategory_id#-#questioncategory_code#">
	<cfif questioncategory_id lt 10>
		<cfset cat = "0#cat#">
	</cfif>
	<cfset order = sort>
	<cfif sort lt 100>
		<cfset order = "0#order#">
		<cfif sort lt 10>
			<cfset order = "0#order#">
		</cfif>
	</cfif>
	<cfif dep_question eq ''>
		<cfset dep = 'NULL'>
		<cfset prisec = 'pri'>
	<cfelse>
		<cfset dep = "'#dep_question#'">
		<cfset prisec = 'sec'>
	</cfif>
	<cfset order = "zzzz#order#">
	<tr>
		<td valign="top">#question_id#</td>
		<td valign="top">#dep#</td>
		<td valign="top">#prisec#</td>
		<td valign="top">#question_code#</td>
		<td valign="top">#cat#</td>
		<td valign="top">#display_text#</td>
		<td valign="top">#order#</td>
	</tr>
	<cfquery name="ins" datasource="#session.datasrc#">
		INSERT INTO tbl_questions_new
			(question_id, category, order_num, pri_sec, question, client, answerfield, dep_field, dep_formula)
		VALUES
			(#question_id#, '#cat#', '#order#', '#prisec#', '#display_text#', 'self', '#question_code#', #PreserveSingleQuotes(dep)#, #PreserveSingleQuotes(dep)#)
	</cfquery>
</cfloop>
</table>
</cfoutput>