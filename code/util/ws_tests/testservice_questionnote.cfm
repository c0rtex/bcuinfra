
<cfparam name="url.question_id" type="numeric" default="796">

<cfinvoke method="getQuestionNote" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_4.cfc?wsdl" >

<cfinvokeargument name="question_id" value="#url.question_id#">
</cfinvoke >



<cfdump var="#responsefromservice#">


