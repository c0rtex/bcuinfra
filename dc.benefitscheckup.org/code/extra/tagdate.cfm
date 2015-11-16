
<CFOUTPUT>
<CFIF IsDefined("attributes.att")>
<CFSET att = #attributes.att#>
	#DateFormat("#att#","MM/DD/YY")#
<CFELSE>
	#DateFormat(now(),"MM/DD/YYYY")#
</CFIF>
</CFOUTPUT>
