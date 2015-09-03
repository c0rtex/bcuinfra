<cfparam name="subset_id" type="integer" default="58">



<h2>Subset Questions for Subset <cfoutput>#subset_id#</cfoutput></h>



<!--- Display results count - comment out when executing batch --->
<cfquery name="questionnaire"  datasource="#session.datasrc#"  >
select  distinct a.answerfield_id, a.answerfield, at.name, at.code
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
<tr><td>ID</td><td>Answerfield</td><td>Name</td><td>Code</td><td>Options</td></tr>
<cfloop query="questionnaire">


	<cfquery name="options"  datasource="#session.datasrc#" >
		select  ao.answerfield_id, o.option_id, sort, o.option_code  
		from 
answerfield_option ao, `option` o
where 
o.option_id = ao.option_id
and answerfield_id = #questionnaire.answerfield_id#
order by ao.option_id, ao.sort

	

	</cfquery>
	<tr bgcolor=#CCCCCC>
		<td><cfoutput>#questionnaire.answerfield_id#</td><td>#questionnaire.answerfield#</td><td>  #name#</td><td> #code#</td></cfoutput></td>
		<td>  
	
		<cfloop query="options">
		<cfoutput>option id: #option_id#_#option_code#</cfoutput>		<br>

		
		

	</cfloop>
		
		</td>
	
	</tr>

	
	</cfloop>
</table>

<cfabort>







