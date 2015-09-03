<cfparam name="subset_id" type="integer" default="58">



<h2>Subset Grid Questions for Subset by Program ID <cfoutput>#subset_id#</cfoutput></h>



<!--- Display results count - comment out when executing batch --->
<cfquery name="questionnaire"  datasource="#session.datasrc#"  >

select distinct ha.answerfield_id
from hardrule h, hardrule_answerfield ha
where ha.hardrule_id = h.hardrule_id
and ha.answerfield_id in 
(
select answerfield_id from program_answerfield pa
where pa.program_id in
(
select program_id from subset_program_sum sps where subset_id = #subset_id#
)
)



</cfquery><cfdump var="#questionnaire#"><cfabort>


<table border=1 valign=top >
<tr><td>Question_Code</td><td>Question</td><td>Question_ID</td><td>AnswerField  ID  Code  Type</td></tr>
<cfloop query="questionnaire">
<cfoutput><tr><td valign=top>#questionnaire.question_code#</td><td valign=top>#questionnaire.display_text#</td><td valign=top>#questionnaire.question_id#</td></cfoutput>




<td valign="top" nowrap>


	<cfquery name="grid"  datasource="#session.datasrc#" >
select *
from 
gridcolumn gc, gridrow gr, gridrow_gridcolumn_answerfield ga , answerfield a, answerfieldtype at
where gc.gridcolumn_id = ga.gridcolumn_id and gr.gridrow_id =ga.gridrow_id
and ga.answerfield_id = a.answerfield_id
and at.answerfieldtype_id = a.answerfieldtype_id
 
<cfif questionnaire.question_code eq 'incomegrid'>
	and at.answerfieldtype_id = 16
<cfelseif questionnaire.question_code eq 'assetgrid'>
	and at.answerfieldtype_id = 17 
<cfelse>
	and 1 = 0
</cfif>
order by gc.sort
	</cfquery>

	  
		<cfset test = "self">
		<cfloop query="grid">
		<cfif code neq test >-------<br></cfif>
		<cfoutput>#answerfield#  #answerfield_id#  #code#  #name#<br></cfoutput>

	
		
		<cfset test = code>
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





