<cfparam name="url.state_id" type="string" default="AK">
<cfparam name="url.subset_id" type="numeric" default="93">
<cfparam name="url.programcategory_id" type="numeric" default="8">

<cfinvoke method="getProgByCat" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >
<cfinvokeargument name="state_id" value="#url.state_id#">
<cfinvokeargument name="subset_id" value="#url.subset_id#">
<cfinvokeargument name="programcategory_id" value="#url.programcategory_id#">
</cfinvoke >


<cfdump var="#responsefromservice#">



<cfinvoke method="getSubsetPrograms" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >

<cfinvokeargument name="subset_id" value="#url.subset_id#">

</cfinvoke >
<cfdump var="#responsefromservice#">


<cfinvoke method="getSubCats" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/remotescreening_3_8.cfc?wsdl" >

<cfinvokeargument name="subset_id" value="#url.subset_id#">

</cfinvoke >


<cfdump var="#responsefromservice#">


