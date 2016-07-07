<cfparam name="attributes.setnum" type="numeric" default="0">
<cfparam name="attributes.increment" type="boolean" default="true">
<cfif Not IsDefined('session.screening.qnum')>
	<cfset session.screening.qnum = 1>
</cfif>
<cfif attributes.setnum>
	<cfset session.screening.qnum = attributes.setnum>
</cfif>
<cfset outNum = session.screening.qnum>
<cfif attributes.increment>
	<cfset session.screening.qnum = session.screening.qnum + 1>
</cfif>
<cfoutput>#outNum#</cfoutput>