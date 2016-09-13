<cfparam name="url.subset_id" type="numeric" default="0">

<cfinvoke method="getSubsetPrograms" 
returnvariable="responseFromService" 
webservice="http://bcuqa.benefitscheckup.org/util/remotescreening_staging.cfc?wsdl" >
<cfinvokeargument name="subset_id" value="#url.subset_id#">
</cfinvoke >
<h2>Programs by Subset </h2>
<cfdump var="#responsefromservice#" label="Subset Programs">

<cfinvoke method="getProgramCategories" 
returnvariable="responseFromService" 
webservice="http://bcuqa.benefitscheckup.org/util/remotescreening_staging.cfc?wsdl" >
</cfinvoke >
<h2>Program Categories by Subset </h2>
<cfdump var="#responsefromservice#" label="Subset Programs">









