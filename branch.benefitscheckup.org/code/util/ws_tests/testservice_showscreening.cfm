<cfparam name="url.partner_id" type="numeric" default="142">
<cfparam name="url.partner_session_id" type="string" default="">
<cfparam name="url.start_date" type="string" default="">
<cfparam name="url.end_date" type="string" default="">
<cfinvoke method="getUserScreenings" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/datarequest_pl.cfc?wsdl" >
<cfinvokeargument name="partner_id" value="#url.partner_id#">
<cfinvokeargument name="partner_session_id" value="#url.partner_session_id#">
<cfinvokeargument name="start_date" value="#url.start_date#">
<cfinvokeargument name="end_date" value="#url.end_date#">

</cfinvoke >


<cfdump var="#responsefromservice#">
