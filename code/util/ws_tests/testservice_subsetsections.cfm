
<cfparam name="url.subset_id" type="numeric" default="0">

<cfinvoke method="getsubsetsections" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_0.cfc?wsdl" >

<cfinvokeargument name="subset_id" value="#url.subset_id#">
</cfinvoke >



<cfdump var="#responsefromservice#">


