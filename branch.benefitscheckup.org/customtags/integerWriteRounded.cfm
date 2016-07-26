<cfparam name="attributes.num" type="numeric">
<cfparam name="attributes.var" type="string" default="">
<cfset intarray = ListToArray(attributes.num, '.')>
<cfset intnum = intarray[1]>
<cfset outnum="">

<cfif intnum gt 1000000000000>
	<cfset intnum = int(intnum / 100000000000) / 10>
	<cf_displayText group="number" code="number_trillion" var="magnitude">
	<cfset outnum = "#intnum# #magnitude#">
<cfelseif intnum gt 1000000000>
	<cfset intnum = int(intnum / 100000000) / 10>
	<cf_displayText group="number" code="number_billion" var="magnitude">
	<cfset outnum = "#intnum# #magnitude#">
<cfelseif intnum gt 1000000>
	<cfset intnum = int(intnum / 100000) / 10>
	<cf_displayText group="number" code="number_million" var="magnitude">
	<cfset outnum = "#intnum# #magnitude#">
<cfelseif intnum gt 1000>
	<cfset intnum = int(intnum / 100) / 10>
	<cf_displayText group="number" code="number_thousand" var="magnitude">
	<cfset outnum = "#intnum# #magnitude#">
<cfelseif intnum gt 100>
	<cfset intnum = int(intnum / 10) / 10>
	<cf_displayText group="number" code="number_hundred" var="magnitude">
	<cfset outnum = "#intnum# #magnitude#">
<cfelse>
	<cfset outnum = intnum>
</cfif>
<cfif attributes.var eq "">
	<cfoutput>#outnum#</cfoutput>
<cfelse>
	<cfset "caller.#attributes.var#" = outnum>
</cfif>