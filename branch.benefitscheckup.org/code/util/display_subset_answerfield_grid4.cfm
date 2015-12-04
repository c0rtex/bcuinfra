<cfparam name="subset_id" type="integer" default="58">



<h2>Subset Grid Questions for Subset <cfoutput>#subset_id#</cfoutput></h>



<!--- Display results count - comment out when executing batch --->
<cfquery name="questionnaire"  datasource="#session.datasrc#"  >

select q.question_id, q.question_code, dl.display_text
from question q, display_language dl

where 
q.display_id = dl.display_id
and dl.language_id = 'EN'

and 
 q.question_id in
(
select question_id from subset_question sq where subset_id = #subset_id# 
)





</cfquery>


<table border=1 valign=top >
<tr><td>Question_Code</td><td>Question</td><td>Question_ID</td><td>AnswerField  ID  Code  Type</td></tr>
<cfloop query="questionnaire">
<cfoutput><tr><td valign=top>#questionnaire.question_code#</td><td valign=top>#questionnaire.display_text#</td><td valign=top>#questionnaire.question_id#</td></cfoutput>




<td valign="top" nowrap>


	<cfquery name="grid"  datasource="#session.datasrc#" >
select *
from 
 answerfield a, answerfieldtype at
where 
 at.answerfieldtype_id = a.answerfieldtype_id
 
<cfif questionnaire.question_code eq 'incomegrid'>
	and at.answerfieldtype_id = 16
<cfelseif questionnaire.question_code eq 'assetgrid'>
	and at.answerfieldtype_id = 17 
<cfelse>
	and 1 = 0
</cfif>
and
a.answerfield_id in (
select a.answerfield_id from program_answerfield pa, answerfield a 
where
pa.answerfield_id =a.answerfield_id 
and (a.answerfieldtype_id = 16 or a.answerfieldtype_id = 17)
and pa.program_id in 
(
select program_id 
from subset_program_sum  sps
where sps.subset_id = #subset_id#
)
union

select distinct ha.answerfield_id
from hardrule h, hardrule_answerfield ha
where ha.hardrule_id = h.hardrule_id
and
 ha.answerfield_id in 
(
select answerfield_id from program_answerfield pa
where pa.program_id in
(
select program_id from subset_program_sum sps where subset_id = #subset_id#
)
)



)
order by answerfield asc
	</cfquery>

	  
		
		<cfloop query="grid">
		
		<cfoutput>#answerfield#  #answerfield_id#  #name#<br></cfoutput>

	
		
	
		</cfloop>
		
		
	
	

		<cfquery name="notgrid"  datasource="#session.datasrc#" >
select *
from 
question_answerfield qa, answerfield a , answerfieldtype at
where qa.answerfield_id = a.answerfield_id
and at.answerfieldtype_id = a.answerfieldtype_id

and qa.question_id = #questionnaire.question_id#
	</cfquery>

		<cfloop query="notgrid">
		<cfoutput>#answerfield#  #answerfield_id# #code#  #name#<br></cfoutput>

	
		

		</cfloop>

</td>	</tr>
</cfloop>
</table>

<cfabort>





