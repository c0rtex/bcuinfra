
<cfparam name="url.validation_id" type="numeric" default="109">

<cfinvoke method="getValidationByID" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_4.cfc?wsdl" >

<cfinvokeargument name="validation_id" value="#url.validation_id#">
</cfinvoke >



<cfdump var="#responsefromservice#">


