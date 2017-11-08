<cfparam name="url.state_zip" type="string" default="90211">
<cfparam name="url.statetype_id" type="string" default="1">
<cfinvoke method="getStateDetails" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="state_zip" value="#url.state_zip#">
<cfinvokeargument name="statetype_id" value="#url.statetype_id#" >
</cfinvoke >
<cfdump var="#responsefromservice#">


