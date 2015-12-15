<cfparam name="subset_id" type="integer" default="58">



<h2>Subset Questions for Subset <cfoutput>#subset_id#</cfoutput></h>



<!--- Display results count - comment out when executing batch --->
<cfquery name="questionnaire"  datasource="#session.datasrc#"  >
select  distinct a.answerfield_id, a.answerfield
from question_answerfield qa, answerfield a, answerfieldtype at, question q, display_language dl

where 
q.display_id = dl.display_id
and a.answerfield_id = qa.answerfield_id
and at.answerfieldtype_id = a.answerfieldtype_id
and qa.question_id = q.question_id
and dl.language_id = 'EN'
and a.answerfield_id in
(
select distinct pa.answerfield_id from subset_program_sum sps , program_answerfield pa
where 
pa.program_id = sps.program_id
and sps.subset_id = #subset_id#
)
order by a.answerfield_id

</cfquery>


<table border=1>
<tr><td>Answerfield_id</td><td>Answerfield</td><td>Programs</td></tr>
<cfloop query="questionnaire">

	<cfquery name="field_programs"  datasource="#session.datasrc#"  >
		select * from program p, program_answerfield pa, subset_program_sum sps, display_language dl
		where 
		p.program_id = pa.program_id
		and sps.program_id = p.program_id
		and dl.display_id = p.name_display_id
		and pa.answerfield_id = #questionnaire.answerfield_id#
		and sps.subset_id = #subset_id#
		and dl.language_id = 'EN'
	

	</cfquery>
	<tr bgcolor=#CCCCCC>
		<td><cfoutput>#questionnaire.answerfield_id#</td><td>#questionnaire.answerfield#</cfoutput></td>
		<td>  
	
		<cfloop query="field_programs"><cfoutput>program id: #program_id#  Legacy: #LEGACY_PRG_ID# Name: #display_text#</cfoutput><br></cfloop>


		</td>
	
	</tr>

	
</cfloop>
</table>

<cfabort>







