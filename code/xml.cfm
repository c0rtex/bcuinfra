<cfsetting ShowDebugOutput="No">
<cfcontent type="text/xml">
<cfif Not IsDefined('form.xml')>
<UserScreening />
<cfelse>
<cfoutput>#form.xml#</cfoutput>
</cfif>

