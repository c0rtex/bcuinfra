
<cfparam name="url.state_zip" type="string" default="">
<cfparam name="url.question_code" type="string" default="">
<cfinvoke method="getQuestionAnswerfieldDetails" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_6.cfc?wsdl" >
<cfinvokeargument name="state_zip" value="#url.state_zip#">
<cfinvokeargument name="question_code" value="#url.question_code#">
</cfinvoke >

<cfdump var="#responsefromservice#">


