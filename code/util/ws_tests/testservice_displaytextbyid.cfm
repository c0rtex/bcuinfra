
<cfparam name="url.display_id" type="numeric" default="0">

<cfinvoke method="getDisplayTextById" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_0.cfc?wsdl" >

<cfinvokeargument name="display_id" value="#url.display_id#">
</cfinvoke >



<cfdump var="#responsefromservice#">


