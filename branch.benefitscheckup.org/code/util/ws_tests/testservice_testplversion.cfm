<cfparam name="url.partner_id" type="numeric" default="0">
<cfinvoke method="getServiceVersion" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/datarequest_pl.cfc?wsdl" >
<cfinvokeargument name="partner_id" value="test">
</cfinvoke >


<cfdump var="#responsefromservice#">
