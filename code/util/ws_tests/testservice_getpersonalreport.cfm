<cfparam name="url.screening_id" type="numeric" default="7447422">
<cfparam name="url.subset_id" type="numeric" default="75">





<cfinvoke method="getPersonalReport" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="screening_id" value="#url.screening_id#">
<cfinvokeargument name="subset_id" value="#url.subset_id#">
</cfinvoke >


<cfdump var="#responsefromservice#">


