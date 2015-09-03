
<cfparam name="url.display_code" type="string" default="Null">

<cfinvoke method="getDisplayTextByCode" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_0.cfc?wsdl" >

<cfinvokeargument name="display_code" value="#url.display_code#">
</cfinvoke >



<cfdump var="#responsefromservice#">


