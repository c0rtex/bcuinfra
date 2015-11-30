
<cfparam name="url.subset_id" type="numeric" default="75">
<cfparam name="url.section_code" type="string" default="">
<cfparam name="url.state_id" type="string" default="NA">
<cfparam name="url.partner_id" type="numeric" default="0">
<cfinvoke method="getSectionQuestions" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_6.cfc?wsdl" >

<cfinvokeargument name="subset_id" value="#url.subset_id#">
<cfinvokeargument name="section_code" value="#url.section_code#">
<cfinvokeargument name="state_id" value="#url.state_id#">
<cfinvokeargument name="partner_id" value="#url.partner_id#">
</cfinvoke >



<cfdump var="#responsefromservice#">


