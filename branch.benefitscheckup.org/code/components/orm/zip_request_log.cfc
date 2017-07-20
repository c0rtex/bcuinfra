<!---
  Created by rustik on 17/07/2017.
--->
<cfcomponent persistent="true" entityname="zipRequestLog" table="zip_request_log">
    <cfproperty name="id" fieldtype="id" generator="identity">
    <cfproperty name="host_ip">
    <cfproperty name="log_datetime">
    <cfproperty name="zipcode">
    <cfproperty name="text">
</cfcomponent>
