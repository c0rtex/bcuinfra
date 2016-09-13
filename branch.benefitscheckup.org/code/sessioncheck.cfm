<cfif Not IsDefined('session.screening')>
	<cflocation url="sessionerror.cfm">
</cfif>