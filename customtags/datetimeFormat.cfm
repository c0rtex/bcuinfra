<cfsilent>
<cfparam name="attributes.date" type="string" default="">
<cfparam name="attributes.var" type="string" default="">
<cfif attributes.date eq ''>
	<cfset attributes.date = Now()>
<cfelse>
	<cfset attributes.date = ParseDateTime(attributes.date)>
</cfif>
<cfset dfpart = DateFormat(attributes.date, 'dddd, mmmm d, yyyy')>
<cfset dfhour = DatePart('h', attributes.date)>
<cfif dfhour eq 0>
	<cfset dfhour = 12>
	<cfset dfampm = 'a.m.'>
<cfelseif dfhour gt 0 and dfhour lt 12>
	<cfset dfampm = 'a.m.'>
<cfelseif dfhour eq 12>
	<cfset dfampm = 'p.m.'>
<cfelse>	
	<cfset dfhour = dfhour - 12>
	<cfset dfampm = 'p.m.'>
</cfif>
<cfset dfmin = DatePart('n', attributes.date)>
<cfif dfmin lt 10>
	<cfset dfmin = '0' & dfmin>
</cfif>
<cfset dfsec = DatePart('s', attributes.date)>
<cfif dfsec lt 10>
	<cfset dfsec = '0' & dfsec>
</cfif>
<cfset dftime = "#dfhour#:#dfmin#&nbsp;#dfampm#">
<cfset outval = "#dfpart# at #dftime# Eastern Time">
</cfsilent><cfif attributes.var eq ''><cfoutput>#outval#</cfoutput><cfelse><cfset "caller.#attributes.var#" = outval></cfif>