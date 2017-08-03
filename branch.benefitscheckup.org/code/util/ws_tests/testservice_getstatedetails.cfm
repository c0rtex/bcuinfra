<cfparam name="url.state_zip" type="string" default="90211">
<cfinvoke method="getStateDetails" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="state_zip" value="#url.state_zip#">
</cfinvoke >
<cfdump var="#responsefromservice#">


