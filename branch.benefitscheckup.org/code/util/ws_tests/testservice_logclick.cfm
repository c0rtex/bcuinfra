<cfinvoke method="logAffinityClick" 
returnvariable="responseFromService" 
webservice="https://www.benefitscheckup.org/util/affinity.cfc?wsdl" >
<cfinvokeargument name="internal_flag" value="1">
<cfinvokeargument name="partner_id" value="14">
<cfinvokeargument name="partner_session_id" value="123456-121212-121212">
<cfinvokeargument name="url_id" value="63">
<cfinvokeargument name="campaign_id" value="1">
<cfinvokeargument name="ahn_contact_flag" value="1">
<cfinvokeargument name="screening_id" value="0">
<cfinvokeargument name="click_id" value="1239631">
</cfinvoke>



<cfdump var="#responsefromservice#">