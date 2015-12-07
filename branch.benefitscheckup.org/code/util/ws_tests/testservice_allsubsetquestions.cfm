
<cfparam name="url.subset_id" type="numeric" default="75">
<cfparam name="url.partner_id" type="numeric" default="14">
<cfparam name="url.state_zip" type="string" default="10022">
<cfinvoke method="getAllQuestionsBySubset" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_6.cfc?wsdl" >
<cfinvokeargument name="subset_id" value="#url.subset_id#">
<cfinvokeargument name="state_zip" value="#url.state_zip#">
<cfinvokeargument name="partner_id" value="#url.partner_id#">
</cfinvoke >
<cfdump var="#responsefromservice#">


