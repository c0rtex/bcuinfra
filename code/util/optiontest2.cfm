<cfset lsidVal = "2520-esi_mobilityowncar">
<cfset lsidOptionID = ListGetAt(lsidVal, 1, '-')>
<cfoutput>#lsidOptionID#</cfoutput>


<cfinclude template="../servicexmlparser.cfm">