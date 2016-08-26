<cfparam name="url.partner_id" type="numeric" default="0">
<cfparam name="url.screening_id" type="numeric" default="0">
<cfinvoke method="getReportContent" 
returnvariable="responseFromService" 
webservice="https://redesign.benefitscheckup.org/util/datarequest_pl.cfc?wsdl" >
<cfinvokeargument name="partner_id" value="142">
<cfinvokeargument name="screening_id" value="#url.screening_id#">
</cfinvoke >


<cfdump var="#responsefromservice#">
