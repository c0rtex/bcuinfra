<cfinvoke 
    webservice = "https://www.humanservices-t.state.pa.us/COMPASS.RiaServices/CredentialsManagementService.svc/secured"
    method = "GetCpUserDetails"
    returnVariable = "returnedQuery">
<cfinvokeargument name="CPUserId" value="CPD">
<cfinvokeargument name="password" value="Password##1">
</cfinvoke>

