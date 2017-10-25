
<cfparam name="url.zipcode" type="string" default="06824">
<cfinvoke method="getShipContent" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="zipcode" value="#url.zipcode#">
</cfinvoke >
<cfdump var="#responsefromservice#">


