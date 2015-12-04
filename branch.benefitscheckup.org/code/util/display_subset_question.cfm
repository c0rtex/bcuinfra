<cfparam name="subset_id" type="integer" default="58">
<h2>Subset Questions for Subset <cfoutput>#subset_id#</cfoutput></h>
<!--- Display results count - comment out when executing batch --->
<cfquery name="results3"  datasource="#session.datasrc#"  >
select  
a.answerfield, 
qa.question_id, 
a.answerfield_id, 
a.answerfieldtype_id , 
at.code, at.name, 
q.question_code, 
q.sort, 
dl.display_text,
a.REQUIRED_FLAG
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
and q.question_code not like 'fake%'
order by q.sort, a.answerfield_id

</cfquery>
<cfdump var="#results3#">

<cfquery name="results4"  datasource="#session.datasrc#"  >
select * from answerfield, validation where answerfield.validation_id = validation.validation_id limit 0, 15
</cfquery>
<cfdump var="#results4#">
<cfquery name="results5"  datasource="#session.datasrc#"  >
select * from question limit 0, 15
</cfquery>
<cfdump var="#results5#">

<cfabort>







