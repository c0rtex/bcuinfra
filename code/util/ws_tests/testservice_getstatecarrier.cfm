<cfparam name="url.screening_id" type="numeric" default="1">
<cfparam name="url.state_zip" type="string" default="90211">
<cfparam name="url.star_rating" type="numeric" default="3">
<cfparam name="url.partner_id" type="numeric" default="0">
<cfinvoke method="getStateCarrier" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/remotescreening_3_5.cfc?wsdl" >
<cfinvokeargument name="screening_id" value="#url.screening_id#">
<cfinvokeargument name="star_rating" value="#url.star_rating#">
<cfinvokeargument name="state_zip" value="#url.state_zip#">
<cfinvokeargument name="partner_id" value="#url.partner_id#">
</cfinvoke >
<cfdump var="#responsefromservice#">


