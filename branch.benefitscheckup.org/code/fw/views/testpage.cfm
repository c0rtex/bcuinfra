<h1>TEST PAGE</h1>
<cfdump var="#event.getArgs()#" expand="no" label="EVENT COLLECTION">


<cfif isDefined("session.user")>
<cfdump var="#session.user#" expand="no" label="SESSION USER">

<cfoutput>
	Logged in as: <cfdump var="#session.user.getRoles()#" expand="no" label="ROLES">
</cfoutput>
</cfif>