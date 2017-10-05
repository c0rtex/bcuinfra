<cfparam name="url.screening_id" type="numeric" default="1">
<cfinvoke method="getSummaryContent" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="screening_id" value="#url.screening_id#">
</cfinvoke >


<cfdump var="#responsefromservice#">


